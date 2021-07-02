## Basado https://kb.vmware.com/s/article/2069041?lang=es

- Reinicie el dispositivo de vCenter Server con la vSphere Client.

- Cuando aparezca el cargador de arranque de GRUB, presione la barra espaciadora para deshabilitar el arranque autoinicio.

- Escriba p para acceder a las opciones de arranque del dispositivo.

- Introduzca la contraseña de GRUB.

   
Nota:
Si el dispositivo de vCenter Server se implementa sin editar la contraseña raíz en la interfaz de administración de dispositivos virtuales (virtual Appliance Management Interface, VAMI), la contraseña predeterminada de GRUB es de VMware.
Si la contraseña raíz del dispositivo de vCenter Server se restablece mediante VAMI, la contraseña de GRUB es la contraseña que se estableció en el VAMI para la cuenta raíz.
Utilice las teclas de flecha para resaltar VMware vCenter Server Appliance y escriba e para editar los comandos de arranque.

Editar comandos de arranque: restablecer contraseña raíz de vVenter 5,5 & 6,0
- Desplácese hasta la segunda línea que muestra los parámetros de arranque del kernel.

- Escriba e para editar el comando de arranque.

- Anexe init =/bin/bash a las opciones de arranque del kernel.

- Presione Intro. Vuelve a aparecer el menú de GRUB.

- Escriba b para iniciar el proceso de arranque. El sistema arranca en un shell.

- Restablezca la contraseña raíz ejecutando el comando root passwd.

- Reinicie el dispositivo de ejecutando comando reboot .