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
        <div id="datatable_wrapper" class="dataTables_wrapper container-fluid dt-bootstrap4 no-footer">
            <table id="myTable" class="display table-striped" style="width:100%">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Titre</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
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

<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content" style="background-color:#000;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <div class="row embed-responsive embed-responsive-16by9 videoView">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default closemodals" data-dismiss="modal">Fermer</button>
            </div>
        </div>
    </div>
    </div>
</div>

<?php DebutJavascript(); ?>
<script type="text/javascript">
$( document ).ready(function() {

    $('#myTable').dataTable($.extend(true,{},oDefault,{
        "sAjaxSource": "./lister-ajax/?ajax=1&sSearch=&search[value]="+$("input[type=search]").val()+"&sEcho=1",
        "aaSorting": [[2,'asc'],[1,'asc']],
		"aoColumns": [
            { width: "40px" },
            null,
            { width: "80px", "render": function ( data, type, row ) {
                return creerBtnAction({"video" : row[0], "modifier" : row[0], "supprimer" : row[0]});
            }},
        ],
    }));
} );
</script>
<?php FinJavascript(); ?>
