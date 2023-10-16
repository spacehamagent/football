<?php

use SHA\Config;
use SHA\Page;
use SHA\Module;
use SHA\Fichier;
use SHA\Usager;
use SHA\Courriel;
use Symfony\Component\Dotenv\Dotenv;


Function Configuration() {
	$environnement = getenv('ENVIR_WEB');

	PreparerEnvironnement($environnement);
	ConfigurationEnvironnement();
	ConfigurerInfosProjet();
	PreparerAction();
}

Function ConfigurationEnvironnement() {
	global $cfg;

	$dotenv = new Dotenv();
	$dotenv->load(__DIR__.'/../.env');

	$cfg["nomProjet"] = $_ENV['NOM_PROJET'] ?? $cfg["nomProjet"];
	$cfg["Google"]["analytics"] = $_ENV['GOOGLE_ANALYTIC'] ?? $cfg["Google"]["analytics"];
	$cfg["Google"]["reCaptchaPublic"] = $_ENV['RECAPTCHA_PUBLIC'] ?? $cfg["Google"]["reCaptchaPublic"];
    $cfg["Google"]["reCaptchaPrive"] = $_ENV['RECAPTCHA_PRIVEE'] ?? $cfg["Google"]["reCaptchaPrive"];
    $cfg["sharethis"] = $_ENV['SHARETHIS'] ?? $cfg["sharethis"];
    
    if(isSet($_ENV['LANGUES_SITE'])) {
        $cfg["languesSite"] = explode(',', $_ENV['LANGUES_SITE']) ?? $cfg["languesSite"];
    }
}


Function ConfigurerEnvoiCourriel(){
	$dotenv = new Dotenv();
	$dotenv->load(__DIR__.'/../.env');

	$infosEmail = [
		"from" => $_ENV['EMAIL_FROM'] ?? "",
		"fromName" => $_ENV['EMAIL_FROM_NAME'] ?? "",
		"to" => $_ENV['EMAIL_TO'] ?? "",
		"toName" => $_ENV['EMAIL_TO_NAME'] ?? "",
		"username" => $_ENV['EMAIL_USERNAME'] ?? "",
		"password" => $_ENV['EMAIL_PASSWORD'] ?? "",
		"smtpHost" => $_ENV['EMAIL_SMTP_HOST'] ?? "",
		"smtpPort" => $_ENV['EMAIL_SMTP_PORT'] ?? "",
		"smtpType" => $_ENV['EMAIL_SMTP_TYPE'] ?? "",
	];

	if(strlen($infosEmail["from"]) > 0){
		return $infosEmail;
	} else {
		echo "<p>Problème avec le fichiers de configuration.</p>";
		exit();
	}
}

Function ConfigurerInfosProjet(){
	global $cfg;

    $default = ConfigurationProjet();
    
    // Mettre la langue actuel de la page selon l'URL - Langue par défaut si pas trouvé
    $cfg["noLangue"] = LangueActuelPage();
    //Dump($default);die();
    // Pour les langues qui sont activé pour le site web - Pas encore au point.....
    $cfg[FRANCAIS]["langueActiveSite"] = $default[FRANCAIS]["langueActiveSite"] ?? true;
    $cfg[ANGLAIS]["langueActiveSite"] = $default[ANGLAIS]["langueActiveSite"] ?? true;

	$cfg["nomProjet"] = $default[$cfg["noLangue"]]["nomProjet"] ?? $cfg["nomProjet"];
	$cfg["indexation"]["titre"] = $default[$cfg["noLangue"]]["metaTitre"] ?? $cfg["indexation"]["titre"];
	$cfg["indexation"]["description"] = $default[$cfg["noLangue"]]["metaDescription"] ?? $cfg["indexation"]["description"];

    $cfg["formulaires"]["courrielDemandeInformationFrom"] = $default[$cfg["noLangue"]]["courrielDemandeInformationFrom"]  ?? $cfg["formulaires"]["courrielDemandeInformationFrom"];
    $cfg["formulaires"]["courrielDemandeInformationTo"] = $default[$cfg["noLangue"]]["courrielDemandeInformationTo"]  ?? $cfg["formulaires"]["courrielDemandeInformationTo"];
	
	$cfg["reseauSociaux"]["facebook"] = $default[$cfg["noLangue"]]["facebook"] ?? $cfg["reseauSociaux"]["facebook"];
	$cfg["reseauSociaux"]["youtube"] = $default[$cfg["noLangue"]]["youtube"] ?? $cfg["reseauSociaux"]["youtube"];
	$cfg["reseauSociaux"]["instagram"] = $default[$cfg["noLangue"]]["instagram"] ?? $cfg["reseauSociaux"]["instagram"];
	$cfg["reseauSociaux"]["twitter"] = $default[$cfg["noLangue"]]["twitter"] ?? $cfg["reseauSociaux"]["twitter"];

	$cfg["couleurs"]["coulReseauFacebook"] = $cfg["couleurs"]["coulReseauFacebook"] ?? '';
	$cfg["couleurs"]["coulReseauYoutube"] = $cfg["couleurs"]["coulReseauYoutube"] ?? '';;
	$cfg["couleurs"]["coulReseauTwitter"] = $cfg["couleurs"]["coulReseauTwitter"] ?? '';;
	$cfg["couleurs"]["coulReseauInstagram"] = $cfg["couleurs"]["coulReseauInstagram"] ?? '';;
	
	$cfg["Google"]["analytics"] = $default["googleAnalytic"] ?? $cfg["Google"]["analytics"];
	$cfg["Google"]["reCaptchaPublic"] = $default["googleRecaptchaPublic"] ?? $cfg["Google"]["reCaptchaPublic"];
    $cfg["Google"]["reCaptchaPrive"] = $default["googleRecaptchaPrive"] ?? $cfg["Google"]["reCaptchaPrive"];
    
    $cfg["sharethis"] = $default["sharethis"] ?? $cfg["sharethis"];

	$cfg["couleurs"]["siteBackground"] = $cfg["couleurs"]["siteBackground"] ?? '';;
	$cfg["couleurs"]["coulSiteTexte"] = $cfg["couleurs"]["coulSiteTexte"] ?? '';;
}

Function ConfigurationProjet() {
	return Config::ObtenirConfig();
}

Function PreparerCSSInfosGeneral() {
	global $cfg;

	$css = "<style>";

	$css .= " body { background-color: " . $cfg["couleurs"]["siteBackground"] . "; color: " . $cfg["couleurs"]["coulSiteTexte"] . "; }";

	$css .= " i.icon-facebook { color: " . $cfg["couleurs"]["coulReseauFacebook"] . "; }";
	$css .= " i.icon-youtube { color: " . $cfg["couleurs"]["coulReseauYoutube"] . "; }";
	$css .= " i.icon-twitter { color: " . $cfg["couleurs"]["coulReseauTwitter"] . "; }";
	$css .= " i.icon-instagram { color: " . $cfg["couleurs"]["coulReseauInstagram"] . "; }";

	$css .= "</style>";

	return $css;
}

Function TableauMenu($menuTableau = [], $niveau = 0) {
    if (empty($menuTableau)) {
        $menuTableau = ConstruireMenu();
    }
	$menu = "<ul>
	";

	foreach($menuTableau as $item) {
		$subMenu = "";
		$styleLi = "";

		if(!empty($item["enfants"])) {
			$SubMenu .= TableauMenu($item["enfants"], $niveau++);
			$styleLi = "$menu .= 'has_sub";
		}

		$menu .= '<li class="'.$styleLi.'"><a href="'.$item["repertoire"].'">'.$item["titre"].'</a></li>';
	}

	$menu .= "</ul>";

	return $menu;
}

Function ConstruireMenu($options = []) {
	$default = [
		"microsite" => MICROSITE_SITE,
		"usager" => USAGER,
	];

	$settings = array_merge($default, $options);

	return Page::ConstruireMenu($settings);
}

Function ConfigurerBD(){
	$dotenv = new Dotenv();
	$dotenv->load(__DIR__.'/../.env');

	$infosDB = [
		"username" => $_ENV['DB_USER'] ?? "",
		"password" => $_ENV['DB_PASS'] ?? "",
		"hostname" => $_ENV['DB_HOST'] ?? "",
		"database" => $_ENV['DB_DATABASE'] ?? "",
	];

	if(strlen($infosDB["username"]) > 0){
		return $infosDB;
	} else {
		echo "<p>Problème avec la base de données pour les informations.</p>";
		exit();
	}
}

Function TrouverPageAutresLangues($noPage = 0) {
    echo  Page::TrouverPageAutresLangues($noPage);
}

Function VerifierAjaxURL(){
	$ajaxActive = false;

	if(isset($_GET["ajax"]) && is_numeric($_GET["ajax"])){
		if($_GET["ajax"])
			$ajaxActive = true;
	}

	return $ajaxActive;
}

Function TrouverLangue($mot, $langue = LANGUE_PRINCIPAL) {
    global $cfg;

    $langue = LangueActuelPage();
	$lmot = explode(".", $mot);
	$index = count($lmot);
	$liste = [];
    $m = "";
    $abr = ObtenirAbrLangueUtilise($langue);
	
    if($index == 1):
        $liste = include __DIR__ . '/../langues/default_'.$abr.'.php';
	else:
		$liste = include __DIR__ . '/../langues/'.$lmot[0].'_'.$abr.'.php';
    endif;
    
	ob_start();
	$m = $liste[$lmot[$index-1]];
	ob_end_clean();

	if(strlen($m) > 0):
		echo $m;
	else:
		echo '<label style="color:red;">Impossible de trouver la valeur ['.$mot.']</label>';
	endif;
}

Function ObtenirAbrLangueUtilise($langue = LANGUE_PRINCIPAL) {
    $abr = "fr";

    switch($langue) {
        case ANGLAIS:
            $abr = "en";
        break;
        case ESPAGNOL:
            $abr = "es";
        default:
            $abr = "fr";
    }
    return $abr;
}

Function endsWith($currentString, $target)
{
    $length = strlen($target);
    if ($length == 0) {
        return true;
    }
 
    return (substr($currentString, -$length) === $target);
}

Function ObtenirScriptJS($liste = []){
	$jsHTML = "";

	foreach($liste as $item){
		$jsHTML .= '<script type="text/javascript" src="/src/js/'.$item.'.js" ></script>
		';
	}

	echo $jsHTML;
}

Function ExecuterModule($module, $options = []){
	global $cfg;

	if($module == ""):
		$module = "404";
	endif;

	$modExp = explode("?", $module);

	if(count($modExp) > 1){
		PreparerVariablesModule($modExp[1]);
	}
	$nomModule = $modExp[0];
    $nomModule = str_replace('.inc.php', '', $nomModule);

	$filename = $cfg["params"]["DOCUMENT_ROOT"]."/../modules/".$nomModule."/module.php";

	if (file_exists($filename)) {
		include $filename;
	} else {
		echo "<p>Le module '$nomModule' ne semble pas exister. Il s'agit peut-être d'une erreur?</p>";
		if(isset($_GET["devMode"]) && isset($options["erreur"])):
			echo "<p>Infos Erreur: $options[erreur]</p>";
		endif;
	}
}

Function PreparerVariablesModule($variables = ""){
	global $cfg;
	$liste = explode("&", $variables);

	foreach($liste as $item){
		$i = explode("=", $item);
		$cfg["variablesModule"][$i[0]] = $i[1];
	}
}

Function TrouverTousLesModules($path = __DIR__."/../modules/*/", $fileName = "module.php") {
	return TrouverFichierExisteSousRepertoire($path, $fileName);
}

Function TrouverFichierExisteSousRepertoire($path, $fileName) {
	$liste = [];
	$directories = array_filter(glob($path), 'is_dir');

    foreach ($directories as $directory) {
		if(file_exists($directory.$fileName)) {
			$tmp = array_filter(explode("/", $directory));
			$liste[] = end($tmp);
		}
    }
	
	return $liste;
}

Function CreerTable($donnees, $options = []){
	global $cfg;

	$nb = count($donnees);
	$total = $nb;
	$data = [];
	$default = [
		"activerAction" => 1,
		"table" => "",
	];

	$settings = array_merge($default, $options);
	
	foreach($donnees as $items => $val){
		$tmp = "";
		foreach($val as $key => $v){
			$tmp .= $v.",";
		}

		if($settings["activerAction"]):
			$tmp .=" ,";
		endif;

		$tmp = rtrim($tmp, ",");
		$data[] = explode(",", $tmp);
	}

	if($data == NULL){
		$data = [];
		$nb = 0;
	}

	if(strlen($settings["table"])>0){
		$total = Module::NbTotalTable($settings["table"]);
	}

	$results = array(
		"sEcho" => 1,
		"iTotalRecords" => $nb,
		"iTotalDisplayRecords" => $total,
		"aaData"=>$data);

	return $results;
}

Function abort(){
	global $cfg;
	$cfg["erreur404"] = true;
}

Function FormatTexte($texte = "") {
	$texte = str_replace("\'", "'", $texte);
	$texte = str_replace("\r", "<br/>", $texte);
	$texte = str_replace("\r", "<br/>", $texte);

	return $texte;
}

Function CleanData(&$tableau = null) {
	if (is_null($tableau)) {
		CleanData($_POST);
		CleanData($_GET);
		CleanData($_COOKIE);
		CleanData($_REQUEST);
	}

	if (!is_array($tableau)) {
		return;
	}

	foreach ($tableau as $cle => &$valeur) {
		if (is_array($valeur)) {
			CleanData($valeur);
		} else {
			//if (get_magic_quotes_gpc()) {
			//	$valeur = safe(stripslashes(trim($valeur)));
			//} else {
				$valeur = safe(trim($valeur));
			//}
		}
	}
}

Function safe($string) {
	if(is_array($string)) 
		return array_map(__METHOD__, $string); 

	if(!empty($string) && is_string($string)) { 
		return str_replace(array('\\', "\0", "\n", "\r", "'", '"', "\x1a"), array('\\\\', '\\0', '\\n', '\\r', "\\'", '\\"', '\\Z'), $string); 
	}
	
	return $string;
}

Function PreparerEnvironnement($env = "dev"){
    global $cfg;
    $environnement = "developpement";
    
    switch($env){
        case 'prod':
            $environnement = "production";
        break;
        default:
            $environnement = "developpement";
        break;
    }

    $params = include 'microsite/' . $environnement . '.php';

    $cfg = array_merge($cfg, $params);
}

Function PreparerAction(){
    global $cfg;
    $url = explode("/", $cfg["params"]["REQUEST_URI"]);

    array_shift($url);
    array_pop($url);

    if(count($url) > 2){
        $cfg["action"] = end($url);
    }

}

Function SetParametresUsager(){
	global $cfg;

	if(!isset($_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["parametres"]["theme"]))
		return "dark";
	else
		return $_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["parametres"]["theme"];
}

Function Render($strModule, $options = []) {
    global $cfg;
    $module = explode("/", $strModule);

    extract($options);
    $path = __DIR__ . "/../modules/".$module[0]."/views/".$module[1].".tpl";

    include $path;
}

Function HashMot($mot){
    return password_hash($mot, PASSWORD_DEFAULT);
}

Function VerifierHash($mot, $hash){
    if (password_verify($mot, $hash)) :
        return true;
    else:
        return false;
    endif;
}

Function ObtenirAdresseSite(){
	return 'http://'.$_SERVER['HTTP_HOST'];
}

Function TrouverPage($options = []){
	global $cfg;
	require_once '../modules/pages/classe.php';
    $microsite = "site";
    $page = [];
    
    $langue = LangueActuelPage();

    $default = [
        "noEnr" => 0,
        "repertoire" => ""
    ];

    $settings = array_merge($default, $options);

    if($settings["noEnr"] > 0):
        $page = Page::Trouver($settings["noEnr"], $langue);
    else:
        $urlListe = explode("/", $settings["repertoire"]);
        array_shift($urlListe);
        array_pop($urlListe);
		ConfigLangue(array_shift($urlListe));
		
		if(count($urlListe) > 1){
			if($urlListe[0] == "cms"):
				$cfg["noMicrosite"] = MICROSITE_INTRANET;
			endif;
		}

		$page = Page::TrouverParRepertoire($urlListe, ["noLangue" => $langue, "noMicrosite" => $cfg["noMicrosite"]]);

		if($page != NULL) {
			if(isset($page[0]["micrositePage"]) && $page[0]["micrositePage"] == MICROSITE_INTRANET):
				$microsite = "intranet";
			endif;

			$cfg["microsite"] = $microsite;

			if(count($cfg["variables"]) > 0):
				if(!is_numeric($cfg["variables"][0])):
					$cfg["action"] = $microsite . "-" . $cfg["variables"][0];
				else:
					$cfg["action"] = $microsite . "-lister";
				endif;
			else:
				$cfg["action"] = $microsite . "-lister";
            endif;
            
            $pageLangueAutorise = in_array($page[0]["noLangue"], $cfg["languesSite"]);
            if(!$pageLangueAutorise) {
                $cfg["erreur404"] = true;
            }
		} else {
			$cfg["action"] = $microsite . "-lister";
		}
    endif;
	
	return $page;
}

Function LangueActuelPage() {
    global $cfg;
    $langue = LANGUE_PRINCIPAL;

    $iLangue = explode('/', $cfg["params"]["REQUEST_URI"]);

    if(count($iLangue) > 0) {
        if(isset($iLangue[1])) {
            switch($iLangue[1]) {
                case "en":
                    $langue = ANGLAIS;
                break;
                case "es":
                    $langue = ESPAGNOL;
                break;
                default:
                    $langue = LANGUE_PRINCIPAL;
            }
        }
    }
    return $langue;
}

Function TrouverImageAvatar(){
	global $cfg;
	$noAvatar = $_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["avatarUsager"] ?? 0;
	return Fichier::TrouverLienFichier(["noEnr" => $noAvatar]);
}

Function TrouverFichierLien($fichier, $tmp = false){
	return Fichier::TrouverLienCompletFichier($fichier, $tmp);
}

Function IsFichierImage($type){
	return Fichier::IsFichierImage($type);
}

Function TerminerSession(){
    if (isset($_SESSION)){
        unset($_SESSION);
        session_unset();
        session_destroy();
    }
}

Function ConfigLangue($langue){
    switch($langue){
        case "en":
            $cfg["noLangue"] = ANGLAIS;
		break;
		case "fr":
			$cfg["noLangue"] = FRANCAIS;
		break;
		case "es":
			$cfg["noLangue"] = ESPAGNOL;
		break;
        default:
            $cfg["noLangue"] = LANGUE_PRINCIPAL;
    }
}

Function TrouverLien($noEnr, $options = []){
	return Page::TrouverLien($noEnr, $options);
}

Function MiseAJourSession($donnees, $params, $noMicrosite = MICROSITE_INTRANET){
	$_SESSION["microsite_".$noMicrosite]["usager"]["noUsager"] = $donnees["noUsager"];
	$_SESSION["microsite_".$noMicrosite]["usager"]["prenomUsager"] = $donnees["prenomUsager"];
	$_SESSION["microsite_".$noMicrosite]["usager"]["nomUsager"] = $donnees["nomUsager"];
	$_SESSION["microsite_".$noMicrosite]["usager"]["noSexe"] = $donnees["noSexe"];
	$_SESSION["microsite_".$noMicrosite]["usager"]["adminUsager"] = $donnees["adminUsager"];
	$_SESSION["microsite_".$noMicrosite]["usager"]["avatarUsager"] = $donnees["avatarUsager"];
	
	$_SESSION["microsite_".$noMicrosite]["usager"]["parametres"]["videoBienvenue"] = $params[0]["videoBienvenueUsagerParametre"];
	$_SESSION["microsite_".$noMicrosite]["usager"]["parametres"]["theme"] = $params[0]["themeUsagerParametre"];
}

Function IsSessionActive($noEnr, $noMicrosite = MICROSITE_INTRANET) {
	$sessionNoEnr = $_SESSION["microsite_".$noMicrosite]["usager"]["noUsager"];
	if($sessionNoEnr == $noEnr)
		return true;
	
	return false;
}

Function GestListingPageShow() {
	global $cfg;

	if(isSet($cfg["params"]["REDIRECT_URL"]) && 
		(strpos($cfg["params"]["REDIRECT_URL"], 'pages-site') !== false || 
		strpos($cfg["params"]["REDIRECT_URL"], 'website-pages') !== false)) {
			return MICROSITE_SITE;
	} else {
		return MICROSITE_INTRANET;
	}
}

Function ObtenirInfosUsager($noMicrosite = MICROSITE_INTRANET) {
	return $_SESSION["microsite_".$noMicrosite]["usager"];
}


Function ObtenirPathTheme(){
	global $cfg;

	$theme = "dark";

	if(isset($_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["parametres"]["theme"]) &&
		strlen($_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["parametres"]["theme"]) > 0){
		$theme = $_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["parametres"]["theme"];
	}

	$path = "/src/admin/";
	$path .= $theme;
	$path .= "/";
	echo $path;
}

Function EstAdmin($noMicrosite = MICROSITE_INTRANET){
	if(isset($_SESSION["microsite_".$noMicrosite]['usager']['adminUsager']) && $_SESSION["microsite_".$noMicrosite]['usager']['adminUsager'] == ADMINISTRATEUR){
		return true;
	} else {
		return false;
	}
}

Function isConnected($noMicrosite = MICROSITE_INTRANET){
	if(isset($_SESSION["microsite_".$noMicrosite]['usager'])){
		return true;
	} else {
		return false;
	}
}

Function CreerYoutubeVideo($id, $options = []) {
    $default = [
        'width' => 0,
        'height' => 0
    ];
    $settings = array_merge($default, $options);

    $style = "";

    if($settings["width"] > 0) {
        $style .= "width:".$settings['width']."% !important;";
    }
    if($settings["height"] > 0) {
        $style .= "height:".$settings['height']."% !important;";
    }

	echo '<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/'.$id.'" style="'.$style.'"></iframe>';
}

Function CalculerTailleOctet($octet){
    // Array contenant les differents unités 
    $unite = array(' octet',' ko',' mo',' go');
    
    if ($octet < 1000) // octet
    {
        return $octet.$unite[0];
    }
    else 
    {
        if ($octet < 1000000) // ko
        {
            $ko = round($octet/1024,3);
            return $ko.$unite[1];
        }
        else // Mo ou Go 
        {
            if ($octet < 1000000000) // Mo 
            {
                $mo = round($octet/(1024*1024),3);
                return $mo.$unite[2];
            }
            else // Go 
            {
                $go = round($octet/(1024*1024*1024),3);
                return $go.$unite[3];    
            }
        }
    }
}

Function DebutJavascript(){
	ob_start();
}

Function FinJavascript(){
	global $tpl;
	$tpl["javascript"] .= ob_get_contents();
	ob_end_clean();
}

Function AjouterGoogleAnalytics($idAnalytics) {
	$ga = "";
	
	if(strlen($idAnalytics) > 0) {
        $ga = " <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async src=\"https://www.googletagmanager.com/gtag/js?id=$idAnalytics\"></script>
        <script>
          window.dataLayer = window.dataLayer || [];
          function gtag(){dataLayer.push(arguments);}
          gtag('js', new Date());
        
          gtag('config', '$idAnalytics');
        </script>
        <!-- End Google Analytics -->";
	}
	echo $ga;
}

Function ErreurBdd($msg) {
	global $cfg;

	ob_start();
	echo '<table style="width:100%;"><tbody><tr style="width:100%;"><th style="width:30%;">Server</th><th style="width:70%;">'.
			Dump($_SERVER).'</th></tr></tbody></table>';
	echo '<table style="width:100%;"><tbody><tr style="width:100%;"><th style="width:30%;">Session</th><th style="width:70%;">'.
			Dump($_SESSION).'</th></tr></tbody></table>';
	echo '<table style="width:100%;"><tbody><tr style="width:100%;"><th style="width:30%;">Post</th><th style="width:70%;">'.
			Dump($_POST).'</th></tr></tbody></table>';
	echo '<table style="width:100%;"><tbody><tr style="width:100%;"><th style="width:30%;">Get</th><th style="width:70%;">'.
			Dump($_GET).'</th></tr></tbody></table>';
	echo '<table style="width:100%;"><tbody><tr style="width:100%;"><th style="width:30%;">Files</th><th style="width:70%;">'.
			Dump($_FILES).'</th></tr></tbody></table>';

	$msg .= ob_get_contents();
	ob_end_clean();

	$cfg["erreurMessage"] = $msg;
	$cfg["erreur404"] = true;

	$options = [
		"to" => $cfg["erreurCourriel"],
		"toName" => $cfg["nomProjet"],
		"titre" => "Erreur requête BD",
		"body" => $msg
	];
	Courriel::Envoie($options);
	Render('erreur/site-lister');
	exit();
}

Function Dump($donnees = [], $niveau = 0) {
	$marginLeft = $niveau * 10;
	$style = 'style="width:100%;text-align:left;border: 1px solid black;"';
	$styleKey = 'style="width:30%;background-color:green;"';
	$styleArray = 'style="width:30%;background-color:#5DD6FA;color:#000;"';

    $strHtml = '<table '.$style.'><tbody>';
	
	foreach($donnees as $k => $v) {
		$strHtml .= '<tr class="niveau_'.$niveau.'" style="width:100%;background-color:#ffffe6; color:#fff;border: 1px solid black;">';
	
		if(is_array($v)) {
			$strHtml .= '<th '.$styleArray.'>'.$k.'</th><th style="width:70%">';
			
			ob_start();
			Dump($v, $niveau++);
			$strHtml .= ob_get_contents();
			ob_end_clean();

			$strHtml .= '</th>';
		} else {
			$strHtml .= '<th '.$styleKey.'>'.$k.'</th><th style="width:70%;background-color:#fff !important; color:#000;">'.$v.'</th>';
		}
		$strHtml .= "</tr>";
	}

	$strHtml .= '</tbody></table>';

	echo $strHtml;
}

Function IsMobile() {
	$useragent = $_SERVER['HTTP_USER_AGENT'];
	
	if(preg_match('/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i',$useragent)||preg_match('/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i',substr($useragent,0,4)))
		return true;
	else
		return false;
}

Function DevMode() {
	if(isSet($_GET["devMode"]) && $_GET["devMode"] == 1) {
		return true;
	}
	return false;
}

Function BuildSiteMap() {
    global $cfg;

    $pagesSiteIndexation = Page::TrouverPagesIndexation();

    $siteMap = '<?xml version="1.0" encoding="UTF-8"?>
    <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
      xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">';

    //2020-07-01T01:00:00-05:00
    $date = date('Y-m');

    foreach($pagesSiteIndexation as $pageIndex) {
        $url = $cfg["adresseSiteWeb"].TrouverLien($pageIndex["noPage"]);

        $siteMap .= '
        <url>
            <loc>'.$url.'</loc>
            <lastmod>'.$date.'-01T01:00:00-05:00</lastmod>
            <changefreq>monthly</changefreq>
        </url>';
    }

    $siteMap .= '
    </urlset>';

    echo $siteMap;
}


Function BuildTableauMenuSite($pages = [], $niveau = 0) {
    $niveau++;
    $menuDrop = $niveau > 1 ? ' vertical' : '';
    $ulClass = $niveau > 1 ? 'class="dropdown-menu" role="menu"' : 'class="nav navbar-nav"';

    // ul class="dropdown-menu" role="menu">
    

    $menuStr = '<ul '.$ulClass.'>';//niveau-'.$niveau.$menuDrop.'">';

    foreach($pages as $p) {
        $contientEnfant = !empty($p["pagesEnfants"]);
        $dropdownList = ($contientEnfant) ? ' dropdown' : '';
        $liClass = $niveau > 0 ? 'dropdown' : '';
        $dropdownToggle = ($contientEnfant) ? ' class="dropdown-toggle" data-toggle="dropdown"' : '';
        $iconePage = strlen($p["iconePage"]) > 0 ? '<i class="fa '.$p["iconePage"].' fa-2x" title="'.$p["titrePageLangue"].'"></i>' : '';

        $lienPage = '<a href="'.TrouverLien($p["noPage"]).'"'.$dropdownToggle.'>';
        $lienPage .= strlen($p["iconePage"]) > 0 ? 
                        '<i class="fa '.$p["iconePage"].' fa-2x" title="'.$p["titrePageLangue"].'"></i>' :
                        $p["titrePageLangue"];
        $lienPage .= '</a>';

        $menuStr .= '<li class="'.$liClass.'">'.$lienPage;

        if($contientEnfant) {
            $menuStr .= BuildTableauMenuSite($p["pagesEnfants"], $niveau);
        }

        $menuStr .= "</li>";
    }

    $menuStr .= '</ul>';

    return $menuStr;
}
