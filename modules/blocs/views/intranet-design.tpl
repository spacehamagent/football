<?php

use SHA\Bloc;

$keyTime = time();

$build =  Bloc::ConstruireGridIntranet($blocs["blocs"]);

$infosBuild = array_merge($build, $blocs);
?>

<div class="row" >
    <button type="button" class="btn btn-primary btnBlocs btnCreerBloc btn-secondary"><i class="fa fa-plus fa-1x"></i> <?=TrouverLangue("pages.btnCreerBloc")?></button>
    <button type="button" class="btn btn-primary btnBlocs btnSauvegarder btn-success"><i class="fa fa-save fa-1x"></i> <?=TrouverLangue("pages.btnSauvegarderBloc")?></button>
    <button type="button" class="btn btn-primary btnBlocs btnPublie"><i class="fa fa-desktop fa-1x"></i> <?=TrouverLangue("pages.btnPublieBloc")?></button>
</div>

<div class="card-box" style="width:100%; height:600px; overflow: auto;" >
    <div class="loadingGrid"><i class="fas fa-sync fa-spin"></i></div>

    <div class="grid-intranet" style="display:none;">
        <div class="grid-stack">
            <?=$infosBuild["html"]?>
        </div>
    </div>
</div>

<?php DebutJavascript(); ?>
<script type="text/javascript">
var grid;

$( document ).ready(function() {
    var indexBlocAjout = <?=$infosBuild["index"]?>;
    var noBlocAjout = <?=$infosBuild["noBloc"]?>;
    var keyTimeAjout = '<?=$infosBuild["keyTimeBloc"]?>';
    var typeBlocAjout = 1;

    var optionsGridStack = {
        verticalMargin: 0,
        animate: true,
        always_show_resize_handle: false,
        height: 0,
        removable: false,
        width: 12
    };

    grid = GridStack.init(optionsGridStack);

    $('.btnCreerBloc').on('click', function() {
        CreationNouveauBloc();
    });

    $('.btnSauvegarder').on('click', function() {
        SauvegarderTousLesBlocs();
    })

    $('.btnPublie').on('click', function() {
        bootbox.alert("La publication n'est pas active. Cette option va mettre en ligne votre page avec vos blocs.");
    });

    $(document).on('click', "a.pencil", function(e) {
        e.preventDefault();
        var bloc = $(this).parent().parent().parent();
        var noBloc = bloc.attr("data-noBloc");
        var key = bloc.attr("data-key");
        var indexBloc = bloc.attr("data-index");
        var type = bloc.attr("data-type");

        EditerBloc(noBloc, key, indexBloc,type);
    });

    $( ".bloc" ).each(function( index ) {
        MiseAJourInfoBlocGrid($(this));
    });

    $( ".bloc" ).mouseenter(function( event ) {
        MiseAJourInfoBlocGrid($(this));
    });
    $( ".bloc" ).mouseleave(function( event ) {
        MiseAJourInfoBlocGrid($(this));
    });

    function MiseAJourInfoBlocGrid(bloc) {
        width = bloc.attr("data-gs-width");
        height = bloc.attr("data-gs-height");
        typeBloc = bloc.attr("data-type");

        type = "<?=TrouverLangue("blocs.typeBlocTexte");?>";
        switch(typeBloc) {
            case "2":
                type = "<?=TrouverLangue("blocs.typeBlocImage");?>";
            break;
            case "3":
                type = "<?=TrouverLangue("blocs.typeBlocVideo");?>";
            break;
        }
        bloc.find('.infoBloc').find("span").html(type+' ['+width+', '+height+']');
    }

    $(document).on('click', "a.trash", function(e) {
        e.preventDefault();
        var bloc = $(this).parent().parent().parent();
        var noBloc = bloc.attr("data-noBloc");
        var key = bloc.attr("data-key");
        var indexBloc = bloc.attr("data-index");

        RetirerBloc(noBloc,key,indexBloc);
    });

    function ObtenirInfosBloc(bloc) {
        var noBloc = bloc.attr("data-noBloc");
        var key = bloc.attr("data-key");
        var indexBloc = bloc.attr("data-index");

        var x = bloc.attr("data-gs-x");
        var y = bloc.attr("data-gs-y");
        var width = bloc.attr("data-gs-width");
        var height = bloc.attr("data-gs-height");

        return {"noBloc": noBloc,"key": key, "indexBloc": indexBloc, "x": x, "y": y, "width": width, "height": height };
    }

    $(document).on('click', "a.choixBloc", function(e) {
        e.preventDefault();
        var type = $(this).attr("data-value");
        typeBlocAjout = type;
        $('#typeBlocModal').modal('hide');
        AjouterNouveauBloc(type);
    });

    function CreationNouveauBloc() {
        $('#typeBlocModal').modal('show');
    }

    function AjouterNouveauBloc(typeBlocAjout) {
        var texte = ObtenirTexteDefautBloc(typeBlocAjout);
        var html = '<div class="bloc" data-noBloc="'+noBlocAjout+'" data-key="'+keyTimeAjout+'" data-index="'+indexBlocAjout+'" data-type="'+typeBlocAjout+'"';
        html += 'data-gs-x="0" data-gs-y="0" data-gs-width="12" data-gs-height="1">';
        html += '<div class="infoBloc">';
        html += '<span></span>';
        html += '</div>';
        html += '<div class="actionsBloc">';
        html += '<span><a href="#" class="pencil" ><i class="fa fa-pencil fa-2x" aria-hidden="true"></i></a></span>';
        html += '<span><a href="#" class="trash"><i class="fa fa-trash fa-2x" aria-hidden="true"></i></a></span>';
        html += '</div><div class="grid-stack-item-content"><i class="fa fa-sync fa-spin"></i>'+texte+'</div></div>';
        
        grid.addWidget($(html), 0, 0, 12, 1);

        $('.grid-intranet').show();
        indexBlocAjout++;
    }

    function ObtenirTexteDefautBloc(type) {
        texte = "";

        switch(type) {
            case '2':
                texte = "Image";
            break;
            case '3':
                texte = CreationYouTubeImage('');
            break;
            default:
                texte = "Texte";
        }
        return texte;
    }

    
    function EditerBloc(noBloc, key, index, type) {
        source = '<?=(($cfg["action"] == "intranet-ajouter") ? '../' : '../../');?>edition-bloc-langue/?ajax=1';
        //MettreVisibleModalSelonTypeBloc();
        $.ajax({
            type: "post",
            url: source,
            data: { "noBloc": noBloc, "key": key, "index": index, "type": type },
            dataType: "json",
            "error": function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Erreur');
            }, 
            success: function(resultat){
                if (resultat.etat == 1){
                    $('.contenuFormBloc').html(resultat.html);
                    tinymce.remove();
                    tinymce.init(OptionDefaultTinyMCE());

                    PeuplerContenuBlocModal(resultat.bloc);

                    $('#contenuBlocModal').modal('show');
                }
            }
        });
    }

    function SauvegarderTousLesBlocs() {
        var blocs = ObtenirTousLesBlocs();

        if(blocs.length > 0) {
            source = '<?=(($cfg["action"] == "intranet-ajouter") ? '../' : '../../');?>enregistrer-blocs/?ajax=1';
            $.ajax({
                type: "post",
                url: source,
                data: { "blocs" : blocs },
                dataType: "json",
                "error": function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Erreur');
                }, 
                success: function(resultat){
                    if (resultat.etat != 1){
                        bootbox.alert("Aucun blocs à enregistrer.");
                    } else {
                        bootbox.alert("Vos blocs ont été sauvegarder");
                    }
                }
            });
        }
    }

    function ObtenirTousLesBlocs() {
        var blocs = []
        $('.bloc').each( function() {
            contenu = ObtenirInfosBloc($(this));
            blocs.push(contenu);
        });

        return blocs;
    }

    function RetirerBloc(noBloc, key, index) {
        bootbox.confirm({
            message: "<?=TrouverLangue("blocs.msgSuppressionBloc")?> ["+index+"]",
            buttons: {
                confirm: {
                    label: '<?=TrouverLangue("oui")?>',
                    className: 'btn-danger'
                },
                cancel: {
                    label: '<?=TrouverLangue("non")?>',
                    className: 'btn'
                }
            },
            callback: function (result) {
                if(result) {
                    SupprimerBloc(noBloc, key, index);
                }
            }
        });
    }

    function SupprimerBloc(noBloc, key, index) {
        source = '<?=(($cfg["action"] == "intranet-ajouter") ? '../' : '../../');?>supprimer-bloc/?ajax=1';
        $.ajax({
            type: "post",
            url: source,
            data: { "noBloc" : noBloc, "key": key, "index": index },
            dataType: "json",
            "error": function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Erreur');
            }, 
            success: function(resultat){
                if (resultat.etat == 1){
                    grid.removeWidget($('.bloc[data-index="'+index+'"]'));
                }
            }
        });
    }

    function ChargementContenuBloc() {
        var blocs = ObtenirTousLesBlocs();
        if(blocs.length > 0) {
            source = '<?=(($cfg["action"] == "intranet-ajouter") ? '../' : '../../');?>obtenir-contenu-bloc-traitement/?ajax=1';
            
            $.each( blocs, function( i, l ) {
                $.ajax({
                    type: "post",
                    url: source,
                    data: { "noBloc": l.noBloc, "key": l.key, "index": l.indexBloc },
                    dataType: "json",
                    "error": function (XMLHttpRequest, textStatus, errorThrown) {
                        alert('Erreur');
                    }, 
                    success: function(resultat){
                        if (resultat.etat == 1) {
                            var blocInfos = resultat.blocLangue[<?=$cfg["noLangue"]?>];
                            var blocContenu = blocInfos.contenuBlocEnregistrementLangue;

                            //var blocTexte = blocInfos.contenuBlocEnregistrementLangue.texte;

                            // Si type Texte prendre le texte | 1
                            // Si type Image prendre le lien video | 2
                            // Si type Video prendre le type video | 3
                            contenu = blocInfos.contenuBlocEnregistrementLangue.texte;
                            
                            if(blocInfos.contenuBlocEnregistrementLangue.type == 3) {
                                contenu = CreationYouTubeImage(blocInfos.contenuBlocEnregistrementLangue.urlVideo);
                            }

                            martop = blocInfos.contenuBlocEnregistrementLangue["margin-top"];
                            marbot = blocInfos.contenuBlocEnregistrementLangue["margin-bottom"];
                            marright = blocInfos.contenuBlocEnregistrementLangue["margin-right"];
                            marleft = blocInfos.contenuBlocEnregistrementLangue["margin-left"];

                            padtop = blocInfos.contenuBlocEnregistrementLangue["padding-top"];
                            padbot = blocInfos.contenuBlocEnregistrementLangue["padding-bottom"];
                            padright = blocInfos.contenuBlocEnregistrementLangue["padding-right"];
                            padleft = blocInfos.contenuBlocEnregistrementLangue["padding-left"];
                            
                            var blocTexte = ConstruireIntranetBlocContenuLangue(martop,marbot,marleft,marright,padtop,padbot,padleft,padleft,contenu);
                            
                            $("div.bloc[data-index="+blocInfos.indexBlocEnregistrement+"]").find(".grid-stack-item-content").html(blocTexte);
                        }
                    }
                });
            });

            DisplayContenuSelonTypeBloc();

            $('.loadingGrid').hide();
            $('.grid-intranet').show();
        }
    }

    function DisplayContenuSelonTypeBloc() {
        // Par défaut afficher contenu Texte
        // Si type = 2 Image afficher seulement contenu image
        // Si type = 3 Video afficher seulement contenu video
        type = $('#type').val();

        $('#blocTexteModal').show();
        $('#blocVideoModal').show();

        if(type == "3") {
            $('#blocTexteModal').hide();
        } else {
            $('#blocVideoModal').hide();
        }
    }

    function CreationYouTubeImage(id) {
        srcImage = '/images/site/defaultVideoImage.jpg';
        
        if(id.length > 0) {
            srcImage = 'http://i3.ytimg.com/vi/'+id+'/maxresdefault.jpg';
        }

        html = '<div class="blocVideoImage" >';
        html += '<img class"imgVideoImage" src="'+srcImage+'" style="width:100%;height:100%;" />';
        //html += '<img class"imgVideoImageHover" src="/images/site/playButton.png" style="width:100%;height:100%;" />';
        html += '</div>';

        return html;
    }

    function ConstruireIntranetBlocContenuLangue(martop,marbot, marleft, marright, padtop, padbot, padleft, padright, texte) {
        var txt = "";
        var style = "margin-top:"+martop+"px;margin-bottom:"+marbot+"px;margin-left:"+marleft+"px;margin-right:"+marright+"px;";
        style += "padding-top:"+padtop+"px;padding-bottom:"+padbot+"px;padding-left:"+padleft+"px;padding-right:"+padright+"px;";
        style += "width:98%;height:98%;";
        txt += '<div class="blocContenu" style="'+style+'">';
        txt += texte;
        txt += '</div>';

        return txt;
    }

    $(document).on('click', ".typeNouveauBloc", function(e) {
        e.preventDefault();

    });

    $(document).on('click', ".saveBlocModal", function(e) {
        e.preventDefault();
        source = '<?=(($cfg["action"] == "intranet-ajouter") ? '../' : '../../');?>enregistrer-bloc-langue/?ajax=1';
        
        // Placer le texte au bonne langue des variables avant la serialize()
        <?php foreach($cfg["languesSite"] as $i) : ?>
        $('#texte_<?=$i?>').val(tinymce.get('texte_<?=$i?>').getContent());
        <?php endforeach; ?>

        var data = $('#BlocDonnees').serialize();

        $.ajax({
            type: "post",
            url: source,
            data: data,
            dataType: "json",
            "error": function (XMLHttpRequest, textStatus, errorThrown) {
                alert('Erreur');
            }, 
            success: function(resultat){
                if (resultat.etat == 1){
                    $('#contenuBlocModal').modal('hide');
                    ViderContenuBlocModal();
                    // Vérifier pour charger seulement le bloc qui a été modifié | temporairement en train de charger toutes les blocs
                    // Spécifié le type de bloc pour remplir le tout ?
                    ChargementContenuBloc();
                }
            }
        });
    });

    function PeuplerContenuBlocModal(bloc) {
        $('#noBloc').val(bloc[<?=LANGUE_PRINCIPAL?>].noBloc);
        $('#key').val(bloc[<?=LANGUE_PRINCIPAL?>].keyTimeBloc);
        $('#index').val(bloc[<?=LANGUE_PRINCIPAL?>].indexBlocEnregistrement);
        $('#type').val(bloc[<?=LANGUE_PRINCIPAL?>].contenuBlocEnregistrementLangue.type);

        // Placer infos bloc dans le formulaire modal
        $('.infosBloc').html('['+$('#noBloc').val()+'-'+$('#key').val()+'-'+$('#index').val()+']')

        $('#couleur-texte').val(bloc[<?=LANGUE_PRINCIPAL?>].contenuBlocEnregistrementLangue["couleur-texte"]);
        $('#couleur-background').val(bloc[<?=LANGUE_PRINCIPAL?>].contenuBlocEnregistrementLangue["couleur-background"]);

        $('#padding-top').val(bloc[<?=LANGUE_PRINCIPAL?>].contenuBlocEnregistrementLangue["padding-top"]);
        $('#padding-bottom').val(bloc[<?=LANGUE_PRINCIPAL?>].contenuBlocEnregistrementLangue["padding-bottom"]);
        $('#padding-right').val(bloc[<?=LANGUE_PRINCIPAL?>].contenuBlocEnregistrementLangue["padding-right"]);
        $('#padding-left').val(bloc[<?=LANGUE_PRINCIPAL?>].contenuBlocEnregistrementLangue["padding-left"]);

        $('#margin-top').val(bloc[<?=LANGUE_PRINCIPAL?>].contenuBlocEnregistrementLangue["margin-top"]);
        $('#margin-bottom').val(bloc[<?=LANGUE_PRINCIPAL?>].contenuBlocEnregistrementLangue["margin-bottom"]);
        $('#margin-right').val(bloc[<?=LANGUE_PRINCIPAL?>].contenuBlocEnregistrementLangue["margin-right"]);
        $('#margin-left').val(bloc[<?=LANGUE_PRINCIPAL?>].contenuBlocEnregistrementLangue["margin-left"]);

        <?php foreach($cfg["languesSite"] as $i) : ?>
        tinymce.get('texte_<?=$i?>').setContent(bloc[<?=$i?>].contenuBlocEnregistrementLangue.texte);
        $('#urlImage_<?=$i?>').val('');
        $('#urlVideo_<?=$i?>').val(bloc[<?=$i?>].contenuBlocEnregistrementLangue.urlVideo);
        <?php endforeach; ?>
    }

    function MettreVisibleModalSelonTypeBloc(type) {
        CacherChampsBlocModal();
        if(type ==1) {
            $('#couleur-texte').show();
        } else if(type == 2) {
            <?php foreach($cfg["languesSite"] as $i) : ?>
            $('#urlImage_<?=$i?>').show();
            <?php endforeach; ?>
        } else if(type == 3) {
            <?php foreach($cfg["languesSite"] as $i) : ?>
            $('#urlVideo_<?=$i?>').show();
            <?php endforeach; ?>
        }

        if(type == 1 || type == 2) {
            $('#couleur-background').show();
            $('#padding-top').show();
            $('#padding-bottom').show();
            $('#padding-right').show();
            $('#padding-left').show();

            $('#margin-top').show();
            $('#margin-bottom').show()
            $('#margin-right').show();
            $('#margin-left').show();
        }
    }

    function CacherChampsBlocModal() {
        $('#couleur-texte').hide();
        $('#couleur-background').hide();

        $('#padding-top').hide();
        $('#padding-bottom').hide();
        $('#padding-right').hide();
        $('#padding-left').hide();

        $('#margin-top').hide();
        $('#margin-bottom').hide()
        $('#margin-right').hide();
        $('#margin-left').hide();

        <?php foreach($cfg["languesSite"] as $i) : ?>
        //tinymce.get('texte_<?=$i?>').setContent(bloc[<?=$i?>].contenuBlocEnregistrementLangue.texte);
        $('#urlImage_<?=$i?>').hide();
        $('#urlVideo_<?=$i?>').hide();
        <?php endforeach; ?>
    }

    function ViderContenuBlocModal() {
        $('#noBloc').val('');
        $('#key').val('');
        $('#index').val('');
        $('#couleur-texte').val('');
        $('#couleur-background').val('');

        $('#padding-top').val('');
        $('#padding-bottom').val('');
        $('#padding-right').val('');
        $('#padding-left').val('');

        $('#margin-top').val('');
        $('#margin-bottom').val('');
        $('#margin-right').val('');
        $('#margin-left').val('');

        <?php foreach($cfg["languesSite"] as $i) : ?>
        tinymce.get('texte_<?=$i?>').setContent('');
        $('#urlVideo_<?=$i?>').val('');
        <?php endforeach;?>
    }

    ChargementContenuBloc();
});
</script>
<?php FinJavascript(); ?>
