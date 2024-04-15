FROM ubuntu:latest

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages and cleanup 
RUN apt-get update && \
    apt-get install -y systemd python3 sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    find /etc/systemd/system /lib/systemd/system -type l -name '*.wants' -exec rm -f {} \; && \
    find /lib/systemd/system/sysinit.target.wants/ -type l -name '*udev*' -exec rm -f {} \; && \
    rm -f /lib/systemd/system/multi-user.target.wants/* && \
    rm -f /lib/systemd/system/local-fs.target.wants/* && \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -f /lib/systemd/system/basic.target.wants/* && \
    rm -f /lib/systemd/system/anaconda.target.wants/*

# Configure container to run systemd
VOLUME [ "/sys/fs/cgroup" ]
CMD [ "/lib/systemd/systemd" ]
