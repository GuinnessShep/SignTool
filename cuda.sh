#!/bin/bash

CUDA="installers/cuda_12.2.2_535.104.05_linux.run"
CUDNN="installers/cudnn-local-repo-ubuntu2204-8.9.5.29_1.0-1_amd64.deb"
NCCL="installers/nccl-local-repo-ubuntu2204-2.18.5-cuda12.2_1.0-1_amd64.deb"

cuda() {
  if [[ -f ${CUDA} ]]; then
    echo "[AUTO-CUDA] Installing ${CUDA}.."
    sudo sh ${CUDA} --override --silent --toolkit
    echo "[AUTO-CUDA] CUDA Installation done."
    cudnn
  else
    echo "[AUTO-CUDA] CUDA installers not found."
    echo "[AUTO-CUDA] Installation aborted"
    exit
  fi
}

cudnn() {
  if [[ -f ${CUDNN} ]]; then
    echo "[AUTO-CUDA] Installing ${CUDNN}.."

    mkdir installers/cudnn
    tar -xzvf ${CUDNN} -C installers/cudnn --strip-components=1
    sudo cp installers/cudnn/include/cudnn.h /usr/local/cuda-12.2/include
    sudo cp installers/cudnn/lib64/libcudnn* /usr/local/cuda-12.2/lib64
    sudo chmod a+r /usr/local/cuda-12.2/include/cudnn.h /usr/local/cuda-12.2/lib64/libcudnn*

    echo "[AUTO-CUDA] Cofiguring cuda in linux enviroment.."
    
    cp ~/.bashrc ~/.bashrc.orig.cuda
    echo " " >> ~/.bashrc
    echo '# CUDA Enviroment' >> ~/.bashrc
    echo 'export PATH=/usr/local/cuda-12.2/bin${PATH:+:${PATH}}$' >> ~/.bashrc
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
    echo 'export CUDA_HOME="/usr/local/cuda"' >> ~/.bashrc

    nccl
  else
    echo "[AUTO-CUDA] CUDNN installers not found."
    echo "[AUTO-CUDA] CUDNN installation failed"
    exit
  fi
}

nccl() {
  if [[ -f ${NCCL} ]]; then
    echo "[AUTO-CUDA] Installing ${NCCL}.."
    mkdir installers/nccl
    tar Jxvf ${NCCL} -C installers/nccl/ --strip-components=1
    sudo cp installers/nccl/lib/libnccl* /usr/local/cuda-12.2/lib64/
    sudo cp installers/nccl/include/nccl.h /usr/local/cuda-12.2/include/

    clear_pkg
  else
    echo "[AUTO-CUDA] NCCL installers not found."
    echo "[AUTO-CUDA] NCCL installation failed"
    exit
  fi
}

clear_pkg(){
  if [[ -d installers/nccl ]] && [[ -d installers/cudnn ]]; then
    echo "[AUTO-CUDA] Deleting installation packages.."
    sudo rm -r installers/cudnn
    sudo rm -r installers/nccl
  else
    echo "[AUTO-CUDA] NCCL or CUDNN installers not found."
    echo "[AUTO-CUDA] Installation clean up failed"
    exit
  fi
}

echo "Starting the CUDA installation process..."
cuda
sudo ldconfig

echo "[AUTO-CUDA] CUDA Installation done."
echo " "
echo "==============================================================================================="
echo "CUDA Post Installation Notes"
echo "==============================================================================================="
echo "Load bash profile or bashrc configuration: "
echo " $ source ~/.bashrc"
echo " $ sudo ldconfig"
echo " "
echo "Verify CUDA in linux enviroment: "
echo ' $ echo $CUDA_HOME'
echo "==============================================================================================="
echo " "
