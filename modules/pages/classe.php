<?php

namespace SHA;

class Page extends Module{
    private static $pagesInvisible = [
            INTRANET_LOGIN,
            INTRANET_BIBLIOTHEQUE,
            INTRANET_DEMANDE_INFORMATION,
            INTRANET_PAGES_SYSTEM,
            INTRANET_PAGES,
            INTRANET_USAGERS,
            INTRANET_USAGER
        ];

    private static $pagesNonMenu = [
        INTRANET_LOGIN,
        INTRANET_USAGER,
    ];

    private static $pagesUsager = [
		INTRANET_USAGER,
		INTRANET_RECHERCHER,
		INTRANET_ACCUEIL,
		INTRANET_BIBLIOTHEQUE,
		INTRANET_DEMANDE_INFORMATION,
		INTRANET_USAGERS,
		INTRANET_VIDEOS
	];
    
    public static function Lister($options = []){
        global $cfg;
        $default = [
            "pagesRetirees" => "",
            "noMicrosite" => MICROSITE_INTRANET
        ];
        $settings = array_merge($default, $options);

        $SQL = "SELECT pages.noPage, pages.actifPage, pages.positionPage, pagesLangues.titrePageLangue
            FROM    pages

            INNER   JOIN pagesLangues
                ON  pagesLangues.noPage = pages.noPage
                AND pagesLangues.noLangue = $cfg[noLangue]
        ";

        if(strlen($settings["pagesRetirees"]) > 0 ){
            $SQL .= " WHERE pages.noPage NOT IN ($settings[pagesRetirees])";
        } else {
            $SQL .= " WHERE   pages.noMicrositePage = '$settings[noMicrosite]'";
        }

        $SQL .= " AND pages.noPage NOT IN (" . implode(",", self::$pagesInvisible) . ")";
        
        $pages = DB::query($SQL)->fetchAll();

        return $pages;
    }

    public static function Trouver($noEnr = 0){
        return self::TrouverEnregistrement($noEnr,["pages", "pagesLangues"],"noPage");
    }

    public static function TrouverLien($noEnr, $options = []){
        global $cfg;
        $default = [
            "langue" => $cfg["noLangue"],
            "lienComplet" => false,
        ];
        
        $settings = array_merge($default, $options);
        $lien = "/pageInvalide/";
        
        $SQL = "SELECT	pages.*, pagesLangues.*
                FROM	pages
                
                INNER	JOIN pagesLangues
                ON		pages.noPage = pagesLangues.noPage
                AND		pagesLangues.noLangue = '".$settings["langue"] . "'
                
                WHERE	pages.noPage = $noEnr";
        
        $page = DB::query($SQL)->fetchAll();
        
        if(!empty($page)){
            if($page[0]["pageParentPage"] != 0){
                $lien = self::TrouverLien($page[0]["pageParentPage"], $settings);
                $lien .= $page[0]["repertoirePageLangue"]."/";
            } else {
                ob_start();
                TrouverLangue("langueAbr_".$settings["langue"]);
                $lien = "/".ob_get_contents()."/";
                ob_end_clean();
                $lien .= ($page[0]["noMicrositePage"] == MICROSITE_INTRANET) ? "cms/" : "";
                $lien .= $page[0]["repertoirePageLangue"]."/";
            }
        }

        if($settings["lienComplet"]){
            $lien = '<a href="'.$lien.'" alt="'.$page[0]["titrePageLangue"].'">'.$page[0]["titrePageLangue"].'</a>';
        }

        return $lien;
    }

    public static function TrouverParRepertoire($repertoire, $options = [], $niveau = 0){
        global $cfg;
        $page = [];
        $default = [
            "noLangue" => LANGUE_PRINCIPAL,
            "noMicrosite" => MICROSITE_SITE,
        ];

        $settings = array_merge($default, $options);
        $rep = "";

        if($niveau == 0):
            $rep = end($repertoire);
        else:
            $rep = prev($repertoire);
        endif;
        
        if($rep != NULL){
            $SQL = "SELECT  *
                    FROM    pages
                    
                    INNER   JOIN pagesLangues
                        ON  pagesLangues.noPage = pages.noPage
                        AND pagesLangues.noLangue = '" . $settings["noLangue"] . "'
                        
                    WHERE   pagesLangues.repertoirePageLangue = '$rep'
                        AND pages.noMicrositePage = '" . $settings["noMicrosite"] . "'
                        AND pages.actifPage = 1";

            $page = DB::query($SQL)->fetchAll();

            if(!$page):
                array_unshift($cfg["variables"], $rep);
                $page = self::TrouverParRepertoire($repertoire, $settings, ++$niveau);
            endif;    
        }
        
        if($page != NULL):
            $cfg["module"] = $page[0]["modulePage"];
        endif;
        
        return $page;
    }

    public static function SetActiverDesactiverPage($noEnr = 0) {
        $SQL = "UPDATE pages SET actifPage = NOT actifPage WHERE noPage = '$noEnr'";
        DB::query($SQL);
    }

    public static function Enregistrer($data){
        global $cfg;

        $page = self::Trouver($data["noEnr"]);

        $actif = 0;
        if(isset($data["actif"])) {
            $actif = 1;
        }

        $indexation = 0;
        if(isset($data["indexation"])) {
            $indexation = 1;
        }

        $afficherDescription = 0;
        if(isset($data["afficherDescription"])) {
            $afficherDescription = 1;
        }

        if($page){
            $SQL = "UPDATE pages
                SET actifPage                   = '$actif',
                    indexationPage              = '$indexation',
                    afficherDescriptionPage     = '$afficherDescription',
                    modulePage                  = '$data[module]',
                    pageParentPage              = '$data[pageParent]'
                WHERE pages.noPage              = '$data[noEnr]'";
            
            $page = DB::query($SQL);
            
            foreach($cfg["languesSite"] as $i) {
                $SQL = "UPDATE pagesLangues
                    SET titrePageLangue = '".$data["titre_$i"]."',
                        repertoirePageLangue = '".$data["repertoire_$i"]."',
                        descriptionPageLangue = '".$data["description_$i"]."',
                        titreIndexationPageLangue   = '".$data["titreIndexation_$i"]."',
                        descriptionIndexationPageLangue = '".$data["descriptionIndexation_$i"]."'
                    WHERE   pagesLangues.noPage = '$data[noEnr]'
                        AND pagesLangues.noLangue = '$i'";
                DB::query($SQL);
            }
            return true;
        } else {
            return false;
        }
    }

    public static function ConstruireMenu($options = []) {
        global $cfg;

        $default = [
            "microsite" => MICROSITE_SITE,
            "usager" => USAGER,
        ];
    
        $settings = array_merge($default, $options);


        $SQL = "SELECT * FROM pages
                INNER JOIN pagesLangues
                    ON  pagesLangues.noPage = pages.noPage
                    AND pagesLangues.noLangue = '".$cfg["noLangue"]."'
                WHERE   pages.actifPage = 1
                    AND pages.noMicrositePage = '".$settings["microsite"]."'";

        if($settings["microsite"] == MICROSITE_INTRANET){
            if(($settings["usager"]) == USAGER) {
                $strNoPage = "";

                foreach(self::$pagesUsager as $noPage){
                    $strNoPage .= $noPage.",";
                }
                $strNoPage = rtrim($strNoPage, ',');

                $SQL .= " AND pages.noPage IN (".$strNoPage.")";
            }

            $strNoPageNON = "";

            foreach(self::$pagesNonMenu as $noPage) {
                $strNoPageNON .= $noPage.",";
            }

            $strNoPageNON = rtrim($strNoPageNON, ',');
            
            $SQL .= " AND pages.noPage NOT IN (".$strNoPageNON.")";
        }

        $SQL .= " ORDER BY pagesLangues.titrePageLangue";

        return self::ConstruireMenuProcedure(DB::query($SQL)->fetchAll(), $settings["microsite"]);
    }

    public static function TrouverPageAutresLangues($noPage = 0) {
        global $cfg;
        $autresLangues = "";

        $SQL = "SELECT * FROM pages
                INNER   JOIN pagesLangues
                    ON  pagesLangues.noPage = pages.noPage
                
                WHERE   pages.noPage = '$noPage'";
        $autresPages = DB::query($SQL)->fetchAll();

        foreach($autresPages as $page) {
            $langueAutorise = in_array($page["noLangue"], $cfg["languesSite"]);
            if($page["noLangue"] != $cfg["noLangue"] && $langueAutorise) {
                $url = TrouverLien($page["noPage"],["langue" => $page["noLangue"]]);
                $titre = "";
                ob_start();
                TrouverLangue("langueAbr_".$page["noLangue"]);
                $titre = ob_get_contents();
                ob_end_clean();
                $autresLangues .= '<li><a href="'.$url.'">'.strtoupper($titre).'</a></li>';
            }
        }
        echo $autresLangues;
    }

    private static function ConstruireMenuProcedure($pages = [], $noMicrosite = MICROSITE_INTRANET) {
        global $cfg;

        $niveau = 0;
        $path = "";

        if($cfg["noLangue"] == FRANCAIS) {
            $path .= "/fr/";
        } else {
            $path .= "/en/";
        }

        if($noMicrosite == MICROSITE_INTRANET) {
            $path .= "cms/";
        }

        return self::ConstruireSousMenu($pages, $niveau, $path);
    }

    private static function ConstruireSousMenu($pages = [], $niveau = 0, $path = "/") {
        global $cfg;

        $menu = [];
        $autresPages = [];
        
        foreach($pages as $page) {
            if($page["pageParentPage"] == 0) {

                $menu[$page["noPage"]] = [
                    "noPage" => $page["noPage"],
                    "titre" => $page["titrePageLangue"],
                    "repertoire" => $path."".$page["repertoirePageLangue"],
                    "enfants" => [],
                ];
            } else {
                $autresPages[] = $page;
            }
        }

        if(count($autresPages) > 0) {
            // voir pour faire multiple sous-menu dans le futur... seulement 2 niveau posssible pour le moment
            foreach($autresPages as $page) {
                $tmpPath = $path;
                $pageParent = self::Trouver($page["pageParentPage"]);

                /*
                $menu[$pageParent[$cfg["noLangue"]]["noPage"]] = [
                    "noPage" => $pageParent[$cfg["noLangue"]]["noPage"],
                    "titre" => $pageParent[$cfg["noLangue"]]["titrePageLangue"],
                    "repertoire" => $path."".$pageParent[$cfg["noLangue"]]["repertoirePageLangue"],
                ];*/

                $tmpPath .= $pageParent[$cfg["noLangue"]]["repertoirePageLangue"]."/";

                $menu[$page["pageParentPage"]]["enfants"][$page["noPage"]] = [
                    "noPage" => $page["noPage"],
                    "titre" => $page["titrePageLangue"],
                    "repertoire" => $tmpPath.$page["repertoirePageLangue"],
                    "enfants" => [],
                ];
            }
        }

        return $menu;
    }

    public static function Connexion($data){
        $SQL = "SELECT  *
                FROM    usagers
                WHERE   usagers.courrielUsager = '$data[courriel]'";
        
        $usager = DB::query($SQL)->fetchAll();

        if(!$usager):
            return false;
        else:
            $passWork = VerifierHash($data["motDePasse"], $usager[0]["motDePasseUsager"]);
            if($passWork):
                return true;
            else:
                return false;
            endif;
        endif;
    }

    public static function TrouverPagesIndexation() {
        $SQL = "SELECT * FROM pages
            WHERE   actifPage = 1 
                AND noMicrositePage = 1
                AND indexationPage = 1";
        
        return DB::query($SQL)->fetchAll();
    }

    public static function BuildMenuSite($options = []) {
        global $cfg;
        $default = [
            "microsite" => MICROSITE_SITE,
            "menuSeulement" => true,
            "actifSeulement" => true
        ];

        $settings = array_merge($default, $options);
        //Dump($settings);die();

        $SQL = "SELECT * FROM pages
            INNER   JOIN pagesLangues
                ON  pagesLangues.noPage = pages.noPage
                AND pagesLangues.noLangue = $cfg[noLangue]
            WHERE   actifPage = 1
                AND noMicrositePage = $settings[microsite]
                AND pages.noPage != ".SITE_ACCUEIL;

            //echo $SQL;die();
                
            if($settings["menuSeulement"]){
                $SQL .= " AND dansLeMenuPage = 1";
            }
            
        $SQL .= " ORDER BY pages.positionPage ASC";

        //echo $SQL;die();

        $pagesSite =  DB::query($SQL)->fetchAll();

        return self::BuildTableauMenu($pagesSite);
    }

    private static function BuildTableauMenu($pages = [], $pageParent = 0) {
        $tmpEtageMenu = [];

        foreach($pages as $p) {
            if($p["pageParentPage"] == $pageParent) {
                $p["pagesEnfants"] = self::BuildTableauMenu($pages, $p["noPage"]);
                $tmpEtageMenu[] = $p;
            }
        }

        return $tmpEtageMenu;
    }
}
