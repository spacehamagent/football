<?php

include '../../config/configuration.inc.php';

use SHA\DB;


$SQL = "SELECT * FROM country;";

$listePays = DB::query($SQL)->fetchAll();

$SQL = "DELETE FROM `pays` WHERE 1=1; DELETE FROM `paysLangues` WHERE 1=1";
DB::query($SQL);

$SQL = "ALTER TABLE pays AUTO_INCREMENT = 5;";
DB::query($SQL);

foreach($listePays as $pays){
    $SQL = "INSERT INTO pays (codePays) VALUES ('$pays[iso]');";
    DB::query($SQL);

    $noEnr = DB::obtenirDernierID();

    foreach($cfg["languesSite"] as $i) {
        $SQL = "INSERT INTO paysLangues (noPays,noLangue,titrePaysLangue) VALUES ($noEnr, $i, \"$pays[nicename]\");";
        DB::query($SQL);
    }
}

echo "<p>Imporation terminé !</p>";
exit();
