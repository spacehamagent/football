<div class="wrapper-page">
    <div class="text-center">
        <a href="#" class="logo-lg"><i class="mdi mdi-radar"></i> <span><?=$cfg["nomProjet"]?></span> </a>
    </div>

    <form class="form-horizontal m-t-20" id="formulaireLogin" name="formulaireLogin" action="#" method="post">

        <div class="form-group row">
            <div class="col-12">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="mdi mdi-account"></i></span>
                    </div>
                    <input id="courriel" name="courriel" class="form-control" type="text" required="" placeholder="<?=TrouverLangue("usagers.courriel")?>">
                </div>
            </div>
        </div>

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
            <div class="col-12"></div>
        </div>

        <div class="form-group text-right m-t-20">
            <div class="col-xs-12">
                <button class="btn btn-primary btn-custom w-md waves-effect waves-light" type="submit"><?=TrouverLangue("usagers.connexion")?></button>
            </div>
        </div>

        <div class="form-group row m-t-30">
            <div class="col-sm-7">
                <a href="#reinitialisation" class="text-mutedwaves-effect waves-light" data-animation="makeway" data-plugin="custommodal" data-overlayspeed="100" data-overlaycolor="#36404a"><i class="fa fa-lock m-r-5"></i> <?=TrouverLangue("usagers.motDePasseOublie")?></a>
            </div>
            <div class="col-sm-5 text-right">
                
            </div>
        </div>
    </form>
    <div class="msgLogin" style="display:none;">
        <i class="fa fa-circle-o-notch fa-spin" style="font-size:24px"></i>
        <div class="message"></div>
    </div>
    <div class="messageError"></div>
    <!-- Custom Modal -->
    <div id="reinitialisation" class="modal-demo">
        <button type="button" class="close" onclick="Custombox.close();">
            <span>&times;</span><span class="sr-only"> </span>
        </button>
        <h4 class="custom-modal-title"><?=TrouverLangue("usagers.reinitialisationMotPasse")?></h4>
        <div class="custom-modal-text">
            <form class="form-horizontal m-t-20" id="formulaireReinitialisation" name="formulaireReinitialisation" action="#" method="post">
                <div class="form-group row">
                    <div class="col-12">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="mdi mdi-account"></i></span>
                            </div>
                            <input id="courrielReset" name="courrielReset" class="form-control" type="text" required="" placeholder="<?=TrouverLangue("usagers.courriel")?>">
                        </div>
                    </div>
                </div>
                <div class="form-group text-right m-t-20">
                    <div class="col-xs-12">
                        <button class="btn btn-primary btn-custom w-md waves-effect waves-light" type="submit"><?=TrouverLangue("usagers.reinitialiser")?></button>
                    </div>
                </div>
            </form>
            <div class="msgReinitialisation" style="display:none;">
                <div class="messageReinitialisation"></div>
            </div>
        </div>
    </div>

</div>

<?php DebutJavascript(); ?>
<script type="text/javascript">
$( document ).ready(function() {

    $('#courriel').focus();

    $('#courriel').on("change", function(){
        $('#courrielReset').val($('#courriel').val());
    });

    $("#formulaireLogin").validate({
        rules: {
            courriel: {
                required: true,
                email: true
            },
            motDePasse: {
                required: true
            }
        },
        errorPlacement: function(error, element){
            $(element).closest('.row').append(error);
        },
        errorElement: "p",
        submitHandler: function(form) {
            $.ajax({
                type: "post",
                url: "./login-traitement/?ajax=1",
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
                                window.location = "/fr/cms/accueil/";
                            }, 200
                        );
                        
                    }
                }
            });
        }
    });

    $("#formulaireReinitialisation").validate({
        rules: {
            courrielReset: {
                required: true,
                email: true
            }
        },
        errorPlacement: function(error, element){
            $(element).closest('.row').append(error);
        },
        errorElement: "p",
        submitHandler: function(form) {
            $.ajax({
                type: "post",
                url: "./reinitialisation/?ajax=1",
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
                        $('.messageReinitialisation').html(resultat.message);
                        $('.msgReinitialisation').show().fadeIn().delay(2000).fadeOut();;
                    }
                }
            });
        }
    });
});
</script>
<?php FinJavascript(); ?>
