#!/bin/bash
set -e
docker build \
  --network=host -t troi.fritz.box/risc-v:latest .
