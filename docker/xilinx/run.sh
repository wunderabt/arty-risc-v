#!/bin/bash
docker run --rm -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -u 1000 -it troi.fritz.box/risc-v:latest bash
