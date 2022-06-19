[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

# Windows 10 in Docker using QEMU  

## What's happening inside the container

## TODO

- [x] **Download ISO when container is RUNNING not BUILDING**
- [ ] Might try using Makefile and m4
- [x] Get ubuntu image
- [x] Install necessary dependencies
- [x] Download Windows 10 Evaluation ISO from Microsoft
- [x] Enable KVM support for better perfomance
- [x] Install Windows 10 ISO (make it persistent)
- [x] Write a script to start up the VM every time the container starts
  - [ ] Main HDA drive must be `VirtIO`
  - [x] NIC's device model: `VirtIO`
  - [x] Add a CDROM storage device with Windows 10 ISO
  - [x] Add a CDROM storage device with VirtIO Windows Drivers
  - [x] Minimum CPU allocation: 4. Socket: 1; Cores: 2; Threads: 2
- [x] **Replace CMD in Dockerfile with a proper start.sh file.**
- [ ] **Sound**
- [ ] Add SPICE and noVNC output support
- [ ] Look into interface perfomance issues.
- [ ] Finish up with docker-compose.yml
- [ ] **Cleanup Dockerfile**
