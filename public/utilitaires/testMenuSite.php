<?php
require_once __DIR__ . '/../../config/configuration.inc.php';

use SHA\Page;

$pagesSite = Page::BuildMenuSite();

$menuBuild = BuildTableauMenuSite($pagesSite);

echo $menuBuild;

Dump($pagesSite);die();
