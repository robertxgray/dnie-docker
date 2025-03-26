FROM debian:bullseye

# Set environment to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    firefox-esr \
    pcscd \
    pcsc-tools \
    libpcsclite1 \
    libccid \
    wget \
    curl \
    gnupg \
    libnss3-tools \
    libengine-pkcs11-openssl \
    libcurl4-openssl-dev \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Install DNIe package directly from official source with dependency fix
RUN wget https://www.dnielectronico.es/descargas/distribuciones_linux/libpkcs11-dnie_1.6.8_amd64.deb \
    && dpkg -i libpkcs11-dnie_1.6.8_amd64.deb || apt-get install -f -y \
    && rm libpkcs11-dnie_1.6.8_amd64.deb
RUN wget https://www.dnielectronico.es/descargas/distribuciones_linux/libpkcs11-dnie_1.6.8_amd64.deb \
    && apt-get update \
    && apt-get install -y ./libpkcs11-dnie_1.6.8_amd64.deb \
    && rm libpkcs11-dnie_1.6.8_amd64.deb && apt install -y pcsc-tools pcscd pinentry-gtk2 libccid

# Start pcscd service
CMD ["bash"]
