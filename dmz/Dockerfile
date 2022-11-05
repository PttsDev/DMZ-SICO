FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y openssh-server net-tools iputils-ping traceroute nano iptables iptables-dev pkg-config iproute2 tcpdump nmap apache2 ufw
RUN apt-get install -y curl apache2-utils tcpdump fail2ban
RUN apt-get install -y libpam-google-authenticator
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
#RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# A.1. 

# create new user with no root permissions
RUN useradd -m -s /bin/bash normaluser || true 
RUN echo 'normaluser:1234' | chpasswd

RUN useradd -m -s /bin/bash publickeyuser || true
RUN echo 'publickeyuser:1234' | chpasswd

# modify open ssh to listen to port 2222
RUN sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config

# not allow root login 
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin no/' /etc/ssh/sshd_config

# allow login with password when not empty
RUN sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#?PermitEmptyPasswords\s+.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config

#allow login with public key
RUN sed -ri 's/^#?PubkeyAuthentication\s+.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# max auth tries 2
RUN sed -ri 's/^#?MaxAuthTries\s+.*/MaxAuthTries 2/' /etc/ssh/sshd_config

# personalized MOTD message with ROBERTO Written in ASCII art
RUN sed -i 's/PrintMotd no/PrintMotd yes/g' /etc/ssh/sshd_config
RUN sed -i 's/session optional pam_motd.so noupdate/#session optional pam_motd.so noupdate/g' /etc/pam.d/sshd
COPY ./customMotd.txt /etc/motd

# Authenticator google line to pam.d
RUN echo "auth required pam_google_authenticator.so" >> /etc/pam.d/sshd
RUN echo "auth required pam_permit.so" >> /etc/pam.d/sshd

# Modify /etc/ssh/sshd_config – change ChallengeResponseAuthentication from no to yes
RUN sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config


RUN mkdir /root/.ssh
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 2222
EXPOSE 80
COPY ./start.sh .
RUN chmod +x start.sh
CMD ["./start.sh"]

