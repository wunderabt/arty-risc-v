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

# xilinx vivado web pack
COPY Xilinx_Unified_2020.2_1118_1232_Lin64.bin /
COPY xilinx_install_config.txt /
COPY wi_authentication_key /root/.Xilinx/wi_authentication_key
RUN /Xilinx_Unified_2020.2_1118_1232_Lin64.bin --noexec --target ./installer && \
    cd installer && \
	./xsetup \
  		--agree XilinxEULA,3rdPartyEULA,WebTalkTerms \
  		--config /xilinx_install_config.txt \
  		--batch INSTALL && \
    cd .. && \
    rm -fr xilinx_install_config.txt Xilinx_Unified_2020.2_1118_1232_Lin64.bin ./installer

# additional board files
RUN git clone https://github.com/Digilent/vivado-boards.git && \
    tar -C vivado-boards/new/board_files -c . | tar -C /tools/Xilinx/Vivado/2020.2/data/boards/board_files -xf - && \
    rm -fr vivado-boards

# # shamelessly stolen from https://www.reddit.com/r/FPGA/comments/bk8b3n/dockerizing_xilinx_tools/
# RUN cd $XLNX_INSTALL_LOCATION/tmp \
#  	&& cat $XLNX_VIVADO_BATCH_CONFIG_FILE \
#  	&& tar -zxf $XLNX_VIVADO_OFFLINE_INSTALLER && ls -al \
# 	&& echo "cd $XLNX_INSTALL_LOCATION" >> $HOME_DIR/.bashrc \
# 	&& echo "export LANG=en_US.UTF-8" >> $HOME_DIR/.bashrc \
# 	&& export "LANG=en_US.UTF-8" \
# 	&& echo ". $XLNX_INSTALL_LOCATION/Vivado/2018.3/settings64.sh" >> $HOME_DIR/.bashrc \
# 	&& echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$XLNX_INSTALL_LOCATION/Vivado/2018.3/lib/lnx64.o/" >> $HOME_DIR/.bashrc

# RUN cd $XLNX_INSTALL_LOCATION/tmp \
# 	&& mv $XLNX_VIVADO_BATCH_CONFIG_FILE Xilinx_Vivado_SDK_2018.3_1207_2324/ \
# 	&& cd Xilinx_Vivado_SDK_2018.3_1207_2324 \
# # Setup installer permissions \
#   	&& chmod a+x xsetup \
# # Run Setup in batch mode to install Vivado \
# 	&& cd $XLNX_INSTALL_LOCATION/tmp/Xilinx_Vivado_SDK_2018.3_1207_2324 \
# 	&& ./xsetup \
#   		--agree XilinxEULA,3rdPartyEULA,WebTalkTerms \
#   		--config $XLNX_VIVADO_BATCH_CONFIG_FILE \
#   		--batch INSTALL \
# # Cleanup Temporary Files \
#   	&& cd $HOME_DIR \
#   	&& rm -rf $XLNX_INSTALL_LOCATION/tmp

# # Cleanup temporary install files 
# RUN rm -rf $XLNX_INSTALL_LOCATION/tmp

# # Cleanup apt cache and temporary files to reduce image size
# RUN apt-get clean

# RUN source $XLNX_INSTALL_LOCATION/Vivado/2018.3/settings64.sh
# RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$XLNX_INSTALL_LOCATION/Vivado/2018.3/lib/lnx64.o/
