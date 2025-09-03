# Android TV Deployment Script
# Deploy TvINstallTest MAUI Blazor App to Android TV at 192.168.1.44

Write-Host "=== Android TV Deployment Script ===" -ForegroundColor Green
Write-Host "Target Device: 192.168.1.44" -ForegroundColor Yellow

# Step 1: Connect to Android TV
Write-Host "`n1. Connecting to Android TV..." -ForegroundColor Cyan
adb connect 192.168.1.44:5555

# Step 2: Verify connection
Write-Host "`n2. Verifying connection..." -ForegroundColor Cyan
adb devices

# Step 3: Uninstall previous version (if exists)
Write-Host "`n3. Removing previous version (if exists)..." -ForegroundColor Cyan
adb -s 192.168.1.44:5555 uninstall com.companyname.tvinstalltest 2>$null

# Step 4: Install new APK
Write-Host "`n4. Installing new APK..." -ForegroundColor Cyan
$apkPath = "bin\Release\net8.0-android\com.companyname.tvinstalltest-Signed.apk"
if (Test-Path $apkPath) {
    adb -s 192.168.1.44:5555 install -r $apkPath
    Write-Host "✅ APK installed successfully!" -ForegroundColor Green
}
else {
    Write-Host "❌ APK not found. Please build the project first." -ForegroundColor Red
    exit 1
}

# Step 5: Verify installation
Write-Host "`n5. Verifying installation..." -ForegroundColor Cyan
$installed = adb -s 192.168.1.44:5555 shell pm list packages com.companyname.tvinstalltest
if ($installed -match "com.companyname.tvinstalltest") {
    Write-Host "✅ App verified as installed!" -ForegroundColor Green
}
else {
    Write-Host "❌ Installation verification failed!" -ForegroundColor Red
    exit 1
}

# Step 6: Launch the app
Write-Host "`n6. Launching app on Android TV..." -ForegroundColor Cyan
adb -s 192.168.1.44:5555 shell monkey -p com.companyname.tvinstalltest -c android.intent.category.LAUNCHER 1 >$null 2>&1

Write-Host "`n🎉 Deployment complete!" -ForegroundColor Green
Write-Host "The TvINstallTest app should now be running on your Android TV." -ForegroundColor Yellow
Write-Host "`nApp Features:" -ForegroundColor Cyan
Write-Host "• Use TV remote arrow keys to navigate flag selection" -ForegroundColor White
Write-Host "• Press Enter/OK to view fullscreen waving flag" -ForegroundColor White
Write-Host "• Press Back button to return to flag selection" -ForegroundColor White
Write-Host "• Enjoy the enhanced CSS waving flag animations!" -ForegroundColor White

Write-Host "`nTroubleshooting Commands:" -ForegroundColor Cyan
Write-Host "• View logs: adb -s 192.168.1.44:5555 logcat | findstr TvINstallTest" -ForegroundColor Gray
Write-Host "• Force stop: adb -s 192.168.1.44:5555 shell am force-stop com.companyname.tvinstalltest" -ForegroundColor Gray
Write-Host "• Clear data: adb -s 192.168.1.44:5555 shell pm clear com.companyname.tvinstalltest" -ForegroundColor Gray
