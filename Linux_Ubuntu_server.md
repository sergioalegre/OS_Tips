[TOC]
#-SSH
#-ROLES/SNAPS
#-ACTUALIZAR Y VERSION
#-HARDWARE - TECLADO
#-NETWORKING
#-PAQUETES/SOFTWARE
#-DISCOS/PARTICIONES
#-ARCHIVOS
#-LOGS
#-PERFORMANCE

99-VARIOS

<br><br>
1-SSH<br>
  - Instalar: <b>apt-get install openssh-server</b><br>
  - Comprobar: <b>systemctl status ssh</b><br>
  - Permitir root: en <b>vi /etc/ssh/sshd_config</b> poner <b>PermitRootLogin yes</b> luego <b>systemctl restart sshd</b>
  - Timeout SSH de 1h:  en <b>vi /etc/ssh/sshd_config</b> poner <b>ClientAliveInterval  1200</b> y <b>ClientAliveCountMax 3</b> luego <b>systemctl restart sshd</b>



<br><br>
2-ROLES/SNAPS<br>
  - Añadir o quitar **roles** <b>tasksel</b> (http://spotwise.com/2008/11/05/adding-roles-to-ubuntu-server/)<br>
  <br>
  - Añadir o quitar **snaps** desde la snap store (Snaps are applications packaged with all their dependencies to run on all popular Linux) (https://codeburst.io/how-to-install-and-use-snap-on-ubuntu-18-04-9fcb6e3b34f9)<br>
  - <b>snap search powershell</b> para buscar y para instalar <b>snap install powershell</b><br>
  - <b>IoTStack</b> https://github.com/gcgarner/IOTstack.git



<br><br>
3-ACTUALIZAR Y VERSION<br>
  - Actualizar: <b> sudo apt-get update && apt-get upgrade</b><br>
  - Upgrade: <b>apt-get update && apt-get dist-upgrade</b><br>
  - Subir de version: <b>do-release-upgrade</b>
  - Version actual: <b>lsb_release -a</b>



<br><br>
4-HARDWARE - TECLADO
  - <b>dmidecode</b> lista el hardware
  - <b>uname -m</b> arquitectura de procesador
  - Configurar el teclado <b>sudo dpkg-reconfigure keyboard-configuration</b> (require reinicio)



<br><br>
5-NETWORKING
  - <b>netstat -rn</b> tabla de rutas
  - <b>cat /proc/net/dev</b> ver trafico de red de cada interfaz



<br><br>
6-PAQUETES/SOFTWARE
  - <b>dpkg -L <paquete></b> ver donde se instalo el paquete



<br><br>
7-DISCOS/PARTICIONES
  - <b>parted -l</b> ver discos fiscos y particiones
  - <b>lsblk</b> particiones y puntos de montaje
  - <b>cat /proc/partitions <paquete></b> 'devices' particionados
  - <b>df -h</b> ver espacio libre en cada punto de montaje
  - Extender LVM:
  <img src="https://github.com/sergioalegre/OS_Tips/blob/master/pics/Linux_Extend_LVM_Partition.jpg">



<br><br>
8-ARCHIVOS<br>
  - **updatedb** actualiza el indice de ficheros, luego con **locate** se puede buscar



<br><br>  
97-LOGS
  - <b>dmesg | less</b> ver los de arraque con Av Pag y Re Pag.



<br><br>
98-PERFORMANCE
  - <b>htop</b> se puede usar el raton, permite ordenar por CPU o ram
  - <b>free</b> cuanta RAM esta libre



<br><br>
99-VARIOS
  - <b>history | less</b> ultimos 1000 comandos
  - <b>last -x | grep shutdown</b> fecha del ultimo apagado/reinicio
  - <b>tar czf archivo_comprimido.tgz <dirname></b> comprimir un directorio
  - <b>tar zxvf <archive></b> descomprimir
