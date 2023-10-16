<?php

use SHA\Actualite;

$cfg["minWidth"] = 300;
$cfg["minHeight"] = 275;

switch ($cfg["action"]) {
    case "intranet-lister":
        Render("actualites/intranet-lister");
    break;

    case "intranet-lister-ajax":
        echo json_encode(CreerTable(Actualite::Lister(), ["table" => "clients"]));
        exit();
    break;

    case "intranet-ajouter":
    case "intranet-editer":
        $noEnr = $cfg["variables"][1] ?? 0;

        if($noEnr > 0) {
            $enr = Actualite::Trouver($noEnr);
            $enr[0]["noEnr"] = $enr[0]["noActualite"];
        } else {
            $enr = Actualite::GenererEnr("noActualite",["actualites", "actualitesLangues"]);
            $enr[0]["noEnr"] = $noEnr;
        }

        Render("actualites/intranet-formulaire", ["enr" => $enr]);
    break;

    case "intranet-ajouter-traitement":
    case "intranet-editer-traitement":
        $params = $_POST;
        if(isset($params["noEnr"])) {
            Actualite::Enregistrer($params);
            echo json_encode(["etat" => 1, "message" => "Sauvegarde"]);
        } else {
            echo json_encode(["etat" => 0, "message" => "Impossible de sauvegarder..."]);
        }
        exit();
    break;

    case "intranet-supprimer":
        $noEnr = $_POST["noEnr"] ?? 0;
        $suppression = Actualite::Supprimer($noEnr);
        if($suppression):
            echo json_encode(["etat" => 1, "message" => "Supprimer"]);
        else:
            echo json_encode(["etat" => 0, "message" => "Impossible de supprimer"]);
        endif;
        exit();
    break;

    case "site-lister":
        Render("actualites/site-lister");
    break;

    default:
        abort();
}
