#!/bin/bash

set -xe

# buile-essential cmake - c/c++ 컴파일러 관련 라이브러리 및 도구 
# pkg-config - 컴파일 및 링크 시 필요한 lib 정보들을 메타파일로부터 가져옴
sudo apt install -y git build-essential cmake pkg-config 

# install opencv package
sudo apt install -y libjpeg-dev libtiff5-dev libpng-dev # 이미지 파일 로드 및 저장
sudo apt install -y ffmpeg libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libx264-dev x264 libxine2-dev # 특정 코덱의 비디오 파일 읽기/쓰기
sudo apt install -y libv4l-dev v4l-utils # 실시간 webcam 비디오 캡처를 위한 디바이스 드라이버 및 API
sudo apt install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev # 비디오 스트리밍 라이브러리
sudo apt install -y libatlas-base-dev gfortran libeigen3-dev # OpenCV 최적화 라이브러리
sudo apt install -y libgtk-3-dev # opencv GUI

# etc
sudo apt install -y mesa-utils libgl1-mesa-dri qt5-default libtbb2 libtbb-dev python2.7-dev python3-dev python-numpy python3-numpy python3-setuptools libavresample-dev liblapacke-dev
sudo apt install -y unzip

# opencv download
# opencv_contrib: opencv 기본 모듈에 빠져있는 모듈을 설치하기 위함
wget -O opencv 'https://github.com/opencv/opencv/archive/4.6.0.zip'
wget -O opencv_contrib 'https://github.com/opencv/opencv_contrib/archive/4.6.0.zip'

unzip opencv
unzip opencv_contrib
rm opencv opencv_contrib
mkdir ~/opencv
mv opencv-4.6.0 opencv_contrib-4.6.0 ~/opencv
mkdir -p ~/opencv/opencv-4.6.0/build

cd ~/opencv/opencv-4.6.0/build

# opencv build using cmake
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D WITH_TBB=OFF \
	-D WITH_IPP=OFF \
	-D WITH_1394=OFF \
	-D BUILD_WITH_DEBUG_INFO=OFF \
	-D BUILD_DOCS=OFF \
	-D INSTALL_C_EXAMPLES=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D BUILD_EXAMPLES=OFF \
	-D BUILD_PACKAGE=OFF \
	-D BUILD_TESTS=OFF \
	-D BUILD_PERF_TESTS=OFF \
	-D WITH_QT=OFF \
	-D WITH_GTK=ON \
	-D WITH_OPENGL=ON \
	-D BUILD_opencv_python3=ON \
	-D PYTHON3_PACKAGES_PATH=/usr/local/lib/python3.8/dist-packages \
	-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.6.0/modules \
	-D WITH_V4L=ON  \
	-D WITH_FFMPEG=ON \
	-D WITH_XINE=ON \
	-D OPENCV_DNN_CUDA=ON \
	-D WITH_CUDNN=ON \
	-D WITH_CUDA=ON \
	-D CUDA_FAST_MATH=ON \
	-D ENABLE_FAST_MATH=ON \
	-D CUDA_ARCH_BIN=8.6 \
	-D CUDA_ARCH_PTX=8.6 \
	-D BUILD_opencv_cvv=OFF \
	-D OPENCV_ENABLE_NONFREE=ON \
	-D BUILD_NEW_PYTHON_SUPPORT=ON \
	-D OPENCV_SKIP_PYTHON_LOADER=ON \
	-D OPENCV_GENERATE_PKGCONFIG=ON ../

time make -j$(nproc)
sudo make install # 이후 기존 버전에서 opencv 4.6.0 버전으로 바뀌게 됨.

sudo ldconfig
cd ~/
