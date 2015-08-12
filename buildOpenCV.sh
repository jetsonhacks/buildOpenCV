#!/bin/sh
# buildOpenCV.sh
# Builds and installs OpenCV for the Jetson TK1
# Accelerates OpenCV by using GPU routines
# L4T 21.X
# This version is for CUDA 6.5
# OpenCV 2.4.10
# Note: Earlier versions of OpenCV (< 2.4.10) are not compatible with CUDA 6.5

# Get opencv dependencies
apt-get -y install \
  checkinstall git cmake libfaac-dev libjack-jackd2-dev \
  libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev \
  libtheora-dev libva-dev libvdpau-dev libvorbis-dev libx11-dev libxfixes-dev \
  libxvidcore-dev texi2html yasm zlib1g-dev

NUM_THREADS=4
ver=2.4.10

git clone https://github.com/Itseez/opencv.git opencv-$ver
cd opencv-$ver
git checkout $ver
mkdir build
cd build
# Jetson architecture is 3.2
cmake -D CUDA_ARCH_BIN=3.2 ..
make -j$NUM_THREADS
make -j$NUM_THREADS install
/bin/echo -e "\e[1;32mOpenCV build complete.\e[0m"
