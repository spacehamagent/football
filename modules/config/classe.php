<?php

namespace SHA;

class Config extends Module{
    private static $defaultVariables = [
        FRANCAIS => [
            'nomProjet' => 'Template FR',
            'courriel' => '',
            'metaTitre' => '',
            'metaDescription' => '',
            'courrielDemandeInformationFrom' => '',
            'courrielDemandeInformationTo' => '',
            'langueActiveSite' => true,
        ],
        ANGLAIS => [
            'nomProjet' => 'Template EN',
            'courriel' => '',
            'metaTitre' => '',
            'metaDescription' => '',
            'courrielDemandeInformationFrom' => '',
            'courrielDemandeInformationTo' => '',
            'langueActiveSite' => false,
        ],
        'adresse' => '',
        'ville' => '',
        'province' => '',
        'pays' => '',
        'codePostal' => '',
        'telephone' => '',
        'sansFrais' => '',
        'googleAnalytic' => '',
        'sharethis' => '',
    ];
    
    public static function GetConfig() {
        $SQL = "SELECT * FROM configurations;";

        return DB::query($SQL)->fetch();
    }

    public function ReturnDefault() {
        return self::$defaultVariables;
    }

    public function EnregistrerConfig($donnees = []) {
        global $cfg;
        $values = "";
        $tmpConfig = [];

        foreach($cfg["languesSite"] as $i) {
            if(!isset($donnees["siteLangue-".$i]))
                if($i == LANGUE_PRINCIPAL){
                    $donnees["siteLangue-".$i] = 1;
                } else {
                    $donnees["siteLangue-".$i] = 0;
                }
            else {
                $donnees["siteLangue-".$i] = 1;
            }
        }

        if(!empty($donnees)) {
            foreach($donnees as $k => $v) {
                if (strpos($k, '_') !== false) {
                    $noLangue = substr($k, -1);
                    $variable = substr($k, 0, strpos($k, "_")); 
                    $tmpConfig[$noLangue][$variable] = safe($v);
                } else {
                    $tmpConfig[$k] = $v;
                }
            }

            $jsonConfig = json_encode($tmpConfig, JSON_UNESCAPED_UNICODE);

            $SQL = "UPDATE configurations
                        SET templateConfiguration = '$jsonConfig'";

            DB::query($SQL);
            return true;
        }

        return false;
    }

    public static function ObtenirConfig(){
        $defaultConfig = self::GetConfig();
        $templateConfig = $defaultConfig["templateConfiguration"] ?? '';

        if(strlen($templateConfig) == 0) {
            $templateConfig = $defaultConfig["defaultConfiguration"] ?? '';
        }

        return json_decode($templateConfig, true);
    }
}
