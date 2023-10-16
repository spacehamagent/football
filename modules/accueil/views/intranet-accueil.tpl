<div class="row">
    <p>Ceci est la page de connexion temporaire...</p>
</div>

<div class="row">
    <div class="col-1"></div>
    <div class="col-10 embed-responsive embed-responsive-16by9">
    <?php
        $id = "VyoGYPDZBSM";

        if(!empty($video)):
            $id = $video[$cfg["noLangue"]]["idVideoLangue"];
        endif;

        echo CreerYoutubeVideo($id);
    ?>
    </div>
    <div class="col-1"></div>
</div>