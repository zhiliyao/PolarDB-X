FROM centos:7

ARG BUILD_PATH=/home/polarx/PolarDB-X/build

RUN yum install sudo hostname telnet net-tools vim tree less file java-1.8.0-openjdk-devel -y && \
    yum install openssl-devel ncurses-devel libaio-devel -y && \
    yum clean all && rm -rf /var/cache/yum && rm -rf /var/tmp/yum-*

RUN useradd -ms /bin/bash polarx && \
    echo "polarx:polarx" | chpasswd && \
    echo "polarx    ALL=(ALL)    NOPASSWD: ALL" >> /etc/sudoers && \
    echo "export BUILD_PATH=$BUILD_PATH" >> /etc/profile && \
    echo 'PATH="$BUILD_PATH/run/galaxyengine/u01/mysql/bin:$BUILD_PATH/run/bin:$PATH"' >> /etc/profile && \
    echo "export PATH" >> /etc/profile

USER polarx
WORKDIR /home/polarx

COPY --chown=polarx run $BUILD_PATH/run
COPY --chown=polarx entrypoint.sh entrypoint.sh

ENTRYPOINT entrypoint.sh
