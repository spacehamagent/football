<?php

$lang = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
$url = "location:/";

switch ($lang){
	case "en":
		$url .= "en/";
	
	break;
	
	
	default:
		$url .= "fr/";
	
	break;
}

header($url);
exit();

?>
