Write-Host "=========================================" -ForegroundColor Cyan
Write-Host " Building Ripal Design Flutter Web Release " -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

Write-Host "1. Cleaning previous build output..." -ForegroundColor Yellow
flutter clean

Write-Host "2. Fetching packages..." -ForegroundColor Yellow
flutter pub get

Write-Host "3. Building web release with source maps and tree shaking..." -ForegroundColor Yellow
flutter build web --release --source-maps --tree-shake-icons

Write-Host "=========================================" -ForegroundColor Green
Write-Host " Web build completed successfully!" -ForegroundColor Green
Write-Host " Output directory: build/web/" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
