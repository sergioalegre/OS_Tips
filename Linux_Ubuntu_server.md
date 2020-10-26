1-SSH<br>
2-Roles/snaps<br>
3-Actualizar y Version

<br><br>
1-SSH<br>
  Instalar: <b>apt-get install openssh-server</b><br>
  Comprobar: <b>systemctl status ssh</b><br>
  Permitir root: en <b>vi /etc/ssh/sshd_config</b> poner <b>PermitRootLogin yes</b>y luego <b>systemctl restart sshd</b>
  
<br><br>
2-Roles/Snaps<br>
  Añadir o quitar roles <b>tasksel</b><br>
  http://spotwise.com/2008/11/05/adding-roles-to-ubuntu-server/<br>
  
  Añadir 'snaps' desde la snap store (Snaps are applications packaged with all their dependencies to run on all popular Linux)
  https://codeburst.io/how-to-install-and-use-snap-on-ubuntu-18-04-9fcb6e3b34f9<br>
  <b>snap search powershell</b> para buscar y para instalar <b>snap install powershell</b>
  
<br><br>
3-Actualizar y Version<br>
  Actualizar: <b> sudo apt-get update && apt-get upgrade</b><br>
  Upgrade: <b>apt-get update && apt-get dist-upgrade</b><br>
  Version actual: <b>lsb_release -a</b>
