#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd ffmpeg

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    CPU='cortex-a8'
  ;;
  x86)
    CPU='i686'
  ;;
esac

make clean

./configure \
--target-os="$TARGET_OS" \
--cross-prefix="$CROSS_PREFIX" \
--arch="$NDK_ABI" \
--cpu="$CPU" \
--enable-runtime-cpudetect \
--sysroot="$NDK_SYSROOT" \
--enable-pthreads \
--disable-debug \
--disable-ffserver \
--enable-version3 \
--enable-hardcoded-tables \
--disable-ffplay \
--disable-ffprobe \
--disable-doc \
--disable-shared \
--enable-static \
--disable-avdevice \
--disable-swscale \
--disable-postproc \
--disable-network \
--disable-pixelutils \
--disable-encoders \
--enable-encoder=aac \
--enable-encoder=libfdk_aac \
--enable-encoder=pcm_f64le \
--enable-encoder=pcm_s16le \
--disable-decoders \
--enable-decoder=aac \
--enable-decoder=aac_fixed \
--enable-decoder=aac_latm \
--enable-decoder=h263 \
--enable-decoder=h264 \
--enable-decoder=mp3 \
--enable-decoder=mpeg4 \
--enable-decoder=pcm_f64le \
--enable-decoder=pcm_s16le \
--disable-demuxers \
--enable-demuxer=aac \
--enable-demuxer=h263 \
--enable-demuxer=h264 \
--enable-demuxer=mp3 \
--enable-demuxer=avi \
--enable-demuxer=mpegvideo \
--enable-demuxer=pcm_f64le \
--enable-demuxer=pcm_s16le \
--enable-demuxer=mov \
--enable-demuxer=m4v \
--enable-demuxer=wav \
--enable-demuxer=latm \
--disable-muxers \
--enable-muxer=mp3 \
--enable-muxer=mp4 \
--enable-muxer=latm \
--enable-muxer=wav \
--enable-muxer=m4v \
--enable-muxer=mov \
--enable-muxer=h263 \
--enable-muxer=h264 \
--enable-muxer=pcm_f64le \
--enable-muxer=pcm_s16le \
--enable-libfdk-aac \
--pkg-config="${2}/ffmpeg-pkg-config" \
--prefix="${2}/build/${1}" \
--extra-cflags="-I${TOOLCHAIN_PREFIX}/include $CFLAGS" \
--extra-ldflags="-L${TOOLCHAIN_PREFIX}/lib $LDFLAGS" \
--extra-libs="-lm" \
--extra-cxxflags="$CXX_FLAGS" || exit 1

make -j${NUMBER_OF_CORES} && make install || exit 1

popd
