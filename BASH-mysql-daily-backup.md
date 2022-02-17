
En /etc/cron.daily crear dos archivos .sh ejecutables

[#mysqlbackup.sh](#mysqlbackup.sh)

[#borrar_SQL_antiguos.sh](#borrar_SQL_antiguos.sh)


### mysqlbackup.sh
  ```
  #!/bin/sh
  mysqldump -uroot -pll4gosta nombre_base_datos > /path_backups/nombre_base_datos.$(date +"%Y%m%d").sql**
  ```

### borrar_SQL_antiguos.sh
  ```
  #!/bin/sh
  # borrar ficheros de mas de 15  dias de /path_backups
  /usr/bin/find /path_backups/* -type f -mtime +15 -exec rm {} +

  ```
