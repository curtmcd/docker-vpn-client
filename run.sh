# Run the docker image

OPENVPN_CONFIG=client.ovpn
FILES_DIR=/tmp/files

if [ ! -f $OPENVPN_CONFIG ]; then
    echo >&2 "$0: Cannot find OpenVPN configuration file ./client.ovpn (see README)"
    exit 1
fi

sudo docker run -ti --rm \
     -v /dev/net:/dev/net \
     -v $(pwd)/$OPENVPN_CONFIG:/tmp/$OPENVPN_CONFIG:ro \
     -v $FILES_DIR:$FILES_DIR \
     --cap-add=NET_ADMIN \
     docker-vpn-client
