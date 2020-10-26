1-SCRIPT DESCOMPRESION AUTOMATICA


<br><br>
1-SCRIPT DESCOMPRESION AUTOMATICA<br>
https://techblog.jeppson.org/2016/11/automatically-extract-rar-files-downloaded-transmission/
- contenido de <b>descomprimir_auto.sh</b>
find /$TR_TORRENT_DIR/$TR_TORRENT_NAME -name "*.rar" -execdir unrar e -o- "{}" \;<br>
- <b>chmod a+x descomprimir_auto.sh</b>
- En <b>/var/lib/transmission/.config/transmission-daemon/settings.json</b> poner estas settings:
<b>"script-torrent-done-enabled": true,<br>
"script-torrent-done-filename": "/path/to/where/you/saved/the/script",</b>
