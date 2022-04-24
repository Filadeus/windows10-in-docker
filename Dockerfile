FROM ubuntu:20.04 AS build
SHELL ["/bin/bash", "-c"]

RUN expot DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt install -y --no-install-recomends \
    qemu-system-x86 \
    qemu-utils \
    qemu-kvm \
    git \
    wget \
    apt-transport-https 

RUN mkdir /home/windows10
WORKDIR /home/windows10
