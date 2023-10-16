<?php

namespace SHA;

class Pays extends Module{
    
    public static function Lister(){
        global $cfg;

        $SQL = "SELECT pays.*, paysLangues.titrePaysLangue
            FROM    pays

            INNER   JOIN paysLangues
                ON  paysLangues.noPays = pays.noPays
                AND paysLangues.noLangue = '$cfg[noLangue]'";
        
        return DB::query($SQL)->fetchAll();
    }
}