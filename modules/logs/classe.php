<?php

namespace SHA;

class Log extends Module{
    private static $Ajouter = "Ajouter";

    public static function Lister() {
        $SQL = "SELECT DATE_FORMAT(dateLog, '%Y-%m-%d %H:%i:%s') AS dateLog, INET_NTOA(logs.ipLog) as ip,
                msgLog, hostRefererLog, urlLog, platformLog FROM logs ORDER BY dateLog DESC";
        return DB::query($SQL)->fetchAll();
    }

    public static function EnregistrerVisiteur($options = []) {
        self::SaveLog($options);
    }

    private static function SaveLog($options = []) {
        $default = [
            "ipLog" => $_SERVER['REMOTE_ADDR'] ?? "127.0.0.1",
            "hostRefererLog" => $_SERVER['HTTP_REFERER'] ?? "",
            "urlLog" => $_SERVER['REQUEST_URI'] ?? "",
            "platformLog" => "desktop",
            "msgLog" => "",
        ];

        $settings = array_merge($default, $options);

        if(IsMobile()) {
            $settings["platformLog"] = "mobile";
        }

        $SQL = "INSERT INTO logs (
            dateLog,
            ipLog,
            hostRefererLog,
            urlLog,
            platformLog,
            msgLog
        ) VALUES(
            NOW(6),
            INET_ATON('". $settings["ipLog"] ."'),
            '". $settings["hostRefererLog"] ."',
            '". $settings["urlLog"] ."',
            '". $settings["platformLog"] ."',
            '". $settings["msgLog"] ."'
        )";
    
        try {
            DB::query($SQL);
        }
        catch (\exception $e) {
            $cfg["erreur404"] = true;
        }
    }

    public static function Clean($options = []) {
        global $cfg;

        $default = [
            "dayClean" => 3
        ];

        $settings = array_merge($default, $options);

        if(is_numeric($settings["dayClean"]) && $settings["dayClean"] > 0){
            $SQL = "DELETE FROM logs WHERE dateLog < NOW() - INTERVAL ".$settings["dayClean"]." DAY";
            DB::query($SQL);
        } else {
            $optCourriel = [
                "to" => $cfg["crontaskCourriel"],
                "toName" => "Programmeur",
                "titre" => "Crontak erreur - Clean Log",
                "body" => "<p>Il semble y avoir eu un problème avec le crontask pour le nettoyage du log.</p>",
            ];

            Courriel::Envoie($optCourriel);
        }
    }
}
