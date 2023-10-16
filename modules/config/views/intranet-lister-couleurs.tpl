<div class="card-box">
    <div class="form-group row">
        <label class="col-3 col-form-label" for="coulSiteBackground">Couleur arrière-plan</label>
        <div class="col-md-9">
            <input class="form-control" type="color" id="coulSiteBackground" name="coulSiteBackground" value="<?=$config["coulSiteBackground"] ?? "#ffffff"?>">
        </div>
    </div>

    <div class="form-group row">
        <label class="col-3 col-form-label" for="coulSiteTexte">Couleur texte</label>
        <div class="col-md-9">
            <input class="form-control" type="color" id="coulSiteTexte" name="coulSiteTexte" value="<?=$config["coulSiteTexte"] ?? "#ffffff"?>">
        </div>
    </div>
</div>
