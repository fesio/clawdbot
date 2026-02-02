#!/usr/bin/env bash
# Simple Android build and install script
# Usage: ./scripts/build-android.sh [debug|release] [install]

set -e

cd "$(dirname "$0")/../apps/android"

BUILD_TYPE="${1:-debug}"
INSTALL="${2:-}"

echo "🤖 Building Clawdbot Android app..."
echo ""

# Validate build type
if [[ "$BUILD_TYPE" != "debug" && "$BUILD_TYPE" != "release" ]]; then
    echo "Error: Invalid build type '$BUILD_TYPE'. Use 'debug' or 'release'."
    exit 1
fi

# Build
if [ "$BUILD_TYPE" = "debug" ]; then
    echo "📦 Building debug APK..."
    ./gradlew :app:assembleDebug
    APK_PATH="app/build/outputs/apk/debug/clawdbot-*-debug.apk"
else
    echo "📦 Building release APK..."
    ./gradlew :app:assembleRelease
    APK_PATH="app/build/outputs/apk/release/clawdbot-*-release.apk"
fi

echo ""
echo "✅ Build complete!"
echo ""

# Find the APK
APK_FILE=$(ls -t $APK_PATH 2>/dev/null | head -n 1)

if [ -z "$APK_FILE" ]; then
    echo "⚠️  Warning: Could not find built APK"
    exit 1
fi

echo "📱 APK location: $APK_FILE"
APK_SIZE=$(du -h "$APK_FILE" | cut -f1)
echo "📏 APK size: $APK_SIZE"
echo ""

# Install if requested
if [ "$INSTALL" = "install" ]; then
    echo "📲 Installing on connected device..."
    
    # Check if device is connected
    if ! command -v adb &> /dev/null; then
        echo "❌ Error: adb not found. Make sure Android SDK platform-tools are in your PATH."
        exit 1
    fi
    
    DEVICES=$(adb devices | grep -v "List of devices" | grep -v "^$" | wc -l)
    if [ "$DEVICES" -eq 0 ]; then
        echo "❌ Error: No devices connected."
        echo "   Connect your device via USB and enable USB debugging."
        exit 1
    fi
    
    if [ "$BUILD_TYPE" = "debug" ]; then
        ./gradlew :app:installDebug
    else
        adb install -r "$APK_FILE"
    fi
    
    echo ""
    echo "✅ App installed successfully!"
    echo ""
    echo "🚀 You can now:"
    echo "   1. Launch the Clawdbot app on your device"
    echo "   2. Connect to your gateway (see docs.clawd.bot/platforms/android)"
else
    echo "💡 To install on a connected device, run:"
    echo "   ./scripts/build-android.sh $BUILD_TYPE install"
    echo ""
    echo "   Or use Gradle directly:"
    echo "   cd apps/android && ./gradlew :app:install${BUILD_TYPE^}"
fi

echo ""
