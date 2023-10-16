<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <form id="Donnees" name="Donnees" action="#" method="post">
            <input type="hidden" name="estEnvoye" value="0" />
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="profil-tab" data-toggle="tab" href="#profil" role="tab" aria-controls="profil" aria-selected="true"><?=TrouverLangue("usagers.profil");?></a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
            
                <input type="hidden" id="noEnr" name="noEnr" value="<?=$enr[0]["noEnr"]?>"/>
                <div class="tab-pane fade show active" id="profil" role="tabpanel" aria-labelledby="profil-tab">
                    <div class="card-box">

                        <div class="form-group row col-md-6">
                            <h4>Abonnement infolettre</h4>
                            <div class="mt-3">
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="recevoirCourrielClient_1" name="recevoirCourrielClient" class="custom-control-input" value="1" <?=(($enr[0]["recevoirCourrielClient"] == 1) ? 'checked=checked' : '');?>>
                                    <label class="custom-control-label" for="recevoirCourrielClient_1">Oui</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="recevoirCourrielClient_0" name="recevoirCourrielClient" class="custom-control-input" value="0" <?=(($enr[0]["recevoirCourrielClient"] == 0) ? 'checked=checked' : '');?>>
                                    <label class="custom-control-label" for="recevoirCourrielClient_0">Non</label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("prenom")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="prenomClient" name="prenomClient" value="<?=$enr[0]["prenomClient"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("nom")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="nomClient" name="nomClient" value="<?=$enr[0]["nomClient"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("telephone")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="telephoneClient" name="telephoneClient" value="<?=$enr[0]["telephoneClient"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("cellulaire")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="cellulaireClient" name="cellulaireClient" value="<?=$enr[0]["cellulaireClient"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("courriel")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="courrielClient" name="courrielClient" value="<?=$enr[0]["courrielClient"]?>">
                            </div>
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

    <?php
    $url = "/verifier-courriel-traitement?ajax=1";
    if($cfg["action"] == "intranet-ajouter") { 
        $url = "..".$url;
    } else {
        $url = "../..".$url;
    }
    ?>
    var urlVerifier = '<?=$url?>';

    $("#Donnees").validate({
        rules: {
            prenomClient: { required: true },
            nomClient: { required: true },
            courrielClient: {
                required: true,
                email: true,
                remote: {
                    url: urlVerifier,
                    dataType: 'post',
                    data: {
                        'noEnr': <?=$enr[0]["noEnr"]?>,
                        'courrielClient': $('#courrielClient').val(),
                    },
                    "error": function (XMLHttpRequest, textStatus, errorThrown) {
                        //alert( "Erreur");
                        alert(XMLHttpRequest.status + "\n" + XMLHttpRequest.responseText +
                        "\n" + ' ' + textStatus + "\n" + ' ' + errorThrown);
                    }
                }
            }
        },
        message: {
            courrielClient: {
                remote: "Mon message ici.."
            }
        },
        errorPlacement: function(error, element){
            $(element).closest('.form-group').append(error);
        },
        errorElement: "p",
        submitHandler: function(form) {
            MessageSauvegarde('<?=TrouverLangue("msgSauvegardeEnCours")?>',1000);
            <?php
            $url = "/ajouter-traitement/?ajax=1";
            if($cfg["action"] == "intranet-ajouter") { 
                $url = "..".$url;
            } else {
                $url = "../..".$url;
            }
            ?>

            $.ajax({
                type: "post",
                url: "<?=$url?>",
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
                        <?php if($cfg["action"] == "intranet-ajouter") {?>
                        window.location = "../";
                        <?php } ?>
                    }
                }
            });
        }
    });
    
});
</script>
<?php FinJavascript(); ?>
