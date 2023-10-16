<?php
ini_set('default_charset','utf-8');
date_default_timezone_set('America/Montreal');

header('Cache-Control: no-cache, must-revalidate');
header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');

include __DIR__ . '/../config/configuration.inc.php';

session_start();

use SHA\DB;
use SHA\Fichier;
use SHA\Log;
use SHA\Page;

if(isset($_GET["terminerSession"]) && (is_numeric($_GET["terminerSession"]) && $_GET["terminerSession"] == 1)){
    TerminerSession();
}

CleanData();

$cfg["ajax"] = VerifierAjaxURL();


$page = TrouverPage(["repertoire" => $cfg["params"]["REDIRECT_URL"]]);

if($cfg["module"] == "login" || $cfg["module"] == "connexion"):
    $cfg["module"] = "usagers";
endif;

$cfg["contenu"] = "";
$tpl["contenu"] = "";
$tpl["contenuPage"] = "";
$tpl["titreIndexation"] = $cfg["indexation"]["titre"] ?? "";
$tpl["descriptionIndexation"] = $cfg["indexation"]["description"] ?? "";

$tpl["cssInfosGeneral"] = PreparerCSSInfosGeneral();

if(count($page) > 0){
    //$cfg["pages"] = $page[0];
    //Entrer info de la page nécessaire
    $cfg["page"]["indexationPage"] = $page[0]["indexationPage"];
    $cfg["page"]["afficherDescriptionPage"] = $page[0]["afficherDescriptionPage"] ?? '';

    $cfg["PageAnalyse"] = $page[0]["indexationPage"] ?? false;

    if($cfg["noMicrosite"] == MICROSITE_INTRANET){
        $redirect = false;

        if($page[0]["noPage"] != INTRANET_LOGIN){
            $urlRedirect = TrouverLien(SITE_ACCUEIL);

            if(!isConnected($cfg["noMicrosite"])){
                $urlRedirect = TrouverLien(INTRANET_LOGIN);
                $redirect = true;
            }
        } else {
            if(isConnected($cfg["noMicrosite"])){
                $urlRedirect = TrouverLien(SITE_ACCUEIL);
                $redirect = true;
            }
        }

        if($redirect) {
            header("Location: http://".$_SERVER['HTTP_HOST'].$urlRedirect);
            exit;
        }
    }

    /** Obtenir le menu  */
    $pagesSite = Page::BuildMenuSite();
    //echo BuildTableauMenuSite($pagesSite);
    $tpl["menuSite"] = BuildTableauMenuSite($pagesSite);
    //echo $tpl["menu"];die();
    //die();

    /*
    $tpl["menu"] = "";
    ob_start();
    $pagesSite = Page::BuildMenuSite();
    BuildTableauMenuSite($pagesSite);
    $tpl["menu"] = ob_get_contents();
    ob_end_clean();
    */

    /** Obtenir URL des autres langues pour cette page */
    $tpl["autresLanguesMenu"] = "";
    ob_start();
    TrouverPageAutresLangues($page[0]["noPage"]);
    $tpl["autresLanguesMenu"] = ob_get_contents();
    ob_end_clean();


    /*  Obtenir contenu de la page */
    if (isset($page[0]["descriptionPageLangue"]) 
            && strlen($page[0]["descriptionPageLangue"]) > 0
            && $page[0]["afficherDescriptionPage"]) {
        ob_start();
        echo $page[0]["descriptionPageLangue"];
        $tpl["contenuPage"] = ob_get_contents();
        ob_clean();
    }

    if(isset($page[0]["titreIndexationPageLangue"])
        && strlen($page[0]["titreIndexationPageLangue"]) > 0) {
            ob_start();
        echo $page[0]["titreIndexationPageLangue"];
        $tpl["titreIndexation"] = ob_get_contents();
        ob_clean();
    }
    if(isset($page[0]["descriptionIndexationPageLangue"])
        && strlen($page[0]["descriptionIndexationPageLangue"]) > 0) {
            ob_start();
        echo $page[0]["descriptionIndexationPageLangue"];
        $tpl["descriptionIndexation"] = ob_get_contents();
        ob_clean();
    }

    /*  Obtenir contenu du module de la page */
    if (isset($page[0]["modulePage"]) & strlen($page[0]["modulePage"]) > 0) {
        ob_start();
        ExecuterModule($cfg["module"]);
        $tpl["contenu"] = ob_get_contents();
        ob_clean();
    }
} else {
    $cfg["erreur404"] = true;
}


if(!$cfg["ajax"]){
    if($cfg["erreur404"]):
        ExecuterModule("404");
    endif;

    $tpl["menu"] = ConstruireMenu([
                "microsite" => $cfg["noMicrosite"],
                "usager" => ((EstAdmin()) ? ADMINISTRATEUR : USAGER)
            ]);

    //Log enregistrer historique visiteur | site web
    if($cfg["noMicrosite"] == MICROSITE_SITE) {
        Log::EnregistrerVisiteur(["msgLog" => $cfg["msgLog"]]);
    }

    include $cfg["params"]["DOCUMENT_ROOT"].'/../system/views/'.$cfg["microsite"].'.tpl';
} else {
    exit();
}

$nbRequete = DB::nbRequetes();
echo "<!---- NB REQUETE: ".$nbRequete.(($page != null) ? ' | noPage: '.$page[0]["noPage"] : '')." -->";
