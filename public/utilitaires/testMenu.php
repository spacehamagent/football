<?php

require_once __DIR__ . '/../../config/configuration.inc.php';

use SHA\Page;
use SHA\Usager;

if (DevMode()) {
    echo '<p>Intranet Admin Menu</p>';

    $opt1 = [
		"microsite" => MICROSITE_INTRANET,
		"usager" => ADMINISTRATEUR,
	];
    $menu1 = ConstruireMenu($opt1);
    Dump($menu1);

    echo '<br/><br/><p>Intranet Usager Menu</p>';
    $opt2 = [
        "microsite" => MICROSITE_INTRANET,
		"usager" => USAGER,
    ];
    $menu2 = ConstruireMenu($opt2);

    Dump($menu2);


    $menu3 = TableauMenu();
    var_dump($menu3);

    die();
} else {
    echo '<p>Utilitaire Menu...</p>';
}