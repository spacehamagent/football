<?php

require_once __DIR__ . '/../../config/configuration.inc.php';

use SHA\Log;
use SHA\Courriel;
use SHA\Historique;

$nbJour = 3;
$msg = "<p>Bonjour,<br/><br/> Voici ce qui à été effectué du crontask</p><p></p>";

echo '<p>Nettoyage Logs...</p>';
Log::Clean();
$msg .= "<p>Le nettoyage du log est terminé. $nbJour jours demandé</p>
";
echo '<p>Fin - Nettoyage Logs...</p>';

echo '<p>Nettoyage Historique...</p>';
$nbJour = 5;
Historique::Clean(["dayClean" => $nbJour]);
$msg .= "<p>Le nettoyage de l'historique est terminé. $nbJour jours demandé</p>
";
echo '<p>Fin - Nettoyage Historique...</p>';

$optCourriel = [
    "to" => $cfg["crontaskCourriel"],
    "toName" => "Crontask Analyste",
    "titre" => "Crontak - Clean",
    "body" => $msg,
];
Courriel::Envoie($optCourriel);

die();
