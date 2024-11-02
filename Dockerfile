ARG PACKAGE_WHL="https://github.com/caenHV/caen_tools/releases/download/v2.3.9-dev2/caen_tools-2.3.9-py3-none-any.whl"

FROM python:3.12-alpine AS caen_others
ARG PACKAGE_WHL
RUN apk add --no-cache git && \
    apk --update add postgresql-client && \
    pip install "caen_tools @ ${PACKAGE_WHL}"
RUN mkdir /run/postgresql &&\
    chown postgres:postgres /run/postgresql/

FROM ubuntu:22.04 AS base
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

FROM caen_others AS webserver
ARG PACKAGE_WHL
RUN pip install "caen_tools[webservice] @ ${PACKAGE_WHL}"

FROM base AS devback
ARG PACKAGE_WHL
RUN pip install "caen_tools @ ${PACKAGE_WHL}"
