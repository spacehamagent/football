<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title><?=$cfg["nomProjet"]?> - <?=$tpl["titreIndexation"]?></title>
        <link rel="apple-touch-icon" sizes="57x57" href="/images/icones/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="/images/icones/apple-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="72x72" href="/images/icones/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="/images/icones/apple-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="114x114" href="/images/icones/apple-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="120x120" href="/images/icones/apple-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="144x144" href="/images/icones/apple-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="152x152" href="/images/icones/apple-icon-152x152.png">
        <link rel="apple-touch-icon" sizes="180x180" href="/images/icones/apple-icon-180x180.png">
        <link rel="icon" type="image/png" sizes="192x192"  href="/images/icones/android-icon-192x192.png">
        <link rel="icon" type="image/png" sizes="32x32" href="/images/icones/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="96x96" href="/images/icones/favicon-96x96.png">
        <link rel="icon" type="image/png" sizes="16x16" href="/images/icones/favicon-16x16.png">
        <link rel="manifest" href="/images/icones/manifest.json">
        
        <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico" />

        <meta name="msapplication-TileColor" content="#ffffff">
        <meta name="msapplication-TileImage" content="/images/icones/ms-icon-144x144.png">
        <meta name="theme-color" content="#ffffff">
        
        <?php
        $indexationPage = "noindex, follow";

        if(isset($cfg["page"]["indexationPage"]) && $cfg["page"]["indexationPage"]) {
            $indexationPage = "index,follow";
        }
        ?>
        <meta name="robots" content="<?=$indexationPage?>">

        <meta property="og:type" content="website" />
        <meta property="og:site_name" content="<?=$tpl["titreIndexation"]?>"/>
        <meta property="og:title" content="<?=$tpl["titreIndexation"]?>"/>
        <meta property="og:description" content="<?=$tpl["descriptionIndexation"]?>"/>
        <meta property="og:url" content="<?=$cfg["adresseSiteWeb"]?>/" />
        <meta property="og:image" content="<?=$cfg["adresseSiteWeb"]?>/images/site/facebook.png"/>

        <link rel="image_src" href="<?=$cfg["adresseSiteWeb"]?>/images/site/facebook.png" />
        <link href="https://fonts.googleapis.com/css?family=Patrick+Hand&display=swap" rel="stylesheet">
        <link href="/src/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="/src/admin/dark/assets/css/icons.css" rel="stylesheet" type="text/css">
        <link href="/src/css/font-awesome.min" rel="stylesheet" type="text/css" />
        <link href="/src/css/custom.site.css" rel="stylesheet" type="text/css" />

        <?=$tpl["cssInfosGeneral"];?>

        <script src="/src/js/jquery36.min.js"></script>
        <script src="/src/bootstrap/js/bootstrap.js"></script>


        <?php if(!empty($cfg["sharethis"])) : ?>
        <script type='text/javascript' src='https://platform-api.sharethis.com/js/sharethis.js#property=<?=$cfg["sharethis"]?>&product=sticky-share-buttons' async='async'></script>
        <?php endif; ?>
        
    </head>
    <body>
    
    <div class="contenu">
