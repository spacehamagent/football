<?php

namespace SHA;

class Film extends Module {
    protected $tables = ["films","filmsLangues"];
    protected $variables = [
        "noFilm",
        "dateSortieCinemaFilm",
        "titreFilmOriginal",
        "budgetFilm"
        "titreFilmLangue",
    ];
    
    public static function Lister() {
        $SQL = "SELECT noFilm, dateSortieCinemaFilm, titreFilmOriginal, budgetFilm, titreFilmLangue
            FROM    films";
        
        $films = DB::query($SQL)->fetchAll();

        return $films;
    }

    public static function Trouver($noEnr) {
        $SQL = "SELECT  *, noUsager as noEnr
            FROM    films

            INNER JOIN filmsLangues
                ON  filmsLangues.noFilm = films.noFilm
                AND  filmsLangues.noLangue = ".$cfg["langue"]."

            WHERE   usagers.noUsager = '$noEnr'";
        return DB::query($SQL)->fetchAll();
    }
}
