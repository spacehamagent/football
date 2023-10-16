<?php

require_once __DIR__.'/../vendor/autoload.php';
require_once __DIR__.'/../class/DB.class.php';
require_once __DIR__.'/../class/Bloc.class.php';
require_once __DIR__.'/../class/Module.class.php';
require_once __DIR__.'/../config/functions.inc.php';

// Pages Intranet
const INTRANET_USAGER = 1;
const INTRANET_CONFIGURATION = 2;
const INTRANET_CLIENTS = 3;
const INTRANET_LOGIN = 32;
const INTRANET_RECHERCHER = 63;
const INTRANET_ACCUEIL = 64;
const INTRANET_BIBLIOTHEQUE = 65;
const INTRANET_ACTUALITE = 66;
const INTRANET_PAGES_SITE_WEB = 201;
const INTRANET_DEMANDE_INFORMATION = 255;
const INTRANET_PAGES_SYSTEM = 256;
const INTRANET_PAGES = 257;
const INTRANET_USAGERS = 258;
const INTRANET_VIDEOS = 259;
const INTRANET_LOGS = 260;
const INTRANET_HISTORIQUE = 261;

// Pages Site
const SITE_ACTUALITE = 126;
const SITE_CONFIDENTIALITE = 127;
const SITE_ACCUEIL = 128;
const SITE_NOUS_CONTACTER = 129;

// Type de bloc
const BLOC_TEXTE = 1;
const BLOC_IMAGE = 2;
const BLOC_VIDEO = 3;

const ADMINISTRATEUR = 1;
const USAGER = 2;

const FICHIER_CONFIRMER = 1;
const FICHIER_NON_CONFIRMER = 0;

const MICROSITE_SITE = 1;
const MICROSITE_INTRANET = 2;

const HISTORIQUE_ACTION_AJOUTER = 1;
const HISTORIQUE_ACTION_MODIFIER = 2;
const HISTORIQUE_ACTION_SUPPRIMER = 3;
const HISTORIQUE_ACTION_CONNEXION = 4;

const PAYS_CANADA = 42;

const FRANCAIS = 1;
const ANGLAIS = 2;
const ESPAGNOL = 3;
const ALLEMAND = 4;
const CHINOIS = 5;

const LANGUE_PRINCIPAL = FRANCAIS;

const NB_LANGUE = 2;

$languesSite = [
    FRANCAIS,
];

$cfg = [
    "nomProjet" => "Template V1",
    "erreurCourriel" => "spaceham2002@hotmail.com",
    "crontaskCourriel" => "louisvincentfp@gmail.com",
    "demandeInformation" => [
        "courrielEntreprise" => "spaceham2002@hotmail.com",
        "titreEntreprise" => "Titre Entreprise",
    ],
    "adresseSiteWeb" => $_SERVER["REQUEST_SCHEME"]."://".$_SERVER["HTTP_HOST"],
    "pathVues" => __DIR__ . "/../system/views/",
    "courrielDI" => "spaceham2002@hotmail.com",
    "noVersion" => "1.000202006027000",
    "ajax" => false,
    "erreur404" => false,
    "erreurMessage" => "",
    "module" => "usagers",
    "action" => "lister",
    "params" => $_SERVER,
    "noLangue" => LANGUE_PRINCIPAL,
    "languesSite" => $languesSite,
    "variables" => [],
    "noMicrosite" => MICROSITE_SITE,
    "microsite" => "site",
    "themes" => [
        "dark" => "Dark",
        "new-layout" => "New Layout"
    ],
    "indexation" => [
        "titre" => "Site web template",
        "description" => "Ce site est est un site template.",
    ],
    "msgLog" => "",
    "infosCourriel" => [
        "titreCourriel" => "Titre du courriel",
        "basPage" => '<p>Mon adressepostal<br/>Ma ville, Canada<br/>A0A 0A0<br/><br/><a href="https://'.$_SERVER["HTTP_HOST"].'">https://'.$_SERVER["HTTP_HOST"].'</a></p>',
    ],
    "formulaires" => [
        "courrielDemandeInformationFrom" => "",
        "courrielDemandeInformationTo" => "",
    ],
    "reseauSociaux" => [
        "facebook" => "",
        "youtube" => "",
        "instagram" => "",
        "twitter" => "",
    ],
    "liens" => [
        "sharethis" => "https://platform.sharethis.com/login"
    ]
];

$tpl = [
    "javascript" => ""
];

Configuration();
