<?php

use SHA\Video;

switch($cfg["action"]){
    case "intranet-lister":
        $noVideo = $_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["parametres"]["videoBienvenue"] ?? 0;
        $video = Video::Trouver($noVideo);
        
        Render("accueil/intranet-accueil", ["video" => $video]);
    break;

    case "site-lister":
        Render("accueil/site-lister");
    break;
}