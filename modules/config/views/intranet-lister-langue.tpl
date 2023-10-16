<div class="card-box">
    <?php //Dump($config);
    $visibleTitre = true;

    foreach($cfg["languesSite"] as $i) { 
        $langueActive = false;
        $langueDisable = false;
        $txtLanguePrincipal = "";

        ob_start();
        TrouverLangue("config.languePrincipal");
        $txtLanguePrincipal = ob_get_contents();
        ob_end_clean();

        if($i == LANGUE_PRINCIPAL) {
            $langueActive = true;
            $langueDisable = true;
        } else {
            if($config["siteLangue-".$i]) {
                $langueActive = true;
            }
        }
        ?>
        <div class="form-group row">
            <div class="col-3">
                <label class="col-12 col-form-label">
                    <?php if($visibleTitre) {
                        $visibleTitre = false;
                        echo "Activer langue site";
                    } ?></label>
            </div>
            <div class="form-group row col-7">
                <div class="mt-3">
                    <div class="checkbox checkbox-success">
                        <input id="siteLangue-<?=$i?>" name="siteLangue-<?=$i?>" type="checkbox"
                            <?=(($langueActive) ? ' checked="checked"': '')?>
                            <?=(($langueDisable) ? ' disabled="disabled"' : '')?>>
                        <label for="siteLangue-<?=$i?>">
                        <?=TrouverLangue('langue_'.$i)?>
                        <?=(($i == LANGUE_PRINCIPAL) ? " (".$txtLanguePrincipal.")": '')?>
                    </label>
                    </div>
                </div>
            </div>
            <div class="col-2"> </div>
        </div>

        
<?php } ?>
</div>
