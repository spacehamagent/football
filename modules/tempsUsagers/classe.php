<?php

namespace SHA;

class TempUsager extends Module{

    public static function Lister(){
        
    }

    public static function AjouterTemps($options){
        $default = [
            "noUsager" => 0,
            "tempDebutAjout" => "2019-01-01",
            "tempFinAjout" => "2019-01-01"
        ];

        $settings = array_merge($default, $options);
        if(strlen($settings["tempDebutAjout"]) > 0 && strlen($settings["tempFinAjout"]) > 0){
            if(self::VerifierTemps($settings)){
                $SQL = "INSERT INTO tempsUsagers (
                        noTempUsager,
                        noUsager,
                        dateDebutTempUsager,
                        dateFinTempUsager
                    ) VALUES (
                        NOW(),
                        '$settings[noUsager]',
                        '$settings[tempDebutAjout]',
                        '$settings[tempFinAjout]'
                    );";
                DB::query($SQL);
                return true;
            }
        }
        return false;
    }

    private static function VerifierTemps($options = []){
        $default = [
            "noUsager" => 0,
            "tempDebutAjout" => "2019-01-01",
            "tempFinAjout" => "2019-01-01"
        ];

        $settings = array_merge($default, $options);
        
        $SQL = "SELECT * FROM tempsUsagers
        WHERE noUsager = '$settings[noUsager]'
            AND ( ('$settings[tempDebutAjout]' BETWEEN dateDebutTempUsager AND dateFinTempUsager
            OR '$settings[tempFinAjout]' BETWEEN dateDebutTempUsager AND dateFinTempUsager)
            OR (dateDebutTempUsager BETWEEN '$settings[tempDebutAjout]' AND '$settings[tempFinAjout]'
            OR  dateFinTempUsager BETWEEN '$settings[tempDebutAjout]' AND '$settings[tempFinAjout]'));";
        
        $resultat = DB::query($SQL)->fetchAll();

        if(empty($resultat)):
            return true;
        else:
            return false;
        endif;
    }

    public static function CalculerTemps($options = []){
        $default = [
            "noUsager" => 0,
            "dateDebut" => "2019-01-01",
            "dateFin" => "2019-01-01"
        ];

        $settings = array_merge($default, $options);

        $SQL = "SELECT * FROM tempsUsagers
            WHERE   noUsager = '".$settings["noUsager"]."'
                AND dateDebutTempUsager >= '".$settings["dateDebut"]." 00:00:00'
                AND dateFinTempUsager <= '".$settings["dateFin"]." 23:59:59'";

        $listeTemps = DB::query($SQL)->fetchAll();

        $secondes = 0;

        foreach($listeTemps as $temps){
            $secondes += self::CalculerSecondes($temps["dateDebutTempUsager"], $temps["dateFinTempUsager"]);
        }

        return $secondes;
    }

    private static function CalculerSecondes($dateDebut, $dateFin){
        $secondes = 0;

        $secondes = strtotime(date($dateFin)) - strtotime(date($dateDebut));

        return $secondes;
    }

    public static function SecondesEnHeures($secondes = 0){
        $heures=intval($secondes / 3600);
        if(intval($heures) <= 9){
            $heures = "0".$heures;
        }
        $minutes=intval(($secondes % 3600) / 60);
        if(intval($minutes) <= 9){
            $minutes = "0".$minutes;
        }
        $sec=intval((($secondes % 3600) % 60));
        if(intval($sec) <= 9){
            $sec = "0".$sec;
        }
        return $heures.":".$minutes.":".$sec;
    }

    public static function SecondesEnDecimal($secondes = 0){
        $h = $secondes / 3600;

        return number_format((float)$h, 2, '.', '');
    }
}