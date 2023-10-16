<?php


require_once __DIR__ . '/../../config/configuration.inc.php';


use SHA\Courriel;

echo '<p>Préparation...</p>';
$listeTo = [
    'LV Gmail' => 'louisvincentfp@gmail.com',
    'SpaceHam2002' => 'spaceham2002@hotmail.com',
    'LV Vidéotron' => 'spaceham2002@videotron.ca'
];

echo '<p>Options...</p>';
$options = [
    "from" => "info@spacehamagent.com",
    "fromName" => "Noël du partage - Thetford",
    "titre" => "Faire un don",
    "body" => "Voici mon body",
];

echo '<p>Envoie des courriels...</p>';
foreach($listeTo as $k => $v) {
    $options["to"] = $v;
    $options["toName"] = $k;
    //Dump($options);die();

    $default = ConfigurerEnvoiCourriel();
    $settings = array_merge($default, $options);
//Dump($settings);die();
    Courriel::EnvoyerCourriel($settings);
}

echo '<p>Fin</p>';
