#!/bin/bash

# https://doc.libsodium.org/installation#cross-compiling-to-android
export ANDROID_NDK_ROOT=$ANDROID_HOME/ndk/$NDK_VERSION
./dist-build/android-aar.sh
