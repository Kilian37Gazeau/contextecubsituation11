#=====================================================#
#Name:exerciceAUDIT2dhcp.ps1
#Author: Gazeau Kilian, CUB
#DATE: 11/04/2023
#
#Version 1.0
#Comments: Ce scripts doit permettre de vérfier l'activité des différentes plages DHCP créées sur le serveur.
#
#
#=====================================================#

$scopeInfo = @()

# Spécifiez les adresses IP des serveurs DHCP à surveiller
$dhcpServers = "172.16.52.150"

# Boucle à travers chaque serveur DHCP
foreach ($dhcpServer in $dhcpServers) {
    
    # Obtenez la liste des plages DHCP actives sur le serveur
    $dhcpScopes = Get-DhcpServerv4Scope -ComputerName $dhcpServer
    
    # Boucle à travers chaque plage DHCP
    foreach ($dhcpScope in $dhcpScopes) {
        Write-Host "Vérification de l'activité sur la plage DHCP $($dhcpScope.ScopeId)"
        
        # Obtenez les informations de statistiques de bail pour la plage DHCP
        $dhcpStatistics = Get-DhcpServerv4ScopeStatistics -ComputerName $dhcpServer -ScopeId $dhcpScope.ScopeId
        if ($dhcpStatistics.states -eq "Inactive"){
            writhe-host "la page n'est pas active" -ForegroundColor Red
        }
        # Vérifiez si la plage DHCP a des adresses IP disponibles
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