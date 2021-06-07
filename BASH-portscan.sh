# se basa en revisar si un comando nos devuelve 0 exito o 1 errores
# basado https://www.youtube.com/watch?v=fIGvOGrdxyc&list=PLlb2ZjHtNkpiSbrOfeRASNsvpHD6bEWoA (00:07)
#uso: ./portscan.sh ip_a_escanear

#!/bin/bash

trap ctrl_c INT

function ctrl_c() { #si damos ctrl+c
  echo -e "\n\n[*] Saliendo...\n"
  tput cnorm; exit 0 #que me devuelva el cursero y salga
}

tput civis; for port in $(seq 1 65535); do #tput civis oculta cursor y sec recorre del 1 al 65535
  timeout 1 bash -c "echo '' < /dev/tcp/$1/$port" 2>/dev/null && "Puerto $port - ABIERTO" &
  #maximo 1 segundo por comando. A esa ip prueba puertos y los errores envia a null
  #si la parte izq del && no da error es que el puerto esta abierto
done; wait #que no se cierre el programa al terminar
