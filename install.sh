#!/bin/bash

# Chemins de destination (SANS .sh)
BIN_PATH="/usr/local/bin/autostart"
SERVICE_PATH="/etc/systemd/system/docker-autostart.service"
BASE_URL="https://raw.githubusercontent.com/pasmax2/autostart-srv/main"

echo "Démarrage de l'installation de autostart-srv..."

# 1. Téléchargement du script (nommé 'autostart' sur GitHub)
echo "Téléchargement de autostart..."
curl -sSL "$BASE_URL/autostart" -o "$BIN_PATH"
chmod +x "$BIN_PATH"

# 2. Téléchargement du service
echo "Téléchargement du service systemd..."
curl -sSL "$BASE_URL/docker-autostart.service" -o "$SERVICE_PATH"

# 3. Correction du chemin dans le service pour pointer vers /usr/local/bin/autostart
# On s'assure que le service appelle le bon fichier sans .sh
sed -i 's|/srv/autostart.sh|/usr/local/bin/autostart|g' "$SERVICE_PATH"
sed -i 's|/usr/local/bin/autostart.sh|/usr/local/bin/autostart|g' "$SERVICE_PATH"

# 4. Activation
systemctl daemon-reload
systemctl enable docker-autostart.service
systemctl restart docker-autostart.service

echo "Installation terminée avec le fichier 'autostart' !"
systemctl status docker-autostart.service --no-pager
