<?php

namespace SHA;

class Module {
    protected $tables = [];
    protected $variables = [];

	public function __construct() {
        echo "myClass init'ed successfuly!!!";
    }
	
	public static function GenererEnr($primaryKey, $tables) {
		global $cfg;

		$enr = [];
		
		foreach ($tables as $table) {
			$SQL = "SHOW COLUMNS FROM " . $table;
			$colonnes = DB::query($SQL)->fetchAll();
			$tableLangue = (substr(strtolower($table), -7) == "langues");

			$noLangue = 0;
			$ajout = [];
			foreach ($colonnes as $colonne) {
								
				$valeur = null;
				$type = $colonne["Type"];
				if (strpos($type, "int") !== FALSE) {
					$valeur = 0;
				} else if (strpos($type, "datetime") !== FALSE) {
					$valeur = date("Y-m-d H:i:s");
				} else if (strpos($type, "date") !== FALSE) {
					$valeur = date("Y-m-d");
				} else {
					$valeur = "";
				}
				
				$ajout[$colonne["Field"]] = $valeur;
			}
			
			foreach ($ajout as $champ => $valeur) {
				if ($tableLangue) {
					if (isset($ajout[$primaryKey])) {
						unset($ajout[$primaryKey]);
					}
					if ($champ != $primaryKey && $champ != "noLangue") {
                        foreach($cfg["languesSite"] as $i) {
							$enr[$i][$champ] = $valeur;
                        }
					}
				} else {
				
					if ($champ == $primaryKey) {
						$champ = "noEnr";
					}
					$enr[0][$champ] = $valeur;
				}
			}
			
		}
		
		return $enr;
	}
	
	/**
	 * Remplit un enregistrement avec les données depuis la BD
	 *
	 * Utilisé avec GenererEnr , il remplit l'enregistrement vide avec les données préalablement prises de la base de données. 
	 * La fonction s'occupe de remplir les tables de langues automatiquement également
	 *
	 * @param int $primaryKey La clé primaire de l'enregistrement, exemple pour actualités: noActualite
	 * @param array $resultats Les données de la BD (souvent pris avec la fonction Trouver)
	 * @param array $enr Une référence à l'enregistrement vide qu'on doit remplit
	 */
	public static function RemplirEnr($primaryKey, $resultats, &$enr) {
		if (empty($resultats)) {
			return false;
		}

		foreach ($resultats as $resultat) {
			foreach ($resultat as $champ => $valeur) {
				if (substr(strtolower($champ), -7) == "langue") {
					if ($champ != $primaryKey) {
						$enr[$resultat["noLangue"]][$champ] = $valeur;
						$enr[0][$champ] = $valeur;
					}
				} else {
					if ($champ == $primaryKey) {
						$champ = "noEnr";
					}
					$enr[0][$champ] = $valeur;
				}
			}
			
		}
		return $enr;
	}
	
	public static function GetAllColumnsFromTable($tables = []){
        global $cfg;
        $colonnes = [];
        
        foreach($tables as $table){
            $SQL = "SHOW COLUMNS FROM $table";

            $listeColonnes = DB::query($SQL)->fetchAll();
            
            if(strpos($table, 'Langues') !== false) {
                /*for($indexLangue = 1; $indexLangue <= NB_LANGUES; $indexLangue++){
                    foreach($listeColonnes as $colonne){
                        $colonnes[$indexLangue][$colonne["Field"]] = "";
                    }
                }*/

                foreach($cfg["languesSite"] as $indexLangue) {
                    foreach($listeColonnes as $colonne){
                        $colonnes[$indexLangue][$colonne["Field"]] = "";
                    }
                }

            } else {
                foreach($listeColonnes as $colonne){
                    $colonnes[0][$colonne["Field"]] = "";
                }
            }
        }
        
        return $colonnes;
    }

    public static function TrouverEnregistrement($noEnr, $tables = [], $indexEnr){
        $enr = [];
        $indexLangue = 1;

        foreach($tables as $table){
            $SQL = "SELECT * FROM $table WHERE $indexEnr = $noEnr";
            if(strpos($table, 'Langues') !== false) {
                    $langue = DB::query($SQL)->fetchAll();

                    foreach($langue as $l){
                        $enr[$indexLangue] = $l;
                        $indexLangue++;
                    }
            } else {
                $enr = DB::query($SQL)->fetchAll();
            }
        }

        return $enr;
	}
	
	public static function NbTotalTable($table){
		$SQL = "SELECT COUNT(*) FROM $table";
		$result = DB::query($SQL)->fetchAll();

		return $result[0]["COUNT(*)"];
    }
    
    public static function VerifierLangueExiste($options) {
        $default = [
            "table" => "",
            "id"    => "",
            "noEnr" => 0,
            "langue"    => FRANCAIS
        ];
        $settings = array_merge($default, $options);

        $SQL = "SELECT * FROM ".$settings["table"]."
                 WHERE ".$settings["id"]." = '".$settings["noEnr"]."'
                    AND noLangue = '".$settings["langue"]."'";
        return !empty(DB::query($SQL)->fetchAll());
    }
}
?>
