<div class="row lineDiv">
    <div class="col-9"></div>
    <div class="col-1">
        <button type="button" class="btn btn-primary btnAjouter"><?=TrouverLangue("ajouter")?></button>
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
                        <th>Prénom</th>
                        <th>Nom</th>
                        <th>Courriel</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td></td>
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
        "sAjaxSource": "./liste-ajax/?ajax=1&sSearch=&search[value]="+$("input[type=search]").val()+"&sEcho=1",
        "aaSorting": [[2,'asc'],[1,'asc']],
		"aoColumns": [
            { width: "40px" },
            { width: "100px", "bVisible": false },
            { width: "300px", "render": function( data, type, row ) {
                return row[1] + " " + row[2]
            }},
            null,
            { width: "60px", "render": function ( data, type, row ) {
                return creerBtnAction({"modifier" : row[0], "supprimer" : row[0]});
            }},
        ],
    }));
} );
</script>
<?php FinJavascript(); ?>
