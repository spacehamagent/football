<div class="row">
    <div class="col-1"></div>
    <div class="col-10">
        <div id="table">
            <table id="myTable" class="display" style="width:100%">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Ip</th>
                        <th>Message</th>
                        <th>Reférent</th>
                        <th>Url</th>
                        <th>Platform</th>
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
        "aaSorting": [[0,'desc']],
		"aoColumns": [
            { width: "150px" },
            null,
            null,
            null,
            { width: "100px" },
            { width: "100px" },
        ],
    }));
} );
</script>
<?php FinJavascript(); ?>
