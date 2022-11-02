#!/bin/bash

# Replace the previous default gateway with this one
ip route replace default via 10.5.0.1 dev eth0

# start apache
/etc/init.d/apache2 start

# start apache default
update-rc.d apache2 enable

# Allow traffic for apache
ufw allow "Apache Full"

/usr/sbin/sshd -D
