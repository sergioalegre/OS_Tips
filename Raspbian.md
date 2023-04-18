[#HARDWARE](#HARDWARE)

[#CONFIG-BASICA](#CONFIG-BASICA)

[#CONFIG-TXT](#CONFIG-TXT)

[#DOCKER](#DOCKER)

[#MY_DOCKERS](#MY_DOCKERS)

[#HOME-ASSISTANT](#HOME-ASSISTANT)

[#KODI](#KODI)

[#WEBMIN](#WEBMIN)

[#SAMBA](#SAMBA)

[#CRON_JOBS](#CRON_JOBS)

[#AMULE](#AMULE)

[#IoTStack](#IoTStack)

[#UNRAR/7z](#UNRAR/7z)

[#NGINX_PHP](#NGINX_PHP)

[#VARIOS](#VARIOS)

[#PROBLEMAS_CONOCIDOS](#PROBLEMAS_CONOCIDOS)

[#COMANDOS_UTILES](#COMANDOS_UTILES)

[#DEPRECADO](#DEPRECADO)

------------

### HARDWARE

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
      - Localisation: Locale y Timezone
      - expand filesystem
      - enable 4Kp60

  - cambiar tamaño swap: https://wpitchoune.net/tricks/raspberry_pi3_increase_swap_size.html
      - **/etc/init.d/dphys-swapfile restart** para aplicar

  - **sudo passwd root**
  - **sudo passwd pi**


### CONFIG-TXT  

  - **sudo cp /boot/config.txt /boot/config_ORIGINAL.txt && sudo nano /boot/config.txt**
      ```
      hdmi_edid_file=1
      hdmi_force_hotplug=1
      hdmi_enable_4kp60=1
      # Disable PWR LED
      dtparam=pwr_led_trigger=none
      dtparam=pwr_led_activelow=off
      # Disable Activity LED
      dtparam=act_led_trigger=none
      dtparam=act_led_activelow=off
      # Disable ethernet LEDs
      dtparam=eth_led0=4
      dtparam=eth_led1=4

      ```


### DOCKER

  - **curl -fsSL https://get.docker.com -o get-docker.sh**
  - **sudo sh get-docker.sh**
  - **sudo usermod -aG docker pi**

  - Intercambio claves SSH:
    - En el host: en /etc/sudoers poner al final: **pi ALL=(ALL) NOPASSWD: ALL**
    - En la consola del docker: **ssh-keygen** nos le generará en el dir .ssh
      - copiarle al host: **cd .ssh && ssh-copy-id -i id_rsa pi@192.168.0.2**
      - **yes**
      - poner la pass de pi
      - Prueba1: comprobar funcione con **ssh pi@192.168.0.2** (no deberia pedir password)
      - **exit**
      - **cd ..**
      - Prueba2: **ssh -i .ssh/id_rsa -o StrictHostKeyChecking=no pi@192.168.0.2 date**



### MY_DOCKERS

#### TRANSMISSION-DOCKER

  - nota: hubo que usar seccomp:unconfined porque sino el docker no arrancaba

    ```
    services:
      transmission:
        image: lscr.io/linuxserver/transmission
        container_name: transmission
        security_opt:
          - seccomp:unconfined
        environment:
          - PUID=1000
          - PGID=1000
          - TZ=Europe/Madrid
          - TRANSMISSION_WEB_HOME=/combustion-release/ #optional
        volumes:
          - /home/pi/dockers/transmission/config:/config
          - /home/pi/dockers/transmission/downloads:/downloads
          - /home/pi/dockers/transmission/watch:/watch
        ports:
          - 9091:9091
          - 51413:51413
          - 51413:51413/udp
        restart: always      
    ```  


#### AUDIOBOOKSELF

    ```
    services:
      audiobookshelf:
        image: ghcr.io/advplyr/audiobookshelf:latest
        container_name: audiobookshelf
        security_opt:
          - seccomp:unconfined    
        ports:
          - 8088:80
        volumes:
          - /home/pi/dockers/audiobookshelf/audiobooks:/audiobooks
          - /home/pi/dockers/audiobookshelf/podcasts:/podcasts
          - /home/pi/dockers/audiobookshelf/config:/config
          - /home/pi/dockers/audiobookshelf/metadata:/metadata
        restart: always                      
    ```  


#### CALIBRE-WEB

      ```
      services:
          calibre-web:
              container_name: calibre-web
              environment:
                  - PUID=1000
                  - PGID=1000
                  - TZ=Europe/Madrid
              ports:
                  - '8083:8083'
              volumes:
                  - '/home/pi/dockers/Calibre/config:/config'
                  - '/home/pi/dockers/Calibre/books:/books'
              restart: always
              image: 'lscr.io/linuxserver/calibre-web:latest'
      ```
  - Admin/Basic Configuration/Enable Uploads
  - Admin/admin:
    - Personalizar vistas
    - Allow eBook Viever y Allow Uploads


#### HEIMDALL

    ```
    services:
      heimdall:
        image: lscr.io/linuxserver/heimdall:latest
        container_name: heimdall
        security_opt:
          - seccomp:unconfined    
        environment:
          - PUID=1000
          - PGID=1000
          - TZ=Etc/UTC
        volumes:
          - /home/pi/dockers/heimdall:/config
        ports:
          - 8089:80
          #- 443:443
        restart: always
    ```


#### PHP

    ```
    services:
      sergioalegre-php:
        container_name: sergioalegre-php
        #security_opt:
        #  - seccomp:unconfined
        image: treehouses/php-apache
        ports:
          - 8084:80
        restart: always
        dns: 8.8.8.8
        volumes:
          - /home/pi/dockers/sergioalegre.es/:/var/www/html
    ```   
  - Conectar a la red de BBDD
  - comprobar version php **php -v**
  - **apt update && apt-get install -y php7.3-{mysql,sqlite3,mbstring,json,gd,bz2,bcmath,imagic}**


#### PICOSHARE

    ```
    services:
        picoshare:
            environment:
                - PORT=3001
                - PS_SHARED_SECRET=<PONER_CONTRASEÑA_AQUI>
            ports:
                - '8092:3001/tcp'
            volumes:
                - '/home/pi/dockers/picoshare/:/data'
            container_name: picoshare
            image: mtlynch/picoshare
            restart: always            
    ```  


#### FIREFOX

    ```
    services:
      firefox:
        image: jlesage/firefox
        container_name: firefox
        security_opt:
          - seccomp:unconfined    
        ports:
          #- 5900:5900 #VNC
          - 8091:5800 #HTTP
    ```  


#### PLEX

  - Generar el claim en https://www.plex.tv/claim/
    ```
    version: "2.1"
    services:
      plex:
        image: ghcr.io/linuxserver/plex:arm32v7-latest
        container_name: plex
        security_opt:
          - seccomp:unconfined  
        network_mode: host
        environment:
          - PUID=1000
          - PGID=1000
          - VERSION=docker
          - PLEX_CLAIM= <PONER CLAIM AQUI>
        volumes:
          - /home/pi/dockers/plex/library:/config
          - /home/pi/Series_Nuevas:/tv
          - /home/pi/Peliculas_Nuevas:/movies
        restart: unless-stopped    
    ```    


#### NGINX-PROXY-MANAGER

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


#### FAIL2BAN

    ```
    services:
        fail2ban:
            container_name: fail2ban
            restart: always
            security_opt:
            - seccomp:unconfined        
            network_mode: host
            volumes:
                - '/home/pi/dockers/fail2ban:/data'
                - '/var/log:/var/log:ro'
            image: 'crazymax/fail2ban:latest'   
    ```           
  - **sudo nano /home/pi/dockers/fail2ban/jail.d/sshd.conf**

    ```
    [sshd]
    enabled = true
    chain = INPUT
    port = ssh
    filter = sshd[mode=aggressive]
    logpath = /var/log/auth.log
    maxretry = 3
    ```


#### PORTAINER

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


#### WORDPRESS+MYSQL+PHPMYADMIN_raspberryPi4

    - recordar que el docker sergioalegre-php tambien se conecta a esta red. Si se enciende antes puede que haya cogido una de estas IPs reservadas

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
          - "WORDPRESS_DB_PASSWORD=CAMBIARCONTRASEÑAAQUI"
        restart: always
        dns: 8.8.8.8
        volumes:
          - /home/pi/dockers/afanburgos.com:/var/www/html
        networks:
          wordpress_default:
            ipv4_address: 172.22.0.3      

      mysql:
        container_name: mysql
        image: jsurf/rpi-mariadb
        volumes:
        - /home/pi/dockers/mysql:/var/lib/mysql
        environment:
        - "MYSQL_ROOT_PASSWORD=CAMBIARCONTRASEÑAAQUI"
        - "MYSQL_DATABASE=wordpress"
        restart: always
        networks:
          wordpress_default:
            ipv4_address: 172.22.0.2    

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
            - PMA_PASSWORD=CAMBIARCONTRASEÑAAQUI
          networks:
            wordpress_default:
              ipv4_address: 172.22.0.4        

    networks:
      wordpress_default:
        driver: bridge
        ipam:
         config:
           - subnet: 172.22.0.0/16
             gateway: 172.22.0.1         
    ```


#### CLOUDFLARE_DDNS

    ```
    version: "3.7"
    services:
      cloudflare-ddns:
        image: timothyjmiller/cloudflare-ddns:latest
        container_name: cloudflare-ddns-sergioalegre
        security_opt:
          - seccomp:unconfined    
        #security_opt:
          - no-new-privileges:true
        network_mode: "host"
        environment:
          - PUID=1000
          - PGID=1000
        volumes:
          - /home/pi/dockers/cloudflare-ddns-sergioalegre/config.json:/config.json
        restart: unless-stopped
    ```


#### DUPLICATI

    ```
    version: '3.3'
    services:
        duplicati:
            container_name: duplicati
            volumes:
                - '/home/pi/dockers/duplicati/:/data'
                - '/home/pi/dockers_backup/:/DOCKERS_BACKUP'
                - '/media/DISCO_USB_EXT/:/DISCO_USB_EXT'
                - '/:/RAIZ_RPI'
            ports:
                - '8087:8200'
            image: duplicati/duplicati
    ```
  - Configuración email (requiere contraseña generada en Mi Cuenta/Seguridad/Contraseñas de aplicaciones):
    ```  
    --send-mail-url=smtp://smtp.gmail.com:587/?starttls=when-available
    --send-mail-any-operation=true
    --send-mail-subject=Duplicati %PARSEDRESULT%, %OPERATIONNAME% report for %backup-name%
    --send-mail-to=sergio.alegre.arribas@gmail.com
    --send-mail-username=sergio.alegre.arribas@gmail.com
    --send-mail-password=<PONER LA CONTRASEÑA GENERADA>
    --send-mail-from=sergio.alegre.arribas@gmail.com         
    ```


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
  - ruta a los File Bookmarks:
      ```
      /media/DISCO_USB_EXT
      /media/DISCO_USB_EXT/ZZZ___REVISAR
      /media/DISCO_USB_EXT/Peliculas/SciFi
      /media/DISCO_USB_EXT/Peliculas/Varios
      /media/DISCO_USB_EXT/Series
      /home/pi/dockers
      /home/amule/.aMule/Incoming
      /home/pi/downloads/complete
      /home/pi/Peliculas_Nuevas
      /home/pi/Series_Nuevas
      /home/pi/dockers/audiobookshelf/audiobooks          
      ```


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

      [Transmission]
      	writable = yes
      	guest ok = yes
      	path = /home/pi/downloads/complete/

      [Conocimiento]
      	path = /media/DISCO_USB_EXT/Conocimiento
        browseable = yes
        guest ok = yes
        read only = no

      [Peliculas_Nuevas]
      	path = /home/pi/Peliculas_Nuevas
        browseable = yes
        guest ok = yes
        read only = no  

      [Series_Nuevas]
      	path = //home/pi/Series_Nuevas
        browseable = yes
        guest ok = yes
        read only = no                                
    ```


### CRON_JOBS

#### INVENTARIO: generar y copiar los domingos a las 2am cuando enciendo el Disco USB

      ```
      cmdPeliculas="cd /media/DISCO_USB_EXT/Peliculas && lm -R -l > Inventario_Peliculas.txt"
      cmdSeries="cd /media/DISCO_USB_EXT/Series && lm -R -l > Inventario_Series.txt"
      #Todos los días a las 21h
      schedPelis="0 2 2 ? * SUN * $cmdPeliculas"
      schedSeries="0 2 2 ? * SUN * $cmdSeries"
      ( crontab -l | grep -v -F "$cmdPeliculas" ; echo "$schedPelis" ) | crontab -
      ( crontab -l | grep -v -F "$cmdSeries" ; echo "$schedSeries" ) | crontab -
      ```      


### AMULE

  - **sudo apt-get install amule amule-daemon**
  - **sudo adduser amule**
  - **sudo nano /etc/default/amule-daemon** poner AMULED_USER="amule" y AMULED_HOME="/home/amule"
  - **sudo service amule-daemon start**
  - Crear contraseña mi_md5_pass: **echo -n <poner_aqui_contraseña> | md5sum** y copiarnos todo son el espacio ni guion final
  - **sudo nano /home/amule/.aMule/amule.conf**
    - **AcceptExternalConnections=1**
    - **ECPassword=<mi_md5_pass>**
    - En [WebServer] poner **Enabled=1**
    - **Password=<mi_md5_pass>**
    - **Port=8090**
  - **sudo service amule-daemon restart**
  - GUI preferencias:
    -	Max upload rate: 15
    - TCP Port y UDP Port: lo que haya en el router
    - **cd /usr/share/amule/webserver/default && sudo mv loginlogo.jpg loginlogo_SERGIO.jpg && sudo mv logo.png logo_SERGIO.png && sudo mv loginlogo.png loginlogo_SERGIO.png**
    - Files: **Preallocate disk space for new files** y **save 10 sources on rare files**
    - Servers: https://emuling.gitlab.io/server.met
    - Security: http://upd.emule-security.org/ipfilter.zip


### IoTStack

  - **git clone https://github.com/SensorsIot/IOTstack.git**
  - **cd IOTstack**
  - **./menu.sh**


### UNRAR/7z

  - **echo "deb-src http://mirrordirector.raspbian.org/raspbian/ buster main contrib non-free rpi" | sudo tee -a /etc/apt/sources.list**
  - **cd /tmp**
  - **sudo apt-get build-dep unrar-nonfree;sudo apt-get source -b unrar-nonfree;sudo dpkg -i unrar*.deb;echo 'done'**
  - **sudo apt install --assume-yes p7zip-full**


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
  - paquetes últiles: **sudo apt-get install tmux renameutils** (el ultimo tiene **qmv** para renames masivos)
  - cron job: **sudo chown -R pi /home/pi/Descargas**
  - alias .bashrc:
    - alias la='ls -al --color'
    - alias lm='ls -al --block-size=MB'
    - alias incoming='cd /home/amule/.aMule/Incoming/ && ls'
  - PiKISS: https://github.com/jmcerrejon/PiKISS

  - MOTD:
    - **sudo systemctl disable motd**
    - **sudo rm -f /etc/motd**
    - **sudo rm /etc/update-motd.d/10-uname**
    - **sudo touch /etc/update-motd.d/10-info**
    - **sudo chmod a+x /etc/update-motd.d/***
    - **sudo nano /etc/update-motd.d/10-info**

      ```
      #!/bin/sh

      upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
      secs=$((${upSeconds}%60))
      mins=$((${upSeconds}/60%60))
      hours=$((${upSeconds}/3600%24))
      days=$((${upSeconds}/86400))
      UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

      # get the load averages
      read one five fifteen rest < /proc/loadavg

      echo "

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

        `uname -srmo`
        `date -u`


        Last login.........: `lastlog -u pi | awk 'NR==2 {$1=$2=$3=""; print $0}' | awk '$1=$1'` from `lastlog -u pi | awk 'NR==2 {print $3}'`
        Uptime.............: ${UPTIME}
        Temperature........: `/opt/vc/bin/vcgencmd measure_temp | awk -F '[/=]' '{print $2}'`
        Memory.............: `free -h | awk 'NR==2 {print $4}'` (Free) / `free -h | awk 'NR==2 {print $2}'` (Total)
        Root Drive.........: `df -h -x tmpfs -x vfat -x devtmpfs | awk 'NR==2 {print $5 " (" $3 "/" $2 ") used on " $1 }'`
        IP Addresses.......: `ifconfig eth0 | grep "inet " | awk '{print $2}'`
      "
      ```


### PROBLEMAS_CONOCIDOS
  - Problema con dockers: **libseccomp2** o **warning: unable to iopause**,
    - Solución: en docker run: **--security-opt seccomp=unconfined** en docker compose:
    ```
    security_opt:
      - seccomp:unconfined
    ```


### COMANDOS_UTILES
  - CPU velocidad: **cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq**
  - CPU temperatura: **vcgencmd measure_tempnano**

  - SD velocidad: **while true; do sudo dd if=/dev/mmcblk0 of=/dev/null bs=8M count=10; sleep 5; done**

  - TRANSMISSION config: **/etc/transmission-daemon/settings.json**
    - servicio: **sudo systemctl start transmission-daemon**

  - ls en MB: **ls -al --block-size=MB**
  - cambiar prompt y colores: **PS1='\e[33;1m\u@\h: ' && LS_COLORS="di=1;35:ex=4;31:*.mp3=1;32;41"**

  - Home assistant:
    - **systemctl stop hassio-supervisor && docker ps -a -q | xargs docker stop**
    - **systemctl status hassio-supervisor**

  - Inventario: **lm -R -l > 211230_inventario.txt**
  - Tamaño carpetas (Series,Pelis) del disco externo: **du -h --max-depth=1 /media/DISCO_USB_EXT/**

  - resolucion video, codec, idiomas, subtitulos: **ffmpeg -i VIDEO.MDK**

  - montar PORTATIL: **sudo mount -t cifs //192.168.0.112/c /mnt/PORTATIL/ -o username="sergio"**

  - aMule: **sudo service amule-daemon start**

  - RClone, conexion multicloud: https://ostechnix.com/how-to-mount-google-drive-locally-as-virtual-file-system-in-linux/
    - **rclone config**
    - IMPORTANTE: cuando estemos en Remote config /Use auto config? decir **N**



### DEPRECADO

#### TRANSMISSION

  - NOTA: métodp deprecado en favor de docker
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

#### FILEBROWSER
  - NOTA: deprecado en favor de docker
  - en docker **/srv** ha de apuntar a **/** en el host
  - legacy:
    - https://filebrowser.org/installation
    - **filebrowser -a 192.168.0.2 -p 8888 -r / --noauth**
    - comandos a permitir **pwd mv rm unrar ls mkdir rmdir**  

### HARDWARE

  - Comparativa SD: https://www.pidramble.com/wiki/benchmarks/microsd-cards
  - I/O de la SD:
    - **sudo dd if=/dev/mmcblk0 of=/dev/null bs=8M count=10** Leerá 80 MB y dirá la velocidad
    - **sudo hdparm -t /dev/mmcblk0** similar al anterior
    - <img src="https://github.com/sergioalegre/OS_Tips/blob/master/pics/RPI-SD-IO.jpg">
