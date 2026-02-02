#!/usr/bin/env bash
# Android development environment check script
# Verifies all prerequisites for building the Clawdbot Android app

set -e

echo "🔍 Checking Android development environment..."
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track if all checks pass
ALL_OK=true

# Check Java
echo "📦 Checking Java..."
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | awk -F '.' '{print $1}')
    if [ "$JAVA_VERSION" -ge 17 ]; then
        echo -e "${GREEN}✓${NC} Java $JAVA_VERSION found"
    else
        echo -e "${RED}✗${NC} Java version is too old. Need Java 17+, found version $JAVA_VERSION"
        echo "  Install: brew install openjdk@17 (macOS) or apt install openjdk-17-jdk (Linux)"
        ALL_OK=false
    fi
else
    echo -e "${RED}✗${NC} Java not found"
    echo "  Install: brew install openjdk@17 (macOS) or apt install openjdk-17-jdk (Linux)"
    ALL_OK=false
fi
echo ""

# Check Android SDK
echo "📱 Checking Android SDK..."
if [ -n "$ANDROID_SDK_ROOT" ]; then
    if [ -d "$ANDROID_SDK_ROOT" ]; then
        echo -e "${GREEN}✓${NC} ANDROID_SDK_ROOT is set: $ANDROID_SDK_ROOT"
    else
        echo -e "${YELLOW}⚠${NC} ANDROID_SDK_ROOT is set but directory doesn't exist: $ANDROID_SDK_ROOT"
        ALL_OK=false
    fi
elif [ -n "$ANDROID_HOME" ]; then
    if [ -d "$ANDROID_HOME" ]; then
        echo -e "${GREEN}✓${NC} ANDROID_HOME is set: $ANDROID_HOME"
        export ANDROID_SDK_ROOT="$ANDROID_HOME"
    else
        echo -e "${YELLOW}⚠${NC} ANDROID_HOME is set but directory doesn't exist: $ANDROID_HOME"
        ALL_OK=false
    fi
else
    # Try default locations
    DEFAULT_LOCATIONS=(
        "$HOME/Library/Android/sdk"
        "$HOME/Android/Sdk"
        "/usr/local/android-sdk"
    )
    
    SDK_FOUND=false
    for SDK_PATH in "${DEFAULT_LOCATIONS[@]}"; do
        if [ -d "$SDK_PATH" ]; then
            echo -e "${GREEN}✓${NC} Android SDK found at: $SDK_PATH"
            export ANDROID_SDK_ROOT="$SDK_PATH"
            SDK_FOUND=true
            break
        fi
    done
    
    if [ "$SDK_FOUND" = false ]; then
        echo -e "${RED}✗${NC} Android SDK not found"
        echo "  Install Android Studio or set ANDROID_SDK_ROOT environment variable"
        echo "  See: https://docs.clawd.bot/platforms/android-setup"
        ALL_OK=false
    fi
fi
echo ""

# Check platform-tools (adb)
echo "🔧 Checking Android platform tools..."
if command -v adb &> /dev/null; then
    ADB_VERSION=$(adb version | head -n 1)
    echo -e "${GREEN}✓${NC} adb found: $ADB_VERSION"
else
    if [ -n "$ANDROID_SDK_ROOT" ] && [ -f "$ANDROID_SDK_ROOT/platform-tools/adb" ]; then
        echo -e "${YELLOW}⚠${NC} adb found but not in PATH"
        echo "  Add to PATH: export PATH=\$ANDROID_SDK_ROOT/platform-tools:\$PATH"
    else
        echo -e "${RED}✗${NC} adb not found"
        echo "  Install via Android Studio or: sdkmanager platform-tools"
        ALL_OK=false
    fi
fi
echo ""

# Check build tools
echo "🏗️  Checking Android build tools..."
if [ -n "$ANDROID_SDK_ROOT" ] && [ -d "$ANDROID_SDK_ROOT/build-tools" ]; then
    BUILD_TOOLS_VERSIONS=$(ls -1 "$ANDROID_SDK_ROOT/build-tools" 2>/dev/null | sort -V -r)
    if [ -n "$BUILD_TOOLS_VERSIONS" ]; then
        LATEST_BUILD_TOOLS=$(echo "$BUILD_TOOLS_VERSIONS" | head -n 1)
        echo -e "${GREEN}✓${NC} Android build tools found (latest: $LATEST_BUILD_TOOLS)"
    else
        echo -e "${RED}✗${NC} No build tools found in $ANDROID_SDK_ROOT/build-tools"
        echo "  Install via: sdkmanager \"build-tools;36.0.0\""
        ALL_OK=false
    fi
else
    echo -e "${YELLOW}⚠${NC} Could not check build tools (ANDROID_SDK_ROOT not set)"
fi
echo ""

# Check platforms
echo "🎯 Checking Android platforms..."
if [ -n "$ANDROID_SDK_ROOT" ] && [ -d "$ANDROID_SDK_ROOT/platforms" ]; then
    PLATFORMS=$(ls -1 "$ANDROID_SDK_ROOT/platforms" 2>/dev/null | grep -E "android-[0-9]+" | sort -V -r)
    if [ -n "$PLATFORMS" ]; then
        LATEST_PLATFORM=$(echo "$PLATFORMS" | head -n 1)
        PLATFORM_VERSION=$(echo "$LATEST_PLATFORM" | sed 's/android-//')
        if [ "$PLATFORM_VERSION" -ge 31 ]; then
            echo -e "${GREEN}✓${NC} Android platform found: $LATEST_PLATFORM (required: android-31+)"
        else
            echo -e "${YELLOW}⚠${NC} Latest platform is $LATEST_PLATFORM, but android-31+ is recommended"
            echo "  Install via: sdkmanager \"platforms;android-36\""
        fi
    else
        echo -e "${RED}✗${NC} No Android platforms found"
        echo "  Install via: sdkmanager \"platforms;android-36\""
        ALL_OK=false
    fi
else
    echo -e "${YELLOW}⚠${NC} Could not check platforms (ANDROID_SDK_ROOT not set)"
fi
echo ""

# Check for connected devices
echo "📱 Checking for connected devices..."
if command -v adb &> /dev/null; then
    DEVICES=$(adb devices | grep -v "List of devices" | grep -v "^$" | wc -l)
    if [ "$DEVICES" -gt 0 ]; then
        echo -e "${GREEN}✓${NC} Found $DEVICES connected device(s):"
        adb devices | grep -v "List of devices" | grep -v "^$"
    else
        echo -e "${YELLOW}ℹ${NC} No devices connected (this is OK for build-only)"
        echo "  To install on a device, connect via USB and enable USB debugging"
    fi
else
    echo -e "${YELLOW}⚠${NC} Cannot check devices (adb not available)"
fi
echo ""

# Summary
echo "═══════════════════════════════════════════════════════════"
if [ "$ALL_OK" = true ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "You're ready to build the Android app:"
    echo "  cd apps/android"
    echo "  ./gradlew :app:assembleDebug"
    echo ""
    echo "To install on a connected device:"
    echo "  ./gradlew :app:installDebug"
else
    echo -e "${RED}✗ Some checks failed${NC}"
    echo ""
    echo "Please fix the issues above before building."
    echo ""
    echo "For complete setup instructions, see:"
    echo "  https://docs.clawd.bot/platforms/android-setup"
fi
echo "═══════════════════════════════════════════════════════════"
