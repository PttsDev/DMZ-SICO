#################################################################
#                                                               #
# Roberto Viejo López                                           #
# SICO - Práctica configuración DMZ                             #
#################################################################
# Dockerfile para las maquinas de la red externa                #
# que contiene su configuración inicial                         #
#################################################################



FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y openssh-server net-tools iputils-ping traceroute nano iptables iptables-dev pkg-config iproute2 tcpdump nmap apache2 ufw
RUN apt-get install -y curl apache2-utils
RUN apt-get install -y tcpdump
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 22
EXPOSE 80
COPY ./start.sh .
RUN chmod +x start.sh
CMD ["./start.sh"]