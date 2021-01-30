FROM troi.fritz.box/vivado:latest

ARG VERILATOR_VERSION=stable

# tooling for SiFive risc-v chisel etc
RUN apt-get update && \
    apt-get install -y autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev libusb-1.0-0-dev gawk \
            build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev device-tree-compiler pkg-config libexpat-dev \
            wget scala firefox-esr && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && apt-get install -y sbt && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# verilator
RUN apt-get update && apt-get install -y git make autoconf g++ flex bison python python3 && \
    git clone -b ${VERILATOR_VERSION} https://github.com/verilator/verilator.git && \
    cd verilator && \
    autoconf && \
    ./configure && \
    make -j $(nproc) && \
    make install && \
    cd .. && rm -fr verilator && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# SiFive Freedom Studio
RUN apt-get update && \
    apt-get install -y dbus-x11 && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /tools/sifive && cd /tools/sifive && \
    curl https://static.dev.sifive.com/dev-tools/FreedomStudio/2020.11/FreedomStudio-4.7.2.2020-11-3-x86_64-linux-ubuntu14.tar.gz | tar xz

## risc-v embedded toolchain
# ub: currently not using rv64
#ENV RISCV=/tools/risc-v/riscv64-unknown-elf-gcc-8.3.0-2020.04.0-x86_64-linux-ubuntu14
#RUN mkdir -p /tools/risc-v && cd /tools/risc-v && \
#    curl https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2020.04.0-x86_64-linux-ubuntu14.tar.gz | tar xz