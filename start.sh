VPN_LOG=/tmp/openvpn.log
TD_LOG=/tmp/td.log

# Docker derives an /etc/resolv.conf file at startup.
# Replace it here to use fixed nameservers.

echo "Using Google nameservers"
cat >/etc/resolv.conf <<EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

echo "Starting VPN client, logging to $VPN_LOG"
openvpn --daemon --log-append $VPN_LOG --config /tmp/client.ovpn

echo "Starting transmission-daemon, logging to $TD_LOG"
transmission-daemon --logfile $TD_LOG

echo "Container will exit when this shell exits"
exec /bin/bash
