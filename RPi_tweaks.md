1-SCRIPT DESCOMPRESION AUTOMATICA
2-IOT<br>
3-HomeAssitant<br>
4-Portainer<br>


<br><br>
1-SCRIPT DESCOMPRESION AUTOMATICA<br>
https://techblog.jeppson.org/2016/11/automatically-extract-rar-files-downloaded-transmission/
- contenido de <b>descomprimir_auto.sh</b>
find /$TR_TORRENT_DIR/$TR_TORRENT_NAME -name "*.rar" -execdir unrar e -o- "{}" \;<br>
- <b>chmod a+x descomprimir_auto.sh</b>
- En <b>/var/lib/transmission/.config/transmission-daemon/settings.json</b> poner estas settings:
<b>"script-torrent-done-enabled": true,<br>
"script-torrent-done-filename": "/path/to/where/you/saved/the/script",</b>

Otra opcion: https://github.com/arfoll/unrarall


<br><br>
2-IOT
- <b>git clone https://github.com/gcgarner/IOTstack.git</b>
- <b>cd IOTstack</b>
- <b>./menu.sh</b>
- <b>docker-compose up -d</b> para descargar los docker image pendientes


<br><br>
3- HomeAssitant
- apt-get install apparmor-utils avahi-daemon dbus jq network-manager socat
- curl -sL "https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh" | bash -s


<br><br>
4-Portainer
- actualizar a 2.0 https://www.youtube.com/watch?v=QzEw6xKICZc
