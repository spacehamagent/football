<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <form id="Donnees" name="Donnees" action="#" method="post">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="general-tab" data-toggle="tab" href="#general" role="tab" aria-controls="general" aria-selected="true">Général</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="langues-tab" data-toggle="tab" href="#langues" role="tab" aria-controls="langues">Langues</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="coordonnees-tab" data-toggle="tab" href="#coordonnees" role="tab" aria-controls="coordonnees">Coordonnées</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="formulaires-tab" data-toggle="tab" href="#formulaires" role="tab" aria-controls="formulaires">Formulaires</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="couleurs-tab" data-toggle="tab" href="#couleurs" role="tab" aria-controls="couleurs">Couleurs</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="reseau-sociaux-tab" data-toggle="tab" href="#reseau-sociaux" role="tab" aria-controls="reseau-sociaux">Réseaux Sociaux</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="api-tab" data-toggle="tab" href="#api" role="tab" aria-controls="api">API</a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="general" role="tabpanel" aria-labelledby="general-tab">
                    <?=Render("config/intranet-lister-general",["config" => $config]); ?>
                </div>
                <div class="tab-pane fade show" id="langues" role="tabpanel" aria-labelledby="langues-tab">
                    <?=Render("config/intranet-lister-langue",["config" => $config]); ?>
                </div>
                <div class="tab-pane fade show" id="coordonnees" role="tabpanel" aria-labelledby="coordonnees-tab">
                    <?=Render("config/intranet-lister-coordonnees",["config" => $config]); ?>
                </div>
                <div class="tab-pane fade show" id="formulaires" role="tabpanel" aria-labelledby="formulaires-tab">
                    <?=Render("config/intranet-lister-formulaires",["config" => $config]); ?>
                </div>
                <div class="tab-pane fade show" id="couleurs" role="tabpanel" aria-labelledby="couleurs-tab">
                    <?=Render("config/intranet-lister-couleurs",["config" => $config]); ?>
                </div>
                <div class="tab-pane fade show" id="reseau-sociaux" role="tabpanel" aria-labelledby="reseau-sociaux-tab">
                    <?=Render("config/intranet-lister-reseaux-sociaux",["config" => $config]); ?>
                </div>
                <div class="tab-pane fade show" id="api" role="tabpanel" aria-labelledby="api-tab">
                    <?=Render("config/intranet-lister-api",["config" => $config]); ?>
                </div>
            </div>
            <button type="submit" class="btn btn-primary btnFormulaire"><?=TrouverLangue("sauvegarder");?></button>
        </form>
    </div>
</div>

<?php DebutJavascript(); ?>
<script type="text/javascript">
$( document ).ready(function() {
    $("#Donnees").validate({
        rules: {
            <?php foreach($cfg["languesSite"] as $i) { ?>
            nomProjet_<?=$i?>: { required: true },
            courriel_<?=$i?>: { email: true },
            facebook_<?=$i?>: { url: true },
            twitter_<?=$i?>: { url: true },
            instagram_<?=$i?>: { url: true },
            <?php } ?>
            ville: { required: true }
        },
        errorPlacement: function(error, element){
            $(element).closest('.form-group').append(error);
        },
        errorElement: "p",
        submitHandler: function(form) {
            MessageSauvegarde('<?=TrouverLangue("msgSauvegardeEnCours")?>',1000);
            
            $.ajax({
                type: "post",
                url: "./enregistrer-ajax/?ajax=1",
                data: $(form).serialize(),
                dataType: "json",
                "error": function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Erreur config sauvegarde');
                },
                success: function(resultat){
                    if (resultat.etat == 1){
                        window.setTimeout(function(){location.reload()},1000)
                    }
                }
            });
        }
    });
});
</script>
<?php FinJavascript(); ?>
