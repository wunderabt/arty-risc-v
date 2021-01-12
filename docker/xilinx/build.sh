#!/bin/bash
set -e
DOCKER_BUILDKIT=1 docker build \
  --secret id=xilinx_token,src=wi_authentication_key \
  -t troi.fritz.box/risc-v:latest .
