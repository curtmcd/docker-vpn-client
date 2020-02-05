FROM ubuntu:18.04

RUN apt update && apt upgrade -y

RUN apt install --no-install-recommends -y \
    net-tools iputils-ping openssh-client vim \
    openvpn \
    transmission-daemon transmission-cli

# Install startup script into image. We don't bake /tmp/client.ovpn into
# the image, so it must be passed in via volume mount in run.sh.

COPY start.sh /tmp/

# You could just have /bin/bash here
CMD /tmp/start.sh
