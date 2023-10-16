
<?php
    foreach($fichiersConfirm as $fichier) {
?>

<div class="col-lg-4 col-md-6 fichier" id="fichier_<?=$fichier["noFichier"]?>">
    <div class="text-center card-box">
        <div class="member-card fichierTmp">
            <div class="thumb-lg member-thumb m-b-10 center-page">
                <?=TrouverFichierLien($fichier, true);?>
            </div>

            <div class="">
                <h4 class="m-b-5 mt-2"><?=$fichier["nomTmpFichier"]?></h4>
            </div>
            <div class="row">
                <button type="button" class="btn btn-success btn-sm w-sm waves-effect m-t-10 waves-light btnSave">Sauvegarder</button>
                <button type="button" class="btn btn-danger btn-sm w-sm waves-effect m-t-10 waves-light btnDelete">Supprimer</button>
            </div>
            <div class="row infosFichier">
                <div class="text-left m-t-40">
                    <input type="hidden" class="noEnr" value="<?=$fichier["noFichier"]?>" />
                    <?php foreach($cfg["languesSite"] as $i) { ?>
                    <p class="text-muted font-13"><strong><?=TrouverLangue("langue_$i")?>:</strong> <span class="m-l-15"> </span></p>
                    <input type="text" class="nomFichier_<?=$i?>" id="nom_<?=$i?>_<?=$fichier["noFichier"]?>" name="nom_<?=$i?>_<?=$fichier["noFichier"]?>" />
                    <?php } ?>
                </div>
            </div>
        </div>

    </div> <!-- end card-box -->
</div>
<?php } ?>
