#=====================================================#
#Name:exerciceAUDIT2ad.ps1
#Author: Gazeau Kilian, CUB
#DATE: 11/04/2023
#
#Version 1.0
#Comments: Ce scripts doit permettre d'enregistrer dans un document l'ensemble des informations sur les comptes utilisateurs présent au moment de l'audit
#
#
#=====================================================#
$date=Get-Date
$users = Get-ADUser -Filter *
$output = ""

foreach ($user in $users) {
    $username = $user.SamAccountName
    $displayname = $user.DisplayName
    $enabled = $user.Enabled
    $locked = $user.LockedOut
    $lastlogon = $user.LastLogonTimestamp

    $output += "---------------------------------------------------`n"
    $output += "Username: $username`n"
    $output += "Display Name: $displayname`n"
    $output += "Enabled: $enabled`n"
    $output += "Locked Out: $locked`n"
    $output += "Last Logon: $lastlogon`n"
}

$date, $output | Out-File C:\git_cub\contextecubsituation11\audit\auditAD.txt
