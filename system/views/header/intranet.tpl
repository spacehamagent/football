<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title><?=$cfg["nomProjet"]?> - CMS</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <meta name="description" content="<?=$cfg["nomProjet"]?> - CMS">
        <meta name="author" content="Coderthemes - <?=$cfg["nomProjet"]?>">

        <link rel="shortcut icon" href="<?=ObtenirPathTheme()?>assets/images/favicon.ico">

        <link rel="stylesheet" href="/src/admin/plugins/morris/morris.css">
        <link href="<?=ObtenirPathTheme()?>assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="<?=ObtenirPathTheme()?>assets/css/icons.css" rel="stylesheet" type="text/css">
        <link href="<?=ObtenirPathTheme()?>assets/css/style.css" rel="stylesheet" type="text/css">
        <link href="<?=ObtenirPathTheme()?>assets/css/style_dark.css" rel="stylesheet" type="text/css">
        <link href="<?=ObtenirPathTheme()?>assets/css/style_dark.css.map" rel="stylesheet" type="text/css">
        
        <link href="/src/admin/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />

        <!-- DataTables -->
        <link href="/src/admin/plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="/src/admin/plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="/src/admin/plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- Responsive datatable examples -->
        <link href="/src/admin/plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <link href="/src/admin/plugins/custombox/dist/custombox.min.css" rel="stylesheet">

        <link href="/src/admin/plugins/dropzone/dropzone.css" rel="stylesheet">

        <!-- Grid-Stack -->
        <link rel="stylesheet" href="/src/css/gridstack.min.css" />
        
        <!-- Autres -->
        <link rel="stylesheet" href="/src/css/jquery.Jcrop.min.css" type="text/css" />

        <!-- CSS Personnalisé -->
        <link href="/src/css/custom.intranet.css" rel="stylesheet" type="text/css" />
    </head>

    <?php include __DIR__.'/../contenu-intranet.tpl'; ?>
