#=====================================================#
#Name:exerciceAUDIT2dns.ps1
#Author: Gazeau Kilian, CUB
#DATE: 11/04/2023
#
#Version 1.0
#Comments: Ce scripts doit permettre d'afficher l'ensemble des enregistrements DNS de type A
#
#
#=====================================================#
$date=Get-Date
$records = Get-DnsServerResourceRecord -ZoneName "local.dortmund.cub.sioplc.fr" -RRType A
$output = @()

foreach ($record in $records) {
    $name = $record.HostName
    $ip = $record.RecordData.IPv4Address.IPAddressToString
    $output += "$name,$ip"
}

$output, $date | Out-File C:\git_cub\contextecubsituation11\audit\auditDNS.txt
