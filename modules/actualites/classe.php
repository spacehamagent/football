<?php

namespace SHA;

class Actualite extends Module
{
    protected static $key = "noActualite";
    protected static $table = "actualites";
    protected static $variables = [
        "dateActualite",
        "titreActualiteLangue"
    ];

    public static function Lister($options = []) {
        global $cfg;

        $default = [
            "actifSeulement" => false
        ];

        $settings = array_merge($default, $options);

        $SQL = "SELECT  actualites.noActualite, dateActualite, titreActualiteLangue
                FROM    actualites
                INNER   JOIN actualitesLangues
                    ON  actualitesLangues.noActualite = actualites.noActualite
                    AND actualitesLangues.noLangue = '$cfg[noLangue]'";

        return DB::query($SQL)->fetchAll();
    }

    public static function Trouver($noEnr = 0) {
        return self::TrouverEnregistrement($noEnr,["actualites", "actualitesLangues"],"noActualite");
    }

    public static function Enregistrer($donnees = []) {
        global $cfg;

        $donnees["actif"] = ((isset($donnees["actif"])) ? 1: 0);

        if ($donnees["noEnr"] > 0) {
            $enr = self::Trouver($donnees["noEnr"]);

            if($enr):
                $SQL = "UPDATE actualites
                        SET actifActualite          = '".$donnees["actif"]."',
                            imageActualite          = '".$donnees["imageActualite"]."',
                            dateActualite           = '".$donnees["date"]."'
                    WHERE   actualites.noActualite  = '" . $donnees["noEnr"] . "'";

                DB::query($SQL);

                foreach($cfg["languesSite"] as $i) {
                    self::EnregistrerLangue($donnees,$i);
                }

                Historique::Enregistrer([
                    "noHistoriqueAction" => HISTORIQUE_ACTION_MODIFIER,
                    "messageHistorique" => "Enregistrer [".$donnees["noEnr"]."] module actualite"
                ]);

                return true;
            else:
                return false;
            endif;
        } else {
            $SQL = "INSERT INTO actualites (
                actifActualite,
                imageActualite,
                dateActualite
            ) VALUES (
                '$donnees[actif]',
                '$donnees[imageActualite]',
                '$donnees[date]'
            )";
        
            DB::query($SQL);
            $noEnr = DB::obtenirDernierID();

            foreach ($cfg["languesSite"] as $i) {
                $donnees["noEnr"] = $noEnr;
                self::EnregistrerLangue($donnees,$i);
            }
            return true;
        }
        return false;
    }

    private static function EnregistrerLangue($donnees = [], $langue = FRANCAIS) {
        $SQL = "INSERT INTO actualitesLangues (
                noActualite,
                noLangue,
                titreActualiteLangue,
                descriptionActualiteLangue
            ) VALUES (
                '".$donnees["noEnr"]."',
                '".$langue."',
                '".$donnees["titre_$langue"]."',
                '".$donnees["description_$langue"]."'
            );";
        
        $optionsVerificationLangue = [
            "table" => "actualitesLangues",
            "id"    => "noActualite",
            "noEnr" => $donnees["noEnr"],
            "langue"    => $langue
        ];

        if(self::VerifierLangueExiste($optionsVerificationLangue)) {
            $SQL = "UPDATE actualitesLangues
                    SET titreActualiteLangue            = '" . $donnees["titre_$langue"] . "',
                        descriptionActualiteLangue      = '" . $donnees["description_$langue"] . "'
                    WHERE actualitesLangues.noActualite = '" . $donnees["noEnr"] . "'
                        AND actualitesLangues.noLangue  = '" . $langue . "';";
        }
        DB::query($SQL);
    }

    public static function Supprimer($noEnr){
        $actualite = self::Trouver($noEnr);

        if($actualite){
            $SQL = "DELETE FROM actualites WHERE noActualite = '$noEnr'";
            DB::query($SQL);

            $SQL = "DELETE FROM actualitesLangues WHERE noActualite = '$noEnr'";
            DB::query($SQL);

            Historique::Enregistrer([
                "noHistoriqueAction" => HISTORIQUE_ACTION_SUPPRIMER,
                "messageHistorique" => "Suppression [".$noEnr."] module actualité"
            ]);

            return true;
        } else {
            return false;
        }
    }
}
