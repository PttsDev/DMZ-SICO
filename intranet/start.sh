#!/bin/bash

#################################################################
#                                                               #
# Roberto Viejo López                                           #
# SICO - Práctica configuración DMZ                             #
#################################################################
# Script para las maquinas de la red interna                    #
#                                                               #
#################################################################

# Replace the previous default gateway with this one
ip route replace default via 10.5.2.1 dev eth0

/usr/sbin/sshd -D
