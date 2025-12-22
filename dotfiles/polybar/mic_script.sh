# Fonction pour récupérer le statut
get_status() {
    default_source=$(pactl get-default-source)
    volume=$(pactl list sources | awk -v src="$default_source" '
              $0 ~ "Name: " src {found=1}
              found && /Volume:/ {
                match($0, /([0-9]+)%/, arr)
                print arr[1]
                exit
              }
            ')
    muted=$(pactl list sources | awk -v src="$default_source" '
              $0 ~ "Name: " src {found=1}
              found && /Mute:/ {
                print $2
                exit
              }
            ')

    if [ "$muted" = "yes" ]; then
        echo "  "
    else
        echo " ${volume}%  "
    fi
}

# Affiche le statut initial
get_status

# Écoute les changements PulseAudio et met à jour en temps réel
pactl subscribe | while read -r event; do
    if echo "$event" | grep -q "source"; then
        get_status
    fi
done
