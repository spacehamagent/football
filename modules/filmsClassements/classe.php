<?php

namespace SHA;

class FilmClassement extends Module{
    
    public static function Lister(){
        $SQL = "SELECT noFilmClassement, titreFilmClassementLangue
            FROM    filmsClassements";
        
        $films = DB::query($SQL)->fetchAll();

        return $films;
    }

    public static function Trouver($noEnr){
        $SQL = "SELECT  *, noUsager as noEnr
            FROM    usagers
            
            WHERE   usagers.noUsager = '$noEnr'";
        return DB::query($SQL)->fetchAll();
    }
}
