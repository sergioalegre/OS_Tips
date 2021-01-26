[#BASH-GENERAL](#BASH-GENERAL)

[#FORMATEAR-SALIDA](#FORMATEAR-SALIDA)

[#chattr](#chattr)

[#disown](#diwown)

[#file](#file)

[#find](#find)

[#hostname](#hostname)

[#time](#time)

[#which](#which)

[#xargs](#xargs)

### BASH-GENERAL
  - buscar en el bash history **CTRL+R** y cuando lo encuentres **flecha derecha**
  - AND: encadenar comandos con **&&** solo se ejecutarán si el comando precedente dio salida exitosa (0). Se puede ver el valor de salida del ultimo comando con **echo $?**. Por eso en los scripts se usa **exit 1** para indicar que el programa acabo de manera inesperada.
  - OR: con **a||b** ejemplo **opcion1 || opcion2**

### FORMATEAR-SALIDA
  - awk: mostrar solo la linea 2: **cat /etc/passwd | awk 'NR==2'**
  - awk: mostrar segunda palabra de la salida **cat /etc/passwd | awk '{print $2}'**
  - awk: mostrar última palabra de la salida **cat /etc/passwd | awk 'NF{print $NF}'**
  - base64: pasar a base64 **echo "hola" | base64**
  - base64: decodificar **echo "texto" | base64 -d**
  - rev: invertir caracteres de salida **cat /etc/passwd | rev**
  - column: cuando necesitas tabular bien en columnas:**find . -type f -printf "%f\t%p\t%u\t%g\t%m\n" | column -t**
  - grep: buscar donde contenga root: **cat /etc/passwd | grep "root"**
  - grep: buscar donde empiece por root: **cat /etc/passwd | grep "^root"**
  - grep: buscar exactamente la palabra root: **cat /etc/passwd | grep "^root$"**
  - grep: en que linea hay ocurrencias: **cat /etc/passwd | grep "^root$" -n**
  - head: mostar las dos primeras lineas de este output **cat /etc/passwd | head -n 2**
  - sed: cambiar la primera ocurrencia de root por NUEVO: **cat /etc/passwd | sed 's/root/NUEVO/'**
  - sed: cambiar todas las ocurrencias de root por NUEVO **cat /etc/passwd | sed 's/root/NUEVO/g'**
  - sort: ordenar **comando | sort**
  - stderr: omitir de la salida errores: **comando 2>/dev/null**
  - tr: cambiar espacio a saltos de linea **echo "hola que haces" | tr ' ' '\n'** equivale a **echo "hola que haces" | sed 's/ /\n/g'**'
  - tail: últimas dos líneas **cat /etc/passwd | tail -n 2**
  - wc: contar lineas: **comando | wc -l**
  - xargs: quitar espacios y saltos de linea **cat /etc/apt/sources.list | xargs**

### chattr
  - cambiar las flags de los ficheros: **chattr -i archivo.txt**

### disown
  - si se han abierto desde consola procesos en segundo plano **comando &** con **disown** hace que podamos cerrar consola (proceso padre) y no mate los procesos hijos

### file
  - file lee los 'magic numbers' (primeros caracteres del fichero) para saber que tipo de fichero es (ASCII-text, GIF, gzip). No lee la extensión.

### find
  - mostrar todos los archivos y carpetas a partir de aqui: **find .**
  - buscar desde la raiz todos los archivos del usuario pi y tamaño 33 bytes: **find / -user pi -size 33c**
  - lo mismo pero omitiendo errores de permisos al buscar: **find / -user pi -size 33c 2>/dev/null**
  - mostrar solo archivos a partir de aqui: **find . -type f**

### hostname
  - **hostname -I** ips del sistema

### time
  - tiempo de ejecución de un comando **time find . -name archivo.txt**

### which
  - ruta absoluta a ejecutable **which docker**

### xargs
  - Hacer cat a cada fichero a partir de esta ruta: **find . -type f | xargs cat**
