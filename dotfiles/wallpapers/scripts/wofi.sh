#!/run/current-system/sw/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/.config/wallpapers/"
AUTO_FILE="$HOME/.config/wallpapers/scripts/auto.txt"
THEME_FILE="$HOME/.config/wallpapers/scripts/theme.txt"


# Initialize auto.txt if it doesn't exist
if [ ! -f "$AUTO_FILE" ]; then
    echo "true" >"$AUTO_FILE"
fi

while true; do
    # Get current auto status for the option
    AUTO_STATUS=$(cat "$AUTO_FILE" 2>/dev/null || echo "false")
    if [ "$AUTO_STATUS" = "true" ]; then
        AUTO_OPTION="Auto on  🟢 - Désactiver auto ?"
    else
        AUTO_OPTION="Auto off 🔴 - Activer auto ?"
    fi
    THEME_OPTION="Changer themes"
    FOLDER_OPTION="Ajouter/supprimer"

    # List files in the wallpaper directory and add auto option
    WALLPAPER_LIST=$(find "$WALLPAPER_DIR" -follow -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" -o -iname "*.gif" -o -iname "*.webp" \))
    SELECTED=$(echo "$WALLPAPER_LIST" | xargs -n 1 basename | (
        echo "$AUTO_OPTION";
        echo "$THEME_OPTION";
        echo "$FOLDER_OPTION";
        echo "-----------------------------------------------------";
        cat
    ) | wofi --dmenu --prompt "Select a wallpaper:" -W 300 -H 300 --cache /dev/null)

    # Check if a selection was made
    if [ -n "$SELECTED" ]; then
        # Check if auto toggle was selected
        if [[ "$SELECTED" == *"Activer auto"* ]] || [[ "$SELECTED" == *"Désactiver auto"* ]]; then
            # Toggle auto.txt content
            if [ "$AUTO_STATUS" = "true" ]; then
                echo "false" >"$AUTO_FILE"
            else
                echo "true" >"$AUTO_FILE"
            fi
        elif [[ "$SELECTED" == *"Changer theme"* ]]; then
            alacritty -e nvim "$THEME_FILE"
        elif [[ "$SELECTED" == *"Ajouter/supprimer"* ]]; then
            alacritty -e nvim "$THEME_FILE"
        else
            FULL_PATH=$(echo "$WALLPAPER_LIST" | grep "/$SELECTED$")
            # Set the selected wallpaper using swww
            #   swww img --transition-fps 60 --transition-type grow --transition-duration 2 --invert-y --transition-pos "$(hyprctl cursorpos | grep -E '^[0-9]' || echo "0,0")" "$WALLPAPER_DIR/$SELECTED"
            screen=hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name'
            swww img --transition-fps 60 --transition-type grow --transition-duration 0.5 --transition-bezier 1,0.9,1,0.7 --invert-y --transition-pos "$(hyprctl cursorpos | grep -E '^[0-9]' || echo "0,0")" "$FULL_PATH" --outputs "$screen"
        fi
    else
        # Exit the loop if no selection is made (e.g., user closes wofi or presses ESC)
        break
    fi
done
