#!/bin/bash

build_x86() {
  arch="x86"
  PATH=$ANDROID_NDK_HOME/toolchains/x86-4.9/prebuilt/linux-x86_64/bin:$PATH  
  ./Configure android-${arch} -D__ANDROID_API__=14 --prefix=/opt/openssl/${arch}
  make && make install 
  mkdir -p /tmp/openssl/${arch} && mv /opt/openssl/${arch}/* /tmp/openssl/${arch}/
  make clean
}

build_arm() {
  arch="arm"
  PATH=$ANDROID_NDK_HOME/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:$PATH  
  ./Configure android-${arch} -D__ANDROID_API__=14 --prefix=/opt/openssl/${arch}
  make && make install 
  mkdir -p /tmp/openssl/${arch} && mv /opt/openssl/${arch}/* /tmp/openssl/${arch}/
  make clean
}

build_arm64() {
  arch="arm64"
  PATH=$ANDROID_NDK_HOME/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin:$PATH  
  ./Configure android-${arch} -D__ANDROID_API__=21 --prefix=/opt/openssl/${arch}
  make && make install 
  mkdir -p /tmp/openssl/${arch} && mv /opt/openssl/${arch}/* /tmp/openssl/${arch}/
  make clean
}

build_x86_64() {
  arch="x86_64"
  PATH=$ANDROID_NDK_HOME/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin:$PATH  
  ./Configure android-${arch} -D__ANDROID_API__=21 --prefix=/opt/openssl/${arch}
  make && make install 
  mkdir -p /tmp/openssl/${arch} && mv /opt/openssl/${arch}/* /tmp/openssl/${arch}/
  make clean
}

# Execute builds for different architectures
export ANDROID_NDK_HOME=$ANDROID_HOME/$NDK_VERSION
cd openssl
build_x86
build_arm
build_arm64
build_x86_64
