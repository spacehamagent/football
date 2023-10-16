<div class="wrapper-page">
    <div class="text-center">
        <a href="#" class="logo-lg"><i class="mdi mdi-radar"></i> <span><?=$cfg["nomProjet"]?></span> </a>
    </div>
<?php if(!empty($usager) && $usager[0]["courrielUsager"] == $courriel): ?>
    <form class="form-horizontal m-t-20" id="formulaireReset" name="formulaireReset" action="#" method="post">
        <input type="hidden" id="courriel" name="courriel" value="<?=$courriel?>" />
        <input type="hidden" id="hash" name="hash" value="<?=$hash?>" />
        <div class="row">
            <div class="form-group row">
                <div class="form-group row">
                    <div class="col-12">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="mdi mdi-radar"></i></span>
                            </div>
                            <input id="motDePasse" name="motDePasse" class="form-control" type="password" required="" placeholder="<?=TrouverLangue("usagers.motDePasse")?>">
                        </div>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-12">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="mdi mdi-radar"></i></span>
                            </div>
                            <input id="motDePasseVerif" name="motDePasseVerif" class="form-control" type="password" required="" placeholder="<?=TrouverLangue("usagers.motDePasseVerification")?>">
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-12">
                    <button class="btn btn-primary btn-custom w-md waves-effect waves-light" type="submit"><?=TrouverLangue("usagers.reinitialisation")?></button>
                </div>
            </div>
        </div>
    </form>

<?php DebutJavascript(); ?>
<script type="text/javascript">
    $( document ).ready(function() {

        $('#motDePasse').focus();

        $("#formulaireReset").validate({
            rules: {
                motDePasse: {
                    required: true
                },
                motDePasseVerif: {
                    required: true,
                    equalTo: "#motDePasse"
                }
            },
            errorPlacement: function(error, element){
                $(element).closest('.row').append(error);
            },
            errorElement: "p",
            submitHandler: function(form) {
                $.ajax({
                    type: "post",
                    url: "./reinitialisation-traitement/?ajax=1",
                    data: $(form).serialize(),
                    dataType: "json",
                    
                    "error": function (XMLHttpRequest, textStatus, errorThrown) {
                        alert('Erreur');
                    }, 
                    success: function(resultat){
                        if (resultat.etat != 1){
                            $('.messageError').show().html(resultat.message).fadeIn().delay(2000).fadeOut();
                        }
                        
                        if (resultat.etat == 1){
                            $('.msgLogin').show();
                            $('.message').html(resultat.message);

                            setTimeout(
                                function() {
                                    window.location = "<?=TrouverLien(INTRANET_LOGIN)?>";
                                }, 1000
                            );
                            
                        }
                    }
                });
            }
        });
    });
</script>
<?php FinJavascript(); ?>

<?php else: ?>
    <p><?=TrouverLangue("usagers.aucunUsagerReset")?></p>
<?php endif; ?>
</div>







