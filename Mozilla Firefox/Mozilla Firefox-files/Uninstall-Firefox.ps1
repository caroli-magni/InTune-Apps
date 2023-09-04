
$DistPath = $Env:ProgramFiles + "\Mozilla Firefox\distribution\"
$UninstallerPath = $Env:ProgramFiles + "\Mozilla Firefox\uninstall\helper.exe"
$PolicyPath = $DistPath+"policies.json" 
$FirefoxExePath = $Env:ProgramFiles + "\Mozilla Firefox\firefox.exe"

Remove-Item $PolicyPath -Force

Start-Process $UninstallerPath -NoNewWindow -Wait /S


IF(!Test-Path $FirefoxExePath -PathType leaf)
{
    $logstring = "Firefox executable gone, uninstallation success!"
    echo $logstring >> C:\Temp\firefox_install.log
    return 0
}
ELSE
{
    $logstring = "Firefox still present, uninstallation failed!"
    echo $logstring >> C:\Temp\firefox_install.log
    return 1
}
