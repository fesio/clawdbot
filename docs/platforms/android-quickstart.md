---
summary: "Quick start guide for installing and running Clawdbot on your Android phone"
---

# Android Quick Start Guide

This guide helps you get Clawdbot running on your Android phone quickly.

## Prerequisites

- Android phone with Android 12 (API 31) or higher
- A computer running the Gateway (macOS, Linux, or Windows with WSL2)
- Both devices on the same network OR connected via Tailscale

## Option 1: Install Pre-built APK (Recommended)

If you don't want to build from source, you can use a pre-built APK:

1. **Download the APK** from the latest release on GitHub
2. **Enable installation from unknown sources:**
   - Go to Settings → Security → Unknown Sources
   - Or Settings → Apps → Special access → Install unknown apps
   - Allow your browser or file manager to install apps
3. **Install the APK** by tapping on the downloaded file
4. **Grant permissions** when prompted (camera, notifications, etc.)

## Option 2: Build from Source

### Setup Android Development Environment

1. **Install Android Studio** from https://developer.android.com/studio
2. **Install Android SDK:**
   - Open Android Studio
   - Go to Tools → SDK Manager
   - Install Android SDK Platform 36 (or latest)
   - Install Android SDK Build-Tools
3. **Set environment variables** (optional):
   ```bash
   export ANDROID_HOME=$HOME/Library/Android/sdk  # macOS
   # or
   export ANDROID_HOME=$HOME/Android/Sdk  # Linux
   ```

### Build the APK

1. **Clone the repository:**
   ```bash
   git clone https://github.com/clawdbot/clawdbot.git
   cd clawdbot
   ```

2. **Build the debug APK:**
   ```bash
   cd apps/android
   ./gradlew :app:assembleDebug
   ```

3. **Find the APK:**
   The APK will be located at:
   ```
   apps/android/app/build/outputs/apk/debug/clawdbot-2026.1.25-debug.apk
   ```

4. **Install on your phone:**
   ```bash
   # Connect your phone via USB and enable USB debugging
   ./gradlew :app:installDebug
   
   # Or transfer the APK file to your phone and install manually
   ```

## Setting Up the Gateway

Before using the Android app, you need a Gateway running on another computer.

### Start the Gateway

On your computer (macOS/Linux/Windows WSL2):

```bash
# Install clawdbot CLI
npm install -g clawdbot

# Start the gateway
clawdbot gateway --port 18789 --verbose
```

The gateway will start and listen on `ws://0.0.0.0:18789`.

### For Tailscale Users (Remote Setup)

If your phone and computer are in different locations but connected via Tailscale:

1. **Bind gateway to Tailscale:**
   ```bash
   clawdbot config set gateway.bind tailnet
   ```

2. **Restart the gateway:**
   ```bash
   clawdbot gateway --port 18789
   ```

## Connecting Your Android Phone

### Step 1: Open the Clawdbot App

Launch the Clawdbot app on your Android phone.

### Step 2: Connect to Gateway

#### Automatic Discovery (Local Network)

1. Tap **Settings** in the app
2. Look under **Discovered Gateways**
3. Select your gateway from the list
4. Tap **Connect**

#### Manual Connection (Tailscale or if discovery doesn't work)

1. Tap **Settings** → **Advanced** → **Manual Gateway**
2. Enter gateway details:
   - **Host:** Your computer's IP address or hostname
     - Local: `192.168.1.x` or `<hostname>.local`
     - Tailscale: Use MagicDNS name or Tailscale IP
   - **Port:** `18789`
3. Tap **Connect (Manual)**

### Step 3: Approve Pairing

On your computer, run:

```bash
# List pending connection requests
clawdbot nodes pending

# Approve your Android device
clawdbot nodes approve <requestId>
```

### Step 4: Verify Connection

Check that your Android device is connected:

```bash
clawdbot nodes status
```

You should see your Android device listed as a connected node.

## Using the App

Once connected, you can:

### Chat

- Tap **Chat** to open the chat interface
- Send messages to your AI assistant
- View chat history (shared across all devices)

### Canvas

Display web content or custom UI:

```bash
# From your computer, send content to the Android canvas
clawdbot nodes invoke --node "Android Node" --command canvas.navigate --params '{"url":"http://<gateway-host>:18793/__clawdbot__/canvas/"}'
```

### Camera

Use your phone's camera:

```bash
# Take a photo
clawdbot nodes invoke --node "Android Node" --command camera.snap

# Record a video
clawdbot nodes invoke --node "Android Node" --command camera.clip --params '{"duration":5}'
```

## Troubleshooting

### Can't find gateway on network

1. **Check both devices are on same network:**
   ```bash
   # On computer, check gateway is running
   netstat -an | grep 18789
   ```

2. **Try manual connection** with IP address instead of hostname

3. **Check firewall settings** - ensure port 18789 is not blocked

### Permission denied

Grant required permissions in Android Settings → Apps → Clawdbot:
- Camera (for camera features)
- Notifications (for foreground service)
- Nearby devices (for gateway discovery on Android 13+)
- Location (for gateway discovery on Android 12 and below)

### Connection keeps dropping

The app uses a foreground service to maintain connection. If you see the persistent notification disappear, restart the app.

### Build fails

If building from source fails:
- Ensure you have Android SDK Platform 36 installed
- Check you have Java 17 installed: `java -version`
- Try cleaning and rebuilding:
  ```bash
  cd apps/android
  ./gradlew clean
  ./gradlew :app:assembleDebug
  ```

## Next Steps

- Read the full [Android platform documentation](/platforms/android)
- Learn about [gateway configuration](/gateway/configuration)
- Explore [camera commands](/nodes/camera)
- Set up [Voice Wake features](/features/voice-wake)

## Getting Help

- Check [GitHub Issues](https://github.com/clawdbot/clawdbot/issues)
- Read the [troubleshooting guide](/troubleshooting)
- Join the community discussions
