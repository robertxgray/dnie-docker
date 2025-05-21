# Introduccion

Imagen podman para poder utilizar el DNIE desde cualquier entorno linux, sabiendo que siempre te va a funcionar al estar utilizando podman.

# Como utilizarlo

Dentro del directorio del repositorio, crea la imagen con el comando: `podman build -t dnie-firefox .`

* Ejecuta este comando para iniciar la imagen podman:

```
sudo apt-get install --reinstall pcscd libccid pcsc-tools # Necesario porque a veces en linux se lía si no el detector de tarjetas. A mi me ha pasado y esto me lo ha resuelto.

podman run -it \
  --name dnie-firefox \
  --env DISPLAY=$DISPLAY \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --volume /run/pcscd/pcscd.comm:/run/pcscd/pcscd.comm \
  --device /dev/bus/usb \
  dnie-firefox
```

Una vez dentro del contenedor:
* Arranca firefox (comando `firefox` en la terminal, te abrirá una ventana de firefox)
* Navega a `OPTIONS -> SECURITY-> SECURITY DEVICES -> Boton "LOAD"` Valor: '/usr/lib/libpkcs11-dnie.so'
* Navega a `OPTIONS -> SECURITY-> VIEW CERTIFICATES -> AUTHORITIES -> Boton "IMPORT"` Valor: '/usr/lib/AutoFirma/AutoFirma\_ROOT.cer'

# Copiando ficheros
Si descargas algun justificante a la imagen podman y quieres descargarlo a tu local, los pasos son:
* Guarda tus ficheros en /tmp/
* Ejecuta el comando `podman ps` y encuentra el identificador de tu imagen. Algo como `e88dc32a90a4`
* Ejecuta el comando `podman cp e88dc32a90a4:/tmp/ .` y se copiara el contenido del directorio `/tmp/` del contenedor, a tu host.

# Tips
* Recuerda probar con tarjeta DNI con el chip boca arriba, en el caso de mi tarjetero (Marca zoweetec) es asi.
* Para monitorizar si la tarjeta esta activa `pcsc_scan`, pero no deberias necesitarlo.
