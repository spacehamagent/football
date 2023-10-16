<?php

namespace SHA;

class Rechercher extends Module
{
    public static function Rechercher($mots = ""){
        $resultats = [];
        if(strlen($mots) > 3 ){
            $resultats["fichiers"] = Fichier::Rechercher($mots);
        }

        return $resultats;
    }
}