#!/usr/bin/env bash
set -e

echo "========================================="
echo " Building Ripal Design Flutter Web Release "
echo "========================================="

echo "1. Cleaning previous build output..."
flutter clean

echo "2. Fetching packages..."
flutter pub get

echo "3. Building web release with source maps and tree shaking..."
flutter build web --release --source-maps --tree-shake-icons

echo "========================================="
echo " Web build completed successfully!"
echo " Output directory: build/web/"
echo "========================================="
