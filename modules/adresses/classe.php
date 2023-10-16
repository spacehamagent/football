<?php

namespace SHA;

class Adresse extends Module{
    private static $adresse = "";
    private static $codePostal = "";
    
    public static function Trouver($noEnr){
        $SQL = "SELECT * FROM adresses
            WHERE   noAdresse = '".$noEnr."'";
        return DB::query($SQL)->fetchAll();
    }

    public static function Ajouter($donnees){
        $SQL = "INSERT INTO adresses (
                adresseAdresse,
                codePostalAdresse,
                villeAdresse,
                provinceAdresse,
                noPays
            ) VALUES (
                '$donnees[adresse]',
                '$donnees[codePostal]',
                '$donnees[ville]',
                '$donnees[province]',
                '$donnees[pays]'
            );";

        DB::query($SQL);

        return DB::obtenirDernierID();
    }

    public static function Enregistrer($noEnr, $donnees){
        $noPays = $donnees["pays"] ?? PAYS_CANADA;

        $SQL = "UPDATE adresses
            SET adresseAdresse = '$donnees[adresse]',
                codePostalAdresse   = '$donnees[codePostal]',
                villeAdresse = '$donnees[ville]',
                provinceAdresse = '$donnees[province]',
                noPays = '$noPays'
            WHERE   noAdresse = '$noEnr'";
        DB::query($SQL);
    }

    public static function Supprimer($noEnr){
        $adresse = self::Trouver($noEnr);

        if($adresse){
            $SQL = "DELETE FROM adresses WHERE noAdresse = '$noEnr'";
            DB::query($SQL);

            return true;
        } else {
            return false;
        }
    }
}