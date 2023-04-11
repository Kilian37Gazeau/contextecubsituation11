#=====================================================#
#Name:exerciceAUDIT1services.ps1
#Author: Gazeau Kilian, CUB
#DATE: 11/04/2023
#
#Version 1.0
#Comments: Ce scripts doit permettre de créer un fichier texte dans lequel sera indiqué
#
#
#=====================================================#

$date=Get-Date
$service=Get-Service -Name "DNS", "DHCP", "AD*" 
$date, $service | Out-File C:\git_cub\contextecubsituation11\audit\auditServices.txt