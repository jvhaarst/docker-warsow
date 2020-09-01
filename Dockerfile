FROM ubuntu:20.04
MAINTAINER Jan van Haarst <jan@vanhaarst.net>

ADD cfg /opt/wsw_cfg/
RUN apt-get update
RUN apt-get install wget libcurl3 libcurl3-gnutls -y

# Install game from warsow.net
RUN wget --no-verbose -O warsow-2.1.2.tar.gz http://warsow.net/warsow-2.1.2.tar.gz
RUN tar zxf warsow-2.1.2.tar.gz -C /opt/
RUN chmod +x /opt/warsow-2.1.2/wsw_server*

# Setup user
RUN useradd -m -s /bin/bash warsow
RUN chown -R warsow:warsow /opt/warsow-2.1.2

# Setup server
WORKDIR /opt/warsow-2.1.2
USER warsow
EXPOSE 44401/udp

CMD ./wsw_server +set fs_usehomedir 0 +set fs_basepath /opt/warsow-2.1.2/ +set dedicated 1
