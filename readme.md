# Recuerda tarjeta DNI con el chip boca arriba.
# Para monitorizar si la tarjeta esta activa `pcsc_scan`, pero no deberias necesitarlo.
# Ejecuta este comando para iniciar la imagen docker:

sudo apt-get install --reinstall pcscd libccid pcsc-tools # Necesario porque a veces en linux se lía si no el detector de tarjetas. A mi me ha pasado y esto me lo ha resuelto.
xhost +local:docker

docker run -it --rm \
  --env DISPLAY=$DISPLAY \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --volume /run/pcscd/pcscd.comm:/run/pcscd/pcscd.comm \
  --device /dev/bus/usb \
  --group-add $(getent group plugdev | cut -d: -f3) \
  dnie-firefox



# ONCE INSIDE:
# * START FIREFOX (comando `firefox` en la terminal, te abrirá una ventana de firefox)
# OPTIONS -> SECURITY-> DEVICE MANAGER -> LOAD -> '/usr/lib/libpkcs11-dnie.so'
