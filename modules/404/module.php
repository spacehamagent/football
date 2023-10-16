<?php

$cfg["action"] = "intranet-lister";

switch($cfg["action"]){
    case "intranet-lister":
        Render("404/intranet-404");
    break;
    case "site-lister":
        $erreurMessage = $cfg["erreurMessage"] ?? "";
        Render("404/site-404", ["erreurMessage" => $erreurMessage]);
    break;
}