<?php

$actualistes =  [
    0 => [
        "titre" => "Actualite #1",
        "description" => "Breve description de l'acutalite numéro 1",
    ],
    1 => [
        "titre" => "Actualite #2",
        "description" => "Breve description de l'acutalite numéro 2",
    ],
    2 => [
        "titre" => "Actualite #3",
        "description" => "Breve description de l'acutalite numéro 3",
    ],
    3 => [
        "titre" => "Actualite #4",
        "description" => "Breve description de l'acutalite numéro 4",
    ]
];

foreach ($actualistes as $actu) {
    echo '<br/><p>'.$actu["titre"].'</p><p>'.$actu["description"].'</p><br/><br/>';
}
