# autostart-srv
Gestion du démarrage automatique des projets `docker-compose.yml` situés dans `/srv`.

## Description
Ce service surveille le répertoire `/srv` et lance automatiquement les projets Docker Compose qui contiennent un fichier `.start`.

## Installation

1. **Copier le fichier de service** :
   Placez le fichier `docker-autostart.service` dans le répertoire suivant :
   `/etc/systemd/system/`

2. **Activer le service** :
   Exécutez les commandes suivantes pour recharger systemd et activer le service au démarrage :

   ```bash
   systemctl enable docker-autostart.service
   systemctl start docker-autostart.service
   systemctl daemon-reload

## Méthode #2 installation automatique
```bash
   curl -sSL https://raw.githubusercontent.com/pasmax2/autostart-srv/main/install.sh | sudo bash
