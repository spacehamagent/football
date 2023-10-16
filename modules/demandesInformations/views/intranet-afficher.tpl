<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <?php 
        if(!empty($enr)) :
        ?>
        <div class="form-group">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                        <span class="input-group-text" id="basic-addon3">Prénom</span>
                </div>
                <input type="text" class="form-control" id="prenom" name="prenom" aria-describedby="basic-addon3" value="<?=$enr[0]["prenomDemandeInformation"]?>" readonly="readonly">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                        <span class="input-group-text" id="basic-addon3">Nom</span>
                </div>
                <input type="text" class="form-control" id="nom" name="nom" aria-describedby="basic-addon3" value="<?=$enr[0]["nomDemandeInformation"]?>" readonly="readonly">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                        <span class="input-group-text" id="basic-addon3">Courriel</span>
                </div>
                <input type="text" class="form-control" id="courriel" name="courriel" aria-describedby="basic-addon3" value="<?=$enr[0]["courrielDemandeInformation"]?>" readonly="readonly">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                        <span class="input-group-text" id="basic-addon3">Téléphone</span>
                </div>
                <input type="text" class="form-control" id="telephone" name="telephone" aria-describedby="basic-addon3" value="<?=$enr[0]["telephoneDemandeInformation"]?>" readonly="readonly">
            </div>
        </div>

        <div class="form-group">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                        <span class="input-group-text" id="basic-addon3">Sujet</span>
                </div>
                <input type="text" class="form-control" id="sujet" name="sujet" aria-describedby="basic-addon3" value="<?=$enr[0]["sujetDemandeInformation"]?>" readonly="readonly">
            </div>
        </div>

        <div class="form-group">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                        <span class="input-group-text" id="basic-addon3">Commentaire</span>
                </div>
                <textarea id="commentaire" name="commentaire" class="md-textarea form-control" rows="5" readonly="readonly"><?=$enr[0]["commentaireDemandeInformation"]?></textarea>
            </div>
        </div>

    <?php
    else:
    ?>
        <p>Pas de demande!</p>
    <?php
    endif;
    ?>
    </div>
    <div class="col-1"></div>
</div>