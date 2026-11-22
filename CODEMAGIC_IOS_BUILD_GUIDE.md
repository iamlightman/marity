# Marity Trade — Codemagic iOS App Build & Deployment Guide

This guide details the complete configuration for building and releasing the official **Marity Trade** iOS application on **Codemagic CI/CD**.

---

## ✦ What Was Built & Configured

1. **Capacitor Mobile Architecture (`package.json`, `capacitor.config.json`)**:
   - Bundle ID: `com.marity.trade`
   - App Name: `Marity Trade`
   - Web Directory: `public` (clean production bundle containing HTML, CSS, JS, and high-res assets)
   - Status Bar: Dark content, full-bleed safe area integration
   - Splash Screen: Autohide after 1.2s on luxury `#11151F` onyx background

2. **Official Apple App Assets (`tools/ios_assets/` & `ios/App/App/Assets.xcassets/`)**:
   - **`AppIcon.appiconset`**: Full suite of iOS App Icons including 1024×1024 App Store icon, 180×180 (@3x), 120×120 (@2x), etc. Handcrafted with the authentic Marity logo on solid deep onyx background (0% transparency per Apple App Store requirements).
   - **`Splash.imageset`**: High-resolution universal splash screens (@1x, @2x, @3x) matching the brand aesthetic.
   - **`Info.plist`**: Configured with bundle ID `com.marity.trade`, display name `Marity Trade`, portrait orientation lock, and `ITSAppUsesNonExemptEncryption = false`.

3. **Codemagic CI/CD Pipeline (`codemagic.yaml`)**:
   - **`ios-release`**: Full App Store / TestFlight pipeline with automatic provisioning and signed `.ipa` generation.
   - **`ios-debug`**: Fast Simulator pipeline that builds without needing Apple Developer certificates, producing `MarityTrade-Simulator.app.zip`.

4. **Automated Bundle Script (`tools/prepare_ios_bundle.js`)**:
   - Runs `npm run build` to package clean web assets into `public/` before iOS compilation.

---

## ✦ How to Build on Codemagic in 3 Simple Steps

### Step 1: Push Code to Your Git Repository
Push this project to your GitHub, GitLab, or Bitbucket repository:
```bash
git init
git add .
git commit -m "Configure Marity Trade iOS build for Codemagic"
git branch -M main
git remote add origin <YOUR_REPOSITORY_URL>
git push -u origin main
```

### Step 2: Connect Repository to Codemagic
1. Log in to [Codemagic](https://codemagic.io/).
2. Click **Add application**.
3. Select your Git provider (GitHub / GitLab / Bitbucket) and choose the `marity-trade` repository.
4. Codemagic will automatically detect [`codemagic.yaml`](file:///c:/xampp/htdocs/c%20eye%20q%20portfolio/portfolio/web%20pro%20import%20old%20pc/marity%20app%20demo/codemagic.yaml) in the root of the project.

### Step 3: Start the Build

#### Option A: Simulator / Verification Build (No Apple Developer account needed)
1. Select the **Marity Trade — iOS Simulator Build (No Certs Required)** workflow (`ios-debug`).
2. Click **Start new build**.
3. Codemagic spins up a macOS M2 runner, compiles the Capacitor iOS project with `xcodebuild`, and outputs `MarityTrade-Simulator.app.zip`.
4. You can download the artifact and drag it onto the macOS Xcode Simulator to test immediately!

#### Option B: Official App Store / TestFlight Release (`ios-release`)
1. In Codemagic, go to **Team settings > Integrations > Apple Developer Portal**.
2. Connect your **App Store Connect API key** (Issuer ID, Key ID, and `.p8` file).
3. Select the **Marity Trade — iOS Release (App Store / TestFlight)** workflow (`ios-release`).
4. Click **Start new build**.
5. Codemagic automatically signs the binary, increments the build number with `agvtool`, and produces the signed `App.ipa` ready for TestFlight / App Store submission!

---

## ✦ File Structure Summary

```text
├── codemagic.yaml               # Codemagic CI/CD configuration (ios-release & ios-debug)
├── package.json                 # Capacitor dependencies and build scripts
├── capacitor.config.json        # Capacitor iOS configuration (com.marity.trade)
├── public/                      # Compiled production web bundle for WKWebView
├── tools/
│   ├── prepare_ios_bundle.js    # Node script that bundles client files into public/
│   ├── generate_ios_icons.ps1   # PowerShell generator for 1024x1024 + iOS icons
│   ├── generate_ios_splash.ps1  # PowerShell generator for Splash screens
│   └── ios_assets/              # Preserved AppIcon & Splash image sets
└── ios/
    └── App/
        ├── App/
        │   ├── AppDelegate.swift
        │   ├── Info.plist
        │   ├── Assets.xcassets/
        │   └── Base.lproj/
        └── Podfile
```
