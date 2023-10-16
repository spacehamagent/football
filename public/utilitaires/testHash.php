<?php

$string = $_GET["mot"] ?? "Bonjour";
$hash = password_hash($string, PASSWORD_DEFAULT);

echo "<h5>".$string."</h5>";

echo "<p>".$hash."</p>";

echo "<p>Vérifier: ".password_verify($string, $hash)."</p>";