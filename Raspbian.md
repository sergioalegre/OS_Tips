[#HARDWARE](#HARDWARE)

[#CONFIG-BASICA](#CONFIG-BASICA)

[#DOCKER](#DOCKER)

[#HOME-ASSISTANT](#HOME-ASSISTANT)

[#KODI](#KODI)

[#WEBMIN](#WEBMIN)

[#SAMBA](#SAMBA)

[#TRANSMISSION](#TRANSMISSION)

[#VARIOS](#VARIOS)


------------

### HARDWARE

  - Comparativa SD: https://www.pidramble.com/wiki/benchmarks/microsd-cards
  - I/O de la SD:
    - **sudo dd if=/dev/mmcblk0 of=/dev/null bs=8M count=10** Leerá 80 MB y dirá la velocidad
    - **sudo hdparm -t /dev/mmcblk0** similar al anterior
    - <img src="https://github.com/sergioalegre/OS_Tips/blob/master/pics/RPI-SD-IO.jpg">

### CONFIG-BASICA

  - **raspi-config**:
      - activar SSH
      - locale
      - expand filesystem

  - cambiar tamaño swap: https://wpitchoune.net/tricks/raspberry_pi3_increase_swap_size.html
      - **/etc/init.d/dphys-swapfile restart** para aplicar

  - **sudo passwd root**
  - **sudo passwd pi**

  - configurar para que arranque el HDMI al arrancar la PI
    - **apt install cec-utils**
    - Sacar el address de la TV con: **echo 'scan' | cec-client -s -d**
    - Activar: **echo 'on <DEVICEADDRESS>' | cec-client -s d 1**


### DOCKER

  - **curl -fsSL https://get.docker.com -o get-docker.sh**
  - **sudo sh get-docker.sh**
  - **sudo usermod -aG docker pi**

  - Intercambio claves SSH:
    - En el host: en /etc/sudoers poner al final: **pi ALL=(ALL) NOPASSWD: ALL**
    - En la consola del docker: **ssh-keygen** nos le generará en el dir .ssh
      - copiarle al host: **cd .ssh && ssh-copy-id -i id_rsa pi@192.168.0.2**
      - **yes**
      - **poner la pass de pi**
      - Prueba1: comprobar funcione con ssh pi@192.168.0.2 (no deberia pedir password)
      - **exit**
      - **cd ..**
      - Prueba2: **ssh -i .ssh/id_rsa -o StrictHostKeyChecking=no pi@192.168.0.2 date**


### HOME-ASSISTANT

  - **mkdir homeassistant**
  - **sudo apt-get install -y software-properties-common apparmor-utils apt-transport-https avahi-daemon ca-certificates curl dbus jq network-manager socat**
  - **curl -Lo installer.sh https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh**
  - **sudo bash installer.sh --machine raspberrypi3 -d /home/pi/homeassistant**
  - **y** a la pregunta: tarda unos 10 min
  - acceder por **http://192.168.0.2:8123/** tarda unos25 min


### KODI

  - **sudo apt-get install kodi**
  - Configurar para arrancar al inicio: https://gist.github.com/Cyberek/33af1b92c071791a71aa8bccf87b8a3a
    - **sudo nano /etc/init.d/kodi**
    - **sudo nano /etc/default/kodi**
    - **sudo chmod a+x /etc/init.d/kodi**
    - **sudo update-rc.d kodi defaults**
  - Tweaks kodi segun modelo raspberry: https://www.raspberrypi.org/forums/viewtopic.php?t=251645


### WEBMIN

  - Instrucciones: https://www.webmin.com/deb.html
    - **sudo nano /etc/apt/sources.list**
    - Añadir **deb https://download.webmin.com/download/repository sarge contrib**
    - **cd /root**
    - **wget https://download.webmin.com/jcameron-key.asc**
    - **apt-key add jcameron-key.asc**
    - **sudo apt-get update && sudo apt-get install webmin**
  - 2FA: https://doxfer.webmin.com/Webmin/Enhanced_Authentication
  - Dark Mode: en el panel de la izquierda (simbolo luna)


### SAMBA
  - montar USB desde webmin de modo permanente
  - **sudo mkdir /media/DISCO_USB_EXT**
  - Configurar:
      ```
      [DISCO_USB_EXT]
      	path = /media/DISCO_USB_EXT
          browseable = yes
          guest ok = yes
          read only = no

      [Documentales]
      	path = /media/DISCO_USB_EXT/Documentales
          browseable = yes
          guest ok = yes
          read only = no

      [Descargas]
      	path = /media/DISCO_USB_EXT/Descargas
          browseable = yes
          guest ok = yes
          read only = no

      [Intercambio]
      	path = /media/DISCO_USB_EXT/Intercambio
          browseable = yes
          guest ok = yes
          read only = no

      [Juegos]
      	path = /media/DISCO_USB_EXT/Juegos
          browseable = yes
          guest ok = yes
          read only = no

      [Otros]
      	path = /media/DISCO_USB_EXT/Otros
          browseable = yes
          guest ok = yes
          read only = no

      [Peliculas]
      	path = /media/DISCO_USB_EXT/Peliculas
          browseable = yes
          guest ok = yes
          read only = no

      [Series]
      	path = /media/DISCO_USB_EXT/Series
          browseable = yes
          guest ok = yes
          read only = no

      [homeassistant]
      	browseable = yes
      	path = /home/pi/homeassistant/homeassistant/
      	writable = yes
      	force user = root
      	guest ok = yes
      	force group = root
      ```





###TRANSMISSION

  - **sudo apt-get install transmission-cli transmission-common transmission-daemon**
  - **sudo service transmission-daemon stop**
  - **cp /var/lib/transmission-daemon/info/settings.json /var/lib/transmission-daemon/info/settings.json.ORIGINAL**
  - **nano /var/lib/transmission-daemon/info/settings.json** cambiar estos parametros:
    - "rpc-whitelist": "127.0.0.1,192.168.*.*",
    - "download-dir": "/media/DISCO_USB_EXT/Descargas",
    - "incomplete-dir": "/media/DISCO_USB_EXT/Descargas_Incompletas",
    - "incomplete-dir-enabled": true,
  - **sudo service transmission-daemon start**
  - Probar la app user y pass: transmission
  - Cambiar el ratio de compartición al mínimo


###VARIOS

  - Portainer: mostrar Dockers ocultos: Settings / Remove
  - paquetes últiles: **sudo apt-get install locate**
