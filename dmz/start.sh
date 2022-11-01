#!/bin/bash

# Replace the previous default gateway with this one
ip route replace default via 10.5.1.1 dev eth0

/usr/sbin/sshd -D
