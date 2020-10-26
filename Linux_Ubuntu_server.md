1-SSH<br>
2-Roles/snaps<br>

<br><br>
1-SSH<br>
  #instalar<br>
  <b>apt-get install openssh-server</b>
  
  #comprobar<br>
  <b>systemctl status ssh</b>
  
  #permitir root<br>
  en <b>vi /etc/ssh/sshd_config</b> poner <b>PermitRootLogin yes</b><br>
  y luego <b>systemctl restart sshd</b>
  
<br><br>
2-Roles/Snaps<br>
  #añadir o quitar roles <b>tasksel</b><br>
  http://spotwise.com/2008/11/05/adding-roles-to-ubuntu-server/<br>
  
  #añadir 'snaps' desde la snap store (Snaps are applications packaged with all their dependencies to run on all popular Linux)
  https://codeburst.io/how-to-install-and-use-snap-on-ubuntu-18-04-9fcb6e3b34f9<br>
  <b>snpa search powershell</b> para buscar y para instalar <b>snap install powershell</b>
  
