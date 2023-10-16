<?php

use Illuminate\Database\Capsule\Manager as Capsule;
use Illuminate\Events\Dispatcher;
use Illuminate\Container\Container;

$factory = new Dotenv\Environment\DotenvFactory([
    new Dotenv\Environment\Adapter\EnvConstAdapter(),
    new Dotenv\Environment\Adapter\PutenvAdapter(),
]);

$dotenv = Dotenv\Dotenv::create(__DIR__ . "/../", null, $factory);
$dotenv->load();

$capsule = new Capsule;

function bootEloquent()
{
	global $capsule;

	$capsule = new Capsule;
	
	$capsule->addConnection([
		'driver'    => 'mysql',
		'host'      => env("DB_HOST"),
		'database'  => env("DB_NAME"),
		'username'  => env("DB_USER"),
		'password'  => env("DB_PASSWORD"),
		'charset'   => 'utf8',
		'collation' => 'utf8_unicode_ci',
		'prefix'    => '',
		'options' => [
			\PDO::ATTR_EMULATE_PREPARES => true,
		],
	]);
	
	$capsule->setEventDispatcher(new Dispatcher(new Container));
	
	// Make this Capsule instance available globally via static methods... (optional)
	$capsule->setAsGlobal();
	
	// Setup the Eloquent ORM... (optional; unless you've used setEventDispatcher())
	$capsule->bootEloquent();
}
