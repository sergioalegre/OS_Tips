1-SSH<br>

<br><br>
1-SSH<br><br>
  #instalar<br>
  <b>apt-get install openssh-server</b>
  
  #comprobar<br>
  <b>systemctl status ssh</b>
  
  #permitir root<br>
  en <b>vi /etc/ssh/sshd_config</b> poner <b>PermitRootLogin yes</b>
