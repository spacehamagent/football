<?php

namespace SHA;

class Historique extends Module{

    public static function Lister(){
        global $cfg;

        $SQL = "SELECT DATE_FORMAT(dateHistorique, '%Y-%m-%d %H:%i:%s') AS dateHistorique, historiquesActionsLangues.titreHistoriqueActionLangue, messageHistorique, historiques.noUsager, usagers.prenomUsager
            FROM    historiques
            
            INNER JOIN historiquesActionsLangues
                ON  historiquesActionsLangues.noHistoriqueAction = historiques.noHistoriqueAction
                AND historiquesActionsLangues.noLangue = '$cfg[noLangue]'

            INNER JOIN usagers
                ON  usagers.noUsager = historiques.noUsager";
        
        $demandesInformations = DB::query($SQL)->fetchAll();

        return $demandesInformations;
    }

    public static function Trouver($noEnr = 0){
        $SQL = "SELECT *
                FROM historiques
                WHERE noHistorique = '$noEnr'";
        
        return DB::query($SQL)->fetchAll();
    }

    public static function Enregistrer($options = []) {
        $usagerEnCours = ObtenirInfosUsager();

        $default = [
            "noHistoriqueAction" => HISTORIQUE_ACTION_AJOUTER,
            "messageHistorique" => "",
            "noUsager" => $usagerEnCours["noUsager"] ?? 0,
        ];
    
        $settings = array_merge($default, $options);

        $SQL = "INSERT INTO historiques (
                dateHistorique,
                noHistoriqueAction,
                messageHistorique,
                noUsager) 
            VALUES (
                NOW(6),
                '".$settings["noHistoriqueAction"]."',
                '".$settings["messageHistorique"]."',
                '".$settings["noUsager"]."'
            );";
        
        DB::query($SQL);
    }

    public static function Clean($options = []) {
        global $cfg;

        $default = [
            "dayClean" => 3
        ];

        $settings = array_merge($default, $options);

        $optCourriel = [
            "to" => $cfg["crontaskCourriel"],
            "toName" => "Programmeur",
            "titre" => "Crontak - Clean Log",
            "body" => "<p>Le nettoyage du log est terminé. $settings[dayClean] jours demandé</p>",
        ];

        if(is_numeric($settings["dayClean"]) && $settings["dayClean"] > 0){
            $SQL = "DELETE FROM historiques WHERE dateHistorique < NOW() - INTERVAL ".$settings["dayClean"]." DAY";
            DB::query($SQL);
        } else {
            $optCourriel = [
                "to" => $cfg["crontaskCourriel"],
                "toName" => "Programmeur",
                "titre" => "Crontak erreur - Clean Historique",
                "body" => "<p>Il semble y avoir eu un problème avec le crontask pour le nettoyage de l'historique.</p>",
            ];

            Courriel::Envoie($optCourriel);
        }
    }
}