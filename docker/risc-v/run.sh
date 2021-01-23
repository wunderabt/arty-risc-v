#!/bin/bash

image_name="troi.fritz.box/risc-v:latest"

docker build --tag ${image_name}_${USER} -<<EOF
FROM ${image_name}
RUN useradd --uid $(id -u) --home /host/${HOME} ${USER}
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
