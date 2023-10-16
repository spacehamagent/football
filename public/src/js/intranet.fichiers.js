$(document).ready(function () {
    setTimeout( function() 
    {
        VerificationImageParcourir();
    }, 1000);

});
var listeImagesCrop = false;
var pathBibliotheque = '/fr/cms/contenu/bibliotheque/';
var x = 0;
var y = 0;
var w = 0;
var h = 0;
var largeur = 16;//<?=$width?>;
var hauteur = 9;//<?=$height?>;
//var img = $('.imgSrc').attr('src');
var img = $('#cropbox').attr('src');

// Image Parcourir
function VerificationImageParcourir() {
    if ($("#btnImageParcourir").length) {
        ConstruireModalImageParcourir();
        BuildBtnImageParcourir(300,275,'actualites');
        SetActionImageParcourir();
        ModalPreparerVisuelImageParcourir();

        $(document).on('click', '.imgSrcForCrop', function () {
            url = $(this).find('img').attr('src');
            $('#cropbox').attr('src', url);
            $('.jcrop-holder img').attr('src', url);
        });

        // Pour image section
        $(document).on('click', '#btnImageParcourir', function () {
            ObtenirFichierImageParcourir();
        });

    }
}

function ConstruireModalImageParcourir() {
    $.ajax({
        type: "post",
        url: pathBibliotheque+"obtenir-modal-imgParcourir/?ajax=1",
        dataType: "json",
        
        "error": function (XMLHttpRequest, textStatus, errorThrown) {
            alert('Erreur');
        },
        success: function(resultat){
            if (resultat.etat == 1){
                var html = '<!-- Section Modal pour cropper image - Premier test !-->';
                html += '<!-- Modal -->'
                html += '<div class="modal fade" id="imageCropModal" tabindex="-1" role="dialog" aria-labelledby="imageCropModal" aria-hidden="true">';
                html += '<div class="modal-dialog modal-lg contenuCropImage" role="document">'+resultat.html+'</div>';
                html += '</div>';

                $('#autresHtml').html(html);
            }
        }
    });
}

function ModalPreparerVisuelImageParcourir() {
    if(listeImagesCrop) {
        $('.modalListeImagesCrop').show();
        $('.modalImageCrop').hide();
    } else {
        AppliquerCrop();
        $('.modalListeImagesCrop').hide();
        $('.modalImageCrop').show();
    }
}
function BuildBtnImageParcourir(x,y,module) {
    var pathImage = "/fichiersUpload/fichiers/opt/"+x+"-"+y+"/";
    var img = $('.imageParcourir').val();
    var style = '';
    
    if (img.length == 0) {
        style = 'display:none;';
        listeImagesCrop = false;
        $('.imageParcourirCrop').hide();
        $('.actionsImgParcourir').hide();
        $("#btnImageParcourir").show();
    } else {
        var html = '<div class="imgParcourirCrop" style="'+style+'">'
        html += '<img src="' + pathImage + img + '" class="imageParcourirCrop" id="imageParcourirCrop" name="imageParcourirCrop" />';
        html += '<div class="actionsImgParcourir">';
        html += '<span><a href="#" class="cropImgParcourir"><i class="fa fa-pencil fa-2x"></i></a></span>';
        html += '<span><a href="#" class="trashImgParcourir"><i class="fa fa-trash fa-2x"></i></a></span>';
        html += '</div>';
        html += '</div>';
        $("#btnImageParcourir").parent().append(html);
        
        $("#btnImageParcourir").hide();
    }
}

function SetActionImageParcourir() {
    $(document).on('click', '.cropImgParcourir', function() {
        ModalPreparerVisuelImageParcourir();
        ObtenirFichierImageParcourir();
    });

    $(document).on('click', '.trashImgParcourir', function() {
        SupprimerImageParcourir();
        $('.image').val('');
    });

    $(document).on('click', '#cropSave', function() {
        $.ajax({
            url: pathBibliotheque+"crop-image-sauvegarde/?ajax=1",
            type: "post",
            data: {"tmpNom": '20190525083751-Bane_Batman.png',"img": img,"x":x,"y":y,"width":w,"height":h,"largeur": largeur, "hauteur": hauteur},
            dataType: "json",
            "error": function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Erreur');
            }, 
            success: function(resultat){
                if (resultat.etat == 1){
                    //setter la nouvelle image dans le formulaire avec les options [ Crop | Supprimer]
                    $('#image').attr('src',resultat.imageInfos.urlImage);
                    $('#imageActualite').val(resultat.imageInfos.nomImage);
                    $('.imgShowCrop').show();
                    $('#imageCropModal').modal('hide');
                }
            }
        });
    });
}

function SupprimerImageParcourir() {
    console.log('Supprimer image');
    $('.imageParcourir').val('');
    BuildBtnImageParcourir(300,275,'actualites');
}

function ObtenirFichierImageParcourir() {
    // obtenir-fichiers-image
    
    $.ajax({
        type: "post",
        url: pathBibliotheque+"obtenir-fichiers-image/?ajax=1",
        dataType: "json",
        
        "error": function (XMLHttpRequest, textStatus, errorThrown) {
            alert('Erreur');
        },
        success: function(resultat){
            if (resultat.etat == 1){
                VisuelListerImageModal(resultat.images);
            }
        }
    });

    $('#imageCropModal').modal('show');
}

function VisuelListerImageModal(images) {
    var html = '';
    
    $.each(images, function(key, value) {
        html += '<div class="imageListe col-lg-2 col-sm-4" style="padding:5px !important">';
        html += '<a href="#" class="imgSrcForCrop"><img src="/fichiersUpload/fichiers/'+value.nomTmpFichier+'" title="'+value.titreFichierLangue+'" style="max-width:90px;height:auto;"/><a>';
        html += '</div>';
    });

    $('.listeImagesCrop').html(html);
}

function AppliquerCrop() {
    console.log('CROP: largeur:' + largeur + ' | hauteur:' + hauteur);

    $('#cropbox').Jcrop({
        boxWidth: 600,
        aspectRatio: largeur / hauteur,
        minSize: [largeur,hauteur],
        onSelect: function(c) {
            x = c.x;
            y = c.y;
            w = c.w;
            h = c.h;
            size = {x:c.x,y:c.y,w:c.w,h:c.h};
        }
    });
}


