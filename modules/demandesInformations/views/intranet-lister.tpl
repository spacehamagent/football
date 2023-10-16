<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <div id="table">
            <table id="myTable" class="display" style="width:100%">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Prenom</th>
                        <th>Nom</th>
                        <th>Courriel</th>
                        <th>Téléphone</th>
                        <th>Date</th>
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
        "aaSorting": [[5,'asc']],
		"aoColumns": [
            { width: "40px" },
            { width: "100px", "bVisible": false },
            { width: "300px", "render": function( data, type, row ) {
                return row[1] + " " + row[2]
            }},
            null,
            null,
            { width: "150px" },
            { width: "80px", "render": function ( data, type, row ) {
                return creerBtnAction({"visualiser" : row[0]});
            }},
        ],
    }));
} );
</script>
<?php FinJavascript(); ?>
