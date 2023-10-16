<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <div class="row">
            <div class="col-xl-4 col-md-12 col-xs-12">
                <form id="DonneesAjoutTemps" name="DonneesAjoutTemps" action="#" method="post">
                    <div class="form-group">
                        <div class="input-append date dateTempDebutAjout">
                            <span class="add-on"><i class="fa fa-calendar" aria-hidden="true"></i>&nbsp;&nbsp;Temps début</span>
                            <input type="text" value="" id="tempDebutAjout" name="tempDebutAjout" readonly>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-append date dateTempFinAjout">
                            <span class="add-on"><i class="fa fa-calendar" aria-hidden="true"></i>&nbsp;&nbsp;Temps fin</span>
                            <input type="text" value="" id="tempFinAjout" name="tempFinAjout" readonly>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary btnFormulaire">Ajouter</button>
                    <div id="msgAjout" name="msgAjout" ></div>
                </form>
            </div>
            <div class="col-xl-4 col-md-6 col-xs-12">
                <form id="Donnees" name="Donnees" action="#" method="post">
                    <div class="form-group">
                        <div class="input-append date dateOnlyDateDebut">
                            <span class="add-on"><i class="fa fa-calendar" aria-hidden="true"></i>&nbsp;&nbsp;Date début</span>
                            <input type="text" value="" id="dateDebut" name="dateDebut" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-append date dateOnlyDatFin">
                            <span class="add-on"><i class="fa fa-calendar" aria-hidden="true"></i>&nbsp;&nbsp;Date fin</span>
                            <input type="text" value="" id="dateFin" name="dateFin" readonly>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary btnFormulaire">Calculer Temps</button>
                    <div id="msg" name="msg" ></div>
                </form>
            </div>
            <div class="col-xl-4 col-md-6 col-xs-12">
                <div class="row">
                    <div class="col-12">
                        <label>Secondes: <span id="secondes" name="secondes"></span></label><br/>
                    </div>
                    <div class="col-12">
                        <label>Temps: <span id="temps" name="temps"></span></label><br/>
                    </div>
                    <div class="col-12">
                        <label>Temps décimal: <span id="tempsDecimal" name="tempsDecimal"></span></label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-1"></div>
</div>

<script type="text/javascript">
$( document ).ready(function() {

    $('#tempDebutAjout').datetimepicker({format: 'yyyy-mm-dd hh:ii'});
    $('#tempFinAjout').datetimepicker({
        format: 'yyyy-mm-dd hh:ii',
        mindate: $('#tempDebutAjout').val()
    });
    $('#dateDebut').datetimepicker({format: 'yyyy-mm-dd'});
    $('#dateFin').datetimepicker({
        format: 'yyyy-mm-dd',
        mindate: $('#dateDebut').val()
    });

    $("#DonneesAjoutTemps").validate({
        rules: {
            tempDebutAjout: { required: true },
            tempFinAjout: { required: true },
        },
        errorPlacement: function(error, element){
            $(element).closest('.form-group').append(error);
        },
        errorElement: "p",
        submitHandler: function(form) {
            $.ajax({
                type: "post",
                url: "./ajouter-temps/?ajax=1",
                data: $(form).serialize(),
                dataType: "json",
                
                "error": function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Erreur');
                }, 
                success: function(resultat){
                    if (resultat.etat == 1){
                        $('#msgAjout').html('<p>'+resultat.message+'</p>');
                        $('#dateAjout').val('');
                        $('#tempDebutAjout').val('');
                        $('#tempFinAjout').val('');
                    } else {
                        $('#msgAjout').html('<p>'+resultat.message+'</p>');
                    }
                }
            });
        }
    });

    $("#Donnees").validate({
        rules: {
            dateDebut: { required: true },
            dateFin: { required: true },
        },
        errorPlacement: function(error, element){
            $(element).closest('.form-group').append(error);
        },
        errorElement: "p",
        submitHandler: function(form) {
            $.ajax({
                type: "post",
                url: "./calculer-temps/?ajax=1",
                data: $(form).serialize(),
                dataType: "json",
                
                "error": function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Erreur');
                }, 
                success: function(resultat){
                    if (resultat.etat == 1){
                        $('#secondes').html(resultat.secondes);
                        $('#temps').html(resultat.temps);
                        $('#tempsDecimal').html(resultat.tempsDecimal+'H');
                    } else {
                        $('#msg').html('<p>Aucune information aux dates spécifiées.</p>');
                    }
                }
            });
        }
    });

});
</script>
