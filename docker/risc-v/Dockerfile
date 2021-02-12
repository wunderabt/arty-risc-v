FROM troi.fritz.box/vivado:latest

ARG VERILATOR_VERSION=stable

# tooling for SiFive risc-v chisel etc
RUN apt-get update && \
    apt-get install -y autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev libusb-1.0-0-dev gawk \
            build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev device-tree-compiler pkg-config libexpat-dev \
            wget scala firefox-esr tio && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && apt-get install -y sbt && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# verilator
RUN apt-get update && apt-get install -y git make autoconf g++ flex bison python python3 python3-venv && \
    git clone -b ${VERILATOR_VERSION} https://github.com/verilator/verilator.git && \
    cd verilator && \
    autoconf && \
    ./configure && \
    make -j $(nproc) && \
    make install && \
    cd .. && rm -fr verilator && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# SiFive Freedom Studio - has problem with opening new projects, reports webkit2-gtk bindings issue
#RUN apt-get update && \
#    apt-get install -y dbus-x11 && \
#    apt-get autoclean && apt-get autoremove && \
#    rm -rf /var/lib/apt/lists/* && \
#    mkdir -p /tools/sifive && cd /tools/sifive && \
#    curl https://static.dev.sifive.com/dev-tools/FreedomStudio/2020.11/FreedomStudio-4.7.2.2020-11-3-x86_64-linux-ubuntu14.tar.gz | tar xz

# Arduino - no connection to board
#RUN curl https://downloads.arduino.cc/arduino-1.8.13-linux64.tar.xz | tar -C /tools -xJf -

## risc-v embedded toolchain
ENV RISCV=/tools/risc-v/riscv64-unknown-elf-gcc-8.3.0-2020.04.0-x86_64-linux-ubuntu14
ENV RISCV_PATH=/tools/risc-v/riscv64-unknown-elf-gcc-8.3.0-2020.04.0-x86_64-linux-ubuntu14
ENV RISCV_OPENOCD_PATH=/tools/risc-v/riscv-openocd-0.10.0-2019.08.2-x86_64-linux-ubuntu14
RUN mkdir -p /tools/risc-v && cd /tools/risc-v && \
    curl https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2020.04.0-x86_64-linux-ubuntu14.tar.gz | tar xz && \
    curl https://static.dev.sifive.com/dev-tools/riscv-openocd-0.10.0-2019.08.2-x86_64-linux-ubuntu14.tar.gz | tar xz