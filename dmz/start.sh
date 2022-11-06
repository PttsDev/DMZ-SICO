#!/bin/bash

# Replace the previous default gateway with this one
ip route replace default via 10.5.1.1 dev eth0

# start apache
/etc/init.d/apache2 start

# start apache default
update-rc.d apache2 enable

# Log file for fail2ban
touch /var/log/auth.log

# create a jail

touch /etc/fail2ban/jail.local

echo '[sshd]
mode = aggresive
enabled = true
port = 2222
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
findtime = 300
bantime = 3600
ignoreip = 127.0.0.1' >/etc/fail2ban/jail.local

# start fail2ban
/etc/init.d/fail2ban start

# modify index.html from apache
echo '<html>\<Hola mundo desde la primera practica de Sistemas Confiables!". \</html>' >/var/www/html/index.html

/usr/sbin/sshd -D
