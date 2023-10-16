<?php

require_once __DIR__ . '/../../config/configuration.inc.php';

use MetzWeb\Instagram\Instagram;

if (DevMode()) {

/*
$instagram = new Instagram(array(
    'apiKey'      => 'YOUR_APP_KEY',
    'apiSecret'   => 'YOUR_APP_SECRET',
    'apiCallback' => 'YOUR_APP_CALLBACK'
));
*/

    $token = "7d3de2c6cd42660272e0ab56e2f2aeb2";

    $data = $instagram->getOAuthToken($token);

    echo 'Your username is: ' . $data->user->username;

    //$instagram = new Instagram($user);

//var_dump($instagram);

//echo "<a href='{$instagram->getLoginUrl()}'>Login with Instagram</a>";
} else {
    echo '<p>Utilitaire Instagram...</p>';
}