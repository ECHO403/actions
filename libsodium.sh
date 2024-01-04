#!/bin/bash

# https://doc.libsodium.org/installation#cross-compiling-to-android
export ANDROID_NDK_ROOT=$ANDROID_HOME/ndk/$NDK_VERSION

LIBSODIUM_VERSION=1.0.19

git clone --recursive -b $LIBSODIUM_VERSION https://github.com/jedisct1/libsodium.git
cd libsodium
./dist-build/android-aar.sh
mv libsodium-$LIBSODIUM_VERSION.0.aar ../libsodium-$LIBSODIUM_VERSION.aar 