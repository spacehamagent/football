<div class="row">
    <div class="col-lg-1"> </div>
    <div class="col-lg-10 col-sm-12 formulaire">
        <form id="Donnees" name="Donnees" action="#" method="post">
            <div class="form-group">
                <label for="prenom"><?=TrouverLangue("prenom")?></label>
                <input type="text" class="form-control" id="prenom" name="prenom" placeholder="<?=TrouverLangue("demandesInformations.votrePrenom")?>" value="">
            </div>

            <div class="form-group">
                <label for="nom"><?=TrouverLangue("nom")?></label>
                <input type="text" class="form-control" id="nom" name="nom" placeholder="<?=TrouverLangue("demandesInformations.votreNom")?>" value="">
            </div>

            <div class="form-group">
                <label for="courriel"><?=TrouverLangue("courriel")?></label>
                <input type="text" class="form-control" id="courriel" name="courriel" placeholder="<?=TrouverLangue("demandesInformations.votreCourriel")?>" value="">
            </div>

            <div class="form-group">
                <label for="telephone"><?=TrouverLangue("telephone")?></label>
                <input type="text" class="form-control" id="telephone" name="telephone" placeholder="<?=TrouverLangue("demandesInformations.votreTelephone")?>" value="">
            </div>

            <div class="form-group">
                <label for="sujet"><?=TrouverLangue("titre")?></label>
                <input type="text" class="form-control" id="sujet" name="sujet" placeholder="<?=TrouverLangue("demandesInformations.votreSujet")?>" value="">
            </div>

            <div class="form-group">
                <label for="sujet"><?=TrouverLangue("demandesInformations.commentaire")?></label>
                <textarea id="commentaire" name="commentaire" class="md-textarea form-control" rows="5" maxlength="500"></textarea>
            </div>

            <?php if(isset($cfg["Google"]["reCaptchaPublic"]) && strlen($cfg["Google"]["reCaptchaPublic"]) > 0) { ?>
            <div class="form-group">
                <div class="g-recaptcha" data-sitekey="<?=$cfg["Google"]["reCaptchaPublic"]?>"></div>
                <input type="hidden" class="hiddenRecaptcha required" name="hiddenRecaptcha" id="hiddenRecaptcha">
            </div>
            <?php } ?>

            <button type="submit" class="btn btn-primary btn-success btnFormulaire"><?=TrouverLangue("envoyer") ?></button>
        </form>
    </div>
    <div class="col-lg-1"> </div>
</div>

<?php DebutJavascript(); ?>
<script type="text/javascript">
$( document ).ready(function() {


    $.validator.addMethod("isEmail", function(value, element) {
        var email = $('#courrielDemandeInformation').val();
        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        return regex.test(value);
    },'<?=TrouverLangue("demandesInformations.msgIsEmail")?>');


    $("#Donnees").validate({
        ignore: ".ignore",
        rules: {
            prenom: { required: true },
            nom: { required: true },
            courriel: {
                required: true,
                email: true,
                isEmail: true
            },
            sujet: { required: true },
            commentaire: { required: true },
            hiddenRecaptcha: {
                required: function () {
                    if (grecaptcha.getResponse() == '') {
                        return true;
                    } else {
                        return false;
                    }
                }
            }
        },
        errorPlacement: function(error, element){
            $(element).closest('.form-group').append(error);
        },
        errorElement: "p",
        submitHandler: function(form) {
            $.ajax({
                type: "post",
                url: "ajouter-traitement/?ajax=1",
                data: $(form).serialize(),
                dataType: "json",
                
                "error": function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Erreur');
                }, 
                success: function(resultat){
                    message = resultat.message;
                    if (resultat.etat == 1){
                        message = "<?=TrouverLangue("demandesInformations.remerciement")?>";
                    }

                    $('.formulaire').html(message);
                }
            });
        }
    });
});
</script>
<?php FinJavascript(); ?>
