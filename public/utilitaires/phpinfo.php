<?php 

require_once __DIR__ . '/../../config/configuration.inc.php';

if (DevMode()) {
    phpinfo();
} else {
    echo '<p>Vous vous êtes <a href="http://www.perdu.com/" target="_blank">perdu</a> ? </p>';
}
