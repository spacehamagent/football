<?php

namespace SHA;

class DemandeInformation extends Module{

    public static function Lister(){
        global $cfg;

        $SQL = "SELECT noDemandeInformation, prenomDemandeInformation, nomDemandeInformation,
                courrielDemandeInformation, telephoneDemandeInformation, dateDemandeInformation
            FROM    demandesInformations";
        
        $demandesInformations = DB::query($SQL)->fetchAll();

        return $demandesInformations;
    }

    public static function Trouver($noEnr = 0){
        $SQL = "SELECT *
                FROM demandesInformations
                WHERE noDemandeInformation = '$noEnr'";
        
        return DB::query($SQL)->fetchAll();
    }

    public static function Enregistrer($donnees) {
        $donnees["courriel"] = $donnees["courriel"] ?? "";

        if(strlen($donnees["courriel"]) > 0) {
            $SQL = "INSERT INTO demandesInformations (
                    prenomDemandeInformation,
                    nomDemandeInformation,
                    courrielDemandeInformation,
                    telephoneDemandeInformation,
                    sujetDemandeInformation,
                    commentaireDemandeInformation,
                    dateDemandeInformation
                ) VALUES (
                    '".$donnees["prenom"]."',
                    '".$donnees["nom"]."',
                    '".$donnees["courriel"]."',
                    '".$donnees["telephone"]."',
                    '".$donnees["sujet"]."',
                    '".$donnees["commentaire"]."',
                    NOW()
                )";
            DB::query($SQL);

            $noEnr = DB::obtenirDernierID();
            $noDI = "0";

            ob_start();
            printf("%04d", $noEnr);
            $noDI = ob_get_contents();
            ob_get_clean();

            self::EnvoyerCourrielClient($noDI, $donnees);

            self::EnvoyerAccuseReception($noDI, $donnees);

            return true;
        }
        return false;
    }

    private static function EnvoyerCourrielClient($noEnr, $donnees) {
        global $cfg;

        if (strlen($donnees["courriel"]) > 0) {
            $titre = "Demande d'information - DI-".$noEnr;
            $cfg["infosCourriel"]["titreCourriel"] = $titre;

            $nomComplet = $donnees["prenom"] . " " . $donnees["nom"];
            $msg = "<p>Bonjour $donnees[prenom],<br/>nous avons bien reçu votre demande et le tout sera traité dans les prochaines 48h.</p>
            <p>Nom : $nomComplet<br/>Courriel : $donnees[courriel]<br/>Téléphone : $donnees[telephone]</p>
                    <p>Sujet : ". FormatTexte($donnees["sujet"]) . "<br/>Commentaire : ". FormatTexte($donnees["commentaire"]) . "</p><p></p>";

            $options = [
                "to" => $donnees["courriel"],
                "toName" => $donnees["prenom"],
                "titre" => $titre,
                "body" => $msg
            ];
            
            Courriel::Envoie($options);
        }
    }

    private static function EnvoyerAccuseReception($noEnr, $donnees) {
        global $cfg;

        if (strlen($donnees["courriel"]) > 0) {
            $titre = "Accusé réception - DI-".$noEnr;
            $cfg["infosCourriel"]["titreCourriel"] = $titre;

            $nomComplet = $donnees["prenom"] . " " . $donnees["nom"];
            $msg = "<p>Bonjour,<br/>une nouvelle demande d'information vous à été envoyé.</p>
            <p>Nom : $nomComplet<br/>Courriel : $donnees[courriel]<br/>Téléphone : $donnees[telephone]</p>
                    <p>Sujet : ". FormatTexte($donnees["sujet"]) . "<br/>Commentaire : ". FormatTexte($donnees["commentaire"]) . "</p><p></p>";

            $options = [
                "to" => $cfg["demandeInformation"]["courrielEntreprise"],
                "toName" => $cfg["demandeInformation"]["titreEntreprise"],
                "titre" => $titre,
                "body" => $msg
            ];
            
            Courriel::Envoie($options);
        }
    }
}