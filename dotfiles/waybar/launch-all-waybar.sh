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

pkill waybar 2>/dev/null || true
monitors=$(get_monitors_hyprctl)
if [[ -z "$monitors" ]]; then
    echo "Aucun moniteur trouvé, lancement de Waybar par défaut..."
    waybar &
    exit 0
fi

mkdir -p /tmp/waybar_configs
monitor_count=0

while IFS= read -r monitor; do
    if [[ -n "$monitor" ]]; then
        monitor_count=$((monitor_count + 1))
        echo "  → Moniteur $monitor_count: $monitor"
        config_temp="/tmp/waybar_configs/config_${monitor}.jsonc"
        cp "$CONFIG_DIR/config.jsonc" "$config_temp"
        sed -i "2i\\    \"output\": \"$monitor\"," "$config_temp"
        waybar --config "$config_temp" &
        sleep 0.3
    fi
done <<<"$monitors"

if [[ $monitor_count -eq 0 ]]; then
    echo "Aucun moniteur valide trouvé, lancement par défaut..."
    waybar &
else
    echo "✓ Waybar lancé sur $monitor_count moniteur(s)"
fi
