FROM ubuntu:22.04 AS prebase
COPY ./soft /app
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt update && \
    apt install -y \
        build-essential \
        linux-headers-generic \
        udev \
        libncurses5-dev \
        libncursesw5-dev \
        libusb-1.0-0 \
        dwarves \
        git \
        wget \
        mailutils -y \
        software-properties-common -y && \
    TZ=Etc/UTC apt install tzdata -y && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt install python3.12 -y && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.12 100 && \
    update-alternatives --config python && \
    wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && rm get-pip.py && \
    cd /app/CAENVMELib-v3.4.0/lib/ && chmod +x ./install_x64 && ./install_x64 && cd / && \
    cd /app/CAENComm-v1.6.0/lib/ && chmod +x ./install_x64 && ./install_x64 && cd / && \
    cd /app/CAENHVWrapper-6.3/ && chmod +x ./install.sh && ./install.sh && cd / && \
    ln -s /lib64/libcaenhvwrapper.so /lib/libcaenhvwrapper.so

FROM prebase AS base
RUN wget 'https://github.com/caenHV/caen_tools/releases/download/v1.2.1-dev/caen_tools-1.2.1-py3-none-any.whl' && \
    pip install 'caen_tools-1.2.1-py3-none-any.whl[webservice]' && \
    rm caen_tools-1.2.1-py3-none-any.whl

FROM base AS webserver
CMD caen_webserver 

FROM base AS devback
CMD caen_device_backend

FROM base AS monitor
CMD caen_monitor