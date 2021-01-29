#!/bin/bash

image_name="troi.fritz.box/risc-v:latest"

# HINT: on the host the following group access rights were set:
#       /dev/ttyUSB* - dialout
#       /dev/bus/usb/* - root
#       so the user is added to those groups to allow vivado to
#       program the FPGA via USB
docker build --tag ${image_name}_${USER} -<<EOF
FROM ${image_name}
RUN useradd --uid $(id -u) --home /host/${HOME} ${USER} && \
    usermod -a -G dialout ${USER} && \
    usermod -a -G root ${USER}
EOF

docker run --rm \
           --network host \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v /:/host \
           -e DISPLAY \
           -u $(id -u) \
           -e HOME=/host${HOME} \
           -w /host$(pwd) \
           --privileged \
           -it \
           ${image_name}_${USER} /bin/bash
