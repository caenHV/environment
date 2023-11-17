FROM ubuntu:22.04
COPY ./soft /app
RUN apt update && \
    apt install -y \
        build-essential \
        linux-headers-generic \
        udev \
        libncurses5-dev \
        libncursesw5-dev \
        libusb-1.0-0 \
        dwarves \
        software-properties-common -y && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt install tzdata -y && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt install python3.12 -y && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.12 100 && \
    update-alternatives --config python && \
    cd /app/CAENVMELib-v3.4.0/lib/ && chmod +x ./install_x64 && ./install_x64 && cd / && \
    cd /app/CAENHVWrapper-6.3/ && chmod +x ./install.sh && ./install.sh && cd / && \
    ln -s /lib64/libcaenhvwrapper.so /lib/libcaenhvwrapper.so && \
    echo "HELLO WORLD"

