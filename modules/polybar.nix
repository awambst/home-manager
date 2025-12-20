{ pkgs, ... }:
{
  services.polybar = {
    enable = true;
    script = "polybar main &";
    package = pkgs.polybarFull;

    config = {
      "bar/main" = {
        width = "100%";
        height = 30;
        bottom = true;
        background = "#BB1e1e2e";
        foreground = "#FFcdd6f4";

        padding-left = 1;
        padding-right = 2;
        module-margin = 1;

        # Configuration du tray

        font-0 = "DejaVu Sans:size=10;2";
        font-1 = "Font Awesome 6 Free:style=Solid:size=12;3";
        font-2 = "Font Awesome 6 Free:style=Solid:size=16;3";
        modules-left = "powermenu i3 cpu memory filesystem";
        modules-center = "date";
        modules-right = "microphone volume network wifi battery tray";
      };

      "module/tray" = {
        type = "internal/tray";

        tray-position = "right"; # left, center, right, ou none
        tray-detached = false;
        tray-maxsize = 24; # Taille des icônes en pixels
        tray-padding = 2; # Espacement entre les icônes
        tray-offset-x = 0; # Décalage horizontal
        tray-offset-y = 0; # Décalage vertical
      };

      # Workspaces i3
      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";

        label-focused = "%index%";
        label-focused-background = "#89b4fa";
        label-focused-foreground = "#1e1e2e";
        label-focused-padding = 2;

        label-unfocused = "%index%";
        label-unfocused-padding = 2;

        label-visible = "%index%";
        label-visible-padding = 2;

        label-urgent = "%index%";
        label-urgent-background = "#f38ba8";
        label-urgent-padding = 2;
      };

      # Date et heure
      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%d/%m/%Y";
        time = "%H:%M:%S";
        label = " %date%  %time%";
      };

      # CPU
      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = " ";
        format-prefix-font = 2;
        label = "%percentage:2%% ";
      };

      # Mémoire RAM
      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = " ";
        format-prefix-font = 2;
        #label = "%used% / %total% GiB (%percentage_used%%)  ";
        label = "%percentage_used%%  ";
      };

      # Espace disque
      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";
        interval = 30;
        format-mounted-prefix = " ";
        format-mounted-prefix-font = 2;
        label-mounted = "%percentage_used%%  ";
      };

      # Batterie (pour laptop)
      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "AC";
        full-at = 98;

        format-charging = "<label-charging>";
        format-charging-prefix = " ";
        format-charging-prefix-font = 2;

        format-discharging = "<label-discharging>";
        format-discharging-prefix = " ";
        format-discharging-prefix-font = 2;

        format-full-prefix = " ";
        format-full-prefix-font = 2;

        label-charging = "%percentage%%  ";
        label-discharging = "%percentage%%  ";
        label-full = "%percentage%%  ";
      };

      # Volume
      "module/volume" = {
        type = "internal/pulseaudio";
        format-volume = "<label-volume> ";
        format-volume-prefix = " ";
        format-volume-prefix-font = 2;
        label-volume = "%percentage%%";

        format-muted = "<label-muted>";
        format-muted-prefix = " ";
        format-muted-prefix-font = 2;
        label-muted = "";
        label-muted-foreground = "#f38ba8";

        click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      "module/microphone" = {
        type = "custom/script";
        exec = "${pkgs.writeShellScript "microphone-status" ''
          # Fonction pour récupérer le statut
          get_status() {
            default_source=$(${pkgs.pulseaudio}/bin/pactl get-default-source)
            volume=$(${pkgs.pulseaudio}/bin/pactl list sources | ${pkgs.gawk}/bin/awk -v src="$default_source" '
              $0 ~ "Name: " src {found=1}
              found && /Volume:/ {
                match($0, /([0-9]+)%/, arr)
                print arr[1]
                exit
              }
            ')
            muted=$(${pkgs.pulseaudio}/bin/pactl list sources | ${pkgs.gawk}/bin/awk -v src="$default_source" '
              $0 ~ "Name: " src {found=1}
              found && /Mute:/ {
                print $2
                exit
              }
            ')
            
            if [ "$muted" = "yes" ]; then
              echo "  "
            else
              echo " ''${volume}%  "
            fi
          }

          # Affiche le statut initial
          get_status

          # Écoute les changements PulseAudio et met à jour en temps réel
          ${pkgs.pulseaudio}/bin/pactl subscribe | while read -r event; do
            if echo "$event" | ${pkgs.gnugrep}/bin/grep -q "source"; then
              get_status
            fi
          done
        ''}";

        tail = true; # Important pour le mode temps réel

        click-left = "${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        click-right = "${pkgs.pavucontrol}/bin/pavucontrol --tab=4 &";
        scroll-up = "${pkgs.pulseaudio}/bin/pactl set-source-volume @DEFAULT_SOURCE@ +5%";
        scroll-down = "${pkgs.pulseaudio}/bin/pactl set-source-volume @DEFAULT_SOURCE@ -5%";
      };

      # Réseau
      "module/network" = {
        type = "internal/network";
        interface-type = "wired";
        interval = 3;

        format-connected = "<label-connected> ";
        format-connected-prefix = " ";
        format-connected-prefix-font = 2;
        label-connected = "%linkspeed%";

        format-disconnected = "<label-disconnected> ";
        format-disconnected-prefix = " ";
        format-disconnected-prefix-font = 2;
        label-disconnected = "X";
        label-disconnected-foreground = "#f38ba8";
      };

      "module/wifi" = {
        type = "internal/network";
        interface-type = "wireless";
        interval = 3;

        format-connected = "<label-connected> ";
        format-connected-prefix = " ";
        format-connected-prefix-font = 2;
        label-connected = "%essid% - %signal%";

        format-disconnected = "<label-disconnected> ";
        format-disconnected-prefix = " ";
        format-disconnected-prefix-font = 2;
        label-disconnected = "X";
        label-disconnected-foreground = "#f38ba8";
      };

      # Menu power avec rofi
      "module/powermenu" = {
        type = "custom/text";
        content = "";
        content-font = 3;
        content-foreground = "#7EB1EF";
        click-left = "${pkgs.writeShellScript "powermenu" ''
          choice=$(echo -e "Annuler\n🔴 Éteindre\n🔄 Redémarrer\n🚪 Déconnexion" |
            ${pkgs.rofi}/bin/rofi \
            -dmenu \
            -p "" \
            -theme-str 'window {width: 500px; height: 500px; border-radius: 12px;}' \
            -theme-str 'listview {lines: 4; columns: 1; spacing: 10px;}' \
            -theme-str 'element {padding: 20px; border-radius: 10px;}' \
            -theme-str 'element-text {horizontal-align: 0.5; vertical-align:
          0.5; font: "JetBrains Mono Nerd Font 22";}' \
            -theme-str 'element-icon {size: 0;}' \
            -theme-str 'element selected {background-color: #BEBEBE;}' \
            -theme-str 'inputbar {enabled: false;}' \
            -theme-str 'mainbox {padding: 15px;}')
              case "$choice" in
                "Annuler") ;;
                "🔴 Éteindre") systemctl poweroff ;;
                "🔄 Redémarrer") systemctl reboot ;;
                "🚪 Déconnexion") i3-msg exit ;;
              esac
        ''}";
      };
    };
  };
}
