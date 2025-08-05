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

    Write-Host "Impossible de récupérer le handle de la console."
    
}

taskkill /F /IM EpicGamesLauncher.exe
sudo powershell -WindowStyle hidden -Command {winget upgrade --all --accept-package-agreements --accept-source-agreements}
winget upgrade --wait