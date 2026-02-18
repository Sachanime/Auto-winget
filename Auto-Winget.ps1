Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinAPI {

    [DllImport("kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll")]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter,
        int X, int Y, int cx, int cy, uint uFlags);

    public static readonly IntPtr HWND_BOTTOM = new IntPtr(1);
    public const UInt32 SWP_NOMOVE = 0x0002;
    public const UInt32 SWP_NOSIZE = 0x0001;
    public const UInt32 SWP_NOACTIVATE = 0x0010;

}
"@

$hwnd = [WinAPI]::GetConsoleWindow()

if ($hwnd -ne [IntPtr]::Zero) {

    [WinAPI]::SetWindowPos($hwnd, [WinAPI]::HWND_BOTTOM, 0, 0, 0, 0,
    [WinAPI]::SWP_NOMOVE -bor [WinAPI]::SWP_NOSIZE -bor [WinAPI]::SWP_NOACTIVATE)

} 

else {

    Write-Host "Impossible de récupérer le handle de la console." -ForegroundColor Red
    
}

# Discord Patch
if(winget upgrade --id Discord.Discord --include-unknown 2>&1 -match "Version") {

    Write-Host ""
    Write-Host "Discord installation detected, adding to pin list..." -ForegroundColor Blue
    Write-Host ""
    Start-Sleep 1

    winget pin add --id Discord.Discord
    Write-Host ""
    Write-Host "Discord has been added to pin list" -ForegroundColor Green
    Write-Host ""
    Start-Sleep 1

}

# Epic Games Patch
if(winget upgrade --id EpicGames.EpicGamesLauncher --include-unknown 2>&1 -match "Version") {

    Write-Host "An Epic Games Launcher update was detected, the proccess will be killed !" -ForegroundColor DarkYellow
    Start-Sleep 5
    
    Write-Host "Killing proccess..." -ForegroundColor Blue
    Write-Host ""
    Start-Sleep 1

    taskkill /F /IM EpicGamesLauncher.exe

    Write-Host ""
    Write-Host "Epic Games Launcher proccess has been killed" -ForegroundColor Green
    Write-Host ""

}

pwsh <# -WindowStyle hidden #> -Command {winget upgrade --all --include-unknown --accept-package-agreements --accept-source-agreements --silent}

# Roblox Patch
if(winget upgrade --id Roblox.Roblox --include-unknown 2>&1 -match "Version") {

    $RobloxRegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\roblox-player"
    $RobloxRegObject = Get-ItemProperty -Path $RobloxRegPath
    $RobloxPlayer = $RobloxRegObject.InstallLocation + "\RobloxPlayerBeta.exe"
    $RobloxVersion = (Get-Item $RobloxPlayer).VersionInfo.FileVersion -replace ', ', '.'

    Write-Host ""
    Write-Host "Roblox installation detected, patching Windows Registry..." -ForegroundColor Blue
    Write-Host ""
    Start-Sleep 1

    $RobloxRegPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\roblox-player"
    REG ADD $RobloxRegPath /v DisplayVersion /t REG_SZ /d $RobloxVersion /f

    Write-Host ""
    Write-Host "Windows Registry has been patched for Roblox" -ForegroundColor Green
    Write-Host ""
    Start-Sleep 3

}

# Corsair iCUE Patch
if(winget upgrade --id Corsair.iCUE.5 --include-unknown 2>&1 -match "Version") {

    $SetupUrl = "https://www3.corsair.com/software/CUE_V5/public/modules/windows/installer/Install%20iCUE.exe"
    $SetupPath = "C:\Program Files\SKL\Auto-Winget\iCUESetup.exe"

    Write-Host "A Corsair iCUE5 Software update was detected" -ForegroundColor DarkYellow
    Write-Host "Your attention is required !" -ForegroundColor DarkYellow
    Write-Host "You must follow the following steps :" -ForegroundColor Blue
    Write-Host ""
    Write-Host "1) Select language and click on Next" -ForegroundColor Blue
    Write-Host "2) Click on repair and wait unitl the installation is completely finished" -ForegroundColor Blue
    Write-Host "3) When the installation is finished, click on Finish" -ForegroundColor Blue
    Write-Host ""
    Start-Sleep 5

    Write-Host "Downloading setup..." -ForegroundColor Blue
    Write-Host ""
    Start-Sleep 1
    curl --output $SetupPath $SetupUrl

    Write-Host ""
    Write-Host "Starting setup..." -ForegroundColor Blue
    Start-Sleep 1
    Start-Process $SetupPath -Wait

    Write-Host "Deleting setup..." -ForegroundColor Blue
    Start-Sleep 1
    Remove-Item $SetupPath

    Write-Host "Verification..." -ForegroundColor Blue
    Write-Host ""
    Start-Sleep 3

    if(winget upgrade --id Corsair.iCUE.5 --include-unknown 2>&1 -match "Version") {
        Write-Host "Corsair iCUE was not updated correctly" -ForegroundColor DarkRed
        Write-Host "You can open a new issue on the project's Github repository at https://github.com/Sachanime/Auto-winget/issues" -ForegroundColor DarkRed
        Write-Host ""
    }

    else{
        Write-Host "Corsair iCUE has been updated" -ForegroundColor Green
        Write-Host ""
    }
    
}

winget upgrade --include-unknown --wait