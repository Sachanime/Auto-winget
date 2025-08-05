sudo config --enable normal
mkdir "C:\Program Files\SKL\Auto-Winget"
curl -L -o "C:\Program Files\SKL\Auto-Winget\Auto-Winget.ps1" https://raw.githubusercontent.com/Sachanime/Auto-winget/main/Auto-Winget.ps1
curl -L -o "C:\Program Files\SKL\Auto-Winget\Auto-winget.xml" https://raw.githubusercontent.com/Sachanime/Auto-winget/main/Auto-winget.xml
powershell Register-ScheduledTask -Xml (Get-Content "C:\Program Files\SKL\Auto-Winget\Auto-winget.xml" | Out-String) -TaskName "Auto-Winget"
pause