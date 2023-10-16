<?php

use SHA\Page;
use SHA\Usager;
use SHA\Bloc;

switch($cfg["action"]) {
    case "intranet-lister":
        $noMicrosite = GestListingPageShow();
        $variables = [
            "noMicrosite" => $noMicrosite
        ];
        Render("pages/intranet-lister", $variables);
    break;

    case "intranet-lister-ajax":
        $options = [
            "noMicrosite" => $_GET["noMicrosite"] ?? MICROSITE_INTRANET
        ];
        echo json_encode(CreerTable(Page::Lister($options)));
        exit();
    break;

    case "intranet-ajouter":
        echo "ajouter page";
    break;

    case "intranet-editer":
        $noEnr = $cfg["variables"][1] ?? 0;
        $enr = Page::Trouver($noEnr);
        $listeModule = TrouverTousLesModules();
        $blocs = Bloc::ObtenirBlocs($noEnr);

        if($enr){
            $pagesParent = Page::Lister(["pagesRetirees" => $enr[0]["noPage"]]);
            Render("pages/intranet-formulaire",[
                        "enr" => $enr, 
                        "pagesParent" => $pagesParent,
                        "listeModule" => $listeModule,
                        "blocs" => $blocs
            ]);
        } else {
            echo '<p>La page demandé ne peut être trouvé</p>';
        }
    break;

    case "intranet-editer-traitement":
        $sauvegarder = Page::Enregistrer($_POST);
        if($sauvegarder):
            echo json_encode(["etat" => 1, "message" => "Sauvegarde"]);
        else:
            echo json_encode(["etat" => 0, "message" => "Impossible de sauvegarder..."]);
        endif;
        exit();
    break;

    case "intranet-supprimer":
        echo "SUPPRIMER PAGE";exit();
    break;

    case "intranet-page-actif-traitement":
        Page::SetActiverDesactiverPage($_POST["noEnr"]);
        echo json_encode(["etat" => 1, "message" => "Sauvegarde"]);
        exit();
    break;

    // BLOC
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
    // Fin Bloc

    case "intranet-login":
        Render("usagers/intranet-login", []);
    break;

    case "intranet-login-traitement":
        $connexion = Usager::Connexion($_POST);

        if($connexion):
            echo json_encode(["etat" => 1, "message" => "Connexion en cours..."]);
        else:
            echo json_encode(["etat" => 0, "message" => "Informations manquante!"]);
        endif;
        exit();
    break;

    default:
        abort();
}
