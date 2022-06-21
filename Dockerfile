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
    software-properties-common \
    qemu-system-gui

RUN mkdir /home/windows10
WORKDIR /home/windows10

RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.3.0.tar.gz
RUN tar -xvf v1.3.0.tar.gz

RUN apt update
RUN apt install -y powershell

RUN wget https://raw.githubusercontent.com/pbatard/Fido/master/Fido.ps1

RUN wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso

RUN find . -type f -name 'virtio-win*.iso' -exec sh -c 'x="{}"; mv "$x" "virtio-win.iso"' \;

RUN qemu-img create -f qcow2 windows10.img 120G
RUN apt install -y qemu-system-gui x11-apps
RUN chown $(id -u):$(id -g) /dev/kvm 2>/dev/null || true  

RUN touch start.sh \
    && chmod +x ./start.sh \
    && tee -a start.sh <<< '#!/bin/sh' \
    && tee -a start.sh <<< 'wget https://git.efimio.ru/efim/windows10-in-docker/raw/branch/master/isoCheck.ps1' \
    && tee -a start.sh <<< 'wget https://git.efimio.ru/efim/windows10-in-docker/raw/branch/master/launchNoVNC.sh' \
    && tee -a start.sh <<< 'pwsh isoCheck.ps1' \
    && tee -a start.sh <<< 'chmod +x ./launchNoVNC.sh' \
    && tee -a start.sh <<< './launchNoVNC.sh &>/dev/null &' \
    && tee -a start.sh <<< 'exec qemu-system-x86_64 \' \
    && tee -a start.sh <<< '-enable-kvm \' \
    && tee -a start.sh <<< '-cpu host -smp 16 \' \
    && tee -a start.sh <<< '-drive file=./windows10.img,if=virtio \' \
    && tee -a start.sh <<< '-net nic -net user,hostname=windows10vm \' \
    && tee -a start.sh <<< '-boot d -drive file=/home/windows10/virtio-win.iso,media=cdrom \' \
    && tee -a start.sh <<< '-drive file=/home/windows10/windows10.iso,media=cdrom \' \
    && tee -a start.sh <<< '-audiodev alsa,id=snd0,out.try-poll=off -device ich9-intel-hda -device hda-output,audiodev=snd0 \' \
    && tee -a start.sh <<< '-m 4G \' \
    && tee -a start.sh <<< '-boot menu=on \' \
    && tee -a start.sh <<< '-boot c \' \
    && tee -a start.sh <<< '-vga std \' \
    && tee -a start.sh <<< '-usb -device usb-kbd -device usb-tablet \' \
    && tee -a start.sh <<< '-name "windows 10" \'

CMD ["/bin/bash","-c","./start.sh"]