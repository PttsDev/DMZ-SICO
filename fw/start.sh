#!/bin/bash

#################################################################
#                                                               #
# Roberto Viejo López                                           #
# SICO - Práctica configuración DMZ                             #
#################################################################
# Script para la maquina que ejerce de firewall                 #
# sobre todo contiene reglas iptables                           #
#################################################################

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

# Permitir trafico de conexiones establecidas o relacionadas par alos protocolos TCP, UDP e ICMP
iptables -A FORWARD -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p udp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT

# Permitir tráfico que entre en fw a través de la interfaz de red interna y salga por la interfaz de red externa con protocolos TCP, UDP e ICMP
EXTRANET_IF=eth1
INTRANET_IF=eth2
ACCEPTED_IP_RANGE="10.5.2.0/24"

iptables -A FORWARD -i $INTRANET_IF -o $EXTRANET_IF -s $ACCEPTED_IP_RANGE -p tcp -j ACCEPT
iptables -A FORWARD -i $INTRANET_IF -o $EXTRANET_IF -s $ACCEPTED_IP_RANGE -p udp -j ACCEPT
iptables -A FORWARD -i $INTRANET_IF -o $EXTRANET_IF -s $ACCEPTED_IP_RANGE -p icmp -j ACCEPT

# Paquetes que abandonen la red interna y entren en la red externa deben cambiar la ip origen por la ip del fw en esa interfaz
FW_EXTERNAL_IP="10.5.0.1"

iptables -t nat -A POSTROUTING -o $EXTRANET_IF -s $ACCEPTED_IP_RANGE -j SNAT --to-source $FW_EXTERNAL_IP

# Configuraciones DMZ
DMZ_IP="10.5.1.20"
INT1_IP="10.5.2.20"

# Acceso TCP desde cualquier maquina a la maquina de la DMZ, exclusivamente al servicio HTTP
iptables -A FORWARD -p tcp -d $DMZ_IP --dport 80 -j ACCEPT

# Acceso SSH desde int1 a la dmz
iptables -A FORWARD -p tcp -s $INT1_IP -d $DMZ_IP --dport 22 -j ACCEPT

#A.1. Acceso a SSH desde int1 a la dmz por puerto 2222
iptables -A FORWARD -p tcp -s $INT1_IP -d $DMZ_IP --dport 2222 -j ACCEPT

# A.2.
# Aceptar trafico https a la dmz
iptables -A FORWARD -p tcp -d $DMZ_IP --dport 443 -j ACCEPT

/usr/sbin/sshd -D
