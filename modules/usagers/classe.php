<?php

namespace SHA;

class Usager extends Module{
    private static $prenom = "";
    private static $nom = "";
    private static $courriel = "";
    private static $groupeUsager = [1];
    
    public static function Lister(){
        $SQL = "SELECT noUsager, prenomUsager, nomUsager, courrielUsager
            FROM    usagers";
        
        $usagers = DB::query($SQL)->fetchAll();

        return $usagers;
    }

    public static function Trouver($noEnr){
        $SQL = "SELECT  *, noUsager as noEnr
            FROM    usagers
            
            WHERE   usagers.noUsager = '$noEnr'";
        return DB::query($SQL)->fetchAll();
    }

    public static function Ajouter($donnees){
        $donnees["actif"] = isset($donnees["actif"]) ? 1 : 0;
        $donnees["admin"] = isset($donnees["admin"]) ? 1 : 0;
        
        if(!EstAdmin()){
            $donnees["actif"] = 1;
            $donnees["admin"] = 0;
        }

        $clés = "actifUsager, adminUsager, ";
        $valeurs = "'".$donnees["actif"]."', '".$donnees["admin"]."', ";

        $noEnrAdresse = Adresse::Ajouter($donnees);

        if($noEnrAdresse > 0){
            $SQL = "INSERT INTO usagers (
                        $clés
                        prenomUsager,
                        nomUsager,
                        courrielUsager,
                        dateNaissanceUsager,
                        telephoneUsager,
                        cellulaireUsager,
                        avatarUsager,
                        noSexe, 
                        noAdresse
                    ) VALUES (
                        $valeurs
                        '".$donnees["prenom"]."',
                        '".$donnees["nom"]."',
                        '".$donnees["courriel"]."',
                        '".$donnees["dateNaissance"]."',
                        '".$donnees["telephone"]."',
                        '".$donnees["cellulaire"]."',
                        '".$donnees["avatar"]."',
                        '".$donnees["noSexe"]."',
                        '$noEnrAdresse'
                    )";
            DB::query($SQL);

            $noEnr = DB::obtenirDernierID();

            self::EnregistrerUsagerParametres(["noEnr" => $noEnr, "videoBienvenue" => 1, "theme" => "dark"]);

            self::EnregistrerGroupe(["noUsager" => $noEnr, "noGroupe" => self::$groupeUsager]);

            Historique::Enregistrer([
                "noHistoriqueAction" => HISTORIQUE_ACTION_AJOUTER,
                "messageHistorique" => "Ajouter [".$noEnr."] module usager [".$donnees["courriel"]."]"
            ]);

            return true;
        }

        return false;
    }

    public static function Enregister($donnees){
        $donnees["actif"] = isset($donnees["actif"]) ? 1 : 0;
        $donnees["admin"] = isset($donnees["admin"]) ? 1 : 0;

        $cleValeur = "";

        if(!EstAdmin()){
            $donnees["actif"] = 1;
            $donnees["admin"] = 0;
        }
        
        $cleValeur .= " actifUsager             = '" . $donnees["actif"] . "', ";
        $cleValeur .= " adminUsager             = '" . $donnees["admin"] . "', ";
        
        $usager = self::Trouver($donnees["noEnr"]);
        
        if ($usager) {
            $SQL = "UPDATE usagers
                    SET prenomUsager            = '" . $donnees["prenom"] . "',
                        nomUsager               = '" . $donnees["nom"] . "',
                        noSexe                  = '" . $donnees["noSexe"] . "',
                        dateNaissanceUsager     = '" . $donnees["dateNaissance"] . "',
                        $cleValeur
                        courrielUsager          = '" . $donnees["courriel"] . "',
                        telephoneUsager         = '" . $donnees["telephone"] . "',
                        cellulaireUsager        = '" . $donnees["cellulaire"] . "',
                        avatarUsager            = '" . $donnees["avatar"] . "'
                 WHERE   usagers.noUsager        = '" . $donnees["noEnr"] . "'";

            DB::query($SQL);

            Adresse::Enregistrer($usager[0]["noAdresse"], $donnees);

            if (strlen($donnees["motDePasse"]) > 0) {
                self::EnregistrerMotDePasse($usager[0]["courrielUsager"], $donnees["motDePasse"]);
            }

            self::EnregistrerGroupe(["noUsager" => $usager[0]["noUsager"], "noGroupe" => self::$groupeUsager]);

            if (IsSessionActive($donnees["noEnr"])) {
                self::MiseAJourUsager($donnees);
            }

            Historique::Enregistrer([
                "noHistoriqueAction" => HISTORIQUE_ACTION_MODIFIER,
                "messageHistorique" => "Modification [".$donnees["noEnr"]."] module usager [".$donnees["courriel"]."]"
            ]);

            return true;
        } else {
            return false;
        }
    }

    private static function EnregistrerGroupe($options = []) {
        $default = [
            "noUsager" => 0,
            "noGroupe" => []
        ];
        $settings = array_merge($default, $options);

        if (!empty($settings["noGroupe"])) {
            $SQL = "DELETE FROM groupesUsagers
                    WHERE noUsager = " . $settings["noUsager"];
            DB::query($SQL);

            foreach ($settings["noGroupe"] as $noGroupe) {
                $SQL = "INSERT INTO groupesUsagers (
                    noGroupe,
                    noUsager
                ) VALUES (
                    $noGroupe, 
                    " . $settings["noUsager"] . ")";
                DB::query($SQL);
            }
        }
    }

    private static function EnregistrerMotDePasse($courriel, $mdp) {
        $motDePasse = HashMot($mdp);
        $SQL = "UPDATE usagers SET motDePasseUsager = '$motDePasse' WHERE courrielUsager = '$courriel'";
        DB::query($SQL);
    }

    private static function MiseAJourUsager($donnees, $noMicrosite = MICROSITE_INTRANET){
        $_SESSION["microsite_".$noMicrosite]["usager"]["prenomUsager"] = $donnees["prenom"];
	    $_SESSION["microsite_".$noMicrosite]["usager"]["nomUsager"] = $donnees["nom"];
        $_SESSION["microsite_".$noMicrosite]["usager"]["avatarUsager"] = $donnees["avatar"];
    }

    public static function SetDefaultAvatarToUsers($noFichier = 0) {
        if($noFichier > 0){
            $SQL = "UPDATE  usagers
                        SET avatarUsager = 0
                    WHERE avatarUsager = $noFichier";
            DB::query($SQL);
        }
    }

    public static function TrouverUsagerParametre($noEnr){
        $SQL = "SELECT * FROM usagersParametres WHERE noUsager = '$noEnr'";
        return DB::query($SQL)->fetchAll();
    }

    public static function EnregistrerUsagerParametres($donnees, $noMicrosite = MICROSITE_INTRANET){
        $noUsager = $_SESSION["microsite_".$noMicrosite]["usager"]["noUsager"] ?? 0;

        if(isset($donnees["noEnr"])){
            $noUsager = $donnees["noEnr"];
        }
        
        if($noUsager > 0){
            $paramsUsager = self::TrouverUsagerParametre($noUsager);
            $SQL = "";

            if(!empty($paramsUsager)){
                $SQL = "UPDATE usagersParametres
                    SET videoBienvenueUsagerParametre = '$donnees[videoBienvenue]',
                        themeUsagerParametre = '$donnees[theme]'
                    WHERE   noUsager = '$noUsager'";
            } else {
                $SQL = "INSERT INTO usagersParametres (
                        noUsager,
                        videoBienvenueUsagerParametre,
                        themeUsagerParametre
                    ) VALUES (
                        '$noUsager',
                        '$donnees[videoBienvenue]',
                        '$donnees[theme]'
                    )";
            }
            DB::query($SQL);
            self::MiseAJourParametresUsager($donnees, $noMicrosite);

            return true;
        }

        return false;
    }

    private static function MiseAJourParametresUsager($donnees, $noMicrosite = MICROSITE_INTRANET){
        $_SESSION["microsite_".$noMicrosite]["usager"]["parametres"]["videoBienvenue"] = $donnees["videoBienvenue"];
        $_SESSION["microsite_".$noMicrosite]["usager"]["parametres"]["theme"] = $donnees["theme"];
    }

    public static function Supprimer($noEnr){
        $usager = self::Trouver($noEnr);

        if($usager && $noEnr > 1){
            $SQL = "DELETE FROM usagers WHERE noUsager = '$noEnr'";
            DB::query($SQL);

            Adresse::Supprimer($usager[0]["noAdresse"]);

            Historique::Enregistrer([
                "noHistoriqueAction" => HISTORIQUE_ACTION_SUPPRIMER,
                "messageHistorique" => "Suppression [".$usager[0]["noUsager"]."] module usager [".$usager[0]["courriel"]."]"
            ]);

            return true;
        } else {
            return false;
        }
    }

    public static function Connexion($data){
        $connexion = false;
        $usager = self::TrouverParCourriel($data["courriel"]);

        if(!empty($usager)):
            $passWork = VerifierHash($data["motDePasse"], $usager[0]["motDePasseUsager"]);
            if($passWork):
                self::MiseAJourConnexion($usager[0]["noUsager"]);
                $connexion = true;
            else:
                $usager = [];
            endif;
        endif;

        return ["connexion" => $connexion, "usager" => $usager];
    }

    public static function TrouverHashUsager($hash){
        //Trouver usager avec le hash et moins de 15 minutes
        $SQL = "SELECT *
                FROM usagers
                WHERE hashUsager = '$hash'
                    AND dateHashUsager > NOW() - INTERVAL 15 MINUTE";

        return DB::query($SQL)->fetchAll();
    }

    public static function MiseAJourMotDePasse($donnees = []){
        $hash = $donnees["hash"] ?? "";
        $courriel = $donnees["courriel"] ?? "";

        $usager = Usager::TrouverHashUsager($hash);
        if(!empty($usager)){
            if($usager[0]["courrielUsager"] == $courriel){
                $motDePasse = HashMot($donnees["motDePasse"]);
                $SQL = "UPDATE usagers SET motDePasseUsager = '$motDePasse', hashUsager = '' WHERE courrielUsager = '$courriel'";
                DB::query($SQL);
                return true;   
            }
        }

        return false;
    }

    public static function Reinitialisation($donnees = []){
        global $cfg;

        if(isset($donnees["courrielReset"]) && strlen($donnees["courrielReset"]) > 0){
            $usager = self::TrouverParCourriel($donnees["courrielReset"]);

            if(!empty($usager)){
                $hashUsager = HashMot($donnees["courrielReset"]."-hash-".date("Y-M-d"));
                $SQL = "UPDATE usagers
                        SET hashUsager = '$hashUsager',
                            dateHashUsager = NOW()
                        WHERE courrielUsager = '". $donnees["courrielReset"]."'";
                DB::query($SQL);

                $hash = self::ObtenirHashUsager($donnees["courrielReset"]);
                $msg = "";

                $url = "https://" . $cfg["params"]["SERVER_NAME"];
                $url .= TrouverLien(INTRANET_LOGIN) . "?action=resetPass&hash=" .$hash . "&courriel=" .$usager[0]["courrielUsager"];

                ob_start();
                Render("usagers/message-reinitialisation", ["url" => $url]);
                $msg = ob_get_contents();
                ob_end_clean();

                $options = [
                    "to" => $usager[0]["courrielUsager"],
                    "toName" => $usager[0]["prenomUsager"] . " " . $usager[0]["nomUsager"],
                    "titre" => "Demande de réinitialisation du mot de passe !",
                    "body" => $msg
                ];

                return Courriel::Envoie($options);
            }
        }

        return false;
    }

    private static function MiseAJourConnexion($noEnr){
        $SQL = "UPDATE usagers
            SET dateConnexionUsager = NOW()
            WHERE   usagers.noUsager = '$noEnr'";
        DB::query($SQL);
    }

    private static function TrouverParCourriel($courriel = ""){
        $SQL = "SELECT  *
                FROM    usagers
                WHERE   usagers.courrielUsager = '$courriel'";
        
        return DB::query($SQL)->fetchAll();
    }

    private static function ObtenirHashUsager($courriel){
        if(strlen($courriel) > 0){
            $SQL = "SELECT hashUsager FROM usagers WHERE courrielUsager = '$courriel'";

            $resultat = DB::query(($SQL))->fetchAll();

            return $resultat[0]["hashUsager"];
        } else {
            return "";
        }
    }
}