<div class="modal-content">
    <div class="modal-header">
        <h5 class="modal-title" id="contenuFichierModal">TÉLÉCHARGER VOTRE FICHIER<span class=""></span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="modal-body">
        <form id="FichierDonnees" name="FichierDonnees" action="#" method="post" enctype="multipart/form-data">
            <div class="form-group row col-md-12">
                <div class="custom-file">
                    <input type="file" class="custom-file-input" id="fichierTelecharger" name="fichierTelecharger" required>
                    <label class="custom-file-label" for="fichierTelecharger">Choisissez votre fichier</label>
                    <div class="invalid-feedback">Fichier invalide...</div>
                </div>
            </div>

            <div class="form-group row col-md-12">
                <button type="submit" class="btn btn-primary btnTelechargerFichier" style="">Télécharger</button>
            </div>
        </form>

        <div class="row">
            <div class="col-12">
                <label>Liste des fichiers télécharger ici...</label>
            </div>
        </div>
    </div>
</div>

<?php DebutJavascript(); ?>
<script type="text/javascript">
$( document ).ready(function() {
    
    $("#FichierDonnees").validate({
        rules: {
            fichierTelecharger: { required: true },
        },
        errorPlacement: function(error, element){
            $(element).closest('.form-group').append(error);
        },
        errorElement: "p",
        beforeSend : function() {
            console.log('before send');
        },
        submitHandler: function(form) {
            var fd = new FormData();
            var files = $('#fichierTelecharger')[0].files;

            // Check file selected or not
            if(files.length > 0 ) {
                fd.append('file',files[0]);

                $.ajax({
                    type: "post",
                    url: "./fichier-sauvegarder-traitement/?ajax=1",
                    data: fd,
                    dataType: "json",
                    contentType: false,
                    processData: false,
                    "error": function (XMLHttpRequest, textStatus, errorThrown) {
                        alert('Erreur');
                    }, 
                    success: function(resultat){
                        if (resultat.etat == 1){
                            $('#contenuFichierModal').modal('hide');
                            LoadNouveauFichiers();
                        }
                    }
                });
            } else {
                alert('Pas de fichier');
            }
        }
    });
});
</script>
<?php FinJavascript(); ?>
