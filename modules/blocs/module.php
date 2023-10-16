<?php

use SHA\Bloc;

switch($cfg["action"]) {
    case "intranet-enregistrer-blocs":
        $blocs = $_POST["blocs"] ?? [];
        $reponse = [
            "etat" => 0,
            "message" => "Aucune sauvegarde..."
        ];

        if(!empty($blocs)) {
            Bloc::EnregistrerBlocs($blocs);
            $reponse["etat"] = 1;
            $reponse["message"] = "Blocs enregistres";
        }
        echo json_encode($reponse);
        exit();
    break;

    case "intranet-supprimer-bloc":
        if(Bloc::SupprimerBlocEnregistrement($_POST)) {
            echo json_encode(["etat" => 1, "message" => "Suppression du bloc"]);
        } else {
            echo json_encode(["etat" => 0, "message" => "Suppression impossible..."]);
        }
        exit();

    break;

    case "intranet-obtenir-contenu-bloc-traitement":
        $blocLangue = Bloc::ObtenirContenuBlocLangue($_POST["noBloc"], $_POST["key"], $_POST["index"]);
        echo json_encode(["etat" => 1, "blocLangue" => $blocLangue]);
        exit();
    break;

    case "intranet-edition-bloc-langue":
        $blocLangue = Bloc::ObtenirContenuBlocLangue($_POST["noBloc"], $_POST["key"], $_POST["index"], $_POST["type"]);
        echo json_encode(["etat" => 1, "bloc" => $blocLangue]);
        exit();
    break;

    case "intranet-enregistrer-bloc-langue":
        $reponse = ["etat" => 0, "msg" => "Erreur lors de l'enregistrement..."];
        if(Bloc::EnregistrementContenuBlocEnregistrement($_POST)) {
            $reponse["etat"] = 1;
            $reponse["msg"] = "Enregistrement fait";
        }
        echo json_encode($reponse);
        exit();
    break;

    // Portion pour création du contenu selon le module
    case "intranet-publier-contenu-bloc-page":
        die('Peuple le contenu du bloc pour la page');
        Bloc::PublierBlocs($_POST["infos"]);

    break;

    default:
        $cfg["erreur404"] = true;

}
