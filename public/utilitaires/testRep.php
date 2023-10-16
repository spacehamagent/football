<?php

require_once __DIR__ . '/../../config/configuration.inc.php';

if (DevMode()) {
    $listeRep = TrouverTousLesModules();
    print_r($listeRep);die();

} else {
    echo '<p>Utilitaire repertoire...</p>';
}
