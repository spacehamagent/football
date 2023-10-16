<?php

require_once __DIR__ . '/../../config/configuration.inc.php';

if (DevMode()) {
    var_dump($_SERVER);die();

} else {
    echo '<p>Utilitaire repertoire...</p>';
}
