## SICO - Práctica configuración DMZ

### Roberto Viejo López

### Los archivos que conforman esta entrega son:

- Un dockerfile y un start.sh para cada tipo de máquina distinta
- En la DMZ un customMotd.txt para el banner personalizado de un ejercicio opcional
- docker-compose.yml para levantar los contenedores
- Este archivo de manifiesto README.md

### Anotaciones:

- A causa del ejercicio voluntario el ssh no funciona en el puerto 22, funcionando exclusivamente en el puerto 2222, ya que, al no especificarse, asumí que solo debía funcionar en ese puerto.
  Pese a ello, en el video demostración se muestra su uso en el puerto 22 previo a la realización del ejercicio opcional.

- En caso de ser necesario, en este repositorio se encuentran las versiones que corresponden a la parte obligatoria y partes opcionales, la más actualizada es la de esta entrega: https://github.com/PttsDev/DMZ-SICO

* #### Video de demostración de la práctica: https://drive.google.com/file/d/19zxrZQeH0aaq-8iz1827gpfqxyGZkSHK/view?usp=share_link

* #### Usuarios creados y utilizados:

  - Usuario sin permisos en la DMZ con contraseña: normaluser : 1234
  - Usuario sin permisos en la DMZ con clave publica: publickeyuser : 1234

### Salida de los comandos IP address

#### IP address dmz1:

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
33: eth0@if34: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:01:14 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.1.20/24 brd 10.5.1.255 scope global eth0
       valid_lft forever preferred_lft forever
```

#### IP address ext1:

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
35: eth0@if36: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:00:14 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.0.20/24 brd 10.5.0.255 scope global eth0
       valid_lft forever preferred_lft forever
```

#### IP address int1:

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
29: eth0@if30: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:02:14 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.2.20/24 brd 10.5.2.255 scope global eth0
       valid_lft forever preferred_lft forever
```

#### IP address int2:

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
31: eth0@if32: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:02:15 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.2.21/24 brd 10.5.2.255 scope global eth0
       valid_lft forever preferred_lft forever
```

#### IP address fw:

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
23: eth0@if24: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:01:01 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.1.1/24 brd 10.5.1.255 scope global eth0
       valid_lft forever preferred_lft forever
25: eth1@if26: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:00:01 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.0.1/24 brd 10.5.0.255 scope global eth1
       valid_lft forever preferred_lft forever
27: eth2@if28: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:02:01 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.2.1/24 brd 10.5.2.255 scope global eth2
       valid_lft forever preferred_lft forever
```
