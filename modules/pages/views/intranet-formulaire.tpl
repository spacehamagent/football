<div class="row">
    <div class="col-md-8"></div>
    <div class="col-md-4 float-right">
        <button type="button" class="btn btn-primary btnVoirPage"><?=TrouverLangue("pages.voirPage")?></button>
        <button type="button" class="btn btn-primary btnSave"><i class="fa fa-save fa-1x"></i>  <?=TrouverLangue("pages.enregistrer")?></button>
    </div>
</div>
<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <form id="Donnees" name="Donnees" action="#" method="post">
            <input type="hidden" id="noEnr" name="noEnr" value="<?=$enr[0]["noPage"]?>"/>
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="general-tab" data-toggle="tab" href="#general" role="tab" aria-controls="general" aria-selected="true">Général</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="design-tab" data-toggle="tab" href="#design" role="tab" aria-controls="design" aria-selected="true">Design</a>
                </li>
                <?php foreach($cfg["languesSite"] as $i) : ?>
                <li class="nav-item">
                    <a class="nav-link" id="langue_<?=$i?>-tab" data-toggle="tab" href="#langue_<?=$i?>" role="tab" aria-controls="langue_<?=$i?>" aria-selected="false"><?=TrouverLangue("langue_$i");?></a>
                </li>
                <?php endforeach; ?>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="general" role="tabpanel" aria-labelledby="general-tab">
                    <div class="card-box">
                        <div class="form-group row col-md-6">
                            <div class="mt-3">
                                <div class="checkbox checkbox-success">
                                    <input id="actif" name="actif" type="checkbox" <?=(($enr[0]["actifPage"]) ? 'checked=checked' : '');?>>
                                    <label for="actif"><?=TrouverLangue("actif");?></label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row col-md-6">
                            <div class="mt-3">
                                <div class="checkbox checkbox-success">
                                    <input id="indexation" name="indexation" type="checkbox" <?=(($enr[0]["indexationPage"]) ? 'checked=checked' : '');?>>
                                    <label for="indexation"><?=TrouverLangue("pages.indexation");?></label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row col-md-6">
                            <div class="mt-3">
                                <div class="checkbox checkbox-success">
                                    <input id="afficherDescription" name="afficherDescription" type="checkbox" <?=(($enr[0]["afficherDescriptionPage"]) ? 'checked=checked' : '');?>>
                                    <label for="afficherDescription"><?=TrouverLangue("pages.afficherDescription");?></label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="module">Module</label>
                            <select class="form-control" id="module" name="module">
                                <option value="">Aucun</option>
                                <?php foreach($listeModule as $k => $v) :
                                    $selected = (($v == $enr[0]["modulePage"]) ? " selected" : "");
                                ?>
                                <option value="<?=$v?>"<?=$selected?>><?=ucfirst($v)?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="pageParent">Page parent</label>
                            <select class="form-control" id="pageParent" name="pageParent">
                                <option value="0">Racine</option>
                                <?php foreach($enrsParent as $pp) : ?>
                                <option value="<?=$pp["noPage"]?>"<?=(($pp["noPage"] == $enr[0]["pageParentPage"]) ? " selected": "");?>><?=$pp["titrePageLangue"]?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade " id="design" role="tabpanel" aria-labelledby="design-tab">
                    
                        <?php Render("blocs/intranet-design",["blocs" => $blocs ]); ?>
                </div>
                
                <?php foreach($cfg["languesSite"] as $i) : ?>
                <div class="tab-pane fade" id="langue_<?=$i?>" role="tabpanel" aria-labelledby="langue_<?=$i?>-tab">
                    <div class="card-box">
                        <div class="form-group">
                            <label for="titre_<?=$i?>"><?=TrouverLangue("titre")?></label>
                            <input type="text" class="form-control" id="titre_<?=$i?>" name="titre_<?=$i?>" placeholder="Votre titre" value="<?=$enr[$i]["titrePageLangue"]?>">
                        </div>

                        <div class="form-group">
                            <label for="repertoire_<?=$i?>"><?=TrouverLangue("pages.repertoire")?></label>
                            <input type="text" class="form-control" id="repertoire_<?=$i?>" name="repertoire_<?=$i?>" value="<?=$enr[$i]["repertoirePageLangue"]?>">
                        </div>

                        <div class="form-group">
                            <label for="description_<?=$i?>"><?=TrouverLangue("description")?></label>
                            <textarea class="form-control tinymce" id="description_<?=$i?>" name="description_<?=$i?>" rows="3"><?=$enr[$i]["descriptionPageLangue"]?></textarea>
                        </div>
                        <div class="form-group">
                            <label for="titreIndexation_<?=$i?>"><?=TrouverLangue("pages.titreIndexation")?></label>
                            <input type="text" class="form-control" id="titreIndexation_<?=$i?>" name="titreIndexation_<?=$i?>" placeholder="Titre d'indexation" value="<?=$enr[$i]["titreIndexationPageLangue"]?>" >
                        </div>

                        <div class="form-group">
                            <label for="descriptionIndexation_<?=$i?>"><?=TrouverLangue("pages.descriptionIndexation")?></label>
                            <input type="text" class="form-control" id="descriptionIndexation_<?=$i?>" name="descriptionIndexation_<?=$i?>" placeholder="Description d'indexation" value="<?=$enr[$i]["descriptionIndexationPageLangue"]?>">
                        </div>
                    </div>
                </div>
                <?php endforeach; ?>
                
            </div>
            <button type="submit" class="btn btn-primary btnFormulaire" style="display:none;"></button>
        </form>
        <button type="button" class="btn btn-primary btnSave"><i class="fa fa-save fa-1x"></i>  <?=TrouverLangue("pages.enregistrer")?></button>
    </div>
    <div class="col-1"></div>
    <!-- Modal -->
    <div class="modal fade" id="contenuBlocModal" tabindex="-1" role="dialog" aria-labelledby="contenuBlocModal" aria-hidden="true">
        <div class="modal-dialog modal-lg contenuFormBloc" role="document">
            <?=Render('blocs/intranet-design-form')?>
        </div>
    </div>

    <!-- Modal Bloc Type -->
    <div class="modal fade" id="typeBlocModal" tabindex="-1" role="dialog" aria-labelledby="typeBlocModal" aria-hidden="true">
        <div class="modal-dialog modal-lg typeBlocModal" role="document">
            <?=Render('blocs/intranet-modal-type-bloc')?>
        </div>
    </div>
</div>

<?php DebutJavascript(); ?>
<script type="text/javascript">
$( document ).ready(function() {
    $(".btnSave").on('click', function() {
        $('#Donnees').submit();
    });

    $(".btnVoirPage").on('click', function() {
        window.open('<?=TrouverLien($enr[0]["noPage"]);?>', 'voirPage'); 
    });

    $("#Donnees").validate({
        rules: {
            prenom: { required: true },
            nom: { required: true },
            courriel: {
                required: true,
                email: true
            },
        },
        errorPlacement: function(error, element){
            $(element).closest('.form-group').append(error);
        },
        errorElement: "p",
        submitHandler: function(form) {
            MessageSauvegarde('<?=TrouverLangue("msgSauvegardeEnCours")?>');

            <?php foreach($cfg["languesSite"] as $i) : ?>
            //tinymce.get('description_<?=$i?>').setContent('TEST TEXTE <?=$i?>');
            $('#description_<?=$i?>').val(tinymce.get('description_<?=$i?>').getContent());
            <?php endforeach; ?>
            
            $.ajax({
                type: "post",
                url: "../../editer-traitement/?ajax=1",
                data: $(form).serialize(),
                dataType: "json",
                
                "error": function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Erreur');
                }, 
                success: function(resultat){
                    if (resultat.etat != 1){
                        $('#message').show().html(resultat.message).fadeIn().delay(2000).fadeOut();
                    }
                }
            });
        }
    });
});
</script>
<?php FinJavascript(); ?>
