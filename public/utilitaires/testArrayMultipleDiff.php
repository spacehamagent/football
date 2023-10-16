<?php

include '../../config/configuration.inc.php';

$avant = [
    [
        "noUsagerDisponibilite" => 429,
        "journeeUsagerDisponibilite" => 5,
        "heureDebutUsagerDisponibilite" => "07:30:00",
        "heureFinUsagerDisponibilite" => "08:00:00",
    ],
    [
        "noUsagerDisponibilite" => 430,
        "journeeUsagerDisponibilite" => 2,
        "heureDebutUsagerDisponibilite" => "08:05:00",
        "heureFinUsagerDisponibilite" => "09:00:00",
    ],
    [
        "noUsagerDisponibilite" => 431,
        "journeeUsagerDisponibilite" => 5,
        "heureDebutUsagerDisponibilite" => "07:30:00",
        "heureFinUsagerDisponibilite" => "10:15:00",
    ]
];

$apres = [
    [
        "noUsagerDisponibilite" => 430,
        "journeeUsagerDisponibilite" => 1,
        "heureDebutUsagerDisponibilite" => "08:00:00",
        "heureFinUsagerDisponibilite" => "09:00:00",
    ],
    [
        "noUsagerDisponibilite" => 431,
        "journeeUsagerDisponibilite" => 3,
        "heureDebutUsagerDisponibilite" => "09:30:00",
        "heureFinUsagerDisponibilite" => "11:30:00",
    ],
    [
        "noUsagerDisponibilite" => 432,
        "journeeUsagerDisponibilite" => 1,
        "heureDebutUsagerDisponibilite" => "13:30:00",
        "heureFinUsagerDisponibilite" => "15:30:00",
    ],
    [
        "noUsagerDisponibilite" => 0,
        "journeeUsagerDisponibilite" => 0,
        "heureDebutUsagerDisponibilite" => "15:15:00",
        "heureFinUsagerDisponibilite" => "17:45:00",
    ],
    [
        "noUsagerDisponibilite" => 0,
        "journeeUsagerDisponibilite" => 3,
        "heureDebutUsagerDisponibilite" => "11:15:00",
        "heureFinUsagerDisponibilite" => "12:30:00",
    ]
];

echo "<p>AVANT</p>";
Dump($avant);
echo "<br/><br/><p>APRÈS</p>";
Dump($apres);

// Vérifier les différences

$arr_diff = VerifierDifference($avant,$apres);
echo "<br/><br/><p>DIFF</p>";
Dump($arr_diff);

$arr_ajouter = VerifierCollectionAjouter($apres);
echo "<br/<br/><p>Ajouter</p>";
Dump($arr_ajouter);

$arr_retirer = VerifierCollectionRetirer($avant,$apres);
echo "<br/<br/><p>Retirer</p>";
Dump($arr_retirer);

die();


Function VerifierCollectionAjouter($apres, $keyName = "noUsagerDisponibilite") {
    $tmpAjouter = [];

    foreach($apres as $item) {
        if($item[$keyName] == 0) {
            $tmpAjouter[] = $item;
        }
    }

    return $tmpAjouter;
}

Function VerifierCollectionRetirer($avant, $apres, $keyName = "noUsagerDisponibilite") {
    $tmpRetirer = [];

    foreach($avant as $a) {
        $existe = false;

        foreach($apres as $apr) {
            if($a[$keyName] == $apr[$keyName]) {
                $existe = true;
            }
        }

        if(!$existe) {
            $tmpRetirer[$a[$keyName]] = $a;
        }
    }

    return $tmpRetirer;
}

Function VerifierDifference($avant, $apres, $keyName = "noUsagerDisponibilite") {
    $tmpDiff = [];
    $trouve = false;
    $noTrouve = [];
    $tmpNonTrouve = [];

    foreach($avant as $disAvant) {
        $noUsagerDispo = $disAvant[$keyName];

        if($trouve) {
            $trouve = false;
        }

        foreach($apres as $disApres) {
            if($disApres[$keyName] === $noUsagerDispo) {
                $result = GetDifferenceArray($disAvant, $disApres);

                if(count($result) > 0) {
                    $key = GetFirstKeyArray($result);
                    $noTrouve[] = $key;
                    $valueAvant = GetValeursAvant($avant,$key);

                    foreach($result[$key] as $modif => $value) {
                        $tmpDiff[$key]["ancienneValeur"][$modif] = $valueAvant[$modif];
                        $tmpDiff[$key]["nouvellesValeur"][$modif] = $value;
                    } 
                    
                }
                $trouve = true;
            } else {
                $tmpNonTrouve[] = $disApres;
            }
        }
    }
    
    return $tmpDiff;
}

Function GetValeursAvant($avant, $noUsagerDispo, $keyName = "noUsagerDisponibilite") {
    $tmp = [];
    foreach($avant as $a) {
        if($a[$keyName] == $noUsagerDispo)
            return $a;
    }
}

Function GetFirstKeyArray($arr) {
    if (!function_exists('array_key_first')) {
        foreach($arr as $key => $unused) {
            return $key;
        }
        return NULL;
    } else {
        return array_key_first($arr);
    }
}

Function GetDifferenceArray($arr_1, $arr_2, $keyName = "noUsagerDisponibilite") {
    $tmpArray = [];
    $tmpArray[$arr_1[$keyName]] = array_merge(array_diff($arr_1,$arr_2), array_diff($arr_2,$arr_1));
    return $tmpArray;
}

