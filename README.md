# Flutter Development Environment with VS Code using `mingc/android-build-box`

## `mingchen/docker-android-build-box` Documentation

- [GitHub - mingchen/docker-android-build-box](https://github.com/mingchen/docker-android-build-box): An optimized Docker image that includes Android, Kotlin, and Flutter SDK.  
- [Dockerfile on Docker Hub](https://hub.docker.com/r/mingc/android-build-box/dockerfile)

---

## ⚠️ Caution

### CI/CD

- This image is **very large** (13.7 GB as of 2025-09-22).  
- It is **not recommended** for use in CI/CD pipelines due to its size.  
- For official guidance, see [Continuous delivery with Flutter](https://docs.flutter.dev/deployment/cd).

---

## ✨ Features

- Requires only the `ms-vscode-remote.remote-containers` extension in VS Code to get started.  
- Allows running the container with a new user instead of `root`.  
- Supports USB device mounting, making it easy to test projects on real devices.  
- Includes helper scripts (⚠️ these must be run **inside the container**):  
  - [`install_melos.sh`](install_melos.sh): Installs [Melos (Dart package)](https://pub.dev/packages/melos).  
  - [`install_ndk.sh`](install_ndk.sh): Installs the NDK to fix build errors.  

---