#SSH
  #instalar
  <b>apt-get install openssh-server</b>
  
  #comprobar
  <b>systemctl status ssh</b>
  
  #permitir root
  en <b>vi /etc/ssh/sshd_config</b> poner <b>PermitRootLogin yes</b>
