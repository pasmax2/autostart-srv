#!/bin/bash

# Chemins
BIN_PATH="/usr/local/bin/autostart"
SERVICE_PATH="/etc/systemd/system/docker-autostart.service"
BASE_URL="https://raw.githubusercontent.com/pasmax2/autostart-srv/main"

echo "Démarrage de l'installation de autostart-srv..."

# 1. Téléchargement du script 'autostart' (sans .sh)
echo "Téléchargement de l'exécutable..."
curl -sSL "$BASE_URL/autostart" -o "$BIN_PATH"
chmod +x "$BIN_PATH"

# 2. Téléchargement du service systemd
echo "Téléchargement du service..."
curl -sSL "$BASE_URL/docker-autostart.service" -o "$SERVICE_PATH"

# 3. Activation et démarrage
echo "Activation de systemd..."
systemctl daemon-reload
systemctl enable docker-autostart.service
systemctl restart docker-autostart.service

echo "Vérification du statut :"
systemctl status docker-autostart.service --no-pager
