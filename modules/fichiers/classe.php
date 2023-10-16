<?php

namespace SHA;

class Fichier extends Module{
    private static $imageDefault = "/images/joker.jpg";
    private static $pathTmp = "/fichiersUpload/tmpFile";
    private static $pathFichier = "/fichiersUpload/fichiers";
    private static $pathOpt = "/fichiersUpload/fichiers/opt/";
    private static $typeFileAccept = [
                            "image/jpeg",
                            "image/png", 
                            "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                            "text/plain",
                            "application/pdf"
                        ];
    private static $typeFileImage = ["image/jpeg", "image/png"];

    public static function Lister($options = []) {
        global $cfg;
        
        $default = [
            "imageSeulement" => false,
        ];

        $settings = array_merge($default, $options);

        $SQL = "SELECT * FROM fichiers
                INNER   JOIN fichiersLangues
                    ON  fichiersLangues.noFichier = fichiers.noFichier
                    ANd fichiersLangues.noLangue = '".$cfg["noLangue"]."'";

        if($settings["imageSeulement"]) {
            $SQL .= " WHERE typeFichier IN (";
            foreach(self::$typeFileImage as $ext) {
                $SQL .= "'".$ext."',";
            }
            $SQL = substr($SQL,0,-1);
            $SQL .= ")";
        }

        return DB::query($SQL)->fetchAll();
    }

    public static function StockageTotal($noUsager){
        $stockage = [
            "usager" => 0,
            "total" => 0,
        ];

        $SQL = "SELECT SUM(pesanteurFichier) AS usagerStockage FROM fichiers WHERE noUsager = '$noUsager';";

        $stockageUsager = DB::query($SQL)->fetchAll();

        if(isset($stockageUsager[0]["usagerStockage"])){
            $stockage["usager"] = $stockageUsager[0]["usagerStockage"];
        }

        $SQL = "SELECT SUM(pesanteurFichier) AS totalStockage FROM fichiers;";
        $total = DB::query($SQL)->fetchAll();

        if(isset($total[0]["totalStockage"])){
            $stockage["total"] = $total[0]["totalStockage"];
        }
        
        return $stockage;
    }
    
    public static function UploadFichier($donnees = []){
        $usagerEnCours = ObtenirInfosUsager();
        $noUsager = $usagerEnCours["noUsager"] ?? 0;
        date_default_timezone_set('America/Montreal');

        $fichiers["fichiers"][] = $donnees["fichier"];

        foreach ($fichiers as $fichier) {
            $nom = $fichier[0]["name"];
            $nomTmp = date('YmdHis'). "-" . $nom;
            $tmpName = $fichier[0]["tmp_name"];
            $type = $fichier[0]["type"];
            $size = $fichier[0]["size"];

            $source = $tmpName;
            $destination = $_SERVER["DOCUMENT_ROOT"] . self::$pathTmp;

            if (in_array($type, self::$typeFileAccept)) {
                if (!file_exists($destination)) {
                    mkdir($destination, 0770, true);
                }

                move_uploaded_file($source, $destination  . "/" . $nomTmp);
                
                self::Enregistrer([
                    "nom" => $nom,
                    "nomTmp" => $nomTmp,
                    "pesanteur" => $size,
                    "type" => $type,
                    "noUsager" => $noUsager,
                    "confirmer" => 0
                ]);
            } else {
                self::FichierNonAutorises(["nom" => $nom, "type" => $type, "noUsager" => $noUsager]);
            }
        }
    }

    private static function Enregistrer($options = []) {
        global $cfg;

        $default = [
            "nom" => "",
            "nomTmp" => "",
            "pesanteur" => 0,
            "type" => "",
            "noUsager" => 0,
            "confirmer" => 0
        ];

        $settings = array_merge($default, $options);

        if(strlen($settings["nom"]) > 0){
            $SQL = "INSERT INTO fichiers (
                nomOriginalFichier,
                nomTmpFichier,
                pesanteurFichier,
                typeFichier,
                noUsager,
                creationFichier,
                confirmerFichier
            ) VALUES (
                '" . $settings["nom"] . "',
                '" . $settings["nomTmp"] . "',
                '" . $settings["pesanteur"] . "',
                '" . $settings["type"] . "',
                '" . $settings["noUsager"] . "',
                NOW(),
                '" . $settings["confirmer"] . "'
            );";
            
            DB::query($SQL);

            $noEnr = DB::obtenirDernierID();

            foreach($cfg["languesSite"] as $i) {
                $SQL = "INSERT INTO fichiersLangues (
                        noFichier,
                        noLangue,
                        titreFichierLangue
                    ) VALUES (
                        '$noEnr',
                        '$i',
                        ''
                    );";
                DB::query($SQL);
            }
        } else {
            exit();
        }
    }

    private static function FichierNonAutorises($options = []) {
        $default = [
            "nom" => "",
            "type" => "",
            "noUsager" => 0
        ];

        $settings = array_merge($default, $options);

        $SQL = "INSERT INTO fichiersNonAutorises (
            nomFichierNonAutorise,
            typeFichierNonAutorise,
            dateFichierNonAutorise,
            noUsager
        ) VALUES (
            '" . $settings["nom"] . "',
            '" . $settings["type"] . "',
            NOW(),
            '" . $settings["noUsager"] . "'
        );";
        
        DB::query($SQL);
    }

    public static function TrouverFichiers($options = []) {
        global $cfg;

        $default = [
            "confirmerSeulement" => 1,
            "image" => false,
            "limite" => 21,
            "index" => 0,
            "avatar" => false,
            "groupeAvatar" => false,
            "archiveFichier" => false
        ];

        $settings = array_merge($default, $options);

        $SQL = "SELECT fichiers.*, fichiers.noFichier AS noEnr, fichiersLangues.*";

        if($settings["avatar"]){
            $SQL .= ", groupesAvatarFichier.noFichier AS avatar";
        }

        $SQL .= " FROM fichiers
                INNER JOIN fichiersLangues
                    ON fichiersLangues.noFichier = fichiers.noFichier
                    AND fichiersLangues.noLangue = '$cfg[noLangue]'";

        if($settings["avatar"]){
            if($settings["groupeAvatar"]){
                $SQL .= " INNER";
            } else {
                $SQL .= " LEFT";
            }
            $SQL .= " JOIN groupesAvatarFichier
                        ON  groupesAvatarFichier.noFichier = fichiers.noFichier";
        }
        
        $SQL .= " WHERE confirmerFichier = '$settings[confirmerSeulement]'
                    ";

        if($settings["image"]){
            $types = "";
            foreach(self::$typeFileImage as $type){
                $types .= "'$type',";
            }
            $types = substr($types, 0, -1);

            $SQL .= " AND typeFichier IN ($types)";
        }

        if(!$settings["archiveFichier"]) {
            $SQL .= " AND archiveFichier != 1";
        }

        if(!EstAdmin() && !$settings["groupeAvatar"]){
            $noUsager = $_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["noUsager"];
            $SQL .= " AND fichiers.noUsager = '$noUsager'";
        }

        $SQL .= " ORDER BY fichiersLangues.titreFichierLangue ASC";

        $SQL .= " LIMIT " . $settings["limite"] . " OFFSET " . $settings["index"];

        return DB::query($SQL)->fetchAll();
    }

    public static function MiseAJourFichier($options = []){
        global $cfg;

        $default = [
            "noEnr" => 0,
            "titreFr" => "",
            "titreEn" => "",
            "titre_1" => "",
            "titre_2" => ""
        ];

        $settings = array_merge($default, $options);

        if ($settings["noEnr"] > 0) {
            $settings["titre_1"] = $settings["titreFr"];
            $settings["titre_2"] = $settings["titreEn"];

            $fichier = self::TrouverEnregistrement($settings["noEnr"], ["fichiers", "fichiersLangues"], "noFichier");

            if (!empty($fichier)) {
                foreach($cfg["languesSite"] as $i) {
                    $SQL = "UPDATE fichiersLangues
                        SET titreFichierLangue = '" . $settings["titre_$i"] . "'
                        WHERE noLangue = '" . $i . "'
                            AND noFichier = '$settings[noEnr]'";
                    DB::query($SQL);
                }
                $SQL = "UPDATE fichiers
                    SET confirmerFichier = '" . FICHIER_CONFIRMER . "'
                    WHERE   noFichier = '$settings[noEnr]'";
                DB::query($SQL);

                self::CopieFichierConfirme($fichier["0"]["nomTmpFichier"]);

                return true;
            }
        }

        return false;
    }

    private static function CopieFichierConfirme($nomFichier){
        $file = $_SERVER["DOCUMENT_ROOT"] . self::$pathTmp . "/" . $nomFichier;
        $newfile = $_SERVER["DOCUMENT_ROOT"] . self::$pathFichier . "/" . $nomFichier;

        $destination = $_SERVER["DOCUMENT_ROOT"] . self::$pathFichier;

        if (!file_exists($destination)) {
            mkdir($destination, 0770, true);
        }

        if (copy($file, $newfile)) {
            return true;
        }
        
        return false;
    }

    public static function SupprimerFichier($noEnr = 0) {
        $fichier = self::TrouverEnregistrement($noEnr, ["fichiers", "fichiersLangues"], "noFichier");
        $fichierExiste = self::TrouverFichier(self::$pathTmp, $fichier[0]["nomTmpFichier"]);

        if (!empty($fichier) && $fichierExiste) {
            $SQL = "DELETE FROM fichiers
                WHERE noFichier = '$noEnr'";
            DB::query($SQL);

            $SQL = "DELETE FROM fichiersLangues
                WHERE noFichier = '$noEnr'";
            DB::query($SQL);
            
            return true;
        }

        return false;
    }

    public static function IsFichierImage($type){
        if(in_array($type, self::$typeFileImage)){
            return true;
        }
        return false;
    }

    public static function SetImageAvatar($noEnr) {
        if(self::IsImageAvatar($noEnr)){
           $SQL = "DELETE FROM groupesAvatarFichier WHERE noFichier = $noEnr";
           DB::query($SQL);
           return false;
        } else {
            $SQL = "INSERT INTO `groupesAvatarFichier` (`noFichier`) VALUES ('$noEnr');";
            DB::query($SQL);
            return true;
        }
    }

    public static function ArchiveFichier($noEnr = 0) {
        if(self::TrouverEnregistrement($noEnr, ["fichiers", "fichiersLangues"], "noFichier")){
            $SQL = "UPDATE  fichiers
                        SET archiveFichier = 1,
                            dateArchiveFichier = NOW()
                    WHERE   noFichier = '$noEnr'";
            DB::query($SQL);
            return true;
        }
        return false;
    }

    private static function IsImageAvatar($noEnr){
        $SQL = "SELECT * FROM groupesAvatarFichier
                WHERE noFichier = $noEnr";
        $avatar = DB::query($SQL)->fetchAll();
        if(empty($avatar)){
            return false;
        }
        return true;
    }

    private static function TrouverFichier($path, $nomFichier){
        $urlFichier =  $_SERVER["DOCUMENT_ROOT"] . $path . "/" .$nomFichier;

        if(file_exists($urlFichier)){
            unlink($urlFichier);
            return true;
        }

        return false;
    }

    public static function TrouverLienFichier($options = []) {
        $default = [
            "noEnr" => 0,
            "nomTmpFichier" => ""
        ];

        $settings = array_merge($default, $options);
        
        $urlImage = self::$imageDefault;

        $fichier = self::TrouverEnregistrement($settings["noEnr"], ["fichiers", "fichiersLangues"], "noFichier");

        if(!empty($fichier)) {
            $urlImage = self::$pathFichier . "/" . $fichier[0]["nomTmpFichier"];
        }

        return $urlImage;
    }

    private static function TrouverLienURL($options = [], $tmp = false){
        $default = [
            "typeFichier" => "",
            "nomTmpFichier" => ""
        ];
    
        $settings = array_merge($default, $options);
    
        $url = $_SERVER["SERVER_NAME"];
    
        switch($settings["typeFichier"]) {
            case "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
                $url .= "/images/icones/file_icons/doc.svg";
            break;
    
            case "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet":
                $url .= "/images/icones/file_icons/xls.svg";
            break;

            case "text/plain":
                $url .= "/images/icones/file_icons/txt.svg";
            break;

            case "application/pdf":
                $url .= "/images/icones/file_icons/pdf.svg";
            break;
    
            default:
                if($tmp)
                    $url .= self::$pathTmp . '/' . $settings["nomTmpFichier"];
                else
                    $url .= self::$pathFichier . '/' . $settings["nomTmpFichier"];
        }
    
        return $url;
    }

    public static function TrouverLienCompletFichier($fichier = [], $tmp = false) {
        $urlComplet = "";

        if(!in_array($fichier["typeFichier"], self::$typeFileImage)){
            $urlLien = "http://" .$_SERVER["SERVER_NAME"] . self::$pathFichier . "/" . $fichier["nomTmpFichier"];

            $urlComplet .= '<a href="' . $urlLien . '" target="blank">';
            $urlComplet .= '<img src="http://' . self::TrouverLienURL($fichier, $tmp) . '" class="rounded-circle img-thumbnail" alt="profile-image">';
            $urlComplet .= '</a>';
        } else {
            $urlComplet .= '<img src="http://' . self::TrouverLienURL($fichier, $tmp) . '" class="rounded-circle img-thumbnail" alt="profile-image">';
        }

        return $urlComplet;
    }

    public static function Rechercher($mots = "") {
        global $cfg;
        
        $SQL = "SELECT fichiers.*, fichiersLangues.*
                FROM fichiers

                INNER   JOIN fichiersLangues
                    ON  fichiersLangues.noFichier = fichiers.noFichier
                    AND fichiersLangues.noLangue = $cfg[noLangue]
                
                WHERE   fichiersLangues.titreFichierLangue LIKE '%$mots%'
                    OR  fichiers.nomOriginalFichier LIKE '%$mots%'";
        return DB::query($SQL)->fetchAll();
    }

    // Génération de fichier image seulement avec la grandeur voulu dans le répertoire fichiers/opt/x-y/
    // Image de 600 X 250     /fichiers/opt/600-250/nomdelimage.jpg
    // Si elle n'existe pas on la génère pour l'utiliser sinon on la cré.
    public static function GenererImage($nomTmp, $options = []) {
        $default = [
            "width" => 600,
            "height" => 250,
        ];
        $settings = array_merge($default, $options);
        
        $urlImage = "/images/joker_test.jpg";

        if(strlen($nomTmp) > 0) {

        }
        return $urlImage;
    }

    public static function CropImage($nomImage, $options = []) {
        $default = [
            "img" => '',
            "x" => 0,
            "y" => 0,
            "width" => 16,
            "height" => 9,
            "largeur" => 500,
            "hauteur" => 500,
            "enregistrer" => false,
        ];

        $settings = array_merge($default, $options);
        $urlSave = $_SERVER["DOCUMENT_ROOT"] . self::$pathOpt;
        $extension = "png";
        $img_r = "";
        $dst_r = "";
        $urlSave = $urlSave.$settings["largeur"]."-".$settings["hauteur"]."/";
        $urlSiteWeb = $_SERVER[""].self::$pathOpt.$settings["largeur"]."-".$settings["hauteur"]."/";
        $fullImagePath = "";

        if($settings["enregistrer"]) {
            if (!file_exists($urlSave)) {
                mkdir($urlSave, 0770, true);
            }
        }

        if(!empty($settings["img"])) {
            //Trouver extension par le nom du fichier


            switch($extension) {
                case "jpg":
                    $img_r = imagecreatefromjpeg($settings['img']);
                break;

                default:
                    $img_r = imagecreatefrompng($settings['img']);
            }
            
            $dst_r = ImageCreateTrueColor( $settings["width"], $settings["height"] );

            imagecopyresampled($dst_r, 
                                $img_r, 
                                0, 
                                0,
                                $settings["x"],
                                $settings["y"],
                                $settings["width"],
                                $settings["height"],
                                $settings["width"],
                                $settings["height"]
                            );

            $nomDebutImage = "opt-".$settings["largeur"]."-".$settings["hauteur"]."-".$settings["x"]."-".$settings["y"]."-".$nomImage;
            $fullImagePath = $urlSave.$nomDebutImage;
            $urlSiteWeb = $urlSiteWeb.$nomDebutImage;

            $infosImage = [
                "urlImage" => $urlSiteWeb,
                "nomImage" => $nomDebutImage
            ];

            switch($extension) {
                case "jpg":
                    header('Content-type: image/jpeg');
                    if($settings["enregistrer"]) {
                        imagejpeg($dst_r, $fullImagePath);
                    } else {
                        imagejpeg($dst_r);
                    }
                break;

                default:
                    header('Content-type: image/png');
                    if($settings["enregistrer"]) {
                        imagepng($dst_r, $fullImagePath);
                    } else {
                        imagepng($dst_r);
                    }
            }

            imagedestroy($dst_r);

            //return $urlSiteWeb;
            return $infosImage;
        }
    }
}
