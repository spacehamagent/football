<?php include 'header/site.tpl'; ?>
<nav class="navbar fixed-top navbar-expand-md navbar-dark bg-info menuSiteHaut">
    <div class="fixed-top navbar-collapse collapse justify-content-stretch">
    <?=$tpl["menuSite"] ?? '';?>
    <div class="navbar-collapse collapse" id="navbar4"></div>
    <ul class="nav navbar-nav">
        <li class="nav-item">
            <a href="<?=TrouverLien(SITE_ACCUEIL)?>" class="navbar-brand">
                <i class="fa fa-home fa-1x" title="<?=TrouverLangue("accueil")?>"></i>
            </a>
        </li>
        <li class="nav-item">
            <a href="<?=TrouverLien(INTRANET_LOGIN)?>" class="navbar-brand">
                <i class="fa fa-unlock-alt fa-1x" title="<?=TrouverLangue("connexion")?>"></i>
            </a>
        </li>
        <?=$tpl["autresLanguesMenu"] ?? '' ?>
    </ul>
    </div>
</nav>

<div class="row" style="margin-top:70px;">
    <div class="column col-1"></div>
    <div class="column col-10"><?=$tpl["contenuPage"] ?? '' ?></div>
    <div class="column col-1"></div>
</div>
<div class="row" style="margin-top:50px;margin-bottom:50px">
    <div class="column col-1"></div>
    <div class="column col-10"><?=$tpl["contenu"] ?? '' ?></div>
    <div class="column col-1"></div>
</div>

<?php include 'footer/site.tpl'; ?>
