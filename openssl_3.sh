#!/bin/bash

build_openssl() {
  local arch=$1
  PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/linux-x86_64/bin:$ANDROID_NDK_ROOT/toolchains/${arch}-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:$PATH  
  ./Configure android-${arch} -D__ANDROID_API__=29 --prefix=/opt/openssl/${arch}
  make && make install 
  mkdir -p /tmp/openssl/${arch} && mv /opt/openssl/${arch}/lib/lib* /tmp/openssl/${arch}/
  make clean
}

build_x86() {
  build_openssl "x86"
}

build_arm() {
  build_openssl "arm"
}

build_arm64() {
  build_openssl "arm64"
}

build_x86_64() {
  build_openssl "x86_64"
}


export ANDROID_NDK_ROOT=$ANDROID_HOME/ndk/$NDK_VERSION
cd openssl
# Execute builds for different architectures
build_x86
build_arm
build_arm64
build_x86_64
