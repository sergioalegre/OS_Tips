[#HARDWARE](#HARDWARE)

[#CONFIG-BASICA](#CONFIG-BASICA)

[#DOCKER](#DOCKER)

[#HOME-ASSISTANT](#HOME-ASSISTANT)

[#KODI](#KODI)

[#WEBMIN](#WEBMIN)

[#SAMBA](#SAMBA)

[#TRANSMISSION](#TRANSMISSION)

[#TRANSMISSION-DOCKER](#TRANSMISSION-DOCKER)

[#AMULE](#AMULE)

[#FILEBROWSER](#FILEBROWSER)

[#IoTStack](#IoTStack)

[#UNRAR/7z](#UNRAR/7z)

[#CALIBRE-WEB](#CALIBRE-WEB)

[#NGINX-PROXY-MANAGER](#NGINX-PROXY-MANAGER)

[#PORTAINER](#PORTAINER)

[#WORDPRESS+MYSQL+PHPMYADMIN_raspberryPi4](#WORDPRESS+MYSQL+PHPMYADMIN_raspberryPi4)

[#NGINX_PHP](#NGINX_PHP)

[#VARIOS](#VARIOS)

[#PROBLEMAS_CONOCIDOS](#PROBLEMAS_CONOCIDOS)

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


### TRANSMISSION-DOCKER  
  - nota: hubo que usar seccomp:unconfined porque sino el docker no arrancaba

    ```
    version: "2.1"
    services:
      transmission:
        image: lscr.io/linuxserver/transmission
        container_name: transmission
        security_opt:
          - seccomp:unconfined
        environment:
          - PUID=1000
          - PGID=1000
          - TZ=America/Argentina/Buenos_Aires
          - TRANSMISSION_WEB_HOME=/combustion-release/ #optional
        volumes:
          - /home/pi/dockers/transmission/config:/config
          - /home/pi/dockers/transmission/downloads:/downloads
          - /home/pi/dockers/transmission/watch:/watch
        ports:
          - 9091:9091
          - 51413:51413
          - 51413:51413/udp
    ```      

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
  - en docker **/srv** ha de apuntar a **/** en el host
  - legacy:
    - https://filebrowser.org/installation
    - **filebrowser -a 192.168.0.2 -p 8888 -r / --noauth**
    - comandos a permitir **pwd mv rm unrar ls mkdir rmdir**


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


### NGINX-PROXY-MANAGER

      ```
      docker run -d \
      --name=nginx-proxy-manager \
      -p 80:80  \
      -p 81:81  \
      -p 443:443
      -v /home/pi/npm/data:/data  \
      -v /home/pi/npm/letsencrypt:/etc/letsencrypt  \
      --restart unless-stopped \
      jc21/nginx-proxy-manager
      ```

### PORTAINER

    - **docker volume create portainer_nuevo**

    ```
    docker run -d \
    -p 8000:8000 \
    -p 9000:9000 \
    --name=portainer \
    --restart=unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_nuevo:/data \
    portainer/portainer-ce
    ```

### WORDPRESS+MYSQL+PHPMYADMIN_raspberryPi4
      ```
      version: '3.6'

      services:
        wordpress:
          container_name: wordpress
          image: wordpress:5.7.2
          ports:
            - 8081:80
          environment:
            - "WORDPRESS_DB_USER=root"
            - "WORDPRESS_DB_PASSWORD=CAMBIAESTACONTRASEÑA"
          restart: always
          dns: 8.8.8.8
          volumes:
            - /home/pi/wp_data:/var/www/html

        mysql:
          container_name: mysql
          image: jsurf/rpi-mariadb
          volumes:
          - /home/pi/mysql:/var/lib/mysql
          environment:
          - "MYSQL_ROOT_PASSWORD=CAMBIAESTACONTRASEÑA"
          - "MYSQL_DATABASE=wordpress"
          restart: always

        phpmyadmin:
            container_name: phpmyadmin
            image: mt08/rpi-phpmyadmin    
            depends_on:      
              - mysql
            ports:      
              - "8082:80"        
            environment:
              - PMA_ROOT_USER=root
              - PMA_USER=root
              - PMA_ARBITARY=1
              - PMA_HOST=mysql
              - PMA_PASSWORD=CAMBIAESTACONTRASEÑA    
      ```


### NGINX_PHP:

      - **sudo apt install php-fpm php-common php7.3-cli php7.3-common php7.3-fpm php7.3-json php7.3-opcache php7.3-readline nginx libgd3 libnginx-mod-http-auth-pam libnginx-mod-http-dav-ext libnginx-mod-http-echo libnginx-mod-http-geoip libnginx-mod-http-image-filter libnginx-mod-http-subs-filter libnginx-mod-http-upstream-fair libnginx-mod-http-xslt-filter libnginx-mod-mail libnginx-mod-stream nginx-common nginx-full**
      - editar este archivo: **cd /etc/nginx/sites-available && nano default**:
        - en esta linea añadir index.php: index index.html index.htm to index **index.php** index.html index.htm
        - descomentar las lineas de php$ para dejarlo asi:
                ```
                location ~ \.php$ {
                  include snippets/fastcgi-php.conf;
                  fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
                }
                ```
      - **sudo systemctl restart nginx**


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


### PROBLEMAS_CONOCIDOS
  - Problema con dockers: <b>libseccomp2</b> o <b>warning: unable to iopause</b>,
    - Solución: en docker run: <b>--security-opt seccomp=unconfined</b> en docker compose:
    ```
    security_opt:
      - seccomp:unconfined
    ```


### COMANDOS_UTILES
  - velocidad CPU: **cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq**

  - velocidad SD: **while true; do sudo dd if=/dev/mmcblk0 of=/dev/null bs=8M count=10; sleep 5; done**

  - temperatura CPU: **vcgencmd measure_tempnano**

  - TRANSMISSION config: **/etc/transmission-daemon/settings.json**
    - servicio: **sudo systemctl start transmission-daemon**

  - ls en MB: **ls -al --block-size=MB**

  - cambiar prompt y colores: **PS1='\e[33;1m\u@\h: ' && LS_COLORS="di=1;35:ex=4;31:*.mp3=1;32;41"**

  - Home assistant:
    - **systemctl stop hassio-supervisor && docker ps -a -q | xargs docker stop**
    - **systemctl status hassio-supervisor**

  - FileBrowser: **sudo filebrowser -a 192.168.0.2 -p 8888 -r /**

  - Inventario: **lm -R -l > 211230_inventario.txt**

  - Tamaño carpetas (Series,Pelis) del disco externo: **du -h --max-depth=1 /media/DISCO_USB_EXT/**

  - resolucion video, codec, idiomas, subtitulos: **ffmpeg -i VIDEO.MDK**

  - montar PORTATIL: **sudo mount -t cifs //192.168.0.112/c /mnt/PORTATIL/ -o username="sergio"**

  - aMule: **sudo service amule-daemon start**
