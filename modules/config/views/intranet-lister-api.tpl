<div class="card-box">
    <div class="form-group row">
        <label class="col-2 col-form-label" for="googleAnalytic">Google Analytic</label>
        <div class="col-10">
            <input type="text" class="form-control" id="googleAnalytic" name="googleAnalytic" value="<?=$config["googleAnalytic"]?>">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-2 col-form-label" for="googleAnalytic">Google Recaptcha Public</label>
        <div class="col-10">
            <input type="text" class="form-control" id="googleRecaptchaPublic" name="googleRecaptchaPublic" value="<?=$config["googleRecaptchaPublic"]?>">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-2 col-form-label" for="googleRecaptchaPrive">Google Recaptcha Privé</label>
        <div class="col-10">
            <input type="text" class="form-control" id="googleRecaptchaPrive" name="googleRecaptchaPrive" value="<?=$config["googleRecaptchaPrive"]?>">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-2 col-form-label" for="sharethis">Sharethis <a href="<?=$cfg["liens"]["sharethis"]?>" target="_blank"><i class="fa fa-link"></i></a></label>
        <div class="col-10">
            <input type="text" class="form-control" id="sharethis" name="sharethis" value="<?=$config["sharethis"]?>">
        </div>
    </div>
</div>
