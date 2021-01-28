Lanzamos el comando robocopy usando como origen la ruta \\XXXFAS01\XXX_VOL_PUBLIC$ y \\XXXFAS01\XXX_VOL_USERS$
**robocopy sourceFolder destinationFolder /E /SEC /MIR /R:1 /W:1 /MT:48 /v /LOG:logFile**


Usamos el script creado para tal fin “Sincronizacion robocopy.ps1”


Y los rsync en caso de existir volúmenes NFS de datos (no de Virtual Machines):
**rsync -zavPR /sourceFolder /destinationFolder --delete --log-file=logFile**
