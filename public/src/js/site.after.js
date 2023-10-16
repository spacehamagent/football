$(document).ready(function() {

    /** Si lien ne correspond pas au domaine actuel mettre un target _blank */
    var actuelDomaine = window.location.origin;
    $("a:not([href^='" + actuelDomaine + "'], [href^='/'])").attr('target', '_blank');

    // Fixer problème pour le menu du dropdown quand il y a des sous-menus
    //$(".dropdown-toggle").dropdown();
});
