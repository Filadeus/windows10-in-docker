FROM docker.io/ubuntu:20.04 AS build
SHELL ["/bin/bash", "-c"]

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt install -y \
    qemu-system-x86 \
    qemu-utils \
    qemu-kvm \
    git \
    wget \
    apt-transport-https \
    software-properties-common 

RUN mkdir /home/windows10
WORKDIR /home/windows10

RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

RUN apt update
RUN apt install -y powershell

RUN wget https://raw.githubusercontent.com/pbatard/Fido/master/Fido.ps1
RUN pwsh Fido.ps1 -Win 10 -Ed Pro -Lang English International

RUN wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso

RUN find . -type f -name 'Win10*.iso' -exec sh -c 'x="{}"; mv "$x" "windows10.iso"' \;
RUN find . -type f -name 'virtio-win*.iso' -exec sh -c 'x="{}"; mv "$x" "virtio-win.iso"' \;

RUN qemu-img create -f qcow2 windows10.img 120G
RUN apt install -y qemu-system-gui x11-apps

RUN touch start.sh \
    && chmod +x ./start.sh \
    && tee -a start.sh <<< '#!/bin/sh' \
    && tee -a start.sh <<< 'exec qemu-system-x86_64 \' \
    && tee -a start.sh <<< ' \' \


CMD ./start.sh