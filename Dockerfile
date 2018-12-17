FROM debian:jessie

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gawk \
        rsyslog \
        openssl \
        ca-certificates \
        ssh \
        parted \
        sudo \
        net-tools \
        ifupdown \
        python \
        eject \
        python-pyasn1 \
        python-setuptools \
        python-rpm && \
        apt-get clean && rm -rf /var/lib/apt/lists/*

COPY . /WALinuxAgent
WORKDIR /WALinuxAgent
RUN python setup.py install
COPY waagent.conf /etc/waagent.conf
COPY bin/* /usr/sbin/

RUN chmod +x /usr/sbin/waagent && \
    ln -sf /dev/stdout /var/log/waagent.log

ENTRYPOINT ["/usr/sbin/waagent", "-daemon", "-verbose"]