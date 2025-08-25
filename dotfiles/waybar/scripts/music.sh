#!/bin/bash

# Script ~/.config/waybar/scripts/music.sh

# Vérifier si playerctl est installé
if ! command -v playerctl &>/dev/null; then
    echo "⚠️ playerctl non trouvé"
    exit 1
fi

# Obtenir le statut du lecteur
status=$(playerctl status 2>/dev/null)
if [ $? -ne 0 ]; then
    echo "🎵 Aucun lecteur"
    exit 0
fi

# Obtenir les métadonnées
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

# Définir l'icône selon le statut
case $status in
    "Paused")
        icon="⏸️"
        ;;
    "Playing")
        icon="▶️"
        ;;
    *)
        icon="🎵"
        ;;
esac

# Créer le texte affiché
max_length=10
display_text=""
tooltip_text="♪ $artist\n$title\nStatut: $status\nClic: Play/Pause | Clic droit: Suivant"

if [ ${#display_text} -gt $max_length ]; then
    display_text="${display_text:0:$max_length}..."
fi

# Échapper les guillemets pour le JSON
display_text=$(echo "$display_text" | sed 's/"/\\"/g' | sed 's/&/\&amp;/g')
tooltip_text=$(echo "$tooltip_text" | sed 's/"/\\"/g' | sed 's/&/\&amp;/g')

# Sortie JSON pour Waybar
printf '{"text":"%s %s", "alt":"", "tooltip":"%s","class":"%s"}\n' "$icon" "$display_text" "$tooltip_text" "$status"
