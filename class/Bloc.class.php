<?php

namespace SHA;

class Bloc {
    protected static $typeTexte = 1;

    private static $templateBloc = [
        "type" => 1,
        "couleur-texte" => "#000",
        "couleur-background" => "#fff",
        "padding-top" => "0",
        "padding-bottom" => "0",
        "padding-right" => "0",
        "padding-left" => "0",
        "margin-top" => "0",
        "margin-bottom" => "0",
        "margin-right" => "0",
        "margin-left" => "0",
        "texte" => "",
        "urlVideo" => "",
        "url" => "",
    ];

    public static function ConstruireGridIntranet($blocs = [], $options = []) {
        $build = [
            "noBloc" => 0,
            "index" => 1,
            "key" => "",
            "html" => '',
        ];

        $noBloc = 0;
        $index = 0;
        $html = '';

        if(!empty($blocs)) {
            foreach($blocs as $bloc) {
                $noBloc = $bloc["noBloc"];
                $id = $bloc["indexBlocEnregistrement"];
                $key = $bloc["keyTimeBloc"];
                $type = $bloc["blocTypeEnregistrement"];

                if($index <= $id) {
                    $index = $id;
                }

                if(strlen($build["key"]) == 0) {
                    $build["key"] = $key;
                }

                $x = $bloc["xBlocEnregistrement"];
                $y = $bloc["yBlocEnregistrement"];
                $width = $bloc["widthBlocEnregistrement"];
                $height = $bloc["heightBlocEnregistrement"];

                $html .= '<div class="bloc grid-stack-item" 
                                data-noBloc="'.$noBloc.'" 
                                data-key="'.$key.'" 
                                data-index="'.$id.'" 
                                data-type="'.$type.'".
                                data-gs-x="'.$x.'" 
                                data-gs-y="'.$y.'" 
                                data-gs-width="'.$width.'" 
                                data-gs-height="'.$height.'">
                                <div class="infoBloc">
                                    <span></span>
                                </div>
                                <div class="actionsBloc">
                                    <span><a href="#" class="pencil"><i class="fa fa-pencil fa-2x"></i></a></span>
                                    <span><a href="#" class="trash"><i class="fa fa-trash fa-2x"></i></a></span>
                                </div>
                <div class="grid-stack-item-content">';

                $html .= self::RemplirBlocDefaut();

                $html .= '</div></div>';
            }
        }
        $index++;

        $build["noBloc"] = $noBloc;
        $build["index"] = $index++;
        $build["html"] = $html;

        return $build;
    }

    private static function RemplirBlocDefaut() {
        global $cfg;
        $html = "";
        ob_start();
        include $cfg["pathVues"] . "blocs/intranet-bloc-defaut.tpl";
        $html = ob_get_contents();
        ob_end_clean();

        return $html;
    }

    public static function ObtenirContenuBlocLangue($noBloc, $key, $index, $type = 1) {
        $blocsLangues = [];

        $tmp = self::GetBlocEnregistrementLangue($noBloc, $key, $index);

        if(empty($tmp)){
            // Créer le blocEnregistrement et sa langue
            $tmpBlocDefault = self::ObtenirBlocEnregistrementDefault();
            $tmpBlocDefault['noBloc'] = $noBloc;
            $tmpBlocDefault['key'] = $key;
            $tmpBlocDefault['indexBloc'] = $index;
            $tmpBlocDefault['type'] = $type;

            self::AjouterBlocEnregistrement($tmpBlocDefault, $type);
            $tmp = self::GetBlocEnregistrementLangue($noBloc, $key, $index);
        }

        foreach($tmp as $bloc) {
            $indexLangue = $bloc["noLangue"];

            foreach($bloc as $k => $v) {
                if($k == "contenuBlocEnregistrementLangue") {
                    $v = self::FormatContenuBloc($v);
                }
                $blocsLangues[$indexLangue][$k] = $v;
            }
        }

        return $blocsLangues;
    }

    private static function GetBlocEnregistrementLangue($noBloc, $key, $index) {
        $SQL = "SELECT * FROM blocsEnregistrementsLangues
            WHERE   noBloc = '$noBloc'
                AND keyTimeBloc = '$key'
                AND indexBlocEnregistrement = '$index'";
        
        return DB::query($SQL)->fetchAll();
    }

    private static function ObtenirTypeBloc($noBloc, $key, $index) {
        $SQL = "SELECT * FROM blocsEnregistrements
            WHERE   noBloc = '$noBloc'
                AND keyTimeBloc = '$key'
                AND indexBlocEnregistrement = '$index'";
        
        $bloc = DB::query($SQL)->fetchAll();

        if(!empty($bloc)) {
            return $bloc[0]["blocTypeEnregistrement"];
        }
        return 1;
    }

    private static function FormatContenuBloc($str) {
        $defaultBloc = self::GetDefaultBlocContenu();
        $tmp = json_decode($str, true);
        $finalArray = array_merge($defaultBloc, $tmp);
        
        return $finalArray;
    }

    public static function GetDefaultBlocContenu() {
        return self::$templateBloc;
    }

    public static function EnregisterBloc($noBloc = 0, $noEnr = 0, $key = "",$module = 'pages.inc.php') {
        $no = 0;

        if(!self::TrouverBloc($noBloc, $noEnr, $key)) {
            $key = time();
            $SQL = "INSERT INTO blocs (
                keyTimeBloc,
                noEnrBloc,
                moduleBloc
            ) VALUES (
                '$key',
                '$noEnr',
                '$module'
            );";
            DB::query($SQL);

            $no = DB::obtenirDernierID();
        }

        return $no;
    }

    public static function ObtenirBlocs($noEnr, $module = "pages.inc.php") {
        $listeBlocs = [
            "noBloc" => 0,
            "keyTimeBloc" => "",
            "blocs" => []
        ];

        $SQL = "SELECT * FROM blocs WHERE noEnrBloc = '$noEnr' AND moduleBloc = '$module'";
        $bloc = DB::query($SQL)->fetch();

        if(!empty($bloc)) {
            $listeBlocs["noBloc"] = $bloc["noBloc"];
            $listeBlocs["keyTimeBloc"] = $bloc["keyTimeBloc"];

            $SQL = "SELECT * FROM blocsEnregistrements
                    WHERE noBloc = '".$bloc["noBloc"]."' AND keyTimeBloc = '".$bloc["keyTimeBloc"]."'";
            $blocs = DB::query($SQL)->fetchAll();
            if(!empty($blocs)) {
                $listeBlocs["blocs"] = $blocs;
            }
        }
        
        $listeBlocs["blocs"] = DB::query($SQL)->fetchAll();

        return $listeBlocs;
    }

    private static function TrouverBloc($noBloc, $noEnr, $key) {
        $SQL = "SELECT * FROM blocs
            WHERE   noBloc = '$noBloc'
                AND noEnrBloc = '$noEnr'
                AND keyTimeBloc = '$key'";
        return DB::query($SQL)->fetchAll();
    }

    public static function EnregistrerBlocs($blocs = []) {
        foreach($blocs as $bloc) {
            if(self::TrouverBlocEnregistrement($bloc["noBloc"],$bloc["key"],$bloc["indexBloc"])) {
                self::EditerBlocEnregistrement($bloc);
            } else {
                self::AjouterBlocEnregistrement($bloc);
            }
        }
    }

    public static function EnregistrementContenuBlocEnregistrement($donnees = []) {
        global $cfg;

        $noBloc = $donnees["noBloc"];
        $key = $donnees["key"];
        $index = $donnees["index"];
        $contenu = "";

        foreach($cfg["languesSite"] as $langue) {
            $SQL = "";
            $contenu = self::EnregistrementContenuBlocEnregistrementLangue($donnees, $langue);
            $enregistrementBlocLangue = self::TrouverEnregistrementLangue($noBloc, $key, $index, $langue);
            
            if(!empty($enregistrementBlocLangue)) {
                $SQL = "UPDATE blocsEnregistrementsLangues
                    SET contenuBlocEnregistrementLangue = '".FormatTexte($contenu)."'
                    WHERE   noBloc = '$noBloc'
                        AND keyTimeBloc = '$key'
                        AND indexBlocEnregistrement = '$index'
                        AND noLangue = $langue;";
            } else {
                $SQL = "INSERT INTO blocsEnregistrementsLangues (
                        noBloc,
                        keyTimeBloc,
                        indexBlocEnregistrement,
                        noLangue,
                        contenuBlocEnregistrementLangue
                    ) VALUES (
                        '$noBloc',
                        '$key',
                        '$index',
                        '$langue',
                        '".FormatTexte($contenu)."'
                    );";
            }
            DB::query($SQL);
        }

        return true;
    }

    private static function TrouverEnregistrementLangue($noBloc, $key, $index, $langue = LANGUE_PRINCIPAL) {
        $SQL = "SELECT * FROM blocsEnregistrementsLangues
                WHERE   noBloc = '$noBloc'
                    AND keyTimeBloc = '$key'
                    AND indexBlocEnregistrement = '$index'
                    AND noLangue = '$langue'";
        return DB::query($SQL)->fetchAll();
    }

    public static function EnregistrementContenuBlocEnregistrementLangue($donnees = [], $noLangue = LANGUE_PRINCIPAL) {
        $tmp = [];
        $contenu = "{}";
        $arrTmp = $donnees;
        unset($arrTmp['noBloc']);
        unset($arrTmp['key']);
        unset($arrTmp['index']);

        foreach ($arrTmp as $k => $v) {
            $var = explode("_", $k);

            if(isset($var[1])) {
                if($var[1] == $noLangue) {
                    $tmp[$var[0]] = $v;
                }
            } else {
                $tmp[$k] = $v;
            }
        }

        ob_start();
        echo json_encode($tmp);
        $contenu = ob_get_contents();
        ob_end_clean();

        return $contenu;
    }

    private static function PreparerContenuBlocEnregistrementLangue($donnees = [], $langue = LANGUE_PRINCIPAL) {
        $tmp = [];
        $contenu = "{}";
        $default = self::GetDefaultBlocContenu();

        foreach($donnees as $k => $v) {
            $var = explode("_", $k);

            if(isset($var[1]) && $var[1] == $langue) {
                $tmp[$var[0]] = $v;
            } else {
                if($var[0] != 'noBloc' || $var[0] != 'key' || $var[0] != 'index') {
                    $tmp[$var[0]] = $v;
                }
            }
        }
        $tmpContenu = array_merge($default, $tmp);

        ob_start();
        echo json_encode($tmpContenu);
        $contenu = ob_get_contents();
        ob_end_clean();

        return $contenu;
    }

    private static function TrouverBlocEnregistrementLangue($noBloc, $key, $index, $noLangue) {
        $SQL = "SELECT * FROM blocsEnregistrementsLangues
                WHERE   noBloc = '$noBloc'
                    AND keyTimeBloc = '$key'
                    AND indexBlocEnregistrement = '$index'
                    AND noLangue = $noLangue";
        return DB::query($SQL)->fetchAll();
    }

    public static function SupprimerBlocEnregistrement($donnees) {
        $SQL = "DELETE FROM blocsEnregistrements
            WHERE   noBloc = '$donnees[noBloc]'
                AND keyTimeBloc = '$donnees[key]'
                AND indexBlocEnregistrement = '$donnees[index]'";
        DB::query($SQL);

        self::SupprimerBlocEnregistrementLangue($donnees);
        
        return true;
    }

    private static function SupprimerBlocEnregistrementLangue($donnees) {
        $SQL = "DELETE FROM blocsEnregistrementsLangues
            WHERE   noBloc = '$donnees[noBloc]'
                AND keyTimeBloc = '$donnees[key]'
                AND indexBlocEnregistrement = '$donnees[index]'";
        DB::query($SQL);
        return true;
    }

    private static function TrouverBlocEnregistrement($noEnr, $key, $index) {
        $SQL = "SELECT * FROM blocsEnregistrements
                WHERE noBloc = '$noEnr'
                    AND keyTimeBloc = '$key'
                    AND indexBlocEnregistrement = '$index'";

        $bloc = DB::query($SQL)->fetchAll();

        if(empty($bloc)) {
            return false;
        }

        return true;
    }

    private static function EditerBlocEnregistrement($bloc) {
        $SQL = "UPDATE blocsEnregistrements SET
                    xBlocEnregistrement ='".$bloc["x"]."',
                    yBlocEnregistrement ='".$bloc["y"]."',
                    widthBlocEnregistrement ='".$bloc["width"]."',
                    heightBlocEnregistrement ='".$bloc["height"]."',
                    miseAJourBlocEnregistrement = NOW()
                WHERE   noBloc = '".$bloc["noBloc"]."'
                    AND keyTimeBloc = '".$bloc["key"]."'
                    AND indexBlocEnregistrement = '".$bloc["indexBloc"]."'";
        DB::query ($SQL);
    }

    private static function ObtenirBlocEnregistrementDefault() {
        return [
            'noBloc' => '0',
            'key' => '0',
            'indexBloc' => '0',
            'type' => '1',
            'x' => '0',
            'y' => '0',
            'width' => '12',
            'height' => '1',
            'margin-top' => '0',
            'margin-bottom' => '0',
            'margin-right' => '0',
            'margin-left' => '0',
            'padding-top' => '0',
            'padding-bottom' => '0',
            'padding-right' => '0',
            'padding-left' => '0',
            'texte' => '',
            'urlVideo' => '',
            'url' => '',
            'couleur-background' => '#000',
            'couleur-texte' => '#fff'
        ];
    }

    private static function AjouterBlocEnregistrement($bloc, $type =1) { 
        $SQL = "INSERT INTO blocsEnregistrements (
                    noBloc,
                    keyTimeBloc,
                    indexBlocEnregistrement,
                    blocTypeEnregistrement,
                    xBlocEnregistrement,
                    yBlocEnregistrement,
                    widthBlocEnregistrement,
                    heightBlocEnregistrement,
                    creationBlocEnregistrement
                ) VALUES (
                    '".$bloc["noBloc"]."',
                    '".$bloc["key"]."',
                    '".$bloc["indexBloc"]."',
                    '".$type."',
                    '".$bloc["x"]."',
                    '".$bloc["y"]."',
                    '".$bloc["width"]."',
                    '".$bloc["height"]."',
                    NOW()
                );";
        DB::query ($SQL);

        self::AjouterBlocEnregistrementLangue($bloc);
    }

    public static function AjouterBlocEnregistrementLangue($bloc) {
        global $cfg;
        $contenuDefault = "{}";
        $type = $bloc["type"] ?? 1; // Defaut Type Bloc Texte

        ob_start();
        $defaultBloc = self::GetDefaultBlocContenu();
        $defaultBloc["type"] = $type;
        echo json_encode($defaultBloc,true);
        $contenuDefault = ob_get_contents();
        ob_end_clean();



        foreach($cfg["languesSite"] as $k => $v) {
            $SQL = "INSERT INTO blocsEnregistrementsLangues (
                    noBloc,
                    keyTimeBloc,
                    indexBlocEnregistrement,
                    noLangue,
                    contenuBlocEnregistrementLangue
                ) VALUES (
                    '".$bloc["noBloc"]."',
                    '".$bloc["key"]."',
                    '".$bloc["indexBloc"]."',
                    '".$v."',
                    '".$contenuDefault."'
                );";
            DB::query($SQL);
        }
    }

    /*
    Construction html des blocs
    */

    public static function PublierBlocs($options = []) {
        $default = [
            "noEnr" => 0,
            "module" => "pages.inc.php", // ?? vraiment utile ??
            "noBloc" => 0
        ];

        $settings = array_merge($default, $options);

        $blocs = [];

        $html = self::PreparerBlocAPublier($blocs);

        // Prendre le html et faire une update dans la page désirer (noEnr)
    }

    private static function PreparerBlocAPublier($blocs = []) {
        // placer en ordre les blocs et ajouter des blocs au besoin pour remplir les 12 de large


        // Une fois le tout compléter appeler la function pour construire le code HTML à utiliser
        return self::ConstruireBlocHTML($blocs);
    }

    private static function ConstruireBlocHTML($blocs = []) {
        $html = "";

        if(!empty($blocs)) {
            foreach($blocs as $b) {
                dump($b); die();
            }
        }

        return $html;
    }
}
?>
