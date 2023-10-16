
<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <form id="Donnees" name="Donnees" action="#" method="post">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="parametre-tab" data-toggle="tab" href="#parametre" role="tab" aria-controls="parametre" aria-selected="true"><?=TrouverLangue("parametre");?></a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="parametre" role="tabpanel" aria-labelledby="parametre-tab">
                    <div class="form-group row">
                        <label class="col-2 col-form-label">Vidéo de bienvenue</label>
                        <div class="col-10">
                            <select id="videoBienvenue" name="videoBienvenue" class="form-control">
                                <?php foreach($videos as $v) { ?>
                                <option value= "<?=$v["noVideo"]?>" <?=(($noVideo == $v["noVideo"]) ? ' selected="selected"' : '');?>><?=$v["titreVideoLangue"]?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-2 col-form-label">Theme</label>
                        <div class="col-10">
                            <select id="theme" name="theme" class="form-control">
                                <?php foreach($themes as $v => $k) { ?>
                                <option value= "<?=$v?>" <?=(($theme == $v) ? ' selected="selected"' : '');?>><?=$k?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary btnFormulaire"><?=TrouverLangue("sauvegarder");?></button>
        </form>
        
    </div>
    <div class="col-1"></div>
</div>

<div class="col-md-12 m-t-50">
    <div class="row">
        <div class="alert alert-success" id="message" style="display:none"></div>
    </div>
</div>


<?php DebutJavascript(); ?>
<script type="text/javascript">
$( document ).ready(function() {

    $("#Donnees").validate({
        rules: {
            videoBienvenue: { required: true },
        },
        errorPlacement: function(error, element){
            $(element).closest('.form-group').append(error);
        },
        errorElement: "p",
        submitHandler: function(form) {
            MessageSauvegarde('<?=TrouverLangue("msgSauvegardeEnCours")?>');
            
            $.ajax({
                type: "post",
                url: "../parametres-traitement/?ajax=1",
                data: $(form).serialize(),
                dataType: "json",
                
                "error": function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Erreur');
                }, 
                success: function(resultat){
                    if (resultat.etat != 1){
                        $('#message').removeClass('alert-success').addClass('alert-danger').show().html(resultat.message).fadeIn().delay(2000).fadeOut();
                    }
                    
                    if (resultat.etat == 1){
                        $('#message').removeClass('alert-danger').addClass('alert-success').html(resultat.message).fadeIn().delay(2000).fadeOut();
                        location.reload();
                    }
                }
            });
        }
    });
    
});
</script>
<?php FinJavascript(); ?>
