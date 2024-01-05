#!/bin/bash


build_x86() {
  arch="x86"
  PATH=$ANDROID_NDK_HOME/toolchains/x86-4.9/prebuilt/linux-x86_64/bin:$PATH  
  # ./configure --host x86 --with-pic --with-openssl --prefix=/tmp/curl/${arch}
  # make && make install 
  ./configure --host x86 --with-pic --with-openssl --disable-shared --prefix=/tmp/curl/${arch}
  make && make install 
  make clean
}

build_arm() {
  arch="arm"
  PATH=$ANDROID_NDK_HOME/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:$PATH  
  ./configure --host arm-linux-androideabi --with-pic --with-openssl --prefix=/tmp/curl/${arch}
  make && make install 
  make clean
}

build_arm64() {
  arch="arm64"
  PATH=$ANDROID_NDK_HOME/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin:$PATH  
  ./configure --host aarch64-linux-android --with-pic --with-openssl --prefix=/tmp/curl/${arch}
  make && make install 
  make clean
}

build_x86_64() {
  arch="x86_64"
  PATH=$ANDROID_NDK_HOME/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin:$PATH  
  ./configure --host x86_64 --with-pic --with-openssl --prefix=/tmp/curl/${arch}
  make && make install 
  make clean
}

# Execute builds for different architectures
export ANDROID_NDK_HOME=$ANDROID_HOME/$NDK_VERSION
mkdir -p /tmp/curl 
cd curl && autoreconf -fi
build_x86
build_arm
build_arm64
build_x86_64

