# deploy_web.ps1 - Automated Flutter Web Build & Deploy Script (GPG Signed)
$ErrorActionPreference = "Stop"

$projectRoot = $PSScriptRoot
Set-Location -Path $projectRoot

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "1. Building Flutter Web (Release)..." -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan

flutter build web --release

if ($LASTEXITCODE -ne 0) {
    Write-Host "X Flutter build failed!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "2. Pushing web build to Gitea (web-dist branch)..." -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan

Set-Location -Path "$projectRoot\build\web"

if (-not (Test-Path ".git")) {
    git init
    git remote add gitea http://192.168.1.64:8087/gitea/Ripal-Design-Flutter.git
}

git checkout -B web-dist
git add -A
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Sign commit with GPG key as required by server security policy
git commit -S -m "build: deploy flutter web release [$timestamp]"

git push -f gitea web-dist

Set-Location -Path $projectRoot

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Web release successfully built, GPG-signed, and pushed to Gitea (web-dist)!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
