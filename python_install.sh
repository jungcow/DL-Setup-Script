#!/bin/bash

set -xe

sudo apt update

# https://velog.io/@minukiki/Ubuntu-20.04%EC%97%90-OpenCV-4.4.0-%EC%84%A4%EC%B9%98
sudo apt install -y python3.8 python3-dev python3-numpy #python-dev: opencv-python 바인딩을 위해
sudo apt install -y pip
