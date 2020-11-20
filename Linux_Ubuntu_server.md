[#SSH](#SSH)

[#ROLES-SNAPS](#ROLES-SNAPS)

[#ACTUALIZAR-VERSION](#ACTUALIZAR-VERSION)

[#HARDWARE-TECLADO](#HARDWARE-TECLADO)

[#NETWORKING](#NETWORKING)

[#PAQUETES-SOFTWARE](#PAQUETES-SOFTWARE)

[#DISCOS-PARTICIONES](#DISCOS-PARTICIONES)

[#ARCHIVOS](#ARCHIVOS)

[#PERFORMANCE](#PERFORMANCE)

[#VARIOS](#VARIOS)

------------

### SSH
  - Instalar: **apt-get install openssh-server**
  - Comprobar: **systemctl status ssh**
  - Permitir root: en **vi /etc/ssh/sshd_config** poner **PermitRootLogin yes** luego **systemctl restart sshd**
  - Timeout SSH de 1h:  en **vi /etc/ssh/sshd_config** poner **ClientAliveInterval  1200** y **ClientAliveCountMax 3** luego **systemctl restart sshd**

<br>
### ROLES-SNAPS
  - **roles** añadir o quitar con: **tasksel** (http://spotwise.com/2008/11/05/adding-roles-to-ubuntu-server/)
  - **snaps** añadir o quitar desde la snap store (Snaps are applications packaged with all their dependencies to run on all popular Linux) (https://codeburst.io/how-to-install-and-use-snap-on-ubuntu-18-04-9fcb6e3b34f9)<br>
  - **snap search powershell** para buscar y para instalar **snap install powershell**
  - **IoTStack** https://github.com/gcgarner/IOTstack.git

<br>
### ACTUALIZAR-VERSION
  - Actualizar: **sudo apt-get update && apt-get upgrade**
  - Upgrade: **apt-get update && apt-get dist-upgrade**
  - Subir de version: **do-release-upgrade**
  - Version actual: **lsb_release -a**

<br>
### HARDWARE-TECLADO
  - **dmidecode** lista el hardware
  - **uname -m** arquitectura de procesador
  - Configurar el teclado **sudo dpkg-reconfigure keyboard-configuration** (require reinicio)
  - Iniciar impresion **systemctl start cups**
  - Contar cuantas impresoras hay **lpstat -t | grep device | wc -l**

<br>
### NETWORKING
  - **netstat -rn** tabla de rutas
  - **cat /proc/net/dev** ver trafico de red de cada interfaz
  - comprobar estado de tarjetas en bonding (agregado) **cat /proc/net/bonding/bond0**

<br>
### PAQUETES-SOFTWARE
  - **dpkg -L <paquete>** ver donde se instalo el paquete

<br>
### DISCOS-PARTICIONES
  - **parted -l** ver discos fiscos y particiones
  - **lsblk** particiones y puntos de montaje
  - **cat /proc/partitions <paquete>** 'devices' particionados
  - **df -h** ver espacio libre en cada punto de montaje
  - Extender LVM:
  <img src="https://github.com/sergioalegre/OS_Tips/blob/master/pics/Linux_Extend_LVM_Partition.jpg">

<br>
### ARCHIVOS
  - **updatedb** actualiza el indice de ficheros, luego con **locate** se puede buscar

<br>
### LOGS
  - **dmesg | less** ver los de arraque con Av Pag y Re Pag.

<br>
### PERFORMANCE
  - **htop** se puede usar el raton para ordenar por CPU o ram
  - **free** cuanta RAM esta libre

<br>
### VARIOS
  - **history | less** ultimos 1000 comandos
  - **last -x | grep shutdown** fecha del ultimo apagado/reinicio
  - **tar czf archivo_comprimido.tgz <dirname>** comprimir un directorio
  - **tar zxvf <archive>** descomprimir
  - Unir server linux a AD: https://www.redhat.com/sysadmin/linux-active-directory
