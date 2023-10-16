<div class="row lineDiv">
    <div class="col-9"></div>
    <div class="col-1">
        <button type="button" class="btn btn-primary btnAjouter">Ajouter</button>
    </div>
    <div class="col-2"></div>
</div>

<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <div id="table">
            <table id="myTable" class="display" style="width:100%">
                <thead>
                    <tr>
                        <th>#</th>
                        <th><?=TrouverLangue("date")?></th>
                        <th><?=TrouverLangue("titre")?></th>
                        <th><?=TrouverLangue("action")?></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tBody>
            </table>
        </div>
    </div>
    <div class="col-1"></div>
</div>

<?php DebutJavascript(); ?>
<script type="text/javascript">
$( document ).ready(function() {

    $('#myTable').dataTable($.extend(true,{},oDefault,{
        "sAjaxSource": "./lister-ajax/?ajax=1&sSearch=&search[value]="+$("input[type=search]").val()+"&sEcho=1",
        "aaSorting": [[2,'desc']],
		"aoColumns": [
            { width: "60px" },
            { width: "100px", "bVisible": false },
            null,
            { width: "60px", "render": function ( data, type, row ) {
                return creerBtnAction({"modifier" : row[0], "supprimer" : row[0]});
            }},
        ],
    }));
});
</script>
<?php FinJavascript(); ?>
