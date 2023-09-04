$logstring = "Installing Firefox..."
echo $logstring >> C:\Temp\firefox_install.log

Start-Process '.\Firefox Setup 117.0.exe' -NoNewWindow -Wait /S

while(!(Test-Path "C:\Program Files\Mozilla Firefox\uninstall\helper.exe" -PathType leaf)) {
    $logstring = "Waiting for installation to complete..."
    echo $logstring >> C:\Temp\firefox_install.log
    Start-Sleep -s 1;
}

$logstring = "Firefox Installed!"
echo $logstring >> C:\Temp\firefox_install.log

$counter=0
while(!(Test-Path "C:\Program Files\Mozilla Firefox\distribution") -and ($counter -le 10) ) {
    $logstring = "Trying to create distribution folder..."
    echo $logstring >> C:\Temp\firefox_install.log
    New-Item -Path "C:\Program Files\Mozilla Firefox\" -Name "distribution" -ItemType "directory" -Force
    Start-Sleep -s 1;
    $counter++
}


$counter=0
while(!(Test-Path "C:\Program Files\Mozilla Firefox\distribution\policies.json" -Type leaf) -and ($counter -le 10) ) {
    $logstring = "Trying to copy policies.json..."
    echo $logstring >> C:\Temp\firefox_install.log
    Copy-Item -Path .\policies.json -Destination "C:\Program Files\Mozilla Firefox\distribution" -Force
    Start-Sleep -s 1;
    $counter++
}


IF(Test-Path "C:\Program Files\Mozilla Firefox\distribution\policies.json" -PathType leaf)
{
    $logstring = "policies.json successfully written!"
    echo $logstring >> C:\Temp\firefox_install.log
    $logstring = "Sucess!"
    echo $logstring >> C:\Temp\firefox_install.log
    return 0
}
ELSE
{
    $logstring = "Failed to write policies.json!"
    echo $logstring >> C:\Temp\firefox_install.log

    $logstring = "Refusing to install Firefox!"
    echo $logstring >> C:\Temp\firefox_install.log

    $logstring = "Uninstalling Firefox..."
    echo $logstring >> C:\Temp\firefox_install.log

    

    Start-Process "C:\Program Files\Mozilla Firefox\uninstall\helper.exe" -NoNewWindow -Wait /S

    return 1

}

