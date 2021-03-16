FROM ubuntu:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y --no-install-recommends python3-pip python3-dev build-essential net-tools iproute2 tcpdump \
    telnet traceroute curl iperf3 knot-host openssh-client mtr-tiny socat nano vim-tiny nmap iputils-ping && \
    rm -rf /var/lib/apt/lists/*

VOLUME [ "/root" ]

WORKDIR /root