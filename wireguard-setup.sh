#!/bin/bash

# Secure WireGuard server installer
# https://github.com/HessamAyoubi/Easy_WireGuard/

# Generate public and private keys for server and client
server_priv_key=$(wg genkey)
server_pub_key=$(echo $server_priv_key | wg pubkey)
client_priv_key=$(wg genkey)
client_pub_key=$(echo $client_priv_key | wg pubkey)

# Create WireGuard configuration file
cat > /etc/wireguard/wg0.conf <<EOF
[Interface]
Address = 10.1.1.1/24
PrivateKey = $server_priv_key
ListenPort = 51820
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE; sysctl -w net.ipv4.ip_forward=1
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE; sysctl -w net.ipv4.ip_forward=0

[Peer]
PublicKey = $client_pub_key
AllowedIPs = 10.1.1.2/32
EOF

# Set Google DNS servers
echo "nameserver 8.8.8.8" > /etc/resolvconf/resolv.conf.d/head
echo "nameserver 8.8.4.4" >> /etc/resolvconf/resolv.conf.d/head

# Enable IP forwarding and Masquerade
sysctl -w net.ipv4.ip_forward=1
iptables -A FORWARD -i wg0 -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Restart the resolvconf service
systemctl restart resolvconf.service

# Start the WireGuard service
wg-quick up wg0

# Generate client configuration file
cat > client.conf <<EOF
[Interface]
PrivateKey = $client_priv_key
Address = 10.1.1.2/24
DNS = 8.8.8.8

[Peer]
PublicKey = $server_pub_key
Endpoint = $(curl -s ifconfig.co):51820
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 21
EOF

# Display client configuration file
echo "Client configuration file:"
cat client.conf
