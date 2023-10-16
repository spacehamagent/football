<?php

use SHA\Rechercher;
use SHA\Fichier;


switch ($cfg["action"]) {
    case "intranet-lister":
        $mots = $_GET["motRecherche"] ?? "";
        //$fichiersResultat = Fichier::Rechercher($mots);
        $resultats = Rechercher::Rechercher($mots);
        Render("recherches/intranet-lister",["resultats" => $resultats, "mots" => $mots]);

    break;

    default:
        abort();
}