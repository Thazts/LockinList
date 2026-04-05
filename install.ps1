$ErrorActionPreference = "Stop"

$AppName = "Lock in List"
$DownloadUrl = "https://github.com/Thazts/LockinList/releases/latest/download/LockinList.exe"
$AppFolder = "$env:APPDATA\$AppName"
$DesktopShortcut = "$env:USERPROFILE\Desktop\$AppName.lnk"
$StartupShortcut = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\$AppName.lnk"

Write-Host "Installing $AppName..." -ForegroundColor Cyan

if (!(Test-Path $AppFolder)) {
    New-Item -ItemType Directory -Path $AppFolder -Force | Out-Null
    Write-Host "Created app folder: $AppFolder" -ForegroundColor Green
}

Write-Host "Downloading $AppName..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $DownloadUrl -OutFile "$AppFolder\LockinList.exe"
Write-Host "Downloaded successfully" -ForegroundColor Green

Write-Host "Creating desktop shortcut..." -ForegroundColor Cyan
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($DesktopShortcut)
$Shortcut.TargetPath = "$AppFolder\LockinList.exe"
$Shortcut.WorkingDirectory = $AppFolder
$Shortcut.Description = $AppName
$Shortcut.Save()
Write-Host "Desktop shortcut created" -ForegroundColor Green

Write-Host "Creating startup shortcut..." -ForegroundColor Cyan
$StartupShortcut_Dir = Split-Path $StartupShortcut
if (!(Test-Path $StartupShortcut_Dir)) {
    New-Item -ItemType Directory -Path $StartupShortcut_Dir -Force | Out-Null
}
$Shortcut = $WshShell.CreateShortcut($StartupShortcut)
$Shortcut.TargetPath = "$AppFolder\LockinList.exe"
$Shortcut.WorkingDirectory = $AppFolder
$Shortcut.Arguments = "--minimize"
$Shortcut.Description = "$AppName (Startup)"
$Shortcut.Save()
Write-Host "Startup shortcut created" -ForegroundColor Green

Write-Host "Launching $AppName..." -ForegroundColor Cyan
Start-Process "$AppFolder\LockinList.exe"

Write-Host ""
Write-Host "$AppName installation complete!" -ForegroundColor Green
Write-Host "Desktop shortcut created and app will launch on startup."
