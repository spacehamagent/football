<div class="card-box">
    <?php 
    $showLabel = true;
    $labelText = "";
    ob_start();
    TrouverLangue("nomProjet");
    $labelText = ob_get_contents();
    ob_end_clean();

    foreach($cfg["languesSite"] as $i):
        if(!$showLabel) {
            $labelText = "";
        }
    ?>
    <div class="form-group row">
        <label class="col-2 col-form-label"><?=$labelText?></label>
        
        <div class="col-8">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><?=TrouverLangue("langueAbr_$i")?></span>
                </div>
                <input type="text" class="form-control" id="nomProjet_<?=$i?>" name="nomProjet_<?=$i?>" value="<?=$config[$i]["nomProjet"]?>">
            </div>
        </div>
        <div class="col-2">&nbsp;</div>
    </div>
    <?php 
        $labelText = false;
    endforeach; ?>
    <hr>

    <?php 
    $showLabel = true;
    $labelText = "";
    ob_start();
    TrouverLangue("courriel");
    $labelText = ob_get_contents();
    ob_end_clean();

    foreach($cfg["languesSite"] as $i):
        if(!$showLabel) {
            $labelText = "";
        }
    ?>
    <div class="form-group row">
        <label class="col-2 col-form-label"><?=$labelText?></label>
        <div class="col-8">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><?=TrouverLangue("langueAbr_$i")?></span>
                </div>
                <input type="text" class="form-control" id="courriel_<?=$i?>" name="courriel_<?=$i?>" value="<?=$config[$i]["courriel"]?>">
            </div>
        </div>
        <div class="col-2">&nbsp;</div>
    </div>
    <?php 
        $labelText = false;
    endforeach; ?>
    <hr>

    <?php 
    $showLabel = true;
    $labelText = "";
    ob_start();
    TrouverLangue("config.metaTitre");
    $labelText = ob_get_contents();
    ob_end_clean();

    foreach($cfg["languesSite"] as $i):
        if(!$showLabel) {
            $labelText = "";
        }
    ?>
    <div class="form-group row">
        <label class="col-2 col-form-label"><?=$labelText?></label>
        <div class="col-8">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><?=TrouverLangue("langueAbr_$i")?></span>
                </div>
                <input type="text" class="form-control" id="metaTitre_<?=$i?>" name="metaTitre_<?=$i?>" value="<?=$config[$i]["metaTitre"]?>">
            </div>
        </div>
        <div class="col-2">&nbsp;</div>
    </div>
    <?php 
        $labelText = false;
    endforeach; ?>
    <hr>
    
    <?php 
    $showLabel = true;
    $labelText = "";
    ob_start();
    TrouverLangue("config.metaDescription");
    $labelText = ob_get_contents();
    ob_end_clean();

    foreach($cfg["languesSite"] as $i):
        if(!$showLabel) {
            $labelText = "";
        }
    ?>
    <div class="form-group row">
        <label class="col-2 col-form-label"><?=$labelText?></label>
        <div class="col-8">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><?=TrouverLangue("langueAbr_$i")?></span>
                </div>
                <input type="text" class="form-control" id="metaDescription_<?=$i?>" name="metaDescription_<?=$i?>" value="<?=$config[$i]["metaDescription"]?>">
            </div>
        </div>
        <div class="col-2">&nbsp;</div>
    </div>
    <?php 
        $labelText = false;
    endforeach; ?>

</div>
