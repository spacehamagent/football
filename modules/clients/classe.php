<?php

namespace SHA;

class Client extends Module
{
    public static function Lister($options = []) {
        $default = [
            "actifSeulement" => false
        ];

        $settings = array_merge($default, $options);

        $SQL = "SELECT noClient, prenomClient, nomClient, courrielClient, recevoirCourrielClient FROM clients";

        return DB::query($SQL)->fetchAll();
    }

    public static function Trouver($noEnr = 0) {
        $SQL = "SELECT  *, noClient as noEnr
            FROM    clients
            
            WHERE   clients.noClient = '$noEnr'";
        return DB::query($SQL)->fetchAll();
    }

    public static function TrouverParCourriel($courriel = "") {
        $SQL = "SELECT *
            FROM    clients
            WHERE   clients.courrielClient = '".$courriel."';";
        return DB::query($SQL)->fetchAll();
    }

    public static function Enregistrer($donnees = []) {
        if(!empty($donnees)) {
            if($donnees["noEnr"] > 0) {
                return self::Editer($donnees);
            } else {
                return self::Ajouter($donnees);
            }
        }
        return false;
    }

    private static function Ajouter($donnees = []) {
        if(!empty($donnees)) {
            $SQL = "INSERT INTO clients (
                prenomClient,
                nomClient,
                telephoneClient,
                cellulaireClient,
                courrielClient,
                recevoirCourrielClient
            ) VALUES (
                '".$donnees["prenomClient"]."',
                '".$donnees["nomClient"]."',
                '".$donnees["telephoneClient"]."',
                '".$donnees["cellulaireClient"]."',
                '".$donnees["courrielClient"]."',
                '".$donnees["recevoirCourrielClient"]."'
            );";
            DB::query($SQL);
            return true;
        }
        return false;
    }

    private static function Editer($donnees = []) {
        if(!empty($donnees)) {
            $SQL = "UPDATE clients
                SET prenomClient            = '".$donnees["prenomClient"]."',
                    nomClient               = '".$donnees["nomClient"]."',
                    telephoneClient         = '".$donnees["telephoneClient"]."',
                    cellulaireClient        = '".$donnees["cellulaireClient"]."',
                    courrielClient          = '".$donnees["courrielClient"]."',
                    recevoirCourrielClient  = '".$donnees["recevoirCourrielClient"]."'
                WHERE   noClient = '".$donnees["noEnr"]."'";
            DB::query($SQL);
            return true;
        }
        return false;
    }

    public static function ReceptionCourriel($options = []){
        $default = [
            "noEnr" => 0,
            "recevoirCourriel" => 0
        ];

        $settings = array_merge($default, $options);

        if($settings["noEnr"] > 0){
            $SQL = "UPDATE clients
                SET recevoirCourrielClient = '$settings[recevoirCourriel]'
                WHERE   noClient = '$settings[noEnr]'";
            DB::query($SQL);
            return true;
        }
    
        return false;
    }
}
