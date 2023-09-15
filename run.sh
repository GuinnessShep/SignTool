#!/bin/bash

# Update and upgrade only if not done already
if [ ! -f "/var/cache/apt/pkgcache.bin" ]; then
    apt update
    apt full-upgrade -y
fi

# Install necessary packages only if not present
packages="unzip software-properties-common openjdk-8-jdk git python3-dev python3-tk cmake unzip zip python3-numpy python3-six build-essential python3-pip swig python3-wheel libcurl3-dev libcupti-dev"
for package in $packages; do
    if ! dpkg -l | grep -q $package; then
        apt install -y $package
    fi
done

# Add repository only if not added
if ! grep -q "graphics-drivers/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    add-apt-repository -y ppa:graphics-drivers/ppa
    apt update
    apt dist-upgrade -y
    ubuntu-drivers autoinstall
fi

# Download and install cuda & related tools only if not installed
if [ ! -d "installers" ]; then
    mkdir installers
    curl -o installers/cuda_12.2.2_535.104.05_linux.run https://developer.download.nvidia.com/compute/cuda/12.2.2/local_installers/cuda_12.2.2_535.104.05_linux.run
    curl -o installers/cudnn-local-repo-ubuntu2204-8.9.5.29_1.0-1_amd64.deb https://github.com/GuinnessShep/SignTool/releases/download/Cudann/cudnn-local-repo-ubuntu2204-8.9.5.29_1.0-1_amd64.deb
    curl -o installers/nccl-local-repo-ubuntu2204-2.18.5-cuda12.2_1.0-1_amd64.deb https://github.com/GuinnessShep/SignTool/releases/download/Cudann/nccl-local-repo-ubuntu2204-2.18.5-cuda12.2_1.0-1_amd64.deb
    curl -o cuda.sh https://raw.githubusercontent.com/GuinnessShep/SignTool/master/cuda.sh
    bash cuda.sh
fi

# Download and unzip only if not unzipped already
if [ ! -d "oobabooga_linux" ]; then
    curl -o oobabooga_linux.zip https://github.com/oobabooga/text-generation-webui/releases/download/installers/oobabooga_linux.zip
    unzip oobabooga_linux.zip
    rm -rf oobabooga_linux.zip
fi

cd oobabooga_linux
# Always remove and download the new webui.py
rm -rf webui.py
wget https://raw.githubusercontent.com/GuinnessShep/SignTool/master/webui.py

# Finally, start the linux script
bash start_linux.sh
