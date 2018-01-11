#!/bin/bash

ARCH="sm_61"

cd lib/layer_utils/roi_pooling/src/cuda
echo "Compiling roi_pooling kernels by nvcc..."
nvcc -c -o roi_pooling_kernel.cu.o roi_pooling_kernel.cu -x cu -Xcompiler -fPIC -arch=$ARCH
cd ../../
python3 build.py
cd ../../../

### Build NMS
cd lib/nms/src/cuda
echo "Compiling nms kernels by nvcc..."
nvcc -c -o nms_kernel.cu.o nms_kernel.cu -x cu -Xcompiler -fPIC -arch=$ARCH
cd ../../
python3 build.py
cd ../../

### Install the Python COCO API. The code requires the API to access COCO dataset.
cd data
git clone https://github.com/pdollar/coco.git
cd coco/PythonAPI
make
cd ../../..
