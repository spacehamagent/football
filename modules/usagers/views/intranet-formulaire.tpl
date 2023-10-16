<?php if($cfg["action"] == 'intranet-editer') : ?>
<dib class="row">
    <div class="col-1">
        <button type="submit" class="btn btn-light btnRetour"><?=TrouverLangue("retour");?></button>
    </div>
    <div class="col-11"></div>
</dib>
<p></p>
<?php endif; ?>

<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <form id="Donnees" name="Donnees" action="#" method="post">
            <input type="hidden" name="estEnvoye" value="0" />
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="profil-tab" data-toggle="tab" href="#profil" role="tab" aria-controls="profil" aria-selected="true"><?=TrouverLangue("usagers.profil");?></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="adresse-tab" data-toggle="tab" href="#adresseTab" role="tab" aria-controls="adresseTab" aria-selected="false"><?=TrouverLangue("usagers.adresse");?></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="adresse-tab" data-toggle="tab" href="#imageTab" role="tab" aria-controls="imageTab" aria-selected="false"><?=TrouverLangue("usagers.avatar");?></a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
            
                <input type="hidden" id="noEnr" name="noEnr" value="<?=$enr[0]["noEnr"]?>"/>
                <div class="tab-pane fade show active" id="profil" role="tabpanel" aria-labelledby="profil-tab">
                    <div class="card-box">
                        <?php if(EstAdmin()) { ?>
                        <div class="form-group row col-md-6">
                            <div class="mt-3">
                                <div class="checkbox checkbox-success">
                                    <input id="actif" name="actif" type="checkbox" <?=(($enr[0]["actifUsager"]) ? 'checked=checked' : '');?>>
                                    <label for="actif"><?=TrouverLangue("actif");?></label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group row col-md-6">
                            <div class="mt-3">
                                <div class="checkbox checkbox-success">
                                    <input id="admin" name="admin" type="checkbox" <?=(($enr[0]["adminUsager"]) ? 'checked=checked' : '');?>>
                                    <label for="admin"><?=TrouverLangue("usagers.administrateur");?></label>
                                </div>
                            </div>
                        </div>
                        <?php } ?>

                        <div class="form-group row col-md-6">
                            <h4>Sexe</h4>
                            <div class="mt-3">
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="noSexe_0" name="noSexe" class="custom-control-input" value="0" <?=(($enr[0]["noSexe"] == 0) ? 'checked=checked' : '');?>>
                                    <label class="custom-control-label" for="noSexe_0">Non affiché</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="noSexe_1" name="noSexe" class="custom-control-input" value="1" <?=(($enr[0]["noSexe"] == 1) ? 'checked=checked' : '');?>>
                                    <label class="custom-control-label" for="noSexe_1">Masculin</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="noSexe_2" name="noSexe" class="custom-control-input" value="2" <?=(($enr[0]["noSexe"] == 2) ? 'checked=checked' : '');?>>
                                    <label class="custom-control-label" for="noSexe_2">Féminin</label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("prenom")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="prenom" name="prenom" value="<?=$enr[0]["prenomUsager"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("nom")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="nom" name="nom" value="<?=$enr[0]["nomUsager"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label">Date de naissance</label>
                            <div class="col-10">
                                <input class="form-control" type="date" id="dateNaissance" name="dateNaissance" value="<?=$enr[0]["dateNaissanceUsager"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("courriel")?></label>
                            <div class="col-10">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="basic-addon1"><i class="fa fa-envelope-o" aria-hidden="true"></i></span>
                                    </div>
                                    <input type="text" class="form-control" id="courriel" name="courriel" aria-label="<?=TrouverLangue("courriel")?>" aria-describedby="basic-addon1" value="<?=$enr[0]["courrielUsager"]?>">
                                </div>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"></label>
                            <div class="col-10">
                                <div class="input-group">
                                    <button type="button" class="btn btn-primary btnResetPassMail"><?=TrouverLangue("usagers.reinitialiserMotDePasseCourriel");?></button>
                                </div><br/>
                                <div class="input-group">
                                    <button type="button" class="btn btn-primary btnResetPass"><?=TrouverLangue("usagers.reinitialiserMotDePasse");?></button>
                                </div>
                            </div>
                        </div>
                    

                        <div class="resetPassDiv" style="display:none;">
                            <div class="form-group row">
                                <label class="col-2 col-form-label"></label>
                                <div class="col-10">
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="motDePasse" name="motDePasse" aria-label="<?=TrouverLangue("usagers.motDePasse")?>" aria-describedby="basic-addon1" value="">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("telephone")?></label>
                            <div class="col-10">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="basic-addon1"><i class="fa fa-phone" aria-hidden="true"></i></span>
                                    </div>
                                    <input type="text" class="form-control" id="telephone" name="telephone" aria-label="<?=TrouverLangue("telephone")?>" aria-describedby="basic-addon1" value="<?=$enr[0]["telephoneUsager"]?>">
                                </div>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("cellulaire")?></label>
                            <div class="col-10">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="basic-addon1"><i class="fa fa-mobile" aria-hidden="true"></i></span>
                                    </div>
                                    <input type="text" class="form-control" id="cellulaire" name="cellulaire" aria-label="<?=TrouverLangue("cellulaire")?>" aria-describedby="basic-addon1" value="<?=$enr[0]["cellulaireUsager"]?>">
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="tab-pane fade" id="adresseTab" role="tabpanel" aria-labelledby="adresseTab-tab">
                    <div class="card-box">
                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("usagers.adresse")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="adresse" name="adresse" value="<?=$adresse[0]["adresseAdresse"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("usagers.codePostal")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="codePostal" name="codePostal" value="<?=$adresse[0]["codePostalAdresse"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("usagers.ville")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="ville" name="ville" value="<?=$adresse[0]["villeAdresse"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("usagers.province")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="province" name="province" value="<?=$adresse[0]["provinceAdresse"]?>">
                            </div>
                        </div>


                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("usagers.pays")?></label>
                            <div class="col-10">
                                <select class="form-control select2" id="pays" name="pays" tabindex="-1" aria-hidden="true">
                                    <option value="0">Select</option>
                                    <?php foreach($listePays as $pays) { ?>
                                        <option value="<?=$pays["noPays"]?>"<?=(($adresse[0]["noPays"] == $pays["noPays"]) ? ' selected' : '');?>><?=$pays["titrePaysLangue"]?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="imageTab" role="tabpanel" aria-labelledby="imageTab-tab">
                    <div class="card-box">
                        <div class="form-group row">
                            <label class="col-2 col-form-label"></label>
                            <div class="col-10">
                                <img src="<?=$avatar?>" class="rounded-circle avatarUsager" alt="Mon avatar" style="max-width:150px" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("usagers.avatar")?></label>
                            <div class="col-10">
                                <select class="form-control select2" id="avatar" name="avatar" tabindex="-1" aria-hidden="true">
                                    <option value="0">Default</option>
                                    <?php foreach($images as $image) { ?>
                                        <option value="<?=$image["noFichier"]?>"<?=(($enr[0]["avatarUsager"] == $image["noFichier"]) ? ' selected' : '')?>><?=$image["titreFichierLangue"]?></option>
                                    <?php } ?>
                                </select>
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

    $("#Donnees").validate({
        rules: {
            prenom: { required: true },
            nom: { required: true },
            courriel: {
                required: true,
                email: true
            },
            pays: { required: true }
        },
        errorPlacement: function(error, element){
            $(element).closest('.form-group').append(error);
        },
        errorElement: "p",
        submitHandler: function(form) {
            MessageSauvegarde('<?=TrouverLangue("msgSauvegardeEnCours")?>',1000);
            
            $.ajax({
                type: "post",
                <?php if($cfg["action"] == "intranet-ajouter") { ?>
                url: "../ajouter-traitement/?ajax=1",
                <?php } else { ?>
                url: "../../editer-traitement/?ajax=1",
                <?php } ?>
                data: $(form).serialize(),
                dataType: "json",
                
                "error": function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Erreur');
                },
                <?php if($cfg["action"] == "intranet-ajouter") { ?>
                beforeSend: function() {
                    var estEnvoye = $(form).find('input[name=estEnvoye]');
                    if(estEnvoye.val() == 0){
                        estEnvoye.val(1);
                    } else {
                        return false;
                    }
                },
                <?php } ?>
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
    
    $('#avatar').on('change', function(){
        var avatar = $('#avatar').val();

        $.ajax({
            type: "post",
            url: "<?=TrouverLien(INTRANET_BIBLIOTHEQUE);?>url-fichier/?ajax=1",
            data: {"noEnr":avatar},
            dataType: "json",
            "error": function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Erreur');
            }, 
            success: function(resultat){
                if (resultat.etat == 1){
                    $('.avatarUsager').attr('src',resultat.lienUrl);
                    <?php if(IsSessionActive($enr[0]["noEnr"])) { ?>
                    $('#avatarImage').attr('src',resultat.lienUrl);
                    <?php } ?>
                }
            }
        });
    });

    $('.btnResetPassMail').on('click', function(){
        var courriel = $('#courriel').val();

        $.ajax({
            type: "post",
            url: "<?=TrouverLien(INTRANET_USAGERS);?>reinitialisation/?ajax=1",
            data: {"courrielReset":courriel},
            dataType: "json",
            "error": function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Erreur');
            }, 
            success: function(resultat){
                if (resultat.etat == 1){
                    $('#message').addClass('alert-success').show().html(resultat.message).fadeIn().delay(2000).fadeOut();
                }
            }
        });
    });

    $('.btnResetPass').on('click', function(){
        if($('.resetPassDiv').is(":visible")){
            $('.btnResetPass').html('<?=TrouverLangue("usagers.reinitialiserMotDePasse");?>');
            $('.resetPassDiv').hide();
        } else {
            $('.btnResetPass').html('<?=TrouverLangue("usagers.nePasReinitialiserMotDePasse");?>');
            $('.resetPassDiv').show();
        }
        
    });

});
</script>
<?php FinJavascript(); ?>
