<?php

namespace SHA;

class Groupe extends Module{
    
    public static function Lister(){
        global $cfg;
        $SQL = "SELECT *
            FROM    groupes
            
            INNER JOIN groupesLangues
                ON  groupesLangues.noGroupe = groupes.noGroupe
                AND groupesLangues.noLangue = '" . $cfg["noLangue"] . "'";
        return DB::query($SQL)->fetchAll();
    }

    public static function EnregistrerGroupeVideo($noVideo, $donnees){
        $listeGroupe = [];
        foreach($donnees as $key => $val){
            if($key)

            if(substr( $key, 0, 7 ) === "groupe_"){
                $tmp = explode("_", $key);
                $listeGroupe[] = $tmp[1];
            }
        }

        self::SupprimerGroupeVides($noVideo);

        $SQL = "INSERT into groupesVideos (noGroupe, noVideo) VALUES ";
        
        if(!empty($listeGroupe)){
            foreach($listeGroupe as $groupe){
                $SQL .= "($groupe, $noVideo),";
            }
            $SQL = rtrim($SQL, ",");

            DB::query($SQL);
        }
    }

    private static function SupprimerGroupeVides($noVideo){
        $SQL = "DELETE from groupesVideos
            WHERE noVideo = '$noVideo'";
        DB::query($SQL);
    }
}