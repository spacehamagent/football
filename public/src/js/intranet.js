var oDefault;

$(document).ready(function() {

    //datatable langue français
    oDefault = {
        "responsive": true,
        "sAjaxSource": "./lister-ajax/?ajax=1&sSearch=&search[value]=" + $("input[type=search]").val() + "&sEcho=1",
        "lengthMenu": [
            [10, 25, 50, 100],
            [10, 25, 50, 100]
        ],
        "language": {
            "sProcessing": "Traitement en cours...",
            "sSearch": "Rechercher&nbsp;:",
            "sLengthMenu": "Afficher _MENU_ &eacute;l&eacute;ments",
            "sInfo": "Affichage de l'&eacute;l&eacute;ment _START_ &agrave; _END_ sur _TOTAL_ &eacute;l&eacute;ments",
            "sInfoEmpty": "Affichage de l'&eacute;l&eacute;ment 0 &agrave; 0 sur 0 &eacute;l&eacute;ments",
            "sInfoFiltered": "(filtr&eacute; de _MAX_ &eacute;l&eacute;ments au total)",
            "sInfoPostFix": "",
            "sLoadingRecords": "Chargement en cours...",
            "sZeroRecords": "Aucun &eacute;l&eacute;ment &agrave; afficher",
            "sEmptyTable": "Aucune donn&eacute;e disponible dans le tableau",
            "oPaginate": {
                "sFirst": "Premier",
                "sPrevious": "Pr&eacute;c&eacute;dent",
                "sNext": "Suivant",
                "sLast": "Dernier"
            },
            "oAria": {
                "sSortAscending": ": activer pour trier la colonne par ordre croissant",
                "sSortDescending": ": activer pour trier la colonne par ordre d&eacute;croissant"
            }
        },
    };

    setTimeout(
        function() {
            $('.supprimerEnregistrementTable').click(function() {
                var noEnr = $(this).parent().find('[name="noEnr"]').val();
                var confirmationmessage = "Voulez-vous vraiment supprimer l'enregistrement [ " + noEnr + " ]";

                bootbox.confirm({
                    title: 'Suppression enregistrement',
                    message: confirmationmessage,
                    buttons: {
                        confirm: {
                            label: 'Oui',
                            className: 'btn-success'
                        },
                        cancel: {
                            label: 'Non',
                            className: 'btn-danger'
                        }
                    },
                    callback: function(result) {
                        if (result) {
                            $.ajax({
                                type: "post",
                                url: "./supprimer/?ajax=1",
                                data: { "noEnr": noEnr },
                                dataType: "json",
                                success: function(resultat) {
                                    if (resultat.etat == 1) {
                                        $('#myTable').DataTable().ajax.reload();
                                    }
                                }
                            });
                        }
                    }
                });
            });

            $('.visionnerVideo').click(function() {
                var noEnr = $(this).parent().find('[name="noEnr"]').val();
                $.ajax({
                    type: "post",
                    url: "./video-view/?ajax=1",
                    data: { "noEnr": noEnr },
                    dataType: "json",
                    success: function(resultat) {
                        if (resultat.etat == 1) {
                            $('.videoView').html(resultat.message);
                        }
                    }
                });
            });

            $('.btnAjouter').click(function() {
                window.location.href = "./ajouter/";
            });

            $('#myModal').on('hide.bs.modal', function(e) {
                var $if = $(e.delegateTarget).find('iframe');
                var src = $if.attr("src");
                $if.attr("src", '/empty.html');
                $if.attr("src", src);
            });

    }, 500);
    
    SetTinyMCE();

});

function SetTinyMCE() {
    tinymce.init(OptionDefaultTinyMCE());
}

function OptionDefaultTinyMCE() {
    return {
        selector: 'textarea.tinymce',
        height: 300,
        menubar: false,
        plugins: [
            'advlist autolink lists link image charmap print preview anchor',
            'searchreplace visualblocks code fullscreen',
            'insertdatetime media table paste code help wordcount'
        ],
        toolbar: 'undo redo | formatselect | ' +
            ' bold italic backcolor | alignleft aligncenter ' +
            ' alignright alignjustify | bullist numlist outdent indent |' +
            ' removeformat | code',
        content_css: [
            '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
            '//www.tiny.cloud/css/codepen.min.css'
        ]
    };
}

function creerBtnAction(items) {
    var resultat = '';
    var noEnr = 0;
    jQuery.each(items, function(key, val) {
        noEnr = val;
        switch (key) {
            case "visualiser":
                resultat += '<a href="./visualiser/' + val + '/" class="btnVisualiser"/><i class="fa fa-search medium"></i></a>';
                break;
            case "modifier":
                resultat += '<a href="./editer/' + val + '/" class="btnEditer"/><i class="fa fa-pencil" aria-hidden="true"></i></a>';
                break;
            case "supprimer":
                resultat += '<a href="#" class="supprimerEnregistrementTable" ><i class="fa fa-trash" aria-hidden="true"></i></a>';
                break;
            case "video":
                resultat += '<button type="button" class="btn btn-info btn-sm visionnerVideo" data-toggle="modal" data-target="#myModal"><i class="fa fa-play-circle" aria-hidden="true"></i></button>';
                break;
            case "whois":
                resultat += '<a href="http://who.is/whois/' + val + '" target="_blank" class="whois" ><i class="fa fa-web small"></i></a>';
                break;
            default:
                resultat += key;
        }
    });

    resultat = '<input type="hidden" name="noEnr" value="' + noEnr + '" />' + resultat;

    return resultat;
}

function RemoveAccents(str) {
    var accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var accentsOut = "AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz";
    str = str.split('');
    var strLen = str.length;
    var i, x;
    for (i = 0; i < strLen; i++) {
        if ((x = accents.indexOf(str[i])) != -1) {
            str[i] = accentsOut[x];
        }
    }
    return str.join('');
}

function RemoveSpace(str) {
    var value = str.replace("|", "").replace("(", "").replace(")", "").replace("[", "").replace("]", "").replace(":", "").replace("!", "").replace("?", "").replace(/[#-]/g, "-").replace(",", "").replace("&","").replace("--","-").replace(/\s\s+/g, '-');

    return value;
}

function MessageSauvegarde(msg, time = 500) {
    $.blockUI({
        message: '<h3>' + msg + '</h3>',
        centerY: 0,
        css: { top: '10px', left: '', right: '10px', opacity: '0.5' }
    });
    setTimeout($.unblockUI, time);
}

function ActiverDesactiverPage(noEnr) {
    $.ajax({
        type: "post",
        url: "page-actif-traitement/?ajax=1",
        data: { "noEnr": noEnr },
        dataType: "json",
        "error": function(XMLHttpRequest, textStatus, errorThrown) {
            alert('Erreur');
        },
        success: function(resultat) {
            if (resultat.etat == 1) {

            }
        }
    });
}
