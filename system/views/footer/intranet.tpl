        <script src="<?=ObtenirPathTheme()?>assets/js/modernizr.min.js"></script>
        <script src="<?=ObtenirPathTheme()?>assets/js/jquery36.min.js"></script>
        <script src="/src/admin/plugins/jquery-ui/jquery-ui.min.js"></script>

        <script>
            var resizefunc = [];
        </script>

        <script src="<?=ObtenirPathTheme()?>assets/js/fastclick.js"></script>
        <!-- Grid-Stack -->
        <script src="/src/js/gridstack.all.js"></script>

        <!-- AUTRES -->
        <script src="/src/admin/plugins/jquery-validation/js/jquery.validate.min.js"></script>
        <script src="/src/admin/plugins/bootstrapvalidator/src/js/bootstrapValidator.js"></script>
        <script src="/src/admin/plugins/bootstrapvalidator/src/js/language/fr_FR.js"></script>
        <script src="/src/admin/plugins/switchery/switchery.min.js"></script>
        <script src="/src/admin/plugins/jquery-sparkline/jquery.sparkline.min.js"></script>
        
        <!-- DataTable -->
        <script src="/src/admin/plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="/src/admin/plugins/datatables/dataTables.bootstrap4.min.js"></script>
        <script src="/src/admin/plugins/datatables/dataTables.buttons.min.js"></script>
        <script src="/src/admin/plugins/datatables/buttons.bootstrap4.min.js"></script>
        <script src="/src/admin/plugins/datatables/jszip.min.js"></script>
        <script src="/src/admin/plugins/datatables/pdfmake.min.js"></script>
        <script src="/src/admin/plugins/datatables/vfs_fonts.js"></script>
        <script src="/src/admin/plugins/datatables/buttons.html5.min.js"></script>
        <script src="/src/admin/plugins/datatables/buttons.print.min.js"></script>
        <script src="/src/admin/plugins/datatables/buttons.colVis.min.js"></script>
        <script src="/src/admin/plugins/datatables/dataTables.responsive.min.js"></script>
        <script src="/src/admin/plugins/datatables/responsive.bootstrap4.min.js"></script>

        <!-- Dropzone js -->
        <script src="/src/admin/plugins/dropzone/dropzone.js"></script>

        <?php  ?>
        <!--Morris Chart-->
        <script src="/src/admin/plugins/morris/morris.min.js"></script>
        <script src="/src/admin/plugins/raphael/raphael-min.js"></script>
        <?php  ?>
        

        <!-- plugins  -->
        <script src="<?=ObtenirPathTheme()?>assets/js/popper.min.js"></script>
        <script src="<?=ObtenirPathTheme()?>assets/js/bootstrap.min.js"></script>
        <script src="<?=ObtenirPathTheme()?>assets/js/detect.js"></script>
        <script src="<?=ObtenirPathTheme()?>assets/js/jquery.slimscroll.js"></script>
        <script src="<?=ObtenirPathTheme()?>assets/js/jquery.blockUI.js"></script>
        <script src="<?=ObtenirPathTheme()?>assets/js/waves.js"></script>
        <script src="<?=ObtenirPathTheme()?>assets/js/wow.min.js"></script>
        <script src="<?=ObtenirPathTheme()?>assets/js/jquery.nicescroll.js"></script>
        <script src="<?=ObtenirPathTheme()?>assets/js/jquery.scrollTo.min.js"></script>

        <script src="/src/admin/plugins/select2/js/select2.min.js" type="text/javascript"></script>
        
        <!-- Counter Up  -->
        <script src="/src/admin/plugins/waypoints/lib/jquery.waypoints.min.js"></script>
        <script src="/src/admin/plugins/counterup/jquery.counterup.min.js"></script>

        
        <!-- Page js  -->
        <script src="<?=ObtenirPathTheme()?>assets/pages/jquery.dashboard.js"></script>

        <!-- Custom main Js -->
        <script src="<?=ObtenirPathTheme()?>assets/js/jquery.core.js"></script>
        <script src="<?=ObtenirPathTheme()?>assets/js/jquery.app.js"></script>

        <script type="text/javascript" src="/src/js/bootbox/bootbox.min.js"></script>
        <script type="text/javascript" src="/src/js/intranet.js" ></script>
        <?php if($cfg["noLangue"] == LANGUE_PRINCIPAL) { ?>
        <script type="text/javascript" src="/src/js/jquery.validate.fr.js" ></script>
        <?php } ?>

        <!-- Modal-Effect -->
        <script src="/src/admin/plugins/custombox/dist/custombox.min.js"></script>
        <script src="/src/admin/plugins/custombox/dist/legacy.min.js"></script>

        
        <!-- Autres -->
        <script type="text/javascript" src="/src/js/jquery.Jcrop.min.js"></script>
        <script type="text/javascript" src="/src/js/tinymce.min.js"></script>
        <script type="text/javascript" src="/src/js/intranet.fichiers.js"></script>
        <script type="text/javascript" src="/src/js/intranet.after.js"></script>

        <?=$tpl["javascript"]; ?>

    </body>
</html>
