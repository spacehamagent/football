$(document).ready(function () {

    if ($(".btnRetour").length) {
        $(document).on('click', '.btnRetour', function () {
            url = '../../';
            window.location = url;
        });
    }

});
