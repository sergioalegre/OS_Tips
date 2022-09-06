# Windows Subsystem for Linux
[#Basics](#Basics)

[#Montar-disco](#Montar-disco)

[#GWSL](#GWSL)

[#Windows_2019](#Windows_2019)



### Basics
  - restart WSL via Powershell (as admin) **Get-Service LxssManager | Restart-Service**


### Montar-disco
  - En este ejemplo montamos una partición EXT4 en un disco externo. Basado en https://docs.microsoft.com/en-us/windows/wsl/wsl2-mount-disk:
  - En powershell como administrador **GET-CimInstance -query "SELECT * from Win32_DiskDrive"** con ello sacamos el PHYSICALDRIVE1 y el numero de partición
  - **wsl --mount \\.\PHYSICALDRIVE1 --partition 1 --type ext4**
  - ruta donde estara montado **\\wsl.localhost\Ubuntu\mnt\wsl**
  - para desmontar de manera segura **wsl –unmount**


### GWSL
  - Entorno gráfico para soluionar el problema *cannot open display*
  - Descargar e instalar: https://opticos.github.io/gwsl/tutorials/manual.html#installing-gwsl
  - Entrar en la opcion **GWSL Distro Tools**
  - Activar las opciones: **Display/Audio Auto-Exporting** y **LibGl Indirect is Enabled**


### Windows_2019
  - **Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux**
  - Bajar una distro desde https://docs.microsoft.com/en-us/windows/wsl/install-manual#downloading-distributions
  - **Add-AppxPackage .\nombre_distro.appx**
