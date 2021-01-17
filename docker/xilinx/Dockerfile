## run installer in separate image because we don't need the .bin in the final image
FROM debian:latest AS vivado_install

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
    rm -fr /tools/Xilinx/.xinstall

###############################################################################
## main image
#############
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
COPY --from=vivado_install /tools/Xilinx /tools/Xilinx

# workaround for libtinfo.so.5 dependency of vivado
RUN cd /lib/x86_64-linux-gnu && ln -s libtinfo.so.6 libtinfo.so.5
# cs_server needs the UTF-8 env vars
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN echo "source /tools/Xilinx/Vivado/2020.2/settings64.sh" >> /etc/bash.bashrc

# additional Digilent board files for vivado (e.g. Arty A7)
RUN git clone https://github.com/Digilent/vivado-boards.git && \
    tar -C vivado-boards/new/board_files -c . | tar -C /tools/Xilinx/Vivado/2020.2/data/boards/board_files -xf - && \
    rm -fr vivado-boards

RUN apt-get update && \
    apt-get install -y usbutils && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# check hints from https://www.reddit.com/r/FPGA/comments/bk8b3n/dockerizing_xilinx_tools/
#                  https://github.com/phwl/docker-vivado
