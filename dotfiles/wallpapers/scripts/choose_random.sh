#!/run/current-system/sw/bin/bash

WALLPAPER_DIR="$HOME/.config/wallpapers"
#SUPPORTED_FORMATS=("jpg" "jpeg" "png" "bmp" "gif" "webp")
THEME_FILE="$HOME/.config/wallpapers/scripts/theme.txt"
AUTO_FILE="$HOME/.config/wallpapers/scripts/auto.txt"

choose_angle() {
    echo $((RANDOM % 360))
}

choose_transition() {
    local transitions=("fade" "wave" "any" "outer")
    local random_index=$((RANDOM % ${#transitions[@]}))
    echo "${transitions[$random_index]}"
}

get_current_theme() {
    if [ -f "$THEME_FILE" ]; then
        cat "$THEME_FILE" | tr -d '\n\r' | xargs
    else
        echo ""
    fi
}

DEFAULT_INTERVAL=90 # In seconds
# See swww-img(1)
RESIZE_TYPE="fit"
export SWWW_TRANSITION_FPS="${SWWW_TRANSITION_FPS:-60}"
export SWWW_TRANSITION_STEP="${SWWW_TRANSITION_STEP:-2}"

while true; do
    echo "New loop through wallpapers"
    current_theme=$(get_current_theme)
    echo "Thème actuel: '$current_theme'"
    find "$WALLPAPER_DIR" -follow -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" -o -iname "*.gif" -o -iname "*.webp" \) |
        grep -i "$current_theme" |
        while read -r img; do
            echo "$(</dev/urandom tr -dc a-zA-Z0-9 | head -c 8):$img"
        done |
        sort -n | cut -d':' -f2- |
        while read -r img; do
            new_theme=$(get_current_theme)
            if [ "$new_theme" != "$current_theme" ]; then
                echo "Thème changé, relance de la boucle"
                break
            fi

            echo "Chose : $img"
            AUTO_STATUS=$(cat "$AUTO_FILE" 2>/dev/null || "false")
            if [ "$AUTO_STATUS" = "false" ]; then
                sleep 2
                break
            fi
            new_theme=$(get_current_theme)
            if [ "$new_theme" != "$current_theme" ]; then
                echo "Thème changé, relance de la boucle"
                break
            fi

            for d in $( # see swww-query(1)
                swww query | grep -Po "^:\s*\K[^:]+"
            ); do
                # Get next random image for this display, or re-shuffle images
                # and pick again if no more unused images are remaining
                [ -z "$img" ] && if read -r img; then true; else break 2; fi
                swww img --resize "$RESIZE_TYPE" --outputs "$d" -t "$(choose_transition)" --transition-angle "$(choose_angle)" "$img"
                unset -v img # Each image should only be used once per loop
            done

            CHECK_INTERVAL=3
            ITERATIONS=$((DEFAULT_INTERVAL / CHECK_INTERVAL))
            for _ in $(seq 1 $ITERATIONS); do
                sleep $CHECK_INTERVAL

                # Vérification du statut AUTO
                AUTO_STATUS=$(cat "$AUTO_FILE" 2>/dev/null || echo "false")
                if [ "$AUTO_STATUS" = "false" ]; then
                    break # Sortir de la boucle si AUTO est activé
                fi
            done
        done
done
