<div class="modal-content">
    <div class="modal-header">
        <h5 class="modal-title" id="contenuBlocModal"><?=TrouverLangue("blocs.modificationBloc");?> <span class="infosBloc"></span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="modal-body">
        <form id="BlocDonnees" name="BlocDonnees" action="#" method="post">
            <input type="hidden" id="noBloc" name="noBloc" value=""/>
            <input type="hidden" id="key" name="key" value=""/>
            <input type="hidden" id="index" name="index" value=""/>
            <input type="hidden" id="type" name="type" value=""/>
            
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="bloc_general-tab" data-toggle="tab" href="#bloc_general" role="tab" aria-controls="general" aria-selected="false"><?=TrouverLangue("general");?></a>
                </li>
                <?php foreach($cfg["languesSite"] as $i) : ?>
                <li class="nav-item">
                    <a class="nav-link" id="bloc_langue_<?=$i?>_tab" data-toggle="tab" href="#bloc_langue_<?=$i?>" role="tab" aria-controls="langue_<?=$i?>" aria-selected="false"><?=TrouverLangue("langue_$i");?></a>
                </li>
                <?php endforeach; ?>
            </ul>

            <div class="tab-content" id="myTabContentBloc">
                <div class="tab-pane fade show active" id="bloc_general" role="tabpanel" aria-labelledby="bloc_general-tab">
                    <div class="card-box">
                        <div class="form-group row col-md-12 blocPadding blocTexteModal blocTypeTexte">
                            <div class="mt-6">
                                <label for="couleur-texte">Couleur Texte<?//=TrouverLangue("blocs.paddingTop");?></label>
                                <input type="text" id="couleur-texte" name="couleur-texte" value="" />
                            </div>
                            <div class="mt-6">
                                <label for="couleur-background">Couleur background<?//=TrouverLangue("blocs.paddingBottom");?></label>
                                <input type="text" id="couleur-background" name="couleur-background" value="" />
                            </div>
                        </div>
                        <hr>
                        <div class="form-group row col-md-12 blocPadding blocTypeTexte">
                            <div class="mt-6">
                                <label for="padding-top"><?=TrouverLangue("blocs.paddingTop");?></label>
                                <input type="number" id="padding-top" name="padding-top" value="" />
                            </div>
                            <div class="mt-6">
                                <label for="padding-bottom"><?=TrouverLangue("blocs.paddingBottom");?></label>
                                <input type="number" id="padding-bottom" name="padding-bottom" value="" />
                            </div>
                        </div>
                        <div class="form-group row col-md-12 blocPadding blocTypeTexte">
                            <div class="mt-6">
                                <label for="padding-left"><?=TrouverLangue("blocs.paddingLeft");?></label>
                                <input type="number" id="padding-left" name="padding-left" value="" />
                            </div>
                            <div class="mt-6">
                                <label for="padding-right"><?=TrouverLangue("blocs.paddingRight");?></label>
                                <input type="number" id="padding-right" name="padding-right" value="" />
                            </div>
                        </div>
                        <hr>
                        <div class="form-group row col-md-12 blocMargin blocTypeTexte">
                            <div class="mt-6">
                                <label for="margin-top"><?=TrouverLangue("blocs.marginTop");?></label>
                                <input type="number" id="margin-top" name="margin-top" value="" />
                            </div>
                            <div class="mt-6">
                                <label for="margin-bottom"><?=TrouverLangue("blocs.marginBottom");?></label>
                                <input type="number" id="margin-bottom" name="margin-bottom" value="" />
                            </div>
                        </div>
                        <div class="form-group row col-md-12 blocMargin blocTypeTexte">
                            <div class="mt-6">
                                <label for="margin-left"><?=TrouverLangue("blocs.marginLeft");?></label>
                                <input type="number" id="margin-left" name="margin-left" value="" />
                            </div>
                            <div class="mt-6">
                                <label for="margin-right"><?=TrouverLangue("blocs.marginRight");?></label>
                                <input type="number" id="margin-right" name="margin-right" value="" />
                            </div>
                        </div>
                        <hr>
                    </div>
                </div>
                <?php foreach($cfg["languesSite"] as $i) : ?>
                <div class="tab-pane fade" id="bloc_langue_<?=$i?>" role="tabpanel" aria-labelledby="bloc_langue_<?=$i?>_tab">
                    <div class="card-box">
                        <!-- Bloc Texte -->
                        <div class="blocTexte blocTexteModal blocTypeTexte">
                            <div class="form-group row col-md-12">
                                <div class="mt-12">
                                    <label for="texte_<?=$i?>"><?=TrouverLangue("blocs.texte");?></label>
                                    <textarea class="form-control tinymce" id="texte_<?=$i?>" name="texte_<?=$i?>"></textarea>
                                </div>
                            </div>
                        </div>

                        <!-- Bloc Image -->
                        <div class="blocImage blocImageModal blocTypeImage">
                            <div class="form-group row col-md-12">
                                <div class="mt-12">
                                    <label for="margin-left">URL Image<?//=TrouverLangue("blocs.marginLeft");?></label>
                                    <input type="text" id="urlImage_<?=$i?>" name="urlImage_<?=$i?>" value="" />
                                </div>
                            </div>
                        </div>

                        <!-- Bloc Video -->
                        <div class="blocVideo blocVideoModal blocTypeVideo">
                            <div class="form-group row col-md-12">
                                <div class="mt-12">
                                    <label for="margin-left">URL Video<?//=TrouverLangue("blocs.marginLeft");?></label>
                                    <input type="text" id="urlVideo_<?=$i?>" name="urlVideo_<?=$i?>" value="" />
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <?php endforeach; ?>
            </div>
        </form>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal"><?=TrouverLangue("annuler")?></button>
        <button type="button" class="btn btn-primary btn-success saveBlocModal"><?=TrouverLangue("sauvegarder")?></button>
    </div>
</div>


<?php DebutJavascript(); ?>
<script type="text/javascript">

$( document ).ready(function() {

});
</script>
<?php FinJavascript(); ?>
