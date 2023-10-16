<?php
namespace Deployer;

require "recipe/common.php";
require 'recipe/rsync.php';

set("git_tty", false);
set("shared_files", [".env"]);
set("shared_dirs", ["cache/fichiersUploadOpt", "public/fichiersUpload", "logs", "vendor"]);
set("writable_dirs", []);
set("allow_anonymous_stats", false);
set("keep_releases", 2);
set("url_user", "");

set('rsync',[
    'exclude'       => ['.git', 'cache', 'logs', 'public/fichiersUpload', 'vendor'],
    'exclude-file' => false,
    'include'      => [],
    'include-file' => false,
    'filter'       => [],
    'filter-file'  => false,
    'filter-perdir'=> false,
    'flags'        => 'rz', // Recursive, with compress
    'options'      => ['delete'],
    'timeout'      => 120,
]);
set('rsync_src', __DIR__);
set('rsync_dest','{{release_path}}');

host("live")
	->user("prog")
	->hostname("srvubuntu.spacehamagent.com")
	->set("deploy_path", "/var/www/spacehamagent/site")
	->set("bin/php", "/opt/alt/php72/usr/bin/php")
	->set("url", "https://www.spacehamagent.com")
	->set("branch", "master")
	->set("stage", "production")
	->identityFile("~/.ssh/id_rsa")
	->addSshOption("UserKnownHostsFile", "/dev/null")
    ->addSshOption("StrictHostKeyChecking", "no");


desc('Préparer les assets pour la production');
task("build_assets", function () {
	run("npm run production");
})->local();

desc('Retirer la cache du site');
task("delete_cache", function () {
	runLocally("curl --silent {{ url_user}} {{ url }}?devMode=1&reset=1");
	runLocally("curl --silent {{ url_user}} {{ url }}/utilitaires/clearstatcache_php.php");
});

desc('Envoyer le sitemap.xml à Google');
task("sitemap", function () {
    runLocally("curl --silent http://www.google.com/ping?sitemap={{url}}/sitemap.xml");
})->onHosts("prod");

task("release", [
	"deploy:info",
	"deploy:prepare",
	"deploy:lock",
	"deploy:release",
	"rsync",
	"deploy:shared",
	"deploy:writable",
	"deploy:vendors",
	"deploy:clear_paths",
    'template:migrate',
	"deploy:symlink",
	"deploy:unlock",
]);

desc('Envoyer les modifications du site');
task("deploy", [
	"release",
	"cleanup",
	"success",
	"delete_cache",
]);


task('template:migrate', function () {
	run('cd {{release_path}} && {{bin/php}} vendor/bin/phinx migrate');
})->onStage("production");

desc('Préparer les assets et envoyer les modifications du site');
task("full", [
	//"build_assets",
	"deploy",
]);

after("deploy:failed", "deploy:unlock");
