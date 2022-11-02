#!/bin/bash

# Replace the previous default gateway with this one
ip route replace default via 10.5.2.1 dev eth0

# permitir el trafico forward de conexiones establecidas o relacionadas para los protocolos TCP, UDP y ICMP
iptables -A FORWARD -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p udp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT

#

/usr/sbin/sshd -D
