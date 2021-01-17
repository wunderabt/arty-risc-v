FROM troi.fritz.box/vivado:latest

# tooling for SiFive risc-v
RUN apt-get update && \
    apt-get install -y autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev libusb-1.0-0-dev gawk \
            build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev device-tree-compiler pkg-config libexpat-dev \
            python wget scala firefox-esr && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && apt-get install -y sbt && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# verilator
RUN apt-get update && apt-get install -y git make autoconf g++ flex bison python3 && \
    git clone -b stable https://github.com/verilator/verilator.git && \
    cd verilator && \
    autoconf && \
    ./configure && \
    make -j $(nproc) && \
    make install && \
    cd .. && rm -fr verilator && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*