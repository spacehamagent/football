<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <div id="table">
            <table id="myTable" class="display" style="width:100%">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Actif?</th>
                        <th>Position</th>
                        <th>titre</th>
                        <th>Action</th>
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
        "sAjaxSource": "./lister-ajax/?ajax=1&noMicrosite=<?=$noMicrosite?>&sSearch=&search[value]="+$("input[type=search]").val()+"&sEcho=1",
        "aaSorting": [[3,'asc']],
		"aoColumns": [
            { width: "40px" },
            { width: "60px", "className": "text-center", "render": function (data,type, row) {
                var check = "";
                
                if (data == 1) {
                    check = " checked";
                }

                if(row[0] == <?=SITE_ACCUEIL?>) {
                    return '';
                } else {
                    return '<div class="checkbox checkbox-success checkbox-circle"><input id="btnActifPage_'+row[0]+'" onclick="ActiverDesactiverPage('+row[0]+')" data-nopage="'+row[0]+'" type="checkbox" '+check+'><label for="btnActifPage_'+row[0]+'"></label></div>';
                }
            }},
            null,
            { width: "200px", "className": "text-left", "render": function(data, type, row, meta) {
                var niveau = row[2];

                if(niveau > 0) {
                    $(this).addClass('niveau'+niveau);
                    //alert('Titre: '+data+' | niveau: '+niveau);
                    var $table = $(meta.settings.oInstance.api().table().node());
                    var $td = $table.find('tr:eq(' + meta.row + ') > td:eq(' + meta.col + ')');
                    $td.addClass('niveau'+niveau);
                }
                return data;
            }},
            { width: "60px", "render": function ( data, type, row ) {
                return creerBtnAction({"modifier" : row[0], "supprimer" : row[0]});
            }},
        ],
    }));
} );
</script>
<?php FinJavascript(); ?>
