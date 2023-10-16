<?php

namespace SHA;

use \Swift_SmtpTransport;
use \Swift_SendmailTransport;
use \Swift_Mailer;
use \Swift_Message;

class Courriel extends Module{
    
    public static function EnvoyerCourrielTest(){
        $options = ConfigurerEnvoiCourriel();

        $options["titre"] = "Titre Démo";
        $options["body"] = "Voici le message du contenu";

        if(self::EnvoyerCourriel($options)){
            echo "Envoyer<br/><br/>";
            print_r($options);
        } else {
            echo "Échoué<br/><br/>";
            print_r($options);
        }
    }

    public static function Envoie($options = []){
        $default = ConfigurerEnvoiCourriel();

        $settings = array_merge($default, $options);

        return self::EnvoyerCourriel($settings);
    }

    private static function EnvoyerCourriel($options = []){
        global $cfg;

        $default = [
            "from" => "",
            "fromName" => $cfg["nomProjet"],
            "to" => "",
            "toName" => "",
            "username" => "",
            "password" => "",
            "smtpHost" => "",
            "smtpPort" => "25",
            "titre" => "",
            "body" => "",
            "template" => __DIR__."/../../system/courriels/courriel"
        ];

        $settings = array_merge($default, $options);

        $settings["body"] = self::ObtenirTemplateCourriel($settings["template"], $settings["body"]);

        try {
            // Create the Transport
            $transport;

            if(isset($settings["smtpHost"]) && $settings["smtpHost"] == 'localhost'){
                $transport = (new Swift_SendmailTransport('/usr/sbin/sendmail -bs'));
            } else {
                $transport = (new Swift_SmtpTransport($settings["smtpHost"], $settings["smtpPort"]))
                    ->setUsername("$settings[username]")
                    ->setPassword("$settings[password]")
                ;
            }

            // Create the Mailer using your created Transport
            $mailer = new Swift_Mailer($transport);

            // Create a message
            //multiple TO ->setTo(['user@domain.org', 'other@domain.org' => 'nameTo'])
            $message = (new Swift_Message("$settings[titre]"))
                ->setFrom(["$settings[from]" => "$settings[fromName]"])
                ->setTo(["$settings[to]" => "$settings[toName]"])
                ->setBody("$settings[body]", 'text/html')
                ->setCharset('utf-8')
            ;
            //$message->setReturnPath('bounces@address.tld');

            // Send the message
            return $mailer->send($message);
        } catch (Exception $e) {
            echo $e->getMessage();
            return false;
        }
    }

    private function ObtenirTemplateCourriel($template, $body = "") {
        global $cfg;

        $contenu = "";
        ob_start();
        include $template.".tpl";
        $contenu = ob_get_contents();
        ob_end_clean();

        $contenu = str_replace("{{contenu}}", $body, $contenu);
        $contenu = str_replace("{{basPage}}", $cfg["infosCourriel"]["basPage"], $contenu);
        $contenu = str_replace("{{titreCourriel}}", $cfg["infosCourriel"]["titreCourriel"], $contenu);

        return $contenu;
    }
}
