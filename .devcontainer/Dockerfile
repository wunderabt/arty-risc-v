FROM troi.fritz.box/risc-v:latest
RUN useradd --uid 1000 uwe && \
    usermod -a -G dialout uwe && \
    usermod -a -G root uwe && \
    mkdir -p /home/uwe && \
    chmod 777 /home/uwe