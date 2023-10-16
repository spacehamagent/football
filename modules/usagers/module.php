<?php

use SHA\Usager;
use SHA\UsagerParametre;
use SHA\Adresse;
use SHA\Historique;
use SHA\Log;
use SHA\Video;
use SHA\Pays;
use SHA\Courriel;
use SHA\Fichier;

switch($cfg["action"]){
    case "intranet-lister":
        if(isConnected()){
            Render("usagers/intranet-lister");
        } else {
            $action = $_GET["action"] ?? "";
            if($action == "resetPass"):
                $hash = $_GET["hash"] ?? "";
                $courriel = $_GET["courriel"] ?? "";

                $usager = Usager::TrouverHashUsager($hash);
                 
                Render("usagers/intranet-reset",["usager" => $usager, "courriel" => $courriel, "hash" => $hash]);
            else:
                Render("usagers/intranet-login", []);
            endif;
        }
    break;

    case "intranet-liste":
        if(isset($cfg["variables"][1]) && $cfg["variables"][1] == "editer"):
            $index = $cfg["variables"][2] ?? 0;

            header("HTTP/1.1 301 Moved Permanently"); 
            header("Location: /fr/cms/systeme/usagers/editer/".$index."/"); 
            exit();
        elseif(isset($cfg["variables"][1]) && $cfg["variables"][1] == "ajouter"):
            header("HTTP/1.1 301 Moved Permanently"); 
            header("Location: /fr/cms/systeme/usagers/ajouter/"); 
            exit();
        endif;

        if(EstAdmin()){
            Render("usagers/intranet-lister", []);
        } else {
            abort();
        }
    break;

    case "intranet-liste-ajax":
        echo json_encode(CreerTable(Usager::Lister()));
        exit();
    break;

    case "intranet-ajouter":
        $enr = Usager::GenererEnr("noUsager", ["usagers"]);
        $adresse = Adresse::GenererEnr("noAdresse",["adresses"]);
        $listePays = Pays::Lister();
        $images = Fichier::TrouverFichiers(["image" => true, "avatar" => true, "groupeAvagar" => true]);
        $avatar = Fichier::TrouverLienFichier(["noEnr" => $enr[0]["avatarUsager"]]);
        
        Render("usagers/intranet-formulaire", [
            "enr" => $enr, 
            "adresse" => $adresse, 
            "listePays" => $listePays,
            "images" => $images,
            "avatar" => $avatar
        ]);
    break;

    case "intranet-ajouter-traitement":
        if(Usager::Ajouter($_POST)){
            echo json_encode(["etat" => 1, "message" => "Sauvegarde fait!"]);
        } else {
            echo json_encode(["etat" => 0, "message" => "Sauvegarde impossible!"]);
        }
        exit();
    break;

    case "intranet-editer":
        $noEnr = $cfg["variables"][1] ?? 0;
        $enr = Usager::Trouver($noEnr);
        
        if($enr){
            $adresse = Adresse::Trouver($enr[0]["noAdresse"]);
            $listePays = Pays::Lister();
            $images = Fichier::TrouverFichiers(["image" => true, "avatar" => true, "groupeAvatar" => true]);
            $avatar = Fichier::TrouverLienFichier(["noEnr" => $enr[0]["avatarUsager"]]);

            Render("usagers/intranet-formulaire", [
                "enr" => $enr, 
                "adresse" => $adresse, 
                "listePays" => $listePays,
                "images" => $images,
                "avatar" => $avatar
            ]);
        } else {
            echo "<p>Aucun usager trouvé.</p>";
        }
    break;

    case "intranet-editer-traitement":
        if(Usager::Enregister($_POST)){
            echo json_encode(["etat" => 1, "message" => "Sauvegarde fait!"]);
        } else {
            echo json_encode(["etat" => 0, "message" => "Sauvegarde impossible!"]);
        }
        exit();
    break;

    case "intranet-parametres":
        $noVideo = $_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["parametres"]["videoBienvenue"] ?? 0;
        $theme = $_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["parametres"]["theme"] ?? "";
        $listeVideo = Video::Lister(["videosGroupe" => true]);

        Render("usagers/intranet-parametres", ["noVideo" => $noVideo, "theme" => $theme, "videos" => $listeVideo, "themes" => $cfg["themes"]]);
    break;

    case "intranet-parametres-traitement":
        if(Usager::EnregistrerUsagerParametres($_POST)):
            echo json_encode(["etat" => 1, "message" => "Sauvegarde fait!"]);
        else:
            echo json_encode(["etat" => 0, "message" => "Sauvegarde impossible!"]);
        endif;
        exit();
    break;

    case "intranet-reinitialisation":
        $msgReinitaliseMotDePasse = "";
        if(Usager::Reinitialisation($_POST)){
            ob_start();
            TrouverLangue("usagers.msgReinitalisationParCourriel");
            $msgReinitaliseMotDePasse = ob_get_contents();
            ob_end_clean();
            echo json_encode(["etat" => 1, "message" => "$msgReinitaliseMotDePasse"]);
        } else {
            echo json_encode(["etat" => 0, "message" => "Erreur!"]);
        }
        exit();
    break;

    case "intranet-reinitialisation-traitement":
        $resultat = ["etat" => 0, "message" => "Erreur!"];

        if(Usager::MiseAJourMotDePasse($_POST)){
            $resultat["etat"] = 1;
            $resultat["message"] = "Modification fait !";
        }
        
        echo json_encode($resultat);
        exit();
    break;

    case "intranet-login-traitement":
        $usager = Usager::Connexion($_POST);

        if($usager["connexion"]):
            $params = UsagerParametre::Trouver($usager["usager"][0]["noUsager"]);
            if(empty($params)){
                $params = [
                    "themeUsagerParametre" => "dark"
                ];
            }

            MiseAJourSession($usager["usager"][0], $params, MICROSITE_INTRANET);
            Historique::Enregistrer([
                "noHistoriqueAction" => HISTORIQUE_ACTION_CONNEXION,
                "messageHistorique" => "Connexion ".$usager["usager"][0]["prenomUsager"]." [".$usager["usager"][0]["courrielUsager"]."]"
            ]);
            echo json_encode(["etat" => 1, "message" => "Connexion en cours..."]);
        else:
            Log::EnregistrerVisiteur(["msgLog" => "Tentative de connexion échoué. [".$_POST["courriel"]."]"]);
            echo json_encode(["etat" => 0, "message" => "Informations manquante!"]);
        endif;
        exit();
    break;

    case "intranet-supprimer":
        $noEnr = $_POST["noEnr"] ?? 0;
        if(EstAdmin()){
            $suppression = Usager::Supprimer($noEnr);
            if($suppression):
                echo json_encode(["etat" => 1, "message" => "Supprimer"]);
            else:
                echo json_encode(["etat" => 0, "message" => "Impossible de supprimer"]);
            endif;
        } else {
            echo json_encode(["etat" => 0, "message" => "Droits inaccessible"]);
        }
        exit();
    break;

    case "site-lister":

    break;

    default:
        abort();
}
