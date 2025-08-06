@echo off
chcp 65001 >nul

echo  ____  _  ___       ____                                          
echo / ___^|^| ^|/ / ^|     ^|  _ \ _ __ ___   __ _ _ __ __ _ _ __ ___  ___ 
echo \___ \^| ' /^| ^|     ^| ^|_) ^| '__/ _ \ / _` ^| '__/ _` ^| '_ ` _ \/ __^|
echo  ___) ^| . \^| ^|___  ^|  __/^| ^| ^| (_) ^| (_^| ^| ^| ^| (_^| ^| ^| ^| ^| ^| \__ \
echo ^|____/^|_^|\_\_____^| ^|_^|   ^|_^|  \___/ \__, ^|_^|  \__,_^|_^| ^|_^| ^|_^|___/
echo                                     ^|___/                         
timeout 3 >nul
cls

echo     _         _           __        ___                  _   
echo    / \  _   _^| ^|_ ___     \ \      / (_)_ __   __ _  ___^| ^|_ 
echo   / _ \^| ^| ^| ^| __/ _ \ ____\ \ /\ / /^| ^| '_ \ / _` ^|/ _ \ __^|
echo  / ___ \ ^|_^| ^| ^|^| (_) ^|_____\ V  V / ^| ^| ^| ^| ^| (_^| ^|  __/ ^|_ 
echo /_/   \_\__,_^|\__\___/       \_/\_/  ^|_^|_^| ^|_^|\__, ^|\___^|\__^|
echo                                               ^|___/          
echo.
timeout 1 >nul

set CHECK_1=0
set CHECK_2=0

echo Activate Sudo...
sudo config --enable normal
timeout 1 >nul
echo.

echo Create directories...
mkdir "C:\Program Files\SKL\Auto-Winget"
timeout 1 >nul
echo.

echo Download files...
timeout 3 >nul
curl -L -o "C:\Program Files\SKL\Auto-Winget\Auto-Winget.ps1" https://raw.githubusercontent.com/Sachanime/Auto-winget/main/Auto-Winget.ps1 && set CHECK_1=1
curl -L -o "C:\Program Files\SKL\Auto-Winget\Auto-winget.xml" https://raw.githubusercontent.com/Sachanime/Auto-winget/main/Auto-winget.xml
timeout 1 >nul
echo.

echo Import scheduled task...
powershell -Command "Register-ScheduledTask -Xml (Get-Content 'C:\Program Files\SKL\Auto-Winget\Auto-winget.xml' -Raw) -TaskName 'Auto-Winget'" && set CHECK_2=1
timeout 1 >nul
echo.

if %CHECK_1%==1 ( 

    if %CHECK_2%==1 ( echo Operation successful ) else ( echo Operation failed )

) else ( echo Operation failed )

echo.
echo Thanks for using SKL Programs!
timeout -1 >nul