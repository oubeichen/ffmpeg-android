#!/bin/bash

SUPPORTED_ARCHITECTURES=(armeabi-v7a x86)
ANDROID_NDK=~/android-ndk-r10e/
ANDROID_NDK_ROOT_PATH=${ANDROID_NDK}
if [[ -z "$ANDROID_NDK_ROOT_PATH" ]]; then
  echo "You need to set ANDROID_NDK environment variable, please check instructions"
  exit
fi
ANDROID_API_VERSION=9
NDK_TOOLCHAIN_ABI_VERSION=4.8

NUMBER_OF_CORES=8
HOST_UNAME=$(uname -m)
TARGET_OS=linux

CFLAGS='-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fno-strict-overflow -fstack-protector-all'
LDFLAGS='-Wl,-z,relro -Wl,-z,now -pie'

FFMPEG_PKG_CONFIG="$(pwd)/ffmpeg-pkg-config"
