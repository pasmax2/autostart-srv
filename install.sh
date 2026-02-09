#!/bin/bash

# Chemins de destination
BIN_PATH="/usr/local/bin/autostart.sh"
SERVICE_PATH="/etc/systemd/system/docker-autostart.service"

# URL de base (Raw GitHub)
BASE_URL="https://raw.githubusercontent.com/pasmax2/autostart-srv/main"

echo "Démarrage de l'installation de autostart-srv..."

# 1. Téléchargement du script bash
echo "Téléchargement de autostart.sh..."
curl -sSL "$BASE_URL/autostart.sh" -o "$BIN_PATH"
chmod +x "$BIN_PATH"

# 2. Téléchargement du fichier de service systemd
echo "Téléchargement du service systemd..."
curl -sSL "$BASE_URL/docker-autostart.service" -o "$SERVICE_PATH"

# 3. Activation du service
echo "Activation et démarrage du service..."
systemctl daemon-reload
systemctl enable docker-autostart.service
systemctl restart docker-autostart.service

echo "Installation réussie !"
systemctl status docker-autostart.service --no-pager
