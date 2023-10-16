<?php

namespace SHA;

class UsagerParametre extends Module{

    public static function Trouver($noEnr){
        $SQL = "SELECT  *
            FROM    usagersParametres
            
            WHERE   usagersParametres.noUsager = '$noEnr'";
        return DB::query($SQL)->fetchAll();
    }

}