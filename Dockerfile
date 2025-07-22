# Dockerfile for Zephyr RTOS environment
FROM ubuntu:22.04

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    zip \
    tar \
    wget \
    cmake \
    ninja-build \
    gperf \
    ccache \
    dfu-util \
    device-tree-compiler \
    python3-dev \
    python3-setuptools \
    python3-tk \
    python3-wheel \
    xz-utils \
    file \
    make \
    gcc \
    g++ \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Configure timezone
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Install west tool
RUN pip3 install --upgrade pip
RUN pip3 install west

# Set up Zephyr environment using west
WORKDIR /opt
RUN west init -m https://github.com/zephyrproject-rtos/zephyr.git zephyrproject
WORKDIR /opt/zephyrproject 
RUN west update
RUN west zephyr-export

# Install Python requirements for Zephyr
RUN pip3 install -r scripts/requirements.txt

# Archive zephyrproject, .env file, and Python packages
WORKDIR /opt
RUN tar -czvf zephyr_env.tar.gz zephyrproject zephyrproject/.env $(python3 -c "import site; print(site.getsitepackages()[0])")

# Default command
CMD ["/bin/bash"]
