FROM ubuntu:24.04

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=UTC \
    RUNS_IN_DOCKER=true

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    vim \
    git \
    build-essential \
    lsb-release \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user (optional but recommended)
RUN useradd -ms /bin/bash appuser && \
    echo "appuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER appuser
ENV USER=appuser
WORKDIR /home/appuser

RUN git clone https://github.com/Siddhant085/PX4-Autopilot.git --recursive

WORKDIR /home/appuser/PX4-Autopilot

RUN bash ./Tools/setup/ubuntu.sh
ENTRYPOINT ["make", "px4_sitl", "gz_x500"]
