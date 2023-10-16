<?php

use SHA\Film;

switch($cfg["action"]){
    case "intranet-lister":
        
    break;

    case "intranet-liste-ajax":
        echo json_encode(CreerTable(Film::Lister()));
        exit();
    break;

    case "site-lister":

    break;

    default:
        abort();
}
