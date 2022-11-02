#!/bin/bash

# Replace the previous default gateway with this one
# ip route replace default via ... dev eth0

# Activar el bit de forwarding
echo 1 >/proc/sys/net/ipv4/ip_forward

# Cambiar la politica por defecto de las cadenas input y forward a drop
iptables -P INPUT DROP
iptables -P FORWARD DROP

# Output accept
iptables -P OUTPUT ACCEPT

# Permitir tráfico entrante a traves de loopback
iptables -A INPUT -i lo -j ACCEPT

# Permitir trafico entrante a través de cualquier conexión previamente establecida
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Permitir consultas entrantes del tipo ICMP ECHO REQUEST
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

/usr/sbin/sshd -D
