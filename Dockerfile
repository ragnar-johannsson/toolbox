FROM debian:jessie
MAINTAINER Ragnar B. Johannsson <ragnar@igo.is>

RUN sed -i 's/$/ contrib non-free/' /etc/apt/sources.list && apt-get update

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
        atop    \
        dstat   \
        htop    \
        ltrace  \
        strace  \
        sysstat

# IO
RUN apt-get install -y --no-install-recommends \
        blktrace \
        iotop    \
        iozone3  \
        lsof

# Networking
RUN apt-get install -y --no-install-recommends \
        arping          \
        bridge-utils    \
        ca-certificates \
        curl            \
        ethtool         \
        iftop           \
        iperf           \
        iproute2        \
        mtr-tiny        \
        net-tools       \
        nicstat         \
        nmap            \
        tcpdump

# Sysdig
RUN curl -s https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public \
        | apt-key add - \
    && curl -s http://download.draios.com/stable/deb/draios.list \
        > /etc/apt/sources.list.d/draios.list \
    && curl -s http://download.draios.com/apt-draios-priority \
        > /etc/apt/preferences.d/apt-draios-priority \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc     \
        gcc-4.8 \
        sysdig  \
    && ln -s /media/root/lib/modules /lib/modules

# Docker
RUN echo "deb https://get.docker.com/ubuntu docker main" \
        > /etc/apt/sources.list.d/docker.list \
    && apt-key adv --keyserver hkp://pgp.mit.edu \
        --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
    && apt-get install -y --no-install-recommends apt-transport-https \
    && apt-get update \
    && apt-get install -y --no-install-recommends lxc-docker-1.6.2

# Dotfiles
RUN git clone https://github.com/ragnar-johannsson/dotfiles.git /tmp/dotfiles \
    && cp /tmp/dotfiles/zshrc.symlink /root/.zshrc \
    && cp /tmp/dotfiles/vimrc.symlink /root/.vimrc \
    && cp -r /tmp/dotfiles/zsh.symlink /root/.zsh  \
    && cp -r /tmp/dotfiles/vim.symlink /root/.vim  \
    && zsh -i -c "cat /dev/null" \
    && sed -i 's/^colorscheme /" colorscheme /' /root/.vimrc \
    && sed -i '/fzf/s_\./install_echo nnn \\| \./install_' /root/.vimrc \
    && vim +PlugInstall +qall \
    && sed -i 's/^" colorscheme /colorscheme /' /root/.vimrc \
    && sed -i "/'.*separator'/d" /root/.vimrc \
    && sed -i '/fzf/d' /root/.bashrc \
    && sed -i '/fzf/d' /root/.zshrc \
    && touch /root/.z \
    && rm -rf /tmp/dotfiles

CMD ["/bin/zsh"]

