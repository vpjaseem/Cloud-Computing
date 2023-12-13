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

#Note: 'Get-WindowsFeature' used to list out all installed features
#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x
#Download, Unzip and Install VC++ 2015-2019
$Path = $env:TEMP; $Installer = "VC_Redistributable_2015_2019.exe"; Invoke-WebRequest "https://github.com/vpjaseem/Cloud-Computing/raw/main/Azure/Downloads/VC_Redistributable_2015_2019.exe" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $Path\$Installer

#Download, Unzip PHP 7.4
$Path = $env:TEMP; $Installer = "php-7-4.zip";Invoke-WebRequest "https://github.com/vpjaseem/Cloud-Computing/raw/main/Azure/Downloads/php-7.4.13-nts-Win32-VC15-x64.zip" -OutFile $Path\$Installer;Expand-Archive -LiteralPath $Path\$Installer -DestinationPath 'C:\Program Files\iis express\PHP\v7.4'; Remove-Item $Path\$Installer

#Download, and Install Google Chrome
$Path = $env:TEMP; $Installer = "chrome_installer.exe"; Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $Path\$Installer
#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x

#Configure PHP on IIS, Set Directories and Files
cd C:\Windows\System32\inetsrv
.\AppCmd set config -section:system.webServer/fastCgi /+"[fullPath='C:\Program Files\iis express\PHP\v7.4\php-cgi.exe',arguments='',maxInstances='4',idleTimeout='300',activityTimeout='30',requestTimeout='90',instanceMaxRequests='10000',protocol='NamedPipe',flushNamedPipe='False']" /commit:apphost
.\AppCmd set config -section:system.webServer/fastCgi /+"[fullPath='C:\Program Files\iis express\PHP\v7.4\php-cgi.exe'].environmentVariables.[name='PHP_FCGI_MAX_REQUESTS',value='10000']" /commit:apphost
.\AppCmd set config -section:system.webServer/handlers /+"[name='PHP-FastCGI2',path='*.php',verb='GET,HEAD,POST',modules='FastCgiModule',scriptProcessor='C:\Program Files\iis express\PHP\v7.4\php-cgi.exe',resourceType='Either',requireAccess='Script']" /commit:apphost
Add-WebConfiguration //DefaultDocument/Files -AtIndex 0 -Value @{Value="index.php"}
#---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x---x

#Download the Web App file and move to C:\inetpub\wwwroot\
$Path = $env:TEMP; $Installer = "az-php-web-app.zip";Invoke-WebRequest "https://github.com/vpjaseem/az-php-web-app/archive/refs/heads/main.zip" -OutFile $Path\$Installer;Expand-Archive -LiteralPath $Path\$Installer -DestinationPath 'C:\inetpub\wwwroot'; Remove-Item $Path\$Installer
