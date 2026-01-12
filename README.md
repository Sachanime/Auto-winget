# Auto-winget
Script for automate softwares updates with Winget

[![GitHub Release](https://img.shields.io/github/v/release/Sachanime/Auto-winget?logo=Github)](https://github.com/Sachanime/Auto-winget/releases)

> \[!WARNING]\
This program is not compatible with PowerShell 7 and some softwares
> 
> Please read [issues](https://github.com/Sachanime/Auto-winget/issues) for more details

## How to use

Download latest release of [SKL Installer](https://github.com/Sachanime/SKL-Installer) and select "Auto-Winegt"

The script will automaticaly download the scheduled task and the powershell script and install it on your system

## File location

The powershell script and the XML scheduled task file are located in `C:\Program Files\SKL\Auto-Winget`

## How to etit

You can edit the powershell script with **Windows Powershell ISE**

You can edit the scheduled task with the task scheduler accessible with the commande `taskschd.msc` in the Run window, but the XML file is only required on installation and beacame usleess after that. You can delete this file if you want
