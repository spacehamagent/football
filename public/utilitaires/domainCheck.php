<?php

$domaine = "domaine.com";

if(isset($_GET['domain']) && strlen($_GET['domain']) > 3) {
    $domaine = $_GET['domain'];
}

if ( gethostbyname($domaine) != $domaine ) {
    echo "DNS Record found";
    //var_dump(dns_get_record($domaine, DNS_ANY));
    $result = dns_get_record($domaine, DNS_ANY);
    print_r($result);
} else {
    echo "NO DNS Record found";
}

?>
