<?php

namespace SHA;

class Video extends Module{
    
    public static function Lister($options = []){
        global $cfg;
        $default = [
            "videosGroupe" => false 
        ];

        $settings = array_merge($default, $options);
        
        $SQL = "SELECT videos.noVideo, titreVideoLangue
            FROM    videos
            
            INNER   JOIN videosLangues
                ON  videosLangues.noVideo = videos.noVideo
                AND videosLangues.noLangue = $cfg[noLangue]
            ";

        if(!EstAdmin()){

            if($settings["videosGroupe"]){
                $noEnr = $_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["noUsager"] ?? 0;

                $SQL .= "INNER JOIN groupesUsagers
                            ON  groupesUsagers.noUsager = '$noEnr'
                        
                        INNER JOIN groupesVideos
                            ON groupesVideos.noGroupe = groupesUsagers.noGroupe
                         
                        WHERE   groupesVideos.noVideo = videos.noVideo
                            OR  videos.noUsager = '2'
                         
                        GROUP BY videos.noVideo";
            } else {
                $noUsager = $_SESSION["microsite_".$cfg["noMicrosite"]]["usager"]["noUsager"] ?? 0;
                $SQL .= " WHERE videos.noUsager = '$noUsager'";
            }
        }

        return DB::query($SQL)->fetchAll();
    }

    public static function ListerGroupeVideo($noEnr){
        $SQL = "SELECT noGroupe
            FROM groupesVideos
            WHERE noVideo = $noEnr";
        $groupeVideo =  DB::query($SQL)->fetchAll();

        $liste = [];
        foreach($groupeVideo as $groupe){
            $liste[] = $groupe["noGroupe"];
        }
        return $liste;
    }

    public static function Trouver($noEnr = 0){
        return self::TrouverEnregistrement($noEnr,["videos", "videosLangues"],"noVideo");
    }

    public static function Enregistrer($donnees){
        global $cfg;

        $enr = self::Trouver($donnees["noEnr"]);

        $donnees["actif"] = ((isset($donnees["actif"])) ? 1: 0);

        if($enr):
            $SQL = "UPDATE videos
                    SET actifVideo      = '".$donnees["actif"]."',
                        positionVideo   = '0'
                WHERE   videos.noVideo  = '" . $donnees["noEnr"] . "'";

            DB::query($SQL);

            foreach($cfg["languesSite"] as $i) {
                $SQL = "UPDATE videosLangues
                    SET titreVideoLangue        = '" . $donnees["titre_$i"] . "',
                        descriptionVideoLangue  = '" . $donnees["description_$i"] . "',
                        repertoireVideoLangue   = '" . $donnees["repertoire_$i"] . "',
                        urlVideoLangue          = '" . $donnees["url_$i"] . "',
                        idVideoLangue           = '" . $donnees["id_$i"] . "'
                    WHERE videosLangues.noVideo = '" . $donnees["noEnr"] . "'
                        AND videosLangues.noLangue = '" . $i . "'";

                DB::query($SQL);
            }

            Historique::Enregistrer([
                "noHistoriqueAction" => HISTORIQUE_ACTION_MODIFIER,
                "messageHistorique" => "Enregistrer [".$donnees["noEnr"]."] module videos"
            ]);

            return true;
        else:
            return false;
        endif;
    }

    public static function Ajouter($donnees){
        global $cfg;

        $donnees["actif"] = ((isset($donnees["actif"])) ? 1: 0);

        $SQL = "INSERT INTO videos (
                    actifVideo,
                    positionVideo,
                    noUsager,
                    dateAjoutVideo
                ) VALUES (
                    '1',
                    '0',
                    '".$_SESSION["microsite_".MICROSITE_INTRANET]["usager"]["noUsager"]."',
                    NOW()
                )";
        DB::query($SQL);

        $noEnr = DB::obtenirDernierID();

        foreach($cfg["languesSite"] as $i) {
            $SQL = "INSERT INTO videosLangues (
                    noVideo,
                    noLangue,
                    titreVideoLangue,
                    repertoireVideoLangue,
                    descriptionVideoLangue,
                    urlVideoLangue,
                    idVideoLangue
                ) VALUES (
                    '$noEnr',
                    '$i',
                    '".$donnees["titre_$i"]."',
                    '".$donnees["repertoire_$i"]."',
                    '".$donnees["description_$i"]."',
                    '".$donnees["url_$i"]."',
                    '".$donnees["id_$i"]."'
                );";
            DB::query($SQL);
        }

        Historique::Enregistrer([
            "noHistoriqueAction" => HISTORIQUE_ACTION_AJOUTER,
            "messageHistorique" => "Ajouter [".$noEnr."] module videos"
        ]);
    }

    public static function Supprimer($noEnr){
        $video = self::Trouver($noEnr);

        if($video){
            $SQL = "DELETE FROM videos WHERE noVideo = '$noEnr'";
            DB::query($SQL);

            $SQL = "DELETE FROM videosLangues WHERE noVideo = '$noEnr'";
            DB::query($SQL);

            Historique::Enregistrer([
                "noHistoriqueAction" => HISTORIQUE_ACTION_SUPPRIMER,
                "messageHistorique" => "Suppression [".$noEnr."] module videos"
            ]);

            return true;
        } else {
            return false;
        }
    }
}