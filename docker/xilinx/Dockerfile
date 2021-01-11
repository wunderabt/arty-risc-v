FROM debian:latest

# support packages for xilinx tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git \
                       device-tree-compiler \
                       default-jre \
                       openjdk-11-jdk && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# xilinx vivado web pack, download this from Xilinx
COPY Xilinx_Unified_2020.2_1118_1232_Lin64.bin /
COPY xilinx_install_config.txt /
# HINT: add your own token before building the image,
#       run ./Xilinx_Unified_2020.2_1118_1232_Lin64.bin -- --batch AuthTokenGen
#           cp ~/.Xilinx/wi_authentication_key .
COPY wi_authentication_key /root/.Xilinx/wi_authentication_key
RUN /Xilinx_Unified_2020.2_1118_1232_Lin64.bin --noexec --target ./installer && \
    cd installer && \
	./xsetup \
  		--agree XilinxEULA,3rdPartyEULA,WebTalkTerms \
  		--config /xilinx_install_config.txt \
  		--batch INSTALL && \
    cd .. && \
    rm -fr xilinx_install_config.txt Xilinx_Unified_2020.2_1118_1232_Lin64.bin ./installer /tools/Xilinx/.xinstall /root/.Xilinx/wi_authentication_key

# workaround for libtinfo.so.5 dependency of vivado
RUN cd /lib/x86_64-linux-gnu && ln -s libtinfo.so.6 libtinfo.so.5

# additional board files for vivado
RUN git clone https://github.com/Digilent/vivado-boards.git && \
    tar -C vivado-boards/new/board_files -c . | tar -C /tools/Xilinx/Vivado/2020.2/data/boards/board_files -xf - && \
    rm -fr vivado-boards

# tooling for SiFive risc-v
RUN apt-get update && \
    apt-get install -y autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev libusb-1.0-0-dev gawk \
            build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev device-tree-compiler pkg-config libexpat-dev \
            python wget scala && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && apt-get install -y sbt && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# verilator
RUN apt-get update && apt-get install -y git make autoconf g++ flex bison python3 && \
    git clone http://git.veripool.org/git/verilator && \
    cd verilator && \
    git checkout stable && \
    autoconf && \
    ./configure && \
    make -j $(nproc) && \
    make install && \
    cd .. && rm -fr verilator && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# check hints from https://www.reddit.com/r/FPGA/comments/bk8b3n/dockerizing_xilinx_tools/