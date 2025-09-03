# Android TV Deployment Guide

## Target Device Information

- **Device IP**: 192.168.1.44
- **Device Type**: Android TV
- **Target Platform**: Android (.NET 8.0)

## APK Build Information

- **App Name**: TvINstallTest
- **Package Name**: com.companyname.tvinstalltest
- **Framework**: .NET MAUI Blazor Hybrid
- **Target Framework**: net8.0-android

## Available APK Files

### Debug Build

- `bin/Debug/net8.0-android/com.companyname.tvinstalltest-Signed.apk` - Signed debug APK
- `bin/Debug/net8.0-android/com.companyname.tvinstalltest.apk` - Unsigned debug APK

### Release Build

- `bin/Release/net8.0-android/com.companyname.tvinstalltest-Signed.apk` - Signed release APK (recommended for deployment)
- `bin/Release/net8.0-android/com.companyname.tvinstalltest-Signed.aab` - Android App Bundle

## Prerequisites

1. **ADB (Android Debug Bridge)** must be installed and accessible from command line
2. **Developer Options** enabled on Android TV
3. **USB Debugging** enabled on Android TV
4. **Network ADB** enabled on Android TV (for wireless deployment)

## Deployment Steps

### Step 1: Connect to Android TV via ADB

```powershell
# Connect to the Android TV device
adb connect 192.168.1.44:5555

# Verify connection
adb devices
```

### Step 2: Install the APK

```powershell
# For Release build (recommended)
adb -s 192.168.1.44:5555 install -r "bin/Release/net8.0-android/com.companyname.tvinstalltest-Signed.apk"

# Alternative: For Debug build
adb -s 192.168.1.44:5555 install -r "bin/Debug/net8.0-android/com.companyname.tvinstalltest-Signed.apk"
```

### Step 3: Launch the Application

```powershell
# Launch the app on the TV
adb -s 192.168.1.44:5555 shell am start -n com.companyname.tvinstalltest/crc64338477404e88479c.MainActivity
```

### Step 4: Verify Installation

```powershell
# Check if app is installed
adb -s 192.168.1.44:5555 shell pm list packages | findstr tvinstalltest

# Get app information
adb -s 192.168.1.44:5555 shell dumpsys package com.companyname.tvinstalltest
```

## Troubleshooting Commands

### Uninstall Previous Version

```powershell
adb -s 192.168.1.44:5555 uninstall com.companyname.tvinstalltest
```

### Force Stop Application

```powershell
adb -s 192.168.1.44:5555 shell am force-stop com.companyname.tvinstalltest
```

### Clear App Data

```powershell
adb -s 192.168.1.44:5555 shell pm clear com.companyname.tvinstalltest
```

### View Logcat for Debugging

```powershell
adb -s 192.168.1.44:5555 logcat | findstr "TvINstallTest"
```

## Android TV Specific Considerations

1. **Remote Control Navigation**: App supports arrow keys and Enter button
2. **Focus Management**: Ensure proper focus handling for TV interface
3. **Display Scaling**: App is responsive and works on TV screen sizes
4. **Performance**: Release build recommended for smooth TV experience

## App Features for TV

- ✅ Flag selection with remote control navigation (arrow keys)
- ✅ Fullscreen flag display with waving animations
- ✅ Back navigation (Backspace/Escape keys)
- ✅ Optimized for large screen display
- ✅ Touch and remote control compatible

## Network Information

- **Local Network**: 192.168.1.x
- **ADB Port**: 5555 (default)
- **Connection Type**: WiFi/Ethernet

## Build Information

- **Last Build**: Release configuration
- **Signing**: Automatically signed APK available
- **Deployment Method**: ADB over network

## Post-Deployment Testing

1. Use TV remote to navigate flag selection
2. Test arrow keys (Up/Down) for selection
3. Press Enter to view fullscreen flag
4. Test back navigation with remote back button
5. Verify waving flag animations are smooth on TV hardware
