<?php

use SHA\Fichier;
use SHA\Usager;

switch($cfg["action"]){
    case "intranet-lister":
        $stockages = Fichier::StockageTotal($_SESSION["microsite_".MICROSITE_INTRANET]["usager"]["noUsager"]);
        Render("fichiers/intranet-lister", ["stockages" => $stockages]);
    break;

    case "intranet-lister-fichiers-confirmer":
        $html = "";
        $fichiersConfirm = Fichier::TrouverFichiers(["confirmerSeulement" => false]);
        ob_start();
        Render("fichiers/intranet-fichiers-confirm", ["fichiersConfirm" => $fichiersConfirm, "stockages" => $stockages]);
        $html = ob_get_contents();
        ob_end_clean();

        echo json_encode(["etat" => 1, "html" => $html]);
        exit();
    break;

    case "intranet-fichiers-traitement":
        if(Fichier::MiseAJourFichier($_POST)) {
            echo json_encode(["etat" => 1, "message" => "Sauvegarde"]);
        } else {
            echo json_encode(["etat" => 0, "message" => "Erreur..."]);
        }
        exit();
    break;

    case "intranet-fichiers-load":
        $url = "";
        $noIndex = $_POST["noIndex"] ?? 0;
        $limite = 21;

        $fichiers = Fichier::TrouverFichiers(["limite" => $limite, "index" => $noIndex, "avatar" => true]);

        if(!empty($fichiers)){
            ob_start();
            Render("fichiers/intranet-fichiers-lister", ["fichiers" => $fichiers]);
            $url = ob_get_contents();
            ob_end_clean();

            echo json_encode(["etat" => 1, "html" => $url]);
        } else {
            echo json_encode(["etat" => 0, "html" => $url]);
        }
        exit();
    break;

    case "intranet-obtenir-modal-imgParcourir":
        $html = '';

        ob_start();
        Render('fichiers/intranet-crop-image');
        $html = ob_get_contents();
        ob_end_clean();
        
        echo json_encode(["etat"=>1, "html" => $html]);
        exit();
    break;

    case "intranet-obtenir-fichiers-image":
        $fichiersImage = Fichier::Lister(["imageSeulement" => true]);
        echo json_encode(["etat" => 1, "images" => $fichiersImage]);
        exit();
    break;

    case "intranet-crop-image-sauvegarde":
        $imageInfos = Fichier::CropImage($_POST["tmpNom"], [
            "img" => $_POST["img"],
            "x" => $_POST["x"],
            "y" => $_POST["y"],
            "width" => $_POST["width"],
            "height" => $_POST["height"],
            "largeur" => $_POST["largeur"],
            "hauteur" => $_POST["hauteur"],
            "enregistrer" => true]);
        echo json_encode(["etat" => 1, "message" => "Sauvegarde de l'image fait", "imageInfos" => $imageInfos]);
        exit();
    break;

    case "intranet-fichiers-setAvatar":
        $noImage = $_POST["noImage"] ?? 0;
        if ($noImage > 0) {
            if (Fichier::SetImageAvatar($noImage)) {
                echo json_encode(["etat" => 1, "message" => "Avatar added"]);
            } else {
                Usager::SetDefaultAvatarToUsers($noImage);
                echo json_encode(["etat" => 0, "message" => "Avatar removed"]);
            }
        }
        exit();
    break;

    case "intranet-fichiers-archive":
        $noImage = $_POST["noImage"] ?? 0;
        if ($noImage > 0) {
            if(Fichier::ArchiveFichier($noImage)){
                echo json_encode(["etat" => 1, "message" => "Fichier archive"]);
            } else {
                echo json_encode(["etat" => 0, "message" => "Aucun fichier..."]);
            }
        }
        exit();
    break;

    case "intranet-fichier-sauvegarder-traitement":
        $donnees = ["fichier" => $_FILES["file"], "noUsager" => $noUsager];
        Fichier::UploadFichier($donnees);

        echo json_encode(["etat" => 1, "message" => "Sauvegarde"]);
        exit();
    break;

    case "intranet-fichiers-supprimer-traitement":
        $noEnr = $_POST["noEnr"] ?? 0;

        if(Fichier::SupprimerFichier($noEnr)){
            echo json_encode(["etat" => 1, "message" => "Supprimer"]);
        } else {
            echo json_encode(["etat" => 0, "message" => "Erreur..."]);
        }
        exit();
    break;

    case "intranet-url-fichier":
        $lienURL = Fichier::TrouverLienFichier($_POST);
        echo json_encode(["etat" => 1, "lienUrl" => $lienURL]);
        exit();
    break;

    default:
        abort();
}
