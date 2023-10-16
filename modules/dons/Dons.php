<?php
//Tentative avec Laravel pour ce module

namespace SHA;

class Dons extends Module{

    public $tables = ["dons"];

    public $colonnes = [
        "noDons",
        "montantDons",
        "dateRecuDons",
        "prenomDons",
        "nomDons",
        "telephoneDons",
        "courrielDons",
    ]

    public static function Lister(){
        global $cfg;

        $SQL = "SELECT noDons, montantDons, dateRecuDons
            FROM    dons";
        
        $dons = DB::query($SQL)->fetchAll();

        return $dons;
    }

    public function GetMontant() {
        return $this->montantDon . "$";
    }

    public function GetNomComplet() {
        return $this->prenomDons . " " . $this->nomDons;
    }
}
