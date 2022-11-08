#!/bin/bash

#################################################################
#                                                               #
# Roberto Viejo López                                           #
# SICO - Práctica configuración DMZ                             #
#################################################################
# Script de inicip para las maquinas de la red externa          #
#                                                               #
#################################################################

# Replace the previous default gateway with this one
ip route replace default via 10.5.0.1 dev eth0

# start apache
/etc/init.d/apache2 start

# start apache default
update-rc.d apache2 enable

/usr/sbin/sshd -D
