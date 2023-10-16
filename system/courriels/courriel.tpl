<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1">
        <meta name="format-detection" content="telephone=no">
        <title>{{titreCourriel}}</title>
        <style type="text/css">
            body {
                background-color: #fff;
                width: 100%;
            }
            
            table.contenu {
                background-color: #fff;
                color: #000;
                font-family: "Times New Roman", Times, serif;
                font-size:1.2em;
            }
            
            table tr {
                margin: 30px 10px 20px 10px !important;
                padding: 10px 15px 0px 15px !important;
            }
            
            tr.logo {
                float: top;
                width: 100%;
                min-height: auto;
            }
            
            tr.logo img {
                width: 758px !important;
            }
            
            tr.milieu {
                width: 100%;
                max-height: 600px !important;
                min-height: 500px;
                color: #000 !important;
                display: block;
            }
            
            tr.basPage {
                background-color: #C0B0B0;
                max-height: 600px !important;
                min-height: 200px;
                border-radius: 20px;
                display: block;
            }
            
            td {
                word-break: break-all;
            }
        </style>
    </head>

    <body>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr><td>
                <table class="contenu" cellpadding="0" cellspacing="0" width="758" align="center">
                    <tr class="logo">
                        <th><img  class="logoImg" width="758" src="<?=$cfg["adresseSiteWeb"]?>/images/courriel/entete.png" /></th>
                    </tr>
                </table>
            </tr></td>
            <tr><td>
                <table class="contenu" cellpadding="0" cellspacing="0" width="758" align="center">
                    <tr class="milieu">
                        <td height="20" width="100%">{{contenu}}</td>
                    </tr>
                </table>
            </tr></td>
            <tr><td>
                <table class="contenu" cellpadding="0" cellspacing="0" width="758" align="center">
                    <tr class="basPage">
                        <td height="20" width="100%">{{basPage}}</td>
                    </tr>
                </table>
            </td></tr>
        </table>
    </body>

</html>