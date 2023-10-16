<?php

namespace SHA;

class UsagerMediaSociaux extends Module{
    private static $mediasSociaux = [];
    
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

}