sudo config --enable normal
mkdir "C:\Program Files\SKL\Auto-Winget"
curl -L -o "C:\Program Files\SKL\Auto-Winget\Auto-Winget.ps1" https://raw.githubusercontent.com/Sachanime/Auto-winget/main/Auto-Winget.ps1
curl -L -o "C:\Program Files\SKL\Auto-Winget\Auto-winget.xml" https://raw.githubusercontent.com/Sachanime/Auto-winget/main/Auto-winget.xml
powershell -Command "Register-ScheduledTask -Xml (Get-Content 'C:\Program Files\SKL\Auto-Winget\Auto-winget.xml' -Raw) -TaskName 'Auto-Winget'"
pause