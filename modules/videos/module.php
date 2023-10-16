<?php

use SHA\Video;
use SHA\Groupe;

switch($cfg["action"]){
    case "intranet-lister":
        Render("videos/intranet-lister");
    break;

    case "intranet-lister-ajax":
        echo json_encode(CreerTable(Video::Lister(["videosGroupe" => true]), ["table" => "videos"]));
        exit();
    break;

    case "intranet-ajouter":
        $enr = Video::GenererEnr("noVideo", ["videos", "videosLangues"]);
        $listeGroupe = Groupe::Lister();
        $videoGroupe = Video::ListerGroupeVideo($enr[0]["noEnr"]);
        Render("videos/intranet-formulaire", ["enr" => $enr, 
                                            "listeGroupe" => $listeGroupe, 
                                            "videoGroupe" => $videoGroupe]);
    break;

    case "intranet-ajouter-traitement":
        Video::Ajouter($_POST);
        echo json_encode(["etat" => 1, "message" => "Sauvegarde"]);
        exit();
    break;

    case "intranet-editer":
        $noEnr = $cfg["variables"][1] ?? 0;
        $enr = Video::Trouver($noEnr);

        if($enr){
            $listeGroupe = Groupe::Lister();
            $videoGroupe = Video::ListerGroupeVideo($enr[0]["noVideo"]);
            Render("videos/intranet-formulaire", ["enr" => $enr, 
                                            "listeGroupe" => $listeGroupe,
                                            "videoGroupe" => $videoGroupe]);
        } else {
            echo "<p>Aucune vidéo trouvée.</p>";
        }
    break;

    case "intranet-editer-traitement":
        $params = $_POST;
        $sauvegarder = Video::Enregistrer($params);
        Groupe::EnregistrerGroupeVideo($params["noEnr"], $params);

        if($sauvegarder):
            echo json_encode(["etat" => 1, "message" => "Sauvegarde"]);
        else:
            echo json_encode(["etat" => 0, "message" => "Impossible de sauvegarder..."]);
        endif;
        exit();
    break;

    case "intranet-video-view":
        $noEnr = $_POST["noEnr"] ?? 0;
        $video = Video::Trouver($noEnr);
        if($video):
            $id = $video[$cfg["noLangue"]]["idVideoLangue"];
            $urlVideo = '<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/'.$id.'"></iframe>';
            echo json_encode(["etat" => 1, "message" => $urlVideo]);
        else:
            echo json_encode(["etat" => 0, "message" => "Impossible de trouver l'enregistrement"]);
        endif;
        exit();
    break;

    case "intranet-video-id":
        $id = $_POST["id"] ?? "";
        $reponse = ["etat" => 0, "message" => "Impossible de trouver l'enregistrement"];

        if(strlen($id) > 0) {
            $urlVideo = '<iframe class="embed-responsive-item" width="420" height="315" src="https://www.youtube.com/embed/'.$id.'"></iframe>';
            $reponse["etat"] = 1;
            $reponse["message"] = "Affichage de l'id";
            $reponse["video"] = $urlVideo;
        }
        echo json_encode($reponse);
        exit();
    break;

    case "intranet-supprimer":
        $noEnr = $_POST["noEnr"] ?? 0;
        $suppression = Video::Supprimer($noEnr);
        if($suppression):
            echo json_encode(["etat" => 1, "message" => "Supprimer"]);
        else:
            echo json_encode(["etat" => 0, "message" => "Impossible de supprimer"]);
        endif;
        exit();
    break;

    default:
        abort();
}