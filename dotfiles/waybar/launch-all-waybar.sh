#!/bin/bash
CONFIG_DIR="$HOME/.config/waybar"

get_monitors_hyprctl() {
    if command -v hyprctl >/dev/null 2>&1; then
        hyprctl monitors -j | jq -r '.[].name' 2>/dev/null
    else
        echo "hyprctl non disponible" >&2
        return 1
    fi
}
get_heights_hyprctl() {
    if command -v hyprctl >/dev/null 2>&1; then
        hyprctl monitors -j | jq -r '.[].height'/30 2>/dev/null
    else
        echo "hyprctl non disponible" >&2
        return 1
    fi
}

pkill waybar 2>/dev/null || true
readarray -t monitors_array < <(get_monitors_hyprctl)
readarray -t heights_array < <(get_heights_hyprctl)

if [[ ${#monitors_array[@]} -eq 0 ]]; then
    echo "Aucun moniteur trouvé, lancement de Waybar par défaut..."
    waybar &
    exit 0
fi

mkdir -p /tmp/waybar_configs
monitor_count=0

for i in "${!monitors_array[@]}"; do
    monitor="${monitors_array[i]}"
    height="${heights_array[i]}"

    monitor_count=$((monitor_count + 1))
    echo "  → Moniteur $monitor_count: $monitor (hauteur: $height)"
    config_temp="/tmp/waybar_configs/config_${monitor}.jsonc"
    cp "$CONFIG_DIR/config.jsonc" "$config_temp"
    sed -i "3i\\    \"output\": \"$monitor\"," "$config_temp"
    sed -i "s/\"height\": [0-9]*/\"height\": $height/" "$config_temp"
    if ((height > 70)); then
        sed -i 's/"icon-size": 25,/"icon-size": 50,/' "$config_temp"
        waybar --config "$config_temp" --style "$CONFIG_DIR/style-2160p.css" &
    else
        waybar --config "$config_temp" --style "$CONFIG_DIR/style-1080p.css" &
    fi
    sleep 0.3
done

if [[ $monitor_count -eq 0 ]]; then
    echo "Aucun moniteur valide trouvé, lancement par défaut..."
    waybar &
else
    echo "✓ Waybar lancé sur $monitor_count moniteur(s)"
fi
