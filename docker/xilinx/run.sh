#!/bin/bash
docker run --rm \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v /:/host \
           -e DISPLAY \
           -u $(id -u) \
           -it \
           troi.fritz.box/risc-v:latest bash
