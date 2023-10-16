<html>
    <body>
<?php
require_once __DIR__ . '/../../config/configuration.inc.php';

if (DevMode()) {

    $arr1 = [
        "k_titre" => "v_Mon titre",
        "k_collection1" => [
            "k_item1" => "v_valeur 1",
            "k_item2" => "v_valeur 2",
            "k_item3" => "v_valeur 3",
            "k_collection1_1" => [
                "k_item1" => "v_valeur 1_1",
                "k_item2" => "v_valeur 1_2",
            ],
            "k_item4" => "v_valeur 4",
        ],
        "k_item1" => "v_valeur1",
        "k_item2" => "v_valeur2",
    ];

    Dump($arr1);
} else {
    echo '<p>Utilitaire Dump...</p>';
}
?>
    </body>
</html>