<?php /* ?>
<div class="form-group row col-md-12">
    <div class="clearfix pull-right m-t-15">
        <a href="#uploadFichiers" class="text-mutedwaves-effect waves-light" data-animation="push" data-plugin="custommodal" data-overlayspeed="100" data-overlaycolor="#36404a"><i class="fa fa-download m-r-5"></i> Télécharger fichiers</a>
    </div>
</div>

<?php */ ?>
<div class="form-group row col-md-12">
    <div class="clearfix pull-right m-t-15">
        <a type="button" class="btn fichiersModal btn-outline-info" href="#" data-value="1">Télécharger fichier</a>
    </div>
</div>


<div class="form-group row col-md-12">
    <div class="clearfix pull-right m-t-15">
        <p>Taille total de l'usager : <?=CalculerTailleOctet($stockages["usager"]);?><br/>
        Taille total des fichiers : <?=CalculerTailleOctet($stockages["total"]);?></p>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="contenuFichierModal" tabindex="-1" role="dialog" aria-labelledby="contenuFichierModal" aria-hidden="true">
    <div class="modal-dialog modal-lg contenuFichierModal" role="document">
        <?=Render('fichiers/intranet-telecharger-fichiers-modal')?>
    </div>
</div>


<!-- Custom Modal -->
<div id="uploadFichiers" class="modal-demo">
    <button type="button" class="close" onclick="javascript:FermerUpload();">
        <span>&times;</span><span class="sr-only">Close</span>
    </button>
    <h4 class="custom-modal-title"><?=TrouverLangue("fichiers.telechargerFichier")?></h4>
    <form id="DonneesFiles" name="DonneesFiles" action="#" class="dropzone dz-clickable">
        <div class="dz-default dz-message">
            <span><?=TrouverLangue("fichiers.placerFichierIci")?></span>
        </div>
    </form>
</div>

<div class="row listeFichiers"></div>
<?php Render("fichiers/intranet-fichiers");?>

<?php DebutJavascript(); ?>
<script type="text/javascript">
$( document ).ready(function() {
    var index = 0;
    var load = true;
    
    $(window).scroll(function() {
        if($(window).scrollTop() == $(document).height() - $(window).height()) {
            LoadFileAjax();
        }
    });

    $('.fichiersModal').on('click', function(){
        $('#contenuFichierModal').modal('show');
    });

    $(document).on('click', ".btnSave", function(e) {
        var noEnr = $(this).parents('div.fichierTmp').find('.noEnr').val();
        var titreFr = $(this).parents('div.fichierTmp').find('.nomFichier_1').val();
        var titreEn = $(this).parents('div.fichierTmp').find('.nomFichier_2').val();

        $.ajax({
            type: "post",
            url: "./fichiers-traitement/?ajax=1",
            data: {"noEnr": noEnr, "titreFr": titreFr, "titreEn": titreEn},
            dataType: "json",
            
            "error": function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Erreur');
            }, 
            success: function(resultat){
                if (resultat.etat == 1){
                    $('#fichier_'+noEnr).hide();
                }
            }
        });
    });

    $(document).on('click', ".btnDelete", function(e) {
        var noEnr = $(this).parents('div.fichierTmp').find('.noEnr').val();

        $.ajax({
            type: "post",
            url: "./fichiers-supprimer-traitement/?ajax=1",
            data: {"noEnr": noEnr},
            dataType: "json",
            
            "error": function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Erreur');
            }, 
            success: function(resultat){
                if (resultat.etat == 1){
                    $('#fichier_'+noEnr).hide();
                }
            }
        });
    });

    function LoadFileAjax(){
        if(load){
            $.ajax({
                type: "post",
                url: "./fichiers-load/?ajax=1",
                data: {"noIndex": index},
                dataType: "json",
                
                "error": function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Erreur');
                }, 
                success: function(resultat){
                    if (resultat.etat == 1){
                        index+=21;
                        $('.listeFichiersBibliotheque').append(resultat.html);
                    } else{
                        load = false;
                    }
                }
            });  
        }  
    }

    LoadNouveauFichiers();
    LoadFileAjax();
});

function FermerUpload(){
    console.log("debut");
    Custombox.close();
    window.location.href = ".";
    //console.log("Close termine");
}

function SetImageAvatar(noEnr){
    $.ajax({
        type: "post",
        url: "./fichiers-setAvatar/?ajax=1",
        data: {"noImage": noEnr},
        dataType: "json",
        
        "error": function (XMLHttpRequest, textStatus, errorThrown) {
            alert('Erreur');
        }, 
        success: function(resultat){
            if (resultat.etat == 1){
                $('.avatar_'+noEnr).css("color", "green");
            } else {
                $('.avatar_'+noEnr).css("color", "");
            }
        }
    });
}

function ArchiveFichier(noEnr){
    $.ajax({
        type: "post",
        url: "./fichiers-archive/?ajax=1",
        data: {"noImage": noEnr},
        dataType: "json",
        
        "error": function (XMLHttpRequest, textStatus, errorThrown) {
            alert('Erreur');
        }, 
        success: function(resultat){
            if (resultat.etat == 1){
                $('#fichier_'+noEnr).hide();
            }
        }
    });
}

function LoadNouveauFichiers() {
    setTimeout(function(){ 
        $.ajax({
            url: "./lister-fichiers-confirmer/?ajax=1",
            dataType: "json",
            "error": function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Erreur');
            }, 
            success: function(resultat){
                if (resultat.etat == 1){
                    $('.listeFichiers').html(resultat.html);
                }
            }
        });
    }, 500);
    
}

</script>
<?php FinJavascript(); ?>
