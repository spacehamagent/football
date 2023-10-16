<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <form id="Donnees" name="Donnees" action="#" method="post">
            <input type="hidden" id="noEnr" name="noEnr" value="<?=$enr[0]["noVideo"]?>"/>
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
                <div class="tab-pane fade show active" id="general" role="tabpanel" aria-labelledby="general-tab">
                    <div class="card-box">

                        <div class="col-md-6">
                            <div class="mt-3">
                                <div class="checkbox checkbox-success">
                                    <input id="actif" name="actif" type="checkbox" <?=(($enr[0]["actifVideo"]) ? 'checked=checked' : '');?>>
                                    <label for="actif"><?=TrouverLangue("actif");?></label>
                                </div>
                            </div>
                        </div>

                        <p></p>

                        <div class="col-md-6">
                            <h4 class="header-title">Groupes</h4>
                            <div class="mt-3">
                                <?php foreach($listeGroupe as $groupe) { ?>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" name="groupe_<?=$groupe["noGroupe"]?>" id="groupe_<?=$groupe["noGroupe"]?>"<?=((in_array($groupe["noGroupe"], $videoGroupe)) ? ' checked=checked' : '')?>>
                                    <label class="custom-control-label" for="groupe_<?=$groupe["noGroupe"]?>"><?=$groupe["titreGroupeLangue"]?></label>
                                </div>
                                <?php } ?>
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
                                <input type="text" class="form-control" id="titre_<?=$i?>" name="titre_<?=$i?>" value="<?=$enr[$i]["titreVideoLangue"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("pages.repertoire")?></label>
                            <div class="col-10">
                                <input type="text" class="form-control" id="repertoire_<?=$i?>" name="repertoire_<?=$i?>" value="<?=$enr[$i]["repertoireVideoLangue"]?>">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"><?=TrouverLangue("description")?></label>
                            <div class="col-10">
                                <textarea class="form-control" rows="5" id="description_<?=$i?>" name="description_<?=$i?>" ><?=$enr[$i]["descriptionVideoLangue"]?></textarea>
                            </div>
                        </div>


                        <div class="form-group row">
                            <label class="col-2 col-form-label">Youtube</label>
                            <div class="col-10">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="basic-addon1"><i class="fa fa-youtube" aria-hidden="true"></i></span>
                                    </div>
                                    <input type="text" class="form-control" id="url_<?=$i?>" name="url_<?=$i?>" placeholder="https://www.youtube.com/watch?v=0x0x0x0x0x" aria-label="Youtube" aria-describedby="basic-addon1" value="<?=$enr[$i]["urlVideoLangue"]?>">
                                </div>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label">Id</label>
                            <div class="col-10">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="basic-addon1"><i class="fa fa-key" aria-hidden="true"></i></span>
                                    </div>
                                    <input type="text" class="form-control" id="id_<?=$i?>" name="id_<?=$i?>" placeholder="" aria-label="Id" aria-describedby="basic-addon1" value="<?=$enr[$i]["idVideoLangue"]?>" readonly="">
                                </div>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-2 col-form-label"> </label>
                            <div class="col-10">
                                <div class="showVideo_<?=$i?>">
                                <?php
                                if(strlen($enr[$i]["idVideoLangue"]) > 0) {
                                    echo '<iframe width="420" height="315"
                                    src="https://www.youtube.com/embed/'.$enr[$i]["idVideoLangue"].'">
                                    </iframe>';
                                } else {
                                    echo '<p>Aucune vidéo...</p>';
                                }
                                ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <?php } ?>
            </div>
            <button type="submit" class="btn btn-primary btnFormulaire"><?=TrouverLangue("sauvegarder")?></button>
        </form>
        
    </div>
    <div class="col-1"></div>
</div>

<?php DebutJavascript(); ?>
<script type="text/javascript">
$( document ).ready(function() {
    <?php foreach($cfg["languesSite"] as $i) { ?>
    
        $('#titre_<?=$i?>').on('change', function(){
            var valeur = RemoveAccents($('#titre_<?=$i?>').val());
            valeur = RemoveSpace(valeur);
            $('#repertoire_<?=$i?>').val(valeur.toLowerCase());
        });
        $('#url_<?=$i?>').on('change', function(){
            var index = <?=$i?>;
            var url = $('#url_<?=$i?>').val();
            var id = url.split('?v=')[1];
            $('#id_<?=$i?>').val(id);

            AfficherVideo(id, $('.showVideo_'+index));
        });

    <?php } ?>

    $("#Donnees").validate({
        rules: {
            <?php foreach($cfg["languesSite"] as $i) { ?>
            titre_<?=$i?>: { required: true },
            url_<?=$i?>: { required: true, url: true },
            <?php } ?>
        },
        errorPlacement: function(error, element){
            $(element).closest('.form-group').append(error);
        },
        errorElement: "p",
        validClass: "success",
        ignore: "",
        submitHandler: function(form) {
            MessageSauvegarde('<?=TrouverLangue("msgSauvegardeEnCours")?>');
            urlPath = '<?=(($cfg["action"] == "intranet-ajouter") ? '../ajouter-traitement/' : '../../editer-traitement/')?>';

            $.ajax({
                type: "post",
                url: urlPath+"?ajax=1",
                data: $(form).serialize(),
                dataType: "json",
                
                "error": function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Erreur');
                }, 
                success: function(resultat){
                    <?php if($cfg["action"] == "intranet-ajouter") { ?>
                    window.location.href = "..";
                    <?php } ?>
                }
            });
        }
    });

    function AfficherVideo(id, emplacement) {
        urlPath = '<?=(($cfg["action"] == "intranet-ajouter") ? '../video-id/' : '../../video-id/')?>';

        $.ajax({
            type: "post",
            url: urlPath+"?ajax=1",
            data: { "id" : id },
            dataType: "json",
            
            "error": function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Erreur');
            }, 
            success: function(resultat){
                if(resultat.etat == 1) {
                    $(emplacement).html(resultat.video);
                }
            }
        });
    }
});
</script>
<?php FinJavascript(); ?>
