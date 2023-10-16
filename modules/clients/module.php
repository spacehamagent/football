<?php

use SHA\Client;

switch ($cfg["action"]) {
    case "intranet-lister":
        Render("clients/intranet-lister");
    break;

    case "intranet-lister-ajax":
        echo json_encode(CreerTable(Client::Lister(), ["table" => "clients"]));
        exit();
    break;

    case "intranet-ajouter":
    case "intranet-editer":
        $noEnr = $cfg["variables"][1] ?? 0;
        $enr = Client::Trouver($noEnr);

        if($cfg["action"] == "intranet-ajouter") {
            $enr = Client::GenererEnr("noClient", ["clients"]);
        }
        
        if($enr){
            Render("clients/intranet-formulaire",[
                "enr" => $enr
            ]);
        } else {
            echo "<p>Aucun enregistrement</p>";
        }
    break;

    case "intranet-ajouter-traitement":
    case "intranet-editer-traitement":
        if(Client::Enregistrer($_POST)) {
            echo json_encode(["etat" => 1, "message" => "Enregistrement fait"]);
        } else {
            echo json_encode(["etat" => 0, "message" => "Enregistrement impossible."]);
        }
        exit();
    break;

    case "intranet-verifier-courriel-traitement":
        $courriel = $_POST["courriel"] ?? "";
        $reponse = ["etat" => 0, "message" => "Aucun enregistrement"];

        if(strlen($courriel) > 0) {
            $enr = Client::TrouverParCourriel($courriel);
            if(!empty($enr)) {
                $reponse["etat"] = 1;
                $reponse["message"] = "Enregistrement trouvé";
            }
        }
        echo json_encode($reponse);
        exit();
    break;

    default:
        abort();
}
