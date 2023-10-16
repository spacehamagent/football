<?php

require_once __DIR__ . '/../../config/configuration.inc.php';

use SHA\Courriel;

$envoyer = false;

if(isset($_GET["envoyer"]) && $_GET["envoyer"] == 1) {
    $envoyer = true;
}

$courriels = [
    [
        "to" => "louisvincentfp@gmail.com",
        "toName" => "Louis-Vincent Fillion Pratte"
    ],
    [
        "to" => "spaceham2002@videotron.ca",
        "toName" => "Louis-Vincent Fillion Pratte"
    ],
    [
        "to" => "spaceham2002@hotmail.com",
        "toName" => "Louis-Vincent Fillion Pratte"
    ]
];

$titreAleatoire = [
    "La neige est là",
    "Seulement en deux mots",
    "Les vacances arrivent",
    "C'est la fin de semaine",
    "C'est ta fête",
];

$contenuMessage = [
    "<p>Bonjour,<br/><br/>Quod cum ita sit, paucae domus studiorum seriis cultibus antea celebratae nunc ludibriis ignaviae torpentis exundant, vocali sonu, perflabili tinnitu fidium resultantes. denique pro philosopho cantor et in locum oratoris doctor artium ludicrarum accitur et bybliothecis sepulcrorum ritu in perpetuum clausis organa fabricantur hydraulica, et lyrae ad speciem carpentorum ingentes tibiaeque et histrionici gestus instrumenta non levia.</p>",
    "<p>Salut,<br/><br/>Et quia Montius inter dilancinantium manus spiritum efflaturus Epigonum et Eusebium nec professionem nec dignitatem ostendens aliquotiens increpabat, qui sint hi magna quaerebatur industria, et nequid intepesceret, Epigonus e Lycia philosophus ducitur et Eusebius ab Emissa Pittacas cognomento, concitatus orator, cum quaestor non hos sed tribunos fabricarum insimulasset promittentes armorum si novas res agitari conperissent.</p>",
    "<p>Héhé,<br/><br/>Fuerit toto in consulatu sine provincia, cui fuerit, antequam designatus est, decreta provincia. Sortietur an non? Nam et non sortiri absurdum est, et, quod sortitus sis, non habere. Proficiscetur paludatus? Quo? Quo pervenire ante certam diem non licebit. ianuario, Februario, provinciam non habebit; Kalendis ei denique Martiis nascetur repente provincia.</p>"
];

if($envoyer) {
    foreach($courriels as $courriel) {
        $titre = $titreAleatoire[array_rand($titreAleatoire)];
        $contenu = $contenuMessage[array_rand($contenuMessage)];
        
        $options = [
            "from" => "info@spacehamagent.com",
            "fromName" => $cfg["nomProjet"],
            "to" => $courriel["to"],
            "toName" => $courriel["toName"],
            "titre" => $titre,
            "body" => $contenu
        ];

        Courriel::Envoie($options);
    }
    echo "Courriels envoyé...";
} else {
    echo "<p>Titre: ".$titre."<br/><br/>";
    echo "Message: ".$contenu."</p>";
}
