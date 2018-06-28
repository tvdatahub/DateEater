$appName = "DateEater"
$appServicePlan = "LessCheap" #
$repoUrl = "https://github.com/tvdatahub/DateEater"

if ([string]::IsNullOrEmpty($(Get-AzureRmContext).Account)) {Login-AzureRmAccount}

$zones = "W. Europe Standard Time,US Eastern Standard Time,India Standard Time"
$i=0

"Creating $appName Wapps from $repoUrl for time zones $zones..."

if (1) {  # Make 0 to delete Wapps with name starting with $appName
    $zones.Split(",") | % {
        $zone = "$_"
        $i++

        "Creating Wapp $appName$i..."
        $newApp = New-AzureRmWebApp -Name "$appName$i"  -AppServicePlan $appServicePlan

        "Deploy from github..."
        $PropertiesObject = @{ repoUrl = $repoUrl; branch = "master"; isManualIntegration = "false"; }
        Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName "$appName$i" -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName "$appName$i/web" -ApiVersion 2015-08-01 -Force

        "Set $appName$i's zone to $zone..."
        $appSettings = @{"WEBSITE_TIME_ZONE" = $zone}
        (Get-AzureRmWebApp -Name "$appName$i").SiteConfig.AppSettings | % {$appSettings[$_.Name]=$_.Value}
        Set-AzureRmWebApp -ResourceGroupName "$appName$i" -name "$appName$i" -AppSettings $appSettings
    }
} else {
    "Looking for $appName Wapps..."
    Get-AzureRmResourceGroup | % {
        $resName = $_.ResourceGroupName
        if ($resName -like "dateeater*") {
            "Removing Resource Group '$resName' (this can take a minute) ..."
            Remove-AzureRmResourceGroup -Name $resName -Force
        }
    }
}

