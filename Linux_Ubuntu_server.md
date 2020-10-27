1-SSH<br>
2-ROLES/SNAPS<br>
3-ACTUALIZAR Y VERSION
4-HARDWARE
5-PAQUETES/SOFTWARE
6-PERFORMANCE
7-NETWORKING
99-VARIOS

<br><br>
1-SSH<br>
  - Instalar: <b>apt-get install openssh-server</b><br>
  - Comprobar: <b>systemctl status ssh</b><br>
  - Permitir root: en <b>vi /etc/ssh/sshd_config</b> poner <b>PermitRootLogin yes</b> luego <b>systemctl restart sshd</b>
  
<br><br>
2-ROLES/SNAPS<br>
  - Añadir o quitar roles <b>tasksel</b><br>
  - http://spotwise.com/2008/11/05/adding-roles-to-ubuntu-server/<br>
  <br>
  - Añadir 'snaps' desde la snap store (Snaps are applications packaged with all their dependencies to run on all popular Linux)
  - https://codeburst.io/how-to-install-and-use-snap-on-ubuntu-18-04-9fcb6e3b34f9<br>
  - <b>snap search powershell</b> para buscar y para instalar <b>snap install powershell</b>
  
<br><br>
3-ACTUALIZAR Y VERSION<br>
  - Actualizar: <b> sudo apt-get update && apt-get upgrade</b><br>
  - Upgrade: <b>apt-get update && apt-get dist-upgrade</b><br>
  - Version actual: <b>lsb_release -a</b>

<br><br>
4-HARDWARE
  - <b>dmidecode</b> lista el hardware
  
<br><br>
5-PAQUETES/SOFTWARE
  - <b>dpkg -L <paquete></b> ver donde se instalo el paquete
  
  
<br><br>
6-PERFORMANCE
  - <b>htop</b> se puede usar el raton para ordenar por CPU o ram
  - <b>free</b> cuanta RAM esta libre


<br><br>
7-NETWORKING
  - <b>netstat -rn</b> tabla de rutas

  
<br><br>
99-VARIOS
  - <b>history | less</b> ultimos 1000 comandos
  - <b>last -x | grep shutdown</b> fecha del ultimo apagado/reinicio
  - <b>tar czf archivo_comprimido.tgz <dirname></b> comprimir un directorio
  - <b>tar zxvf <archive></b> descomprimir
