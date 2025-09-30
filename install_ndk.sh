#!/bin/bash
# install_ndk.sh
# 
# --------------------------------------------------------------------
# Script Purpose:
# This script resolves the error related to missing or unconfigured NDK 
# when building a Flutter project.
#
# Error Message:
# `NDK not configured. Download it with the SDK manager. 
#  Preferred NDK version is <NDK_VERSION>.`
#
# How It Works:
# 1. Extracts the `ndkVersion` value from `FlutterExtension.kt`.
# 2. Installs the corresponding NDK version automatically using `sdkmanager`.
#
# Usage:
# Run this script in your project environment to ensure the correct NDK 
# version is installed and configured properly.
# --------------------------------------------------------------------

set -e

FLUTTER_EXTENSION_PATH=${FLUTTER_HOME}"/packages/flutter_tools/gradle/src/main/kotlin/FlutterExtension.kt"

# Check FlutterExtension.kt exists
if [ ! -f "$FLUTTER_EXTENSION_PATH" ]; then
  echo "❌ File not found: $FLUTTER_EXTENSION_PATH"
  exit 1
fi

# Extract ndkVersion from FlutterExtension.kt
NDK_VERSION=$(
  awk -F'"' '/^[[:space:]]*val[[:space:]]+ndkVersion[[:space:]]*:/ {print $2; exit}' "$FLUTTER_EXTENSION_PATH" \
  | tr -d '\r' \
  | xargs
)

# Check NDK_VERSION
if [ -z "$NDK_VERSION" ]; then
  echo "❌ ndkVersion not found in $FLUTTER_EXTENSION_PATH"
  exit 1
fi

echo "✅ Detected ndkVersion: $NDK_VERSION"

# Check ANDROID_HOME
if [ -z "$ANDROID_HOME" ]; then
  echo "❌ ANDROID_HOME is not set. Please export ANDROID_HOME first."
  exit 1
fi

echo "✅ ANDROID_HOME: $ANDROID_HOME"

# Fix error: Failed to read or create install properties file.
sudo chown -R "$USER":"$USER" $ANDROID_HOME

# install ndk via sdkmanager
yes | "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" "ndk;$NDK_VERSION" --install
