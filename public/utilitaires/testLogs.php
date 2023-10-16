<?php

require_once __DIR__ . '/../../config/configuration.inc.php';

use SHA\Log;

if (DevMode()) {
    Log::EnregistrerVisiteur();

    $liste = Log::Lister();
    var_dump($liste);

    echo '<br/><br/>';
    Log::Clean();
    $liste = Log::Lister();
    var_dump($liste);

    die();
} else {
    echo '<p>Utilitaire Log...</p>';
}