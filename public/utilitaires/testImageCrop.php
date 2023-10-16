<?php
include '../../config/configuration.inc.php';

use SHA\Fichier;

$tmpNom = "20190525083751-Bane_Batman.png";
$imgSrc = $cfg["adresseSiteWeb"] ."/fichiersUpload/fichiers/".$tmpNom;

if($_GET['img']) {
    $pathOpt = $_SERVER["DOCUMENT_ROOT"] . "/fichiersUpload/fichiers/opt/";

    
    Fichier::CropImage($tmpNom,[
            "img" => $_GET["img"],
            "x" => $_GET["x"],
            "y" => $_GET["y"],
            "width" => $_GET["w"],
            "height" => $_GET["h"],
        ]);
    exit();
}

?>

<html>
    <head>
        <title>Upload and Crop Image using PHP and jQuery</title>
        <link rel="stylesheet" href="../src/css/jquery.Jcrop.min.css" type="text/css" />
        <script src="../src/js/jquery36.min.js"></script>
        <script src="../src/js/jquery.Jcrop.min.js"></script>
        <style>
            body {
                width: 550px;
                font-family: Arial;
            }

            .bgColor {
                width: 100%;
                height: 150px;
                background-color: #fff4be;
                border-radius: 4px;
                margin-bottom: 30px;
            }

            .inputFile {
                padding: 5px;
                background-color: #FFFFFF;
                border: #F0E8E0 1px solid;
                border-radius: 4px;
            }

            .btnSubmit {
                background-color: #696969;
                padding: 5px 30px;
                border: #696969 1px solid;
                border-radius: 4px;
                color: #FFFFFF;
                margin-top: 10px;
            }

            #uploadFormLayer {
                padding: 20px;
            }

            input#crop {
                padding: 5px 25px 5px 25px;
                background: lightseagreen;
                border: #485c61 1px solid;
                color: #FFF;
                visibility: hidden;
            }

            #cropped_img {
                margin-top: 40px;
            }
        </style>
    </head>
    <body>
        <?php
        $imagePath = $imgSrc;

        if (! empty($uploadedImagePath)) {
            $imagePath = $uploadedImagePath;
        }
        ?>
        <div class="bgColor">
                <input type="text" id="largeur" name="largeur" value="16"/>
                <input type="text" id="hauteur" name="hauteur" value="9"/>
                <input type="button" id="btnAppliquer" name="btnAppliquer" value="Appliquer"/>
        </div>
        <div>
            <img src="<?php echo $imagePath; ?>" id="cropbox" class="img" /><br />
        </div>
        <div id="btn">
            <input type='button' id="crop" value='CROP'>
            <input type='button' id="saveImage" value='SAVE IMAGE'>
        </div>
        <div>
            <img src="#" id="cropped_img" style="display: none;">
        </div>
        <script type="text/javascript">
        $(document).ready(function(){
            var size;
            var largeur = $('#largeur').val();
            var hauteur = $('#hauteur').val();
            var x = 0;
            var y = 0;
            var w = 0;
            var h = 0;
            
            $('#btnAppliquer').on('click', function(){
                largeur = $('#largeur').val();
                hauteur = $('#hauteur').val();
                AppliquerCrop();
            });
        
            $("#crop").click(function(){
                var img = $("#cropbox").attr('src');
                $("#cropped_img").show();
                $("#cropped_img").attr('src','testImageCrop.php?x='+size.x+'&y='+size.y+'&w='+size.w+'&h='+size.h+'&img='+img);
            });

            $("#saveImage").on('click', function() {
                $.ajax({
                    url: "http://www.template.mamachine/fr/cms/contenu/bibliotheque/crop-image-sauvegarde/?ajax=1",
                    type: "post",
                    data: {"tmpNom": '<?=$tmpNom?>',"img": '<?=$imagePath?>',"x":x,"y":y,"width":w,"height":h,"largeur": largeur, "hauteur": hauteur},
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
            });

            AppliquerCrop();

            function AppliquerCrop() {
                $('#cropbox').Jcrop({
                    aspectRatio: largeur / hauteur,
                    minSize: [$("#largeur").val(),$("#hauteur").val() ],
                    onSelect: function(c) {
                        x = c.x;
                        y = c.y;
                        w = c.w;
                        h = c.h;
                        size = {x:c.x,y:c.y,w:c.w,h:c.h};
                        $("#crop").css("visibility", "visible")
                    }
                });
            }
        });
        </script>
    </body>
</html>
