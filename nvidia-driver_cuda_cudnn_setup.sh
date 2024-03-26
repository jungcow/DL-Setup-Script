#!/bin/bash

set -xe

# install nvidia driver
sudo apt update
sudo apt install -y nvidia-cuda-toolkit # nvcc (nvidia cuda compiler driver)
sudo apt install -y $(ubuntu-drivers devices | grep 'recommended' | tr ':' '-' | awk -F' - ' '{ print $2 }') # install recommended gpu driver
nvidia-smi # 확인용

# install CUDA - https://developer.nvidia.com/cuda-11-7-1-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_local
# 무조건 11버전으로. 12버전으로 하게 되면 밑의 cuDNN과 opencv 버전도 전부 바꿔줘야 한다.
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda-repo-ubuntu2004-11-7-local_11.7.1-515.65.01-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-7-local_11.7.1-515.65.01-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2004-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda

# CUDA PATH - change version of cuda if you needed
echo 'export PATH=/usr/local/cuda-11.7/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
exec bash # for reloading bash

# install cuDNN
cat | echo -n 'Press Enter after download "cuDNN" from https://developer.nvidia.com/cudnn-downloads :'
echo 'Keep Going...'

eval $(sudo dpkg -i ~/Downloads$(ls ~/Downloads | grep cudnn-local-repo) | grep keyrings)
sudo apt update

sudo apt install -y libcudnn8
sudo apt install -y libcudnn8-dev
sudo apt install -y libcudnn8-samples

# 설치 테스트
sudo apt install -y g++ freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev libfreeimage3 libfreeimage-dev

cp -r /usr/src/cudnn_samples_v8/ $HOME
cd  $HOME/cudnn_samples_v8/mnistCUDNN
make clean && make
./mnistCUDNN
