#=====================================================#
#Name:exerciceAUDIT.ps1
#Author: Gazeau Kilian, CUB
#DATE: 11/04/2023
#
#Version 1.0
#Comments: Créer une interface graphique qui permet de lancer chaque audit
#
#
#=====================================================#

Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.text = "Interface de lancement de script"
$Form.Width = 1000
$Form.Height = 500

$Button1 = New-Object system.Windows.Forms.Button
$Button1.text = "Lancer script 1"
$Button1.Width = 200
$Button1.Height = 30
$Button1.location = New-Object System.Drawing.Point(50,50)
$Button1.add_Click({
    & "C:\git_cub\contextecubsituation11\exerciceAUDIT1services.ps1"
})

$Button2 = New-Object system.Windows.Forms.Button
$Button2.text = "Lancer script 2"
$Button2.Width = 200
$Button2.Height = 30
$Button2.location = New-Object System.Drawing.Point(250,50)
$Button2.add_Click({
    & "C:\git_cub\contextecubsituation11\exerciceAUDIT2dhcp.ps1"
})
$Button3 = New-Object system.Windows.Forms.Button
$Button3.text = "Lancer script 3"
$Button3.Width = 200
$Button3.Height = 30
$Button3.location = New-Object System.Drawing.Point(50,250)
$Button3.add_Click({
    & "C:\git_cub\contextecubsituation11\exerciceAUDIT3dns.ps1"
})
$Button4 = New-Object system.Windows.Forms.Button
$Button4.text = "Lancer script 4"
$Button4.Width = 200
$Button4.Height = 30
$Button4.location = New-Object System.Drawing.Point(250,250)
$Button4.add_Click({
    & "C:\git_cub\contextecubsituation11\exerciceAUDIT4ad.ps1"
})

$Form.controls.add($Button1)
$Form.controls.add($Button2)
$Form.controls.add($Button3)
$Form.controls.add($Button4)

$Form.ShowDialog() | Out-Null
