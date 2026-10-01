# Railway Reservation System - Windows Setup
# SE Mini Project - Team 2

# Note: Open PowerShell as Administrator and run the following commands to allow script execution:
# Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
# .\setup-windows.ps1

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "============================================================"
Write-Host " Railway Reservation System - Development Setup"
Write-Host "============================================================"
Write-Host ""

# 1. Check winget

Write-Host "[1/6] Checking Windows Package Manager..."

if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "winget found."
}
else {
    Write-Host "winget was not found."
    Write-Host "Please install/update App Installer from Microsoft Store."
    exit 1
}

# 2. Install Git

Write-Host ""
Write-Host "[2/6] Checking Git..."

if (Get-Command git -ErrorAction SilentlyContinue) {
    Write-Host "Git already installed."
}
else {
    Write-Host "Installing Git..."
    winget install --id Git.Git -e --source winget
}

# 3. Install CMake

Write-Host ""
Write-Host "[3/6] Checking CMake..."

if (Get-Command cmake -ErrorAction SilentlyContinue) {
    Write-Host "CMake already installed."
}
else {
    Write-Host "Installing CMake..."
    winget install --id Kitware.CMake -e --source winget
}

# 4. Install MSYS2

Write-Host ""
Write-Host "[4/6] Checking MSYS2..."

if (Test-Path "C:\msys64") {
    Write-Host "MSYS2 already installed."
}
else {
    Write-Host "Installing MSYS2..."
    winget install --id MSYS2.MSYS2 -e --source winget
}

# 5. Check GCC

Write-Host ""
Write-Host "[5/6] Checking GCC/G++..."

$gccPath = "C:\msys64\ucrt64\bin"

if (Test-Path "$gccPath\g++.exe") {
    Write-Host "G++ found at:"
    Write-Host "$gccPath"
}
else {
    Write-Host ""
    Write-Host "G++ is not installed yet."
    Write-Host ""
    Write-Host "Open MSYS2 UCRT64 and run:"
    Write-Host ""
    Write-Host "pacman -Syu"
    Write-Host ""
    Write-Host "Then, if requested, close and reopen MSYS2 UCRT64."
    Write-Host "After reopening, run:"
    Write-Host ""
    Write-Host "pacman -Su"
    Write-Host ""
    Write-Host "Then install GCC and build tools:"
    Write-Host ""
    Write-Host "pacman -S --needed mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-cmake mingw-w64-ucrt-x86_64-make"
    Write-Host ""
}

# 6. Add MSYS2 UCRT64 to PATH

Write-Host ""
Write-Host "[6/6] Checking MSYS2 UCRT64 PATH..."

$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($currentPath -notlike "*C:\msys64\ucrt64\bin*") {

    if (Test-Path "C:\msys64\ucrt64\bin") {

        Write-Host "Adding MSYS2 UCRT64 to User PATH..."

        [Environment]::SetEnvironmentVariable(
            "Path",
            "$currentPath;C:\msys64\ucrt64\bin",
            "User"
        )

        Write-Host "PATH updated."
        Write-Host "Please close and reopen PowerShell."
    }
}
else {
    Write-Host "MSYS2 UCRT64 already exists in PATH."
}

# Final verification

Write-Host ""
Write-Host "============================================================"
Write-Host " Setup Check"
Write-Host "============================================================"
Write-Host ""

Write-Host "Git:"
if (Get-Command git -ErrorAction SilentlyContinue) {
    git --version
}
else {
    Write-Host "Not available in current terminal."
}

Write-Host ""
Write-Host "CMake:"
if (Get-Command cmake -ErrorAction SilentlyContinue) {
    cmake --version
}
else {
    Write-Host "Not available in current terminal."
}

Write-Host ""
Write-Host "G++:"
if (Get-Command g++ -ErrorAction SilentlyContinue) {
    g++ --version
}
else {
    Write-Host "Not available in current terminal."
}

Write-Host ""
Write-Host "============================================================"
Write-Host " Initial setup/check completed."
Write-Host "============================================================"
Write-Host ""