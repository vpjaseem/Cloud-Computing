
#Adding IIS and PHP Modules

##Install IIS
Install-WindowsFeature web-server

##Add Security Features
Install-WindowsFeature Web-Basic-Auth
Install-WindowsFeature Web-CertProvider
Install-WindowsFeature Web-Client-Auth 
Install-WindowsFeature Web-Digest-Auth 
Install-WindowsFeature Web-Cert-Auth   
Install-WindowsFeature Web-IP-Security 
Install-WindowsFeature Web-Url-Auth    
Install-WindowsFeature Web-Windows-Auth

##Add Application Development Features
Install-WindowsFeature Web-App-Dev
Install-WindowsFeature Web-CGI


##Add Management Tools
Install-WindowsFeature Web-Mgmt-Tools
Install-WindowsFeature Web-Mgmt-Console     
Install-WindowsFeature Web-Mgmt-Compat      
Install-WindowsFeature Web-Metabase         
#Install-WindowsFeature Web-Lgcy-Mgmt-Console
Install-WindowsFeature Web-Lgcy-Scripting   
#Install-WindowsFeature Web-WMI              
Install-WindowsFeature Web-Scripting-Tools  
Install-WindowsFeature Web-Mgmt-Service     

#Note: 'Get-WindowsFeature' used to list out all instaleld features
#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x
#Download, Unzip and Install VC++ 2015-2019
$Path = $env:TEMP; $Installer = "VC_Redistributable_2015_2019.exe"; Invoke-WebRequest "https://github.com/vpjaseem/Cloud-Computing/raw/main/Azure/Downloads/VC_Redistributable_2015_2019.exe" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $Path\$Installer

#Download, Unzip PHP 7.4
$Path = $env:TEMP; $Installer = "php-7-4.zip";Invoke-WebRequest "https://github.com/vpjaseem/Cloud-Computing/raw/main/Azure/Downloads/php-7.4.13-nts-Win32-VC15-x64.zip" -OutFile $Path\$Installer;Expand-Archive -LiteralPath $Path\$Installer -DestinationPath 'C:\Program Files\iis express\PHP\v7.4'; Remove-Item $Path\$Installer

#Download, and Install Google Chrome
$Path = $env:TEMP; $Installer = "chrome_installer.exe"; Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $Path\$Installer

#Download, and Install Notepad++
$Path = $env:TEMP; $Installer = "notepad_pp_installer.exe"; Invoke-WebRequest "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.8/npp.8.4.8.Installer.x64.exe" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer /S -NoNewWindow -Wait -PassThru; Remove-Item $Path\$Installer

#Download, and Install WinRAR
$Path = $env:TEMP; $Installer = "winRAR.exe"; Invoke-WebRequest "https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x64-620.exe" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer /S -NoNewWindow -Wait -PassThru; Remove-Item $Path\$Installer

#Download, and Install WinSCP
$Path = $env:TEMP; $Installer = "winSCP.exe"; Invoke-WebRequest "https://cdn.winscp.net/files/WinSCP-5.21.7-Setup.exe?secure=djMxrV1mJ9J0BPmGI_mMGQ==,1674854938" -OutFile $Path\$Installer

cd $env:TEMP 
.\winSCP.exe /VERYSILENT /NORESTART /ALLUSERS
Remove-Item $Path\$Installer

#Download, and Install Mozilla
$Path = $env:TEMP; $Installer = "Mozilla.exe"; Invoke-WebRequest "https://cdn.stubdownloader.services.mozilla.com/builds/firefox-stub/en-US/win/38197a23831bc83a476213e0cb110d063d0a5a58d50d26b272dc771b7f335580/Firefox%20Installer.exe" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/s" -Verb RunAs -Wait; 

#Download, and Install PuTTY
$Path = $env:TEMP; $Installer = "PuTTY.msi"; Invoke-WebRequest "https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.78-installer.msi" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer /qn
#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x

#Configure PHP on IIS, Set Dorectories and Files
cd C:\Windows\System32\inetsrv
.\AppCmd set config -section:system.webServer/fastCgi /+"[fullPath='C:\Program Files\iis express\PHP\v7.4\php-cgi.exe',arguments='',maxInstances='4',idleTimeout='300',activityTimeout='30',requestTimeout='90',instanceMaxRequests='10000',protocol='NamedPipe',flushNamedPipe='False']" /commit:apphost
.\AppCmd set config -section:system.webServer/fastCgi /+"[fullPath='C:\Program Files\iis express\PHP\v7.4\php-cgi.exe'].environmentVariables.[name='PHP_FCGI_MAX_REQUESTS',value='10000']" /commit:apphost
.\AppCmd set config -section:system.webServer/handlers /+"[name='PHP-FastCGI2',path='*.php',verb='GET,HEAD,POST',modules='FastCgiModule',scriptProcessor='C:\Program Files\iis express\PHP\v7.4\php-cgi.exe',resourceType='Either',requireAccess='Script']" /commit:apphost
Add-WebConfiguration //DefaultDocument/Files -AtIndex 0 -Value @{Value="index.php"}
#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x

#Download the Web App file and move to C:\inetpub\wwwroot\
$url = "https://github.com/vpjaseem/az-php-web-app/archive/refs/heads/main.zip"
$output = "$home\Downloads\php-web-app.zip"
$start_time = Get-Date
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

Expand-Archive -LiteralPath $home\Downloads\php-web-app.zip -DestinationPath 'C:\inetpub\wwwroot\'
cd C:\inetpub\wwwroot\az-win-php-web-app-main
Move-Item -Path .\* -Destination C:\inetpub\wwwroot\
cd C:\inetpub\wwwroot\
Remove-Item -LiteralPath "C:\inetpub\wwwroot\az-win-php-web-app-main" -Force -Recurse


#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x
###OPTIONAL####Remove the '#' from below lines
#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x
#Download, Unzip and Install VC++ 2015-2019

#$url = "https://raw.githubusercontent.com/vpjaseem/Cloud-Computing/main/Azure/Downloads/VC_Redistributable_2015_2019.zip"
#$output = "$home\Downloads\VC_Redistributable_2015_2019.zip"
#$start_time = Get-Date
#Invoke-WebRequest -Uri $url -OutFile $output
#Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
#Expand-Archive -LiteralPath $home\Downloads\VC_Redistributable_2015_2019.zip -DestinationPath $home\Downloads\VC_Redistributable_2015_2019_Extracted
#.$home\Downloads\VC_Redistributable_2015_2019_Extracted\VC_Redistributable_2015_2019.exe /quiet
#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x
#Download, Unzip PHP 7.4

#$url = "https://github.com/vpjaseem/Cloud-Computing/raw/main/Azure/Downloads/php-7.4.13-nts-Win32-VC15-x64.zip"
#$output = "$home\Downloads\php-7-4.zip"
#$start_time = Get-Date
#Invoke-WebRequest -Uri $url -OutFile $output
#Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
#Expand-Archive -LiteralPath $home\Downloads\php-7-4.zip -DestinationPath 'C:\Program Files\iis express\PHP\v7.4'
#$Path = $env:TEMP; $Installer = "php-7-4.zip";Invoke-WebRequest "https://github.com/vpjaseem/Cloud-Computing/raw/main/Azure/Downloads/php-7.4.13-nts-Win32-VC15-x64.zip" -OutFile $Path\$Installer;Expand-Archive -LiteralPath $Path\$Installer -DestinationPath 'C:\Program Files\iis express\PHP\v7.4'; Remove-Item $Path\$Installer
#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x
#Download the Web App file and move to C:\inetpub\wwwroot\

#$url = "https://github.com/vpjaseem/az-php-web-app/archive/refs/heads/main.zip"
#$output = "$home\Downloads\php-web-app.zip"
#$start_time = Get-Date
#Invoke-WebRequest -Uri $url -OutFile $output
#Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
#Expand-Archive -LiteralPath $home\Downloads\php-web-app.zip -DestinationPath 'C:\inetpub\wwwroot\'
#cd C:\inetpub\wwwroot\az-php-web-app-main
#Move-Item -Path .\* -Destination C:\inetpub\wwwroot\
#cd C:\inetpub\wwwroot\
#Remove-Item -LiteralPath "C:\inetpub\wwwroot\az-php-web-app-main\" -Force -Recurse
#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x

#Allow http Port 80 inbound in Windows Firewall (Not Mandatory)

#Enable-NetFirewallRule -DisplayName "BranchCache Content Retrieval (HTTP-In)"
#Enable-NetFirewallRule -DisplayName "BranchCache Hosted Cache Server (HTTP-In)"
#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x
#Download and Install Web Platform Installer

#$url = "https://go.microsoft.com/fwlink/?LinkId=287166"
#$output = "$home\Downloads\Web-Platform-Installer.msi"
#$start_time = Get-Date
#Invoke-WebRequest -Uri $url -OutFile $output
#Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
#Installing Web Platform Installed
#.$home\Downloads\Web-Platform-Installer.msi /quiet
######
