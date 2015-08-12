#!/bin/sh
# buildOpenCV.sh
# Builds and installs OpenCV for the Jetson TK1
# Accelerates OpenCV by using GPU routines
# L4T 21.X
# This version is for CUDA 6.5
# OpenCV 2.4.10
# Note: Earlier versions of OpenCV (< 2.4.10) are not compatible with CUDA 6.5

sudo apt-add-repository universe
sudo apt-add-repository multiverse
sudo apt-get update

# Install OpenCV dependencies
sudo apt-get -y install \
  build-essential checkinstall cmake pkg-config yasm

# Video I/O
sudo apt-get -y install \
  libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev

# For building Python wrappers
sudo apt-get -y install \
  python-dev python-numpy

sudo apt-get -y install \
  libfaac-dev libjack-jackd2-dev \
  libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev \
  libtheora-dev libva-dev libvdpau-dev libvorbis-dev libx11-dev libxfixes-dev \
  libxvidcore-dev texi2html zlib1g-dev

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
sudo make -j$NUM_THREADS install
/bin/echo -e "\e[1;32mOpenCV build complete.\e[0m"
