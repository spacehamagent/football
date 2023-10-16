<?php

include '../../config/configuration.inc.php';

use SHA\Usager;

$action = $_GET["action"] ?? "";

if($action != ""){
    switch($action){
        case "sitemap":
            header('Content-type: application/xml');
            BuildSiteMap();
            exit();
        break;

        case "fichierUpload":
            var_dump($_FILES);exit();
        break;

        default:
            echo "<p>No action request !</p>";
        break;
    }
}
exit();
