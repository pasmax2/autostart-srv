#!/bin/bash

# Configuration
BASE_DIR="/srv"
MAGIC_FILE=".start"

echo "🔍 Recherche du marqueur '$MAGIC_FILE' dans $BASE_DIR..."
echo "----------------------------------------"

# Vérifier si Docker est présent
if ! command -v docker &> /dev/null; then
    echo "❌ Erreur : Docker n'est pas installé."
    exit 1
fi

# Recherche des dossiers contenant le fichier .start
# On cherche le fichier .start, puis on vérifie si un docker-compose.yml est à côté
find "$BASE_DIR" -maxdepth 2 -name "$MAGIC_FILE" | while read -r magic_path; do

    dossier=$(dirname "$magic_path")

    # Vérification de la présence d'un fichier compose dans le même dossier
    if [[ -f "$dossier/docker-compose.yml" || -f "$dossier/docker-compose.yaml" ]]; then
        echo "🚀 Dossier détecté : $dossier"

        pushd "$dossier" > /dev/null || continue

        # Lancement de Docker Compose
        if docker compose up -d; then
            echo "✅ Service démarré."
        else
            echo "❌ Erreur lors du 'docker compose up' dans $dossier"
        fi

        popd > /dev/null
    else
        echo "⚠️  Marqueur trouvé dans $dossier, mais pas de docker-compose.yml"
    fi
    echo "----------------------------------------"
done

echo "🏁 Scan terminé."
