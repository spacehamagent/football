<?php

use SHA\DemandeInformation;

switch($cfg["action"]){
    case "intranet-lister":
        Render("demandesInformations/intranet-lister");
    break;

    case "intranet-lister-ajax":
        echo json_encode(CreerTable(DemandeInformation::Lister(), ["table" => "demandesInformations"]));
        exit();
    break;


    case "intranet-visualiser":
        $noEnr = $cfg["variables"][1] ?? 0;
        $enr = DemandeInformation::Trouver($noEnr);
        Render("demandesInformations/intranet-afficher", ["enr" => $enr]);
    break;

    case "site-lister":
        Render("demandesInformations/site-lister");
    break;

    case "site-ajouter-traitement":
        $params = $_POST ?? [];
        if(DemandeInformation::Enregistrer($params)) {
            echo json_encode(["etat" => 1, "message" => "recu infos"]);
        } else {
            echo json_encode(["etat" => 0, "message" => "DI"]);
        }
        exit();
    break;

    default:
        abort();
}