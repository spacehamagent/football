<?php
require_once __DIR__ . '/../../config/configuration.inc.php';

use \Mesour\DnsChecker\Providers\DnsRecordProvider;
use \Mesour\DnsChecker\DnsChecker;


$domain = $_GET["domain"] ?? "";

if (DevMode() && strlen($domain) > 0) {
    $provider = new DnsRecordProvider();
    $checker = new DnsChecker($provider);

    //DNS_A, DNS_CNAME, DNS_HINFO, DNS_CAA, DNS_MX, DNS_NS, DNS_PTR, DNS_SOA, DNS_TXT, DNS_AAAA, DNS_SRV, DNS_NAPTR, DNS_A6, DNS_ALL or DNS_ANY
    $dnsRecordSet = $checker->getDnsRecordSet($domain, DNS_A + DNS_CNAME + DNS_MX + DNS_TXT);

    print_r($dnsRecordSet);
    die();
} else {
    echo "<p>Utilitaire DNS</p>";
}