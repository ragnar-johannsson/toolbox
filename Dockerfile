FROM debian:jessie
MAINTAINER Ragnar B. Johannsson <ragnar@igo.is>

RUN apt-get update

# Generic
RUN apt-get install -y --no-install-recommends \
        dstat   \
        htop    \
        ltrace  \
        strace  \
        sysstat
