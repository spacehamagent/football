<?php

include_once("./vendor/autoload.php");
use Symfony\Component\Dotenv\Dotenv;

$dotenv = new Dotenv();
$dotenv->load(__DIR__.'/.env');

return
[
    'paths' => [
        'migrations' => '%%PHINX_CONFIG_DIR%%/db/migrations',
        'seeds' => '%%PHINX_CONFIG_DIR%%/db/seeds'
    ],
    'environments' => [
        'default_migration_table' => 'phinxlog',
        'default_database' => 'develop',
        'develop' => [
            'adapter' => 'mysql',
            'host' => env("DB_HOST"),
            'name' => env("DB_DATABASE_TEST"),
            'user' => env("DB_USER"),
            'pass' => env("DB_PASS"),
            'port' => '3306',
            'charset' => 'utf8',
        ],
    ],
    'version_order' => 'creation'
];
