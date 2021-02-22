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
  - **roles** añadir o quitar con: **tasksel** (http://spotwise.com/2008/11/05/adding-roles-to-ubuntu-server/)
  - **snaps** añadir o quitar desde la snap store (Snaps are applications packaged with all their dependencies to run on all popular Linux) (https://codeburst.io/how-to-install-and-use-snap-on-ubuntu-18-04-9fcb6e3b34f9)<br>
    - **snap search powershell** para buscar y para instalar **snap install powershell**
  - **IoTStack** https://github.com/gcgarner/IOTstack.git


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


### ARCHIVOS
  - **updatedb** actualiza el indice de ficheros, luego con **locate** se puede buscar
  - **sudo du -h /home/ | sort -rh | head -20** top 20 carpetas de mas tamaño dentro de /home
  - **ncdu** utilidad para ver las carpetas por tamaño


### BACKUP
  - script.sh para poner un cron y hacer backup de un directorio concreto: comprimido, nombre basado en fecha, excluyendo algunos directorios y tipos de ficheros:
    - `cd /media/DISCO_USB_EXT/ZZ_backup_ha/ && zip -r "HA-backup-$(date +"%Y-%m-%d_%H-%M").zip" /home/homeassistant/.homeassistant/ -x "*.log" -x "/*tts/*" -x "*.db" -x "*.db-shm" -x "*.db-wal" -x "*.mp3" -x "/*deps/*" -x "/*www/camera_shots/*" -x "/*.git/*" -x "/*shell/gif_maker/venv/*"`


### LOGS
  - **dmesg | less** ver los de arraque con Av Pag y Re Pag.
  - **journalctl -xe** (CENTOS)


### PERFORMANCE
  - **htop** se puede usar el raton para ordenar por CPU o ram
  - **free** cuanta RAM esta libre


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
