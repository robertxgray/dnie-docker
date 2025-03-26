# Introduccion

Imagen docker para poder utilizar el DNIE desde cualquier entorno linux, sabiendo que siempre te va a funcionar al estar utilizando docker.

# Como utilizarlo

Dentro del directorio del repositorio, crea la imagen con el comando: `docker build -t dnie-firefox .`

* Ejecuta este comando para iniciar la imagen docker:

```
sudo apt-get install --reinstall pcscd libccid pcsc-tools # Necesario porque a veces en linux se lía si no el detector de tarjetas. A mi me ha pasado y esto me lo ha resuelto.
xhost +local:docker

docker run -it --rm \
  --env DISPLAY=$DISPLAY \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --volume /run/pcscd/pcscd.comm:/run/pcscd/pcscd.comm \
  --device /dev/bus/usb \
  --group-add $(getent group plugdev | cut -d: -f3) \
  dnie-firefox
```

Una vez dentro del contenedor:
* Arranca firefox (comando `firefox` en la terminal, te abrirá una ventana de firefox)
* Navega a `OPTIONS -> SECURITY-> DEVICE MANAGER -> Boton "LOAD"` Valor: '/usr/lib/libpkcs11-dnie.so'

# Copiando ficheros
Si descargas algun justificante a la imagen docker y quieres descargarlo a tu local, los pasos son:
* Guarda tus ficheros en /tmp/
* Ejecuta el comando `docker ps` y encuentra el identificador de tu imagen. Algo como `e88dc32a90a4`
* Ejecuta el comando `docker cp e88dc32a90a4:/tmp/ .` y se copiara el contenido del directorio `/tmp/` del contenedor, a tu host.

# Tips
* Recuerda probar con tarjeta DNI con el chip boca arriba, en el caso de mi tarjetero (Marca zoweetec) es asi.
* Para monitorizar si la tarjeta esta activa `pcsc_scan`, pero no deberias necesitarlo.
