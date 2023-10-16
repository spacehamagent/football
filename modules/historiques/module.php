<?php

use SHA\Historique;

switch($cfg["action"]){
    case "intranet-lister":
        Render("historiques/intranet-lister");
    break;

    case "intranet-lister-ajax":
        echo json_encode(CreerTable(Historique::Lister(), ["table" => "historiques"]));
        exit();
    break;

    default:
        abort();
}