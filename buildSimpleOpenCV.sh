#!/bin/sh
# buildSimpleOpenCV.sh
# Builds and installs simple version of OpenCV for the Jetson TK1
# Accelerates OpenCV by using GPU routines
# L4T 21.X
# This version is for CUDA 6.5
# OpenCV 2.4.10
# Note: Earlier versions of OpenCV (< 2.4.10) are not compatible with CUDA 6.5

sudo apt-add-repository universe
sudo apt-get update

# Some general development libraries
sudo apt-get install build-essential make cmake cmake-curses-gui g++ pkg-config -y
# libav video input/output development libraries
sudo apt-get install libavformat-dev libavutil-dev libswscale-dev -y
# Video4Linux camera development libraries
sudo apt-get install libv4l-dev -y
# Eigen3 math development libraries
sudo apt-get install libeigen3-dev -y
# OpenGL development libraries (to allow creating graphical windows)
sudo apt-get install libglew1.6-dev -y
# GTK development libraries (to allow creating graphical windows)
sudo apt-get install libgtk2.0-dev -y

# Install OpenCV dependencies
sudo apt-get -y install \
   checkinstall yasm

# Video I/O
sudo apt-get -y install \
  libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
  libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev 

# For building Python wrappers
sudo apt-get -y install \
  python-dev python-numpy -y

# Install sound related libraries
sudo apt-get -y install \
  libfaac-dev libjack-jackd2-dev \
  libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev \
  libva-dev libvdpau-dev  \
  libxvidcore-dev texi2html 

NUM_THREADS=4
ver=2.4.10

git clone https://github.com/Itseez/opencv.git opencv-$ver
cd opencv-$ver
git checkout $ver
mkdir build
cd build
# Jetson architecture is 3.2
cmake -DWITH_CUDA=ON -DCUDA_ARCH_BIN="3.2" -DCUDA_ARCH_PTX="" -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DENABLE_NEON=ON ..
make -j$NUM_THREADS
sudo make -j$NUM_THREADS install
/bin/echo -e "\e[1;32mOpenCV simple build installation complete.\e[0m"
