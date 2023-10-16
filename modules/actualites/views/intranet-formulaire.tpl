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
                    <a class="nav-link active" id="general-tab" data-toggle="tab" href="#general" role="tab" aria-controls="general" aria-selected="true"><?=TrouverLangue("generale");?></a>
                </li>
                <?php foreach($cfg["languesSite"] as $i) { ?>
                <li class="nav-item">
                    <a class="nav-link" id="langue_<?=$i?>-tab" data-toggle="tab" href="#langue_<?=$i?>" role="tab" aria-controls="langue_<?=$i?>" aria-selected="false"><?=TrouverLangue("langue_$i");?></a>
                </li>
                <?php } ?>
            </ul>
            <div class="tab-content" id="myTabContent">
                
                
                    <input type="hidden" id="noEnr" name="noEnr" value="<?=$enr[0]["noEnr"]?>"/>
                    <div class="tab-pane fade show active" id="general" role="tabpanel" aria-labelledby="general-tab">
                        <div class="card-box">
                            <div class="form-group row col-md-6">
                                <div class="mt-3">
                                    <div class="checkbox checkbox-success">
                                        <input id="actif" name="actif" type="checkbox" <?=(($enr[0]["actifActualite"]) ? 'checked=checked' : '');?>>
                                        <label for="actif"><?=TrouverLangue("actif");?></label>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-2 col-form-label">Image<?//=TrouverLangue("actualite.dateAffichage")?></label>
                                <div class="col-10">
                                    <input type="hidden" class="form-control imageParcourir" id="image" name="image" value="<?=$enr[0]["imageActualite"]?>">
                                    <input type="button" class="btn btn-success btnImageParcourir" id="btnImageParcourir" name="btnImageParcourir" value="Parcourir" />
                                </div>
                            </div>
                            
                            <div class="form-group row">
                                <label class="col-2 col-form-label"><?=TrouverLangue("actualite.dateAffichage")?></label>
                                <div class="col-10">
                                    <input type="date" class="form-control" id="date" name="date" value="<?=$enr[0]["dateActualite"]?>">
                                </div>
                            </div>
                        </div>
                    </div>
                    <?php foreach($cfg["languesSite"] as $i) { ?>
                    <div class="tab-pane fade" id="langue_<?=$i?>" role="tabpanel" aria-labelledby="langue_<?=$i?>-tab">
                        <div class="card-box">
                            <div class="form-group row">
                                <label class="col-2 col-form-label"><?=TrouverLangue("titre")?></label>
                                <div class="col-10">
                                    <input type="text" class="form-control" id="titre_<?=$i?>" name="titre_<?=$i?>" value="<?=$enr[$i]["titreActualiteLangue"]?>">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-2 col-form-label"><?=TrouverLangue("description")?></label>
                                <div class="col-10">
                                    <textarea class="form-control" rows="5" id="description_<?=$i?>" name="description_<?=$i?>" ><?=$enr[$i]["descriptionActualiteLangue"]?></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <?php } ?>
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
            <?php foreach($cfg["languesSite"] as $i) { ?>
                titre_<?=$i?>: { required: true },
            <?php } ?>
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
                    if (resultat.etat == 1){
                        
                    }
                }
            });
        }
    });
});
</script>
<?php FinJavascript(); ?>
