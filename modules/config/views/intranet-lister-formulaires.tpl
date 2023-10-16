<div class="card-box">
    <?php
    $showLabel = true;
    $labelText = "";
    ob_start();
    TrouverLangue("config.demandeInformationCourrielFrom");
    $labelText = ob_get_contents();
    ob_end_clean();

    foreach($cfg["languesSite"] as $i):
        if(!$showLabel) {
            $labelText = "";
        }
    ?>
    <div class="form-group row">
        <label class="col-3 col-form-label"><?=$labelText?></label>
        <div class="col-7">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><?=TrouverLangue("langueAbr_$i")?></span>
                </div>
                <input type="text" class="form-control" id="courrielDemandeInformationFrom_<?=$i?>" name="courrielDemandeInformationFrom_<?=$i?>" value="<?=$config[$i]["courrielDemandeInformationFrom"]?>">
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
    TrouverLangue("config.demandeInformationCourrielTo");
    $labelText = ob_get_contents();
    ob_end_clean();

    foreach($cfg["languesSite"] as $i):
        if(!$showLabel) {
            $labelText = "";
        }
    ?>
    <div class="form-group row">
        <label class="col-3 col-form-label"><?=$labelText?></label>
        <div class="col-7">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><?=TrouverLangue("langueAbr_$i")?></span>
                </div>
                <input type="text" class="form-control" id="courrielDemandeInformationTo_<?=$i?>" name="courrielDemandeInformationTo_<?=$i?>" value="<?=$config[$i]["courrielDemandeInformationTo"]?>">
            </div>
        </div>
        <div class="col-2">&nbsp;</div>
    </div>
    <?php 
        $labelText = false;
    endforeach; ?>
</div>
