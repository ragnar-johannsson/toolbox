FROM debian:jessie
MAINTAINER Ragnar B. Johannsson <ragnar@igo.is>

RUN apt-get update

# Convenience
RUN apt-get install -y --no-install-recommends \
        file     \
        git      \
        less     \
        man-db   \
        manpages \
        vim      \
        zsh

# Generic
RUN apt-get install -y --no-install-recommends \
        dstat   \
        htop    \
        ltrace  \
        strace  \
        sysstat

# IO
RUN apt-get install -y --no-install-recommends \
        blktrace \
        iotop    \
        lsof

# Networking
RUN apt-get install -y --no-install-recommends \
        arping          \
        bridge-utils    \
        ca-certificates \
        curl            \
        ethtool         \
        iftop           \
        iproute2        \
        mtr-tiny        \
        net-tools       \
        nicstat         \
        nmap            \
        tcpdump
