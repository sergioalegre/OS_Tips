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
  - Instalar: <b>apt-get install openssh-server</b><br>
  - Comprobar: <b>systemctl status ssh</b><br>
  - Permitir root: en <b>vi /etc/ssh/sshd_config</b> poner <b>PermitRootLogin yes</b> luego <b>systemctl restart sshd</b>
  - Timeout SSH de 1h:  en <b>vi /etc/ssh/sshd_config</b> poner <b>ClientAliveInterval  1200</b> y <b>ClientAliveCountMax 3</b> luego <b>systemctl restart sshd</b>


### ROLES-SNAPS
  -**roles** añadir o quitar con: <b>tasksel</b> (http://spotwise.com/2008/11/05/adding-roles-to-ubuntu-server/)<br>
  <br>
  - **snaps** añadir o quitar desde la snap store (Snaps are applications packaged with all their dependencies to run on all popular Linux) (https://codeburst.io/how-to-install-and-use-snap-on-ubuntu-18-04-9fcb6e3b34f9)<br>
  - <b>snap search powershell</b> para buscar y para instalar <b>snap install powershell</b><br>
  - <b>IoTStack</b> https://github.com/gcgarner/IOTstack.git


### ACTUALIZAR-VERSION
  - Actualizar: <b> sudo apt-get update && apt-get upgrade</b><br>
  - Upgrade: <b>apt-get update && apt-get dist-upgrade</b><br>
  - Subir de version: <b>do-release-upgrade</b>
  - Version actual: <b>lsb_release -a</b>


### HARDWARE-TECLADO
  - <b>dmidecode</b> lista el hardware
  - <b>uname -m</b> arquitectura de procesador
  - Configurar el teclado <b>sudo dpkg-reconfigure keyboard-configuration</b> (require reinicio)


### NETWORKING
  - <b>netstat -rn</b> tabla de rutas
  - <b>cat /proc/net/dev</b> ver trafico de red de cada interfaz


### PAQUETES-SOFTWARE
  - <b>dpkg -L <paquete></b> ver donde se instalo el paquete


### DISCOS-PARTICIONES
  - <b>parted -l</b> ver discos fiscos y particiones
  - <b>lsblk</b> particiones y puntos de montaje
  - <b>cat /proc/partitions <paquete></b> 'devices' particionados
  - <b>df -h</b> ver espacio libre en cada punto de montaje
  - Extender LVM:
  <img src="https://github.com/sergioalegre/OS_Tips/blob/master/pics/Linux_Extend_LVM_Partition.jpg">


### ARCHIVOS
  - **updatedb** actualiza el indice de ficheros, luego con **locate** se puede buscar


### LOGS
  - <b>dmesg | less</b> ver los de arraque con Av Pag y Re Pag.


### PERFORMANCE
  - <b>htop</b> se puede usar el raton para ordenar por CPU o ram
  - <b>free</b> cuanta RAM esta libre


### VARIOS
  - <b>history | less</b> ultimos 1000 comandos
  - <b>last -x | grep shutdown</b> fecha del ultimo apagado/reinicio
  - <b>tar czf archivo_comprimido.tgz <dirname></b> comprimir un directorio
  - <b>tar zxvf <archive></b> descomprimir
  - Unir server linux a AD: https://www.redhat.com/sysadmin/linux-active-directory
