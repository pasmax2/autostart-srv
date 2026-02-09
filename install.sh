#!/bin/bash

# Définition des chemins
INSTALL_DIR="/usr/local/bin"
SERVICE_FILE="docker-autostart.service"
SCRIPT_FILE="autostart.sh"

echo "Installation de autostart-srv..."

# Copie du script vers /usr/local/bin
cp $SCRIPT_FILE $INSTALL_DIR/
chmod +x $INSTALL_DIR/$SCRIPT_FILE

# Copie et activation du service systemd
cp $SERVICE_FILE /etc/systemd/system/
systemctl daemon-reload
systemctl enable $SERVICE_FILE
systemctl start $SERVICE_FILE

echo "Installation terminée et service démarré."
