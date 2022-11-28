[#HARDWARE](#HARDWARE)

[#CONFIG-BASICA](#CONFIG-BASICA)

[#DOCKER](#DOCKER)

[#HOME-ASSISTANT](#HOME-ASSISTANT)

[#KODI](#KODI)

[#WEBMIN](#WEBMIN)

[#SAMBA](#SAMBA)

[#TRANSMISSION](#TRANSMISSION)

[#AMULE](#AMULE)

[#FILEBROWSER](#FILEBROWSER)

[#IoTStack](#IoTStack)

[#UNRAR/7z](#UNRAR/7z)

[#CALIBRE-WEB](#CALIBRE-WEB)

[#VARIOS](#VARIOS)

[#COMANDOS_UTILES](#COMANDOS_UTILES)

------------

### HARDWARE

  - Comparativa SD: https://www.pidramble.com/wiki/benchmarks/microsd-cards
  - I/O de la SD:
    - **sudo dd if=/dev/mmcblk0 of=/dev/null bs=8M count=10** Leerá 80 MB y dirá la velocidad
    - **sudo hdparm -t /dev/mmcblk0** similar al anterior
    - <img src="https://github.com/sergioalegre/OS_Tips/blob/master/pics/RPI-SD-IO.jpg">
  - HDMI activar al arrancar:
    - **apt install cec-utils**
    - Sacar el address de la TV con: **echo 'scan' | cec-client -s -d**
    - Activar: **echo 'on <DEVICEADDRESS>' | cec-client -s d 1**
    - <img src="https://github.com/sergioalegre/OS_Tips/blob/master/pics/RPI-TV-CEC.JPG">
  - soporte 4K:
    - conectar al puerto adyacente al USB-C


### CONFIG-BASICA

  - **raspi-config**:
      - activar SSH
      - locale
      - expand filesystem
      - enable 4Kp60

  - cambiar tamaño swap: https://wpitchoune.net/tricks/raspberry_pi3_increase_swap_size.html
      - **/etc/init.d/dphys-swapfile restart** para aplicar

  - **sudo passwd root**
  - **sudo passwd pi**


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
  - Habilitar borrado/renombrado de ficheros en Apariencia--Skin--Lista de archivos
  - Descargar plugins (rar,Luar)
  - Configurar screensaver.picture.slideshow


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
  - montar portatil **sudo mount -t cifs //192.168.0.112/c /mnt/PORTATIL/ -o username="sergio"**
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

      [Fotos_Destacadas]
      	path = /home/pi/Fotos_Destacadas
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

      [Libros]
      	path = /media/DISCO_USB_EXT/calibre/books
        browseable = yes
        guest ok = yes
        read only = no

      [aMule]
      	writeable = yes
      	force user = root
      	force group = root
      	browseable = yes
      	path = /home/amule/.aMule/Incoming
      	public = yes

      [aMule_Temp]
      	writeable = yes
      	force user = root
      	force group = root
      	browseable = yes
      	path = /home/amule/.aMule/Temp
      	public = yes    
      ```


### TRANSMISSION

  - **sudo apt-get install transmission-cli transmission-common transmission-daemon**
  - **sudo service transmission-daemon stop**
  - **cp /var/lib/transmission-daemon/info/settings.json /var/lib/transmission-daemon/info/settings.json.ORIGINAL**
  - **nano /var/lib/transmission-daemon/info/settings.json** cambiar estos parametros:
    - "rpc-whitelist-enabled": false,
    - "download-dir": "/media/DISCO_USB_EXT/Descargas",
    - "incomplete-dir": "/media/DISCO_USB_EXT/Descargas_Incompletas",
    - "incomplete-dir-enabled": true,
  - **sudo service transmission-daemon start**
  - Probar la app user y pass: transmission
  - Cambiar el ratio de compartición al mínimo


### AMULE

  - **sudo apt-get install amule amule-daemon**
  - **sudo adduser amule**
  - **nano /etc/default/amule-daemon** poner AMULED_USER="amule" y AMULED_HOME="/home/amule"
  - **sudo service amule-daemon start**
  - Crear contraseña mi_md5_pass: **echo -n <poner_aqui_contraseña> | md5sum** y copiarnos todo son el espacio ni guion final
  - **sudo nano /home/amule/amule.conf**
    - **AcceptExternalConnections=1**
    - **ECPassword=<mi_md5_pass>**
    - En [WebServer] poner **Enabled=1**
    - **Password=<mi_md5_pass>**
    - **Port=8090**
  - **sudo service amule-daemon restart**
  - GUI preferencias:
    - Files: **Preallocate disk space for new files** y **save 10 sources on rare files**
    - Servers: https://emuling.gitlab.io/server.met
    - Security: http://upd.emule-security.org/ipfilter.zip


### FILEBROWSER

  - https://filebrowser.org/installation
  - **filebrowser -a 192.168.0.2 -p 8888 -r / --noauth**
  - comandos a permitir **mv rm unrar ls mkdir rmdir**


### IoTStack

  - **git clone https://github.com/SensorsIot/IOTstack.git**
  - **cd IOTstack**
  - **./menu.sh**


### UNRAR/7z

  - **echo "deb-src http://mirrordirector.raspbian.org/raspbian/ buster main contrib non-free rpi" | sudo tee -a /etc/apt/sources.list**
  - **cd /tmp**
  - **sudo apt-get build-dep unrar-nonfree;sudo apt-get source -b unrar-nonfree;sudo dpkg -i unrar*.deb;echo 'done'**
  - **sudo apt install --assume-yes p7zip-full**


### CALIBRE-WEB

  - **sudo chown -R pi /media/DISCO_USB_EXT/Calibre**
  - **sudo chgrp -R pi /media/DISCO_USB_EXT/Calibre**
      ```
      docker run -d \
      --name=calibre-web \
      --security-opt="seccomp=unconfined" \
      -e PUID=1000 \
      -e PGID=1000 \
      -e TZ=Europe/Madrid \
      -p 8083:8083 \
      -v /media/DISCO_USB_EXT/Calibre/config:/config \
      -v /media/DISCO_USB_EXT/Calibre/books:/books \
      --restart unless-stopped \
      lscr.io/linuxserver/calibre-web:latest
      ```
  - Admin/Basic Configuration/Enable Uploads
  - Admin/admin:
    - Personalizar vistas
    - Allow eBook Viever y Allow Uploads


### VARIOS

  - Portainer: mostrar Dockers ocultos: Settings / Remove
  - paquetes últiles: **sudo apt-get install tmux**
  - cron job: **sudo chown -R pi /home/pi/Descargas**
  - alias .bashrc:
    - alias la='ls -al --color'
    - alias lm='ls -al --block-size=MB'
    - alias incoming='cd /home/amule/.aMule/Incoming/ && ls'
  - **sudo nano /etc/motd**
        ```
                        .^~:
                      .!!J7
                       :77....
                    ^~::^:.:.^~
                    ! .~ :^  ~~
                   .! .: ..  !.                             .::^^
                   .!   .:::~!                      ...::^^^~^^~~
                   .!^^^?!....          ..::::^^^^^^^^^^:::::::!:
                       .77.  ...::^^^^^^^^^^:::::::::::::::::::7.
                     ..:??^:~!7?~~~~^^^^::^^^^^^:::::::::::::::7.
                    !~^^^::::::7^.        ....::::^^^^^::::::::!
                  .:7:^^~~^^^:^7^^~:                 .....::^^^~
                 ^~~7:7~:^:~7:!..~:!.
                ~!~:~.!^^^^~!:7  .!!~
               ^~~ :~:^^^^^^::!   .!!
              :~!. ^^::::::::~!  .:^~^
             .~^^ .~~~~!:^7~^^. :!~^^~.
            :~!!    :7!^ .!^:
           :!~!^    ~~~: :7!^                .......
                    !.^. ^^^^        ..:^:::^^::::^^^:::::::^^:::...
                    7.7. !:!:  ..:^^^::..                   ......::
                   ^7^!~:7^~7^^^:..
               ..:~7^^^!:~^^~.
            .^^::....
         .:^^.
        ::.

        ```
### COMANDOS_UTILES
  - velodidad CPU: **cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq**

  - velocidad SD: **while true; do sudo dd if=/dev/mmcblk0 of=/dev/null bs=8M count=10; sleep 5; done**

  - temperatura CPU: **vcgencmd measure_tempnano**

  - TRANSMISSION config: **/etc/transmission-daemon/settings.json**
  - servicio: **sudo systemctl start transmission-daemon**

  - ls en MB: **ls -al --block-size=MB**

  - cambiar prompot y colores: **PS1='\e[33;1m\u@\h: ' && LS_COLORS="di=1;35:ex=4;31:*.mp3=1;32;41"**

  - Home assistant:
    - **systemctl stop hassio-supervisor && docker ps -a -q | xargs docker stop**
    - **systemctl status hassio-supervisor**

  - FileBrowsers: **sudo filebrowser -a 192.168.0.2 -p 8888 -r /**

   - Inventario: **lm -R -l > 211230_inventario.txt**

   - Tamaño carpetas (Series,Pelis) del disco externo: **du -h --max-depth=1 /media/DISCO_USB_EXT/**

   - resolucion video, codec, idiomas, subtitulos: **ffmpeg -i VIDEO.MDK**

   - montar PORTATIL: **sudo mount -t cifs //192.168.0.112/c /mnt/PORTATIL/ -o username="sergio"**

   - aMule: **sudo service amule-daemon start**
