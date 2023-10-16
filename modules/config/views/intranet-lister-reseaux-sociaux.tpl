<div class="card-box">
    <div class="form-group row">
        <label class="col-2 col-form-label">Facebook</label>
        <div class="col-1">
            <input class="form-control" type="color" id="coulReseauFacebook" name="coulReseauFacebook" value="<?=$config["coulReseauFacebook"] ?? "#4267B2"?>">
        </div>
        <?php foreach($cfg["languesSite"] as $i) { ?>
        <div class="col-4">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><?=TrouverLangue("langueAbr_$i")?></span>
                    <span class="input-group-text" id="basic-addon1"><i class="fa fa-facebook-f"></i></span>
                </div>
                <input type="text" class="form-control" id="facebook_<?=$i?>" name="facebook_<?=$i?>" value="<?=$config[$i]["facebook"]?>">
            </div>
        </div>
        <?php } ?>

    </div>
    <div class="form-group row">
        <label class="col-2 col-form-label">Youtube</label>
        <div class="col-1">
            <input class="form-control" type="color" id="coulReseauYoutube" name="coulReseauYoutube" value="<?=$config["coulReseauYoutube"] ?? "#FF0000"?>">
        </div>
        <?php foreach($cfg["languesSite"] as $i) { ?>
        <div class="col-4">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><?=TrouverLangue("langueAbr_$i")?></span>
                    <span class="input-group-text" id="basic-addon1"><i class="fa fa-youtube"></i></span>
                </div>
                <input type="text" class="form-control" id="youtube_<?=$i?>" name="youtube_<?=$i?>" value="<?=$config[$i]["youtube"]?>">
            </div>
        </div>
        <?php } ?>
    </div>
    <div class="form-group row">
        <label class="col-2 col-form-label">Twitter</label>
        <div class="col-1">
            <input class="form-control" type="color" id="coulReseauTwitter" name="coulReseauTwitter" value="<?=$config["coulReseauTwitter"] ?? "#1DA1F2"?>">
        </div>
        <?php foreach($cfg["languesSite"] as $i) { ?>
        <div class="col-4">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><?=TrouverLangue("langueAbr_$i")?></span>
                    <span class="input-group-text" id="basic-addon1"><i class="fa fa-twitter"></i></span>
                </div>
                <input type="text" class="form-control" id="twitter_<?=$i?>" name="twitter_<?=$i?>" value="<?=$config[$i]["twitter"]?>">
            </div>
        </div>
        <?php } ?>
    </div>
    <div class="form-group row">
        <label class="col-2 col-form-label">Instagram</label>
        <div class="col-1">
            <input class="form-control" type="color" id="coulReseauInstagram" name="coulReseauInstagram" value="<?=$config["coulReseauInstagram"] ?? "#fb3958"?>">
        </div>
        <?php foreach($cfg["languesSite"] as $i) { ?>
        <div class="col-4">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><?=TrouverLangue("langueAbr_$i")?></span>
                    <span class="input-group-text" id="basic-addon1"><i class="fa fa-instagram"></i></span>
                </div>
                <input type="text" class="form-control" id="instagram_<?=$i?>" name="instagram_<?=$i?>" value="<?=$config[$i]["instagram"]?>">
            </div>
        </div>
        <?php } ?>
    </div>
</div>
