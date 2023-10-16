<?php

namespace SHA;

class DB {
	private $db_Host;
	private $db_User;
	private $db_Password;
	private $db_Source;
	private $options;
	private $nbRequetes = 0;
	private $lastId = 0;
	private $db;
	
	private static $instance = null;
	
	private function __construct(){
		global $cfg;
		$config = ConfigurerBD();

		$this->db_Host = $config["hostname"];
		$this->db_User = $config["username"];
		$this->db_Password = $config["password"];
		$this->db_Source = $config["database"];

		$this->options = array(\PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',);
		
		$this->db = new \PDO('mysql:host=' . $this->db_Host . ';dbname=' . $this->db_Source, $this->db_User, $this->db_Password, $this->options);
		$this->db->setAttribute(\PDO::ATTR_DEFAULT_FETCH_MODE, \PDO::FETCH_ASSOC);
	}
	
	public static function getDB(){
		if (is_null(self::$instance)) {
			self::$instance = new DB();
		}
		return self::$instance;
	}

	public function __destruct(){
		$this->db = null;
	}
	
	public static function query($SQL, $options = []) {
		return self::getDB()->_query($SQL, $options);
	}
	
	private function _query($SQL, $options = []) {
		global $cfg;

		$default = array(
			'format' => 'PDOStatement',
		);
		
		$settings = array_merge($default, $options);
		$query = $this->db->prepare($SQL);
		$time = microtime(true);
		$requete = $query->execute();
		
		$this->lastId = $this->db->lastInsertId();
		
		$time = microtime(true) - $time;
		$this->nbRequetes++;
		
		if ($requete) {
			switch ($settings["format"]) {
				case "csv":
					$donnees = $query->fetchAll();
					return arrayToCsv($donnees);
				break;
				
				default:
					return $query;
			}
		} else {
			$msg = "Requete: $SQL - Ne peut fonctionner";

			ErreurBdd($msg);
		}
	}
	
	public static function getAllColumnsFromTable($tables = []) {
		global $cfg;

		$colonnes = [];
		
		foreach($tables as $table){
			$SQL = "SHOW COLUMNS FROM $table";
			$listeColonnes = self::query($SQL)->fetchAll();
			
			if(strpos($table, 'Langues') !== false) {
				foreach($cfg["languesSite"] as $i) {
					foreach($listeColonnes as $colonne){
						$colonnes[$i][$colonne["Field"]] = "";
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
	
	public static function obtenirDernierID(){
		return self::getDB()->lastId;
	}
	public static function nbRequetes() {
		return self::getDB()->nbRequetes;
	}
}
?>
