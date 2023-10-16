<?php

use SHA\TempUsager;

switch($cfg["action"]){
    case "intranet-lister":
        Render("tempsUsagers/intranet-lister", []);
    break;

    case "intranet-calculer-temps":
        $params = $_POST;
        $secondes = 0;
        $resultats = ["etat" => 1, "secondes" => 0, "temps" => "", "tempsDecimal" => ""];
        
        if(isset($params["dateDebut"]) && isset($params["dateFin"])):
            $secondes = TempUsager::CalculerTemps([
                "noUsager" => $_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["noUsager"],
                "dateDebut" => $params["dateDebut"], 
                "dateFin" => $params["dateFin"]
                ]);
        endif;

        if($secondes > 0):
            $resultats["secondes"] = $secondes;
            $resultats["temps"] = TempUsager::SecondesEnHeures($secondes);
            $resultats["tempsDecimal"] = TempUsager::SecondesEnDecimal($secondes);
        else:
            $resultats["etat"] = 0;
        endif;
    
        echo json_encode($resultats);
        exit();
    break;

    case "intranet-ajouter-temps":
        $params = $_POST;
        $params["noUsager"] = $_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["noUsager"] ?? 0;
        
        if(TempUsager::AjouterTemps($params)){
            echo json_encode(["etat" => 1, "message" => "Sauvegarde!"]);
        } else {
            echo json_encode(["etat" => 0, "message" => "Erreur sauvegarde!"]);
        }
        exit();
    break;

}