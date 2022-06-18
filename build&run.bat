docker build -t windows10-in-docker:dev .
docker image tag windows10-in-docker:dev git.efimio.ru/efim/windows10-in-docker
docker image push -a git.efimio.ru/efim/windows10-in-docker
wsl docker run --rm -e "DISPLAY=${DISPLAY:-:0}" -v /mnt/wslg/.X11-unix:/tmp/.X11-unix --device /dev/kvm git.efimio.ru/efim/windows10-in-docker