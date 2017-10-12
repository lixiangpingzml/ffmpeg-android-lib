#!/bin/bash
#make clean
export TMPDIR=$(pwd)/tmp
export NDK=/home/ndk/android-ndk-r10b
export PLATFORM=$NDK/platforms/android-L/arch-arm
export PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64
export CPU=arm
export PREFIX=$(pwd)/android/$CPU
export ADDI_CFLAGS="-marm"

function build_one
{
 ./configure --target-os=linux --prefix=$PREFIX \
--enable-cross-compile \
--enable-runtime-cpudetect \
--disable-asm \
--arch=arm \
--cpu=cortex-a8 \
--cc=$PREBUILT/bin/arm-linux-androideabi-gcc \
--cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
--disable-stripping \
--nm=$PREBUILT/bin/arm-linux-androideabi-nm \
--sysroot=$PLATFORM \
--enable-gpl --enable-shared --disable-static --enable-nonfree --enable-version3 --enable-small  --enable-avresample --disable-vda --disable-iconv \
--disable-encoders --enable-libx264 --enable-encoder=libx264  \
--disable-muxers --enable-muxer=mov --enable-muxer=ipod --enable-muxer=psp --enable-muxer=mp4 --enable-muxer=avi \
--disable-decoders --enable-decoder=aac --enable-decoder=aac_latm --enable-decoder=h264 --enable-decoder=mpeg4 \
--disable-demuxers --enable-demuxer=h264 --enable-demuxer=avi --enable-demuxer=mpc --enable-demuxer=mov \
--disable-parsers --enable-parser=aac --enable-parser=ac3 --enable-parser=h264 \
--disable-protocols --enable-protocol=file \
--disable-bsfs --enable-bsf=aac_adtstoasc --enable-bsf=h264_mp4toannexb \
--disable-indevs --enable-zlib \
--disable-outdevs --disable-ffprobe --disable-ffplay --disable-ffmpeg --disable-ffserver --disable-debug \
--extra-cflags="-I/home/robin/x264/android-lib/include -fPIC -DANDROID -D__thumb__ -mthumb -Wfatal-errors -Wno-deprecated -mfloat-abi=softfp  -marm  -march=armv7-a " \
--extra-ldflags="-L/home/robin/x264/android-lib/lib"
}

build_one
make -j4
make install
