<?php

use SHA\Config;

switch($cfg["action"]){
    case "intranet-lister":
        $config = ConfigurationProjet();
        Render("config/intranet-lister", ["config" => $config]);
    break;

    case "intranet-enregistrer-ajax":
        if (Config::EnregistrerConfig($_POST)) {
            echo json_encode(["etat" => 1, "message" => "Sauvegarder"]);
        } else {
            echo json_encode(["etat" => 0, "message" => "Erreur sauvegarde"]);
        }
        exit();
    break;

    default:
        abort();
}