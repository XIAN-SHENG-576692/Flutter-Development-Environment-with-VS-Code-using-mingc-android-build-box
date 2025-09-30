#!/usr/bin/env bash
set -euo pipefail

# Verify Flutter is available in PATH
if ! command -v flutter >/dev/null 2>&1; then
  echo "flutter not on PATH; check Dockerfile or devcontainer PATH."
fi

# Ensure Flutter installation directory is owned by the active (non-root) user
if [ -d /opt/flutter ]; then
  sudo chown -R "$(id -u)":"$(id -g)" /opt/flutter || true
fi

# Set workspace ownership to vscode user to prevent root permission issues
sudo chown -R vscode:vscode /workspace || true

# Configure Git safe.directory to avoid permission conflicts with Flutter repo
git config --global --add safe.directory /opt/flutter || true

# Pre-cache Android artifacts for faster builds and reduced runtime fetches
flutter precache --android || true

# Run diagnostics to validate environment setup
flutter doctor -v || true