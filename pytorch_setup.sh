#!/bin/bash

set -xe

sudo apt install python3-pip pip python-wheel-common python-setuptools
pip3 install -U pip wheel setuptools

# pytorch install
pip install torch==1.12.0+cu116 torchvision==0.13.0+cu116 torchaudio==0.12.0 --extra-index-url https://download.pytorch.org/whl/cu116

# in python3 check cuda is available
# import torch
# torch.__version__
# torch.cuda.is_available()
