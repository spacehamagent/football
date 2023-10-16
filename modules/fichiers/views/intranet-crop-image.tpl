<?php
$tmpNom = "20190525083751-Bane_Batman.png";
$imgSrc = $cfg["adresseSiteWeb"] ."/fichiersUpload/fichiers/".$tmpNom;

$width = $cfg["minWidth"];
$height = $cfg["minHeight"];

?>
<div class="modal-content">
    <div class="modal-header">
        <h5 class="modal-title" id="titreCrop">Crop de votre image</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    
    <div class="modal-body">
        <div class="container testimonial-group">
            <div class="form-group row modalListeImagesCrop" ></div>
        </div>
        <div class="form-group row">
            <div class="col-12 modalImageCrop" >
                <img id="cropbox" name="cropbox" class="imgSrc" src="<?=$imgSrc;?>" alt="Mon image" />
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" id="cropSave" class="btn btn-primary">Crop & Sauvegarder</button>
    </div>
</div>

<?php DebutJavascript(); ?>

<script type="text/javascript">
$(document).ready(function() {
    var x = 0;
    var y = 0;
    var w = 0;
    var h = 0;
    var largeur = <?=$width?>;
    var hauteur = <?=$height?>;
    var img = $('.imgSrc').attr('src');

    


    //AppliquerCrop();

});


</script>
<?php FinJavascript(); ?>
