<?php

use SHA\Log;

switch ($cfg["action"]) {
    case "intranet-lister":
        Render("logs/intranet-lister");
    break;

    case "intranet-lister-ajax":
        echo json_encode(CreerTable(Log::Lister(), ["table" => "logs"]));
        exit();
    break;

    default:
        abort();
}