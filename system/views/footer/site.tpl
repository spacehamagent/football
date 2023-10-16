        
        <script src="/src/admin/plugins/jquery-validation/js/jquery.validate.min.js"></script>
        <?php if($cfg["noLangue"] == LANGUE_PRINCIPAL) { ?>
        <script type="text/javascript" src="/src/js/jquery.validate.fr.js" ></script>
        <?php } ?>

        <?php
        if(isset($cfg["Google"]["analytics"]) && (isset($cfg["PageAnalyse"]) && $cfg["PageAnalyse"])) { 
            AjouterGoogleAnalytics($cfg["Google"]["analytics"]);
        }
        ?>

        <?php
        $langueReCaptcha = (($cfg["noLangue"] == FRANCAIS) ? "fr-CA" : "en");
        if(isset($cfg["Google"]["reCaptchaPublic"]) && strlen($cfg["Google"]["reCaptchaPublic"]) > 0) { ?>
        <script src='https://www.google.com/recaptcha/api.js?hl=<?=$langueReCaptcha?>'></script>
        <?php } ?>

        <?php /* ?>
        <!-- Facebook Messenger script -->
        <script>
            (function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = 'https://connect.facebook.net/<?=($cfg["noLangue"]==FRANCAIS?'fr_CA':'en_US')?>/sdk/xfbml.customerchat.js#xfbml=1&version=v2.12&autoLogAppEvents=1';
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));
        </script>
        <div class="fb-customerchat"
            page_id="100009886725012"
            logged_in_greeting="Mon message messenger ici..."
            logged_out_greeting="Mon message messenger ici..."
            greeting_dialog_display="hide"
            theme_color="#4DA6DE">
        </div>
        <?php */ ?>

        <script type="text/javascript" src="/src/js/site.after.js" ></script>

        <?=$tpl["javascript"]; ?>

        <!-- Footer -->
        
        <footer class="mojFooter">
            <div class="fixed-bottom">
                <font face="Roboto Condensed" size="4"> <center>
                <div class="container">
                    <div class="bottom-footer">
                        <div class="col-md-12"> 
                            <ul class="footer-nav">
                                <?php if(strlen($cfg["reseauSociaux"]["facebook"]) > 0) :?>
                                <li> <a href="<?=$cfg["reseauSociaux"]["facebook"]?>"><i class="icon-facebook icon-2x"></i></a> </li>
                                <?php endif; ?>

                                <?php if(strlen($cfg["reseauSociaux"]["youtube"]) > 0) :?>
                                <li> <a href="<?=$cfg["reseauSociaux"]["youtube"]?>"><i class="icon-youtube icon-2x"></i></a> </li>
                                <?php endif; ?>
                                
                                <?php if(strlen($cfg["reseauSociaux"]["twitter"]) > 0) :?>
                                <li> <a href="<?=$cfg["reseauSociaux"]["twitter"]?>"><i class="icon-twitter icon-2x"></i></a> </li>
                                <?php endif; ?>

                                <?php if(strlen($cfg["reseauSociaux"]["instagram"]) > 0) :?>
                                <li> <a href="<?=$cfg["reseauSociaux"]["instagram"]?>"><i class="icon-instagram icon-2x"></i></a> </li>
                                <?php endif; ?>

                                <li> <a href="<?=TrouverLien(SITE_CONFIDENTIALITE)?>"> <?=TrouverLangue("confidentialite")?></a> </li>
                            </ul>
                        </div>
                        <p class="seo"><?=TrouverLangue("footerTexte")?></p>
                    </div>
                </div>
                </center></font>
            </div>
        </footer>
    </body>
    
</html>
