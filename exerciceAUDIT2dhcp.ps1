#=====================================================#
#Name:exerciceAUDIT2dhcp.ps1
#Author: Gazeau Kilian, CUB
#DATE: 11/04/2023
#
#Version 1.0
#Comments: Ce scripts doit permettre de v�rfier l'activit� des diff�rentes plages DHCP cr��es sur le serveur.
#
#
#=====================================================#

$scopeInfo = @()

# Sp�cifiez les adresses IP des serveurs DHCP � surveiller
$dhcpServers = "172.16.52.150"

# Boucle � travers chaque serveur DHCP
foreach ($dhcpServer in $dhcpServers) {
    
    # Obtenez la liste des plages DHCP actives sur le serveur
    $dhcpScopes = Get-DhcpServerv4Scope -ComputerName $dhcpServer
    
    # Boucle � travers chaque plage DHCP
    foreach ($dhcpScope in $dhcpScopes) {
        Write-Host "V�rification de l'activit� sur la plage DHCP $($dhcpScope.ScopeId)"
        
        # Obtenez les informations de statistiques de bail pour la plage DHCP
        $dhcpStatistics = Get-DhcpServerv4ScopeStatistics -ComputerName $dhcpServer -ScopeId $dhcpScope.ScopeId
        if ($dhcpStatistics.states -eq "Inactive"){
            writhe-host "la page n'est pas active" -ForegroundColor Red
        }
        # V�rifiez si la plage DHCP a des adresses IP disponibles
        $status = if ($dhcpStatistics.PercentAvailable -lt 100) {
            Write-Warning "La plage DHCP $($dhcpScope.ScopeId) est active et a des adresses IP disponibles."
            "Active"
        } else {
            Write-Host "La plage DHCP $($dhcpScope.ScopeId) est active mais n'a pas d'adresse IP disponible."
            "Inactive"
        }
    $scopeInfo += [PSCustomObject]@{
            Date = Get-Date
            Server = $dhcpServer
            Scope = $dhcpScope.Name
            Status = $status
            }
    }
}

$scopeInfo | Select-Object Date, Server, Scope, Status | Out-File C:\git_cub\contextecubsituation11\audit\auditDHCP.txt