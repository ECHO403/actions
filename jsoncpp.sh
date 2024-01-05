#!/usr/bin/env bash 

export ANDROID_NDK_ROOT=$ANDROID_HOME/ndk/$NDK_VERSION
export PATH=$ANDROID_NDK_ROOT:$PATH

ACTIONDIR=$(pwd)

cd jsoncpp || exit

mkdir jni 
mkdir -p ./target/static
mkdir -p ./target/shared
mkdir -p ./target/include/jsoncpp

cat << 'EOF' > jni/Application.mk
APP_ABI := armeabi-v7a arm64-v8a x86 x86_64

APP_PLATFORM := android-21
APP_STL := c++_static

EOF

cat << 'EOF' > jni/Android.mk
#BASE_PATH := $(call my-dir)
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

JSONCPP_SRC:= \
	src/lib_json/json_reader.cpp \
	src/lib_json/json_value.cpp \
	src/lib_json/json_writer.cpp

LOCAL_SRC_FILES := $(addprefix ../, $(JSONCPP_SRC))


LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/../include \
	$(LOCAL_PATH)/../src/lib_json

LOCAL_EXPORT_C_INCLUDE_DIRS := \
	$(LOCAL_PATH)/../include

LOCAL_CFLAGS := \
	-DJSON_USE_EXCEPTION=0

LOCAL_MODULE_TAGS := \
	tests

LOCAL_MODULE := \
	libjsoncpp

include $(BUILD_STATIC_LIBRARY)

EOF

ndk-build clean
ndk-build

find obj/local/ -type d -name 'objs' -exec rm -rf {} +

mv obj/local/* target/static/


cat << 'EOF' > jni/Android.mk
#BASE_PATH := $(call my-dir)
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

JSONCPP_SRC:= \
	src/lib_json/json_reader.cpp \
	src/lib_json/json_value.cpp \
	src/lib_json/json_writer.cpp

LOCAL_SRC_FILES := $(addprefix ../, $(JSONCPP_SRC))

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/../include \
	$(LOCAL_PATH)/../src/lib_json

LOCAL_EXPORT_C_INCLUDE_DIRS := \
	$(LOCAL_PATH)/../include

LOCAL_CFLAGS := \
	-DJSON_USE_EXCEPTION=0

LOCAL_MODULE_TAGS := \
	tests

LOCAL_MODULE := \
	libjsoncpp

include $(BUILD_SHARED_LIBRARY)
EOF

ndk-build clean
ndk-build

mv libs/* target/shared/

cp -r include/json/* target/include/jsoncpp/

# cd jsoncpp && zip -r "$ACTIONDIR"/jsoncpp-android.zip .