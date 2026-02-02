---
summary: "Complete guide to building and installing the Clawdbot Android app"
read_when:
  - Building the Android app for the first time
  - Setting up Android development environment
  - Installing the app on a physical device or emulator
---

# Android App - Build & Installation Guide

This guide covers everything you need to build and install the Clawdbot Android app on your phone.

## Quick Environment Check

Before starting, you can verify your development environment is ready:

```bash
./scripts/check-android-env.sh
```

This script will check for Java, Android SDK, and connected devices. If any requirements are missing, continue with the prerequisites below.

## Prerequisites

### 1. System Requirements

- **Operating System**: macOS, Linux, or Windows (with WSL2)
- **Java Development Kit (JDK)**: JDK 17 or higher
- **Android SDK**: API level 31 or higher (Android 12+)
- **Gradle**: Included via gradlew wrapper (no separate installation needed)

### 2. Install Java Development Kit (JDK)

The Android build requires JDK 17 or higher.

#### macOS

```bash
brew install openjdk@17
```

After installation, you may need to add it to your PATH:

```bash
echo 'export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

#### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install openjdk-17-jdk
```

#### Verify Java Installation

```bash
java -version
```

You should see output indicating Java 17 or higher.

### 3. Install Android SDK

You have two options: use Android Studio (recommended for beginners) or command-line tools only.

#### Option A: Android Studio (Recommended)

1. Download Android Studio from [developer.android.com](https://developer.android.com/studio)
2. Install Android Studio
3. Launch Android Studio and go through the setup wizard
4. The wizard will install:
   - Android SDK
   - Android SDK Platform (API 31+)
   - Android Build Tools
   - Android Emulator (optional, if you want to test without a physical device)

5. Note the SDK location (usually `~/Library/Android/sdk` on macOS or `~/Android/Sdk` on Linux)

#### Option B: Command-Line Tools Only

If you prefer not to install Android Studio:

**macOS/Linux:**

```bash
# Create SDK directory
mkdir -p ~/Android/Sdk
cd ~/Android/Sdk

# Download command line tools (visit https://developer.android.com/studio for latest URL)
# For macOS:
wget https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip
unzip commandlinetools-mac-11076708_latest.zip

# For Linux:
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-11076708_latest.zip

# Set up environment variables
echo 'export ANDROID_SDK_ROOT=$HOME/Android/Sdk' >> ~/.zshrc  # or ~/.bashrc
echo 'export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH' >> ~/.zshrc
source ~/.zshrc

# Install required SDK components
sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0"
```

### 4. Set Environment Variables

Add these to your shell configuration (`~/.zshrc`, `~/.bashrc`, or `~/.profile`):

```bash
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk  # macOS
# or
export ANDROID_SDK_ROOT=$HOME/Android/Sdk  # Linux

# Optional but recommended:
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
export PATH=$ANDROID_SDK_ROOT/emulator:$PATH
```

Reload your shell configuration:

```bash
source ~/.zshrc  # or source ~/.bashrc
```

## Building the Android App

### Quick Build (Using Helper Script)

The easiest way to build and optionally install the app:

```bash
# Build debug APK only
./scripts/build-android.sh debug

# Build and install on connected device
./scripts/build-android.sh debug install

# Build release APK
./scripts/build-android.sh release
```

### Manual Build (Using Gradle Directly)

#### 1. Navigate to the Android App Directory

```bash
cd /path/to/clawdbot/apps/android
```

#### 2. Build the Debug APK

```bash
./gradlew :app:assembleDebug
```

This will:
- Download all required Gradle dependencies (first time only)
- Compile the Kotlin source code
- Package the app into an APK
- Output file: `app/build/outputs/apk/debug/clawdbot-2026.1.25-debug.apk`

**Note**: The first build may take several minutes as Gradle downloads dependencies.

#### 3. Build the Release APK (Optional)

For a production-ready build:

```bash
./gradlew :app:assembleRelease
```

**Note**: Release builds require signing configuration. For development and testing, use the debug build.

## Installing the App

### Option 1: Install on a Physical Device (Recommended)

#### Enable Developer Options on Your Android Phone

1. Open **Settings** on your Android device
2. Go to **About phone**
3. Tap **Build number** 7 times (you'll see a message saying "You are now a developer")
4. Go back to **Settings** → **System** → **Developer options**
5. Enable **USB debugging**

#### Connect Your Device and Install

1. Connect your Android phone to your computer via USB
2. On your phone, approve the USB debugging connection when prompted

3. Verify the device is connected:

```bash
# The adb tool should be in your PATH after setting ANDROID_SDK_ROOT
adb devices
```

You should see your device listed.

4. Install the app:

```bash
./gradlew :app:installDebug
```

Or manually install the APK:

```bash
adb install app/build/outputs/apk/debug/clawdbot-2026.1.25-debug.apk
```

### Option 2: Install on an Emulator

#### Create an Android Virtual Device (AVD)

If using Android Studio:

1. Open Android Studio
2. Go to **Tools** → **Device Manager**
3. Click **Create Device**
4. Select a device profile (e.g., Pixel 7)
5. Download a system image (API 31 or higher)
6. Finish the wizard

If using command-line tools:

```bash
# List available system images
sdkmanager --list | grep system-images

# Download a system image (example: Android 12)
sdkmanager "system-images;android-31;google_apis;x86_64"

# Create AVD
avdmanager create avd -n ClawdbotTest -k "system-images;android-31;google_apis;x86_64"
```

#### Start the Emulator and Install

```bash
# Start the emulator
emulator -avd ClawdbotTest

# In another terminal, install the app
cd /path/to/clawdbot/apps/android
./gradlew :app:installDebug
```

### Option 3: Transfer APK to Phone Manually

1. Build the APK:
```bash
./gradlew :app:assembleDebug
```

2. Transfer the APK file to your phone:
   - Email it to yourself
   - Upload to cloud storage (Google Drive, Dropbox, etc.)
   - Use USB file transfer

3. On your phone:
   - Open the APK file
   - You may need to enable "Install unknown apps" for your file manager
   - Follow the installation prompts

## Running the App

1. Launch the **Clawdbot** app on your Android device
2. Follow the connection steps in the [Android Connection Guide](/platforms/android)

## Troubleshooting

### "SDK location not found"

The gradlew script auto-detects the Android SDK at common locations:
- macOS: `~/Library/Android/sdk`
- Linux: `~/Android/Sdk`

If your SDK is in a different location, set the environment variable:

```bash
export ANDROID_SDK_ROOT=/path/to/your/android/sdk
```

Or create a `local.properties` file in `apps/android/`:

```properties
sdk.dir=/path/to/your/android/sdk
```

### "adb: command not found"

Add the Android SDK platform-tools to your PATH:

```bash
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
```

### Build Fails with "Java version" Error

Ensure you're using JDK 17:

```bash
java -version
# Should show version 17 or higher
```

If you have multiple Java versions, you may need to set JAVA_HOME:

```bash
export JAVA_HOME=$(/usr/libexec/java_home -v 17)  # macOS
```

### Device Not Recognized

1. Ensure USB debugging is enabled on your phone
2. Try a different USB cable (some cables are charge-only)
3. Revoke USB debugging authorizations on your phone and try again
4. Run `adb kill-server && adb start-server`

### Gradle Build is Slow

First builds are always slower. To speed up subsequent builds:

1. Enable Gradle daemon (should be on by default)
2. Increase Gradle memory in `gradle.properties` (already set to 3GB)
3. Use a faster disk (SSD recommended)

## Next Steps

After successfully installing the app:

1. Set up the Gateway on your master machine - see [Getting Started](/start/getting-started)
2. Connect your Android node to the Gateway - see [Android Connection Guide](/platforms/android)
3. Approve the pairing request - see [Pairing](/gateway/pairing)

## Development Tips

### Running Tests

```bash
./gradlew :app:testDebugUnitTest
```

### Opening in Android Studio

1. Open Android Studio
2. Select **File** → **Open**
3. Navigate to and select the `apps/android` folder
4. Wait for Gradle sync to complete

### Rebuilding the App

After making code changes:

```bash
./gradlew :app:installDebug
```

This will rebuild and reinstall the app on your connected device.

### Viewing Logs

```bash
adb logcat | grep Clawdbot
```

## Additional Resources

- [Android Developer Documentation](https://developer.android.com)
- [Gradle Build Tool](https://gradle.org)
- [Android Debug Bridge (adb)](https://developer.android.com/tools/adb)
