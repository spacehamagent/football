<?php

if($cfg["noMicrosite"] == MICROSITE_INTRANET && isConnected()) :
    $nomComplet = $_SESSION["microsite_".MICROSITE_INTRANET]["usager"]["prenomUsager"];
    $sexe = "female";

    if($_SESSION["microsite_".MICROSITE_INTRANET]["usager"]["noSexe"]){
        $sexe = "male";
    }
?>
<body class="fixed-left">
    
    <!-- Begin page -->
    <div id="wrapper">

        <!-- Top Bar Start -->
        <div class="topbar">

            <!-- LOGO -->
            <div class="topbar-left">
                <div class="text-center">
                    <a href="<?=TrouverLien(SITE_ACCUEIL)?>" class="logo" target="_blank"><i class=" mdi mdi-web"></i> <span class="nomProjet"><?=$cfg["nomProjet"]?></span></a>
                </div>
            </div>

            <!-- Button mobile view to collapse sidebar menu -->
            <nav class="navbar-custom">

                <ul class="list-inline float-right mb-0">

                    <li class="list-inline-item notification-list hide-phone">
                        <a class="nav-link waves-light waves-effect" href="#" id="btn-fullscreen">
                            <i class="mdi mdi-crop-free noti-icon"></i>
                        </a>
                    </li>

                    <li class="list-inline-item notification-list">
                        <a class="nav-link right-bar-toggle waves-light waves-effect" href="#">
                            <i class="mdi mdi-dots-horizontal noti-icon"></i>
                        </a>
                    </li>

                    <li class="list-inline-item dropdown notification-list">
                        <a class="nav-link dropdown-toggle arrow-none waves-light waves-effect" data-toggle="dropdown" href="#" role="button"
                            aria-haspopup="false" aria-expanded="false">
                            <i class="mdi mdi-bell noti-icon"></i>
                            <span class="badge badge-pink noti-icon-badge">4</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-arrow dropdown-menu-lg" aria-labelledby="Preview">
                            <!-- item-->
                            <div class="dropdown-item noti-title">
                                <h5 class="font-16"><span class="badge badge-danger float-right">5</span>Notification</h5>
                            </div>

                            <!-- item-->
                            <a href="javascript:void(0);" class="dropdown-item notify-item">
                                <div class="notify-icon bg-success"><i class="mdi mdi-comment-account"></i></div>
                                <p class="notify-details">Robert S. Taylor commented on Admin<small class="text-muted">1 min ago</small></p>
                            </a>

                            <!-- item-->
                            <a href="javascript:void(0);" class="dropdown-item notify-item">
                                <div class="notify-icon bg-info"><i class="mdi mdi-account"></i></div>
                                <p class="notify-details">New user registered.<small class="text-muted">1 min ago</small></p>
                            </a>

                            <!-- item-->
                            <a href="javascript:void(0);" class="dropdown-item notify-item">
                                <div class="notify-icon bg-danger"><i class="mdi mdi-airplane"></i></div>
                                <p class="notify-details">Carlos Crouch liked <b>Admin</b><small class="text-muted">1 min ago</small></p>
                            </a>

                            <!-- All-->
                            <a href="javascript:void(0);" class="dropdown-item notify-item notify-all">
                                View All
                            </a>

                        </div>
                    </li>

                    <li class="list-inline-item dropdown notification-list">
                        <a class="nav-link dropdown-toggle waves-effect waves-light nav-user" data-toggle="dropdown" href="#" role="button"
                            aria-haspopup="false" aria-expanded="false">
                            <img src="<?=TrouverImageAvatar()?>" alt="user" id="avatarImage" name="avatarImage" class="rounded-circle">
                        </a>
                        <div class="dropdown-menu dropdown-menu-right profile-dropdown " aria-labelledby="Preview">
                            <!-- item-->
                            <div class="dropdown-item noti-title">
                                <h5 class="text-overflow"><small>Bonjour <?=$_SESSION["microsite_2"]["usager"]["prenomUsager"];?></small> </h5>
                            </div>

                            <!-- item-->
                            <a href="<?=TrouverLien(INTRANET_USAGERS)?>editer/<?=$_SESSION["microsite_".MICROSITE_INTRANET]["usager"]["noUsager"]?>/" class="dropdown-item notify-item">
                                <i class="mdi mdi-account"></i> <span>Profile</span>
                            </a>

                            <!-- item-->
                            <a href="<?=TrouverLien(INTRANET_USAGERS)?>parametres/" class="dropdown-item notify-item">
                                <i class="mdi mdi-settings"></i> <span>Paramètres</span>
                            </a>

                            <!-- item-->
                            <a href="?terminerSession=1" class="dropdown-item notify-item">
                                <i class="mdi mdi-logout"></i> <span>Déconnexion</span>
                            </a>

                        </div>
                    </li>

                </ul>

                <ul class="list-inline menu-left mb-0">
                    <li class="float-left">
                        <button class="button-menu-mobile open-left waves-light waves-effect btn-menu-intranet">
                            <i class="mdi mdi-menu"></i>
                        </button>
                    </li>
                    <li class="hide-phone app-search">
                        <form role="search" class="">
                            <input type="text" id="motRecherche" name="motRecherche" placeholder="Rechercher..." class="form-control">
                            <a href="javascript:Rechercher()"><i class="fa fa-search"></i></a>
                        </form>
                    </li>
                </ul>

            </nav>

        </div>
        <!-- Top Bar End -->


        <!-- ========== Left Sidebar Start ========== -->

        <div class="left side-menu">
            <div class="sidebar-inner slimscrollleft">
                <!--- Divider -->
                <div id="sidebar-menu">
                    <ul>
                        <li class="menu-title">Menu</li>

                        <li>
                            <a href="<?=TrouverLien(INTRANET_ACCUEIL)?>" class="waves-effect waves-primary">
                                <i class="ti-home"></i><span> Accueil </span>
                            </a>
                        </li>

                        <li class="has_sub">
                            <a href="javascript:void(0);" class="waves-effect waves-primary">
                                <i class="ti-desktop"></i><span> Contenu </span> 
                                <span class="menu-arrow"></span>
                            </a>

                            <ul class="list-unstyled">
                                <?php if(EstAdmin()): ?>
                                <li><a href="<?=TrouverLien(INTRANET_PAGES_SITE_WEB)?>">Pages du site</a></li>
                                <li><a href="<?=TrouverLien(INTRANET_CLIENTS)?>">Clients</a></li>
                                <?php endif; ?>
                                <li><a href="<?=TrouverLien(INTRANET_BIBLIOTHEQUE)?>">Bibliothèque</a></li>
                                <li><a href="<?=TrouverLien(INTRANET_ACTUALITE)?>">Actualités</a></li>
                                <li><a href="<?=TrouverLien(INTRANET_VIDEOS)?>">Vidéo</a></li>
                                <li><a href="<?=TrouverLien(INTRANET_DEMANDE_INFORMATION)?>">Demande informations</a></li>
                            </ul>
                        </li>

                        <?php if(EstAdmin()): ?>
                        <li class="has_sub">
                            <a href="javascript:void(0);" class="waves-effect waves-primary">
                                <i class="ti-settings"></i><span> Système </span> 
                                <span class="menu-arrow"></span>
                            </a>

                            <ul class="list-unstyled">
                                <li><a href="<?=TrouverLien(INTRANET_CONFIGURATION)?>">Infos générales</a></li>
                                <li><a href="<?=TrouverLien(INTRANET_USAGERS)?>">Usagers</a></li>
                                <li><a href="<?=TrouverLien(INTRANET_PAGES)?>">Pages</a></li>
                                <li><a href="<?=TrouverLIen(INTRANET_HISTORIQUE)?>">Historiques</a></li>
                                <li><a href="<?=TrouverLien(INTRANET_LOGS)?>">Logs</a></li>
                            </ul>
                        </li>
                        <?php endif; ?>
                    </ul>


                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <!-- Left Sidebar End -->




        <!-- ============================================================== -->
        <!-- Start right Content here -->
        <!-- ============================================================== -->                      
        <div class="content-page">
            <!-- Start content -->
            <div class="content">
                <div class="container-fluid">

                    <!-- Page-Title -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="page-title-box">
                                <h4 class="page-title">Bienvenue !</h4>
                                <ol class="breadcrumb float-right">
                                    <li class="breadcrumb-item"><a href="<?=TrouverLien(INTRANET_ACCUEIL)?>">Accueil</a></li>
                                    <li class="breadcrumb-item active">Dashboard</li>
                                </ol>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-12">
                            <?=$tpl["contenu"] ?>
                        </div>
                    </div>

                </div>
                <!-- end container -->
            </div>
            <!-- end content -->

            <footer class="footer">
                2016 - <?=date('Y')?> © SHA
            </footer>

        </div>
        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->


        <!-- Right Sidebar -->
        <div class="side-bar right-bar">
            <div class="">
                <ul class="nav nav-tabs tabs-bordered nav-justified">
                    <li class="nav-item">
                        <a href="#home-2" class="nav-link active" data-toggle="tab" aria-expanded="false">
                            Activity
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#messages-2" class="nav-link" data-toggle="tab" aria-expanded="true">
                            Settings
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="home-2">
                        <div class="timeline-2">
                            <div class="time-item">
                                <div class="item-info">
                                    <small class="text-muted">5 minutes ago</small>
                                    <p><strong><a href="#" class="text-info">John Doe</a></strong> Uploaded a photo <strong>"DSC000586.jpg"</strong></p>
                                </div>
                            </div>

                            <div class="time-item">
                                <div class="item-info">
                                    <small class="text-muted">30 minutes ago</small>
                                    <p><a href="" class="text-info">Lorem</a> commented your post.</p>
                                    <p><em>"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam laoreet tellus ut tincidunt euismod. "</em></p>
                                </div>
                            </div>

                            <div class="time-item">
                                <div class="item-info">
                                    <small class="text-muted">59 minutes ago</small>
                                    <p><a href="" class="text-info">Jessi</a> attended a meeting with<a href="#" class="text-success">John Doe</a>.</p>
                                    <p><em>"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam laoreet tellus ut tincidunt euismod. "</em></p>
                                </div>
                            </div>

                            <div class="time-item">
                                <div class="item-info">
                                    <small class="text-muted">1 hour ago</small>
                                    <p><strong><a href="#" class="text-info">John Doe</a></strong>Uploaded 2 new photos</p>
                                </div>
                            </div>

                            <div class="time-item">
                                <div class="item-info">
                                    <small class="text-muted">3 hours ago</small>
                                    <p><a href="" class="text-info">Lorem</a> commented your post.</p>
                                    <p><em>"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam laoreet tellus ut tincidunt euismod. "</em></p>
                                </div>
                            </div>

                            <div class="time-item">
                                <div class="item-info">
                                    <small class="text-muted">5 hours ago</small>
                                    <p><a href="" class="text-info">Jessi</a> attended a meeting with<a href="#" class="text-success">John Doe</a>.</p>
                                    <p><em>"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam laoreet tellus ut tincidunt euismod. "</em></p>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="tab-pane" id="messages-2">

                        <div class="row m-t-20">
                            <div class="col-8">
                                <h5 class="m-0 font-15">Notifications</h5>
                                <p class="text-muted m-b-0"><small>Do you need them?</small></p>
                            </div>
                            <div class="col-4 text-right">
                                <input type="checkbox" checked data-plugin="switchery" data-color="#3bafda" data-size="small"/>
                            </div>
                        </div>

                        <div class="row m-t-20">
                            <div class="col-8">
                                <h5 class="m-0 font-15">API Access</h5>
                                <p class="m-b-0 text-muted"><small>Enable/Disable access</small></p>
                            </div>
                            <div class="col-4 text-right">
                                <input type="checkbox" checked data-plugin="switchery" data-color="#3bafda" data-size="small"/>
                            </div>
                        </div>

                        <div class="row m-t-20">
                            <div class="col-8">
                                <h5 class="m-0 font-15">Auto Updates</h5>
                                <p class="m-b-0 text-muted"><small>Keep up to date</small></p>
                            </div>
                            <div class="col-4 text-right">
                                <input type="checkbox" checked data-plugin="switchery" data-color="#3bafda" data-size="small"/>
                            </div>
                        </div>

                        <div class="row m-t-20">
                            <div class="col-8">
                                <h5 class="m-0 font-15">Online Status</h5>
                                <p class="m-b-0 text-muted"><small>Show your status to all</small></p>
                            </div>
                            <div class="col-4 text-right">
                                <input type="checkbox" checked data-plugin="switchery" data-color="#3bafda" data-size="small"/>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!-- /Right-bar -->
    </div>
    <!-- END wrapper -->
    <div id="autresHtml"></div>
<?php
else:
?>
    <body>
    <div class="row">
        <div class="col-12">
            <?=$tpl["contenu"] ?>
        </div>
    </div>
<?php
endif;
?>
