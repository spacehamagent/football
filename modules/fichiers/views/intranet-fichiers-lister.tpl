<?php
    foreach($fichiers as $fichier) {
?>

<div class="col-xl-3 col-lg-4 col-md-6 fichier" id="fichier_<?=$fichier["noEnr"]?>" name="fichier_<?=$fichier["noEnr"]?>">
    <div class="text-center card-box">
        <div class="member-card fichierTmp">
            <div class="thumb-lg member-thumb m-b-10 center-page">
                <?=TrouverFichierLien($fichier);?>
            </div>

            <div class="">
                <h4 class="m-b-5 mt-2"><?=$fichier["titreFichierLangue"]?></h4>
            </div>
            <div class="avatarSet">
                <h4 class="m-b-5 mt-2">
                    <?php if(IsFichierImage($fichier["typeFichier"]) && EstAdmin()) { ?>
                    <a href="javascript:SetImageAvatar(<?=$fichier["noEnr"]?>)" >
                        <i class="mdi mdi-camera avatar_<?=$fichier["noEnr"]?>" title="Avatar"<?=((isset($fichier["avatar"])) ? ' style="color:green;"' : '')?>></i>
                    </a>
                    <?php } ?>
                    <a href="#" >
                        <i class="mdi mdi-link-variant" title="Lien fichier"></i>
                    </a>
                    <a href="javascript:ArchiveFichier(<?=$fichier["noEnr"]?>)" >
                        <i class="mdi mdi-archive" title="Archive"></i>
                    </a>
                </h4>
            </div>
        </div>
    </div> <!-- end card-box -->
</div>
<?php } ?>
