#!/bin/bash
docker run --rm \
           --network host \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v /:/host \
           -e DISPLAY \
           -u $(id -u) \
           -e HOME=/host${HOME} \
           -it \
           troi.fritz.box/risc-v:latest /bin/bash
