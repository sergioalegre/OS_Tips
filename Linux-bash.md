[#chattr](#chattr)
[#find](#find)
[#hostname](#hostname)
[#which](#which)
[#xargs](#xargs)

### chattr
  - cambiar las flags de los ficheros: **chattr -i archivo.txt**

### find
  - mostrar todos los archivos y carpetas a partir de aqui: **find .**
  - mostrar solo archivos a partir de aqui: **find . -type f**
  - formatear salida: **find . -type f -printf "%f\t%p\t%u\t%g\t%m\n" | column -t**

### hostname
  - **hostname -I** ips del sistema

### which
  - buscar ruta a ejecutable **which docker**

### xargs
  - Hacer cat a cada fichero a partir de esta ruta: **find . -type f | xargs cat**
