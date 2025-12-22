#!/bin/bash

file_man=dolphin


powr_str="   Power"
file_str="📂  File Manager"
disp_str="🖥️  Display Settings"
audi_str="🔊  Audio Settings"



# Main menu function
main_menu() {
    echo "$file_str"
    echo "$disp_str"
    echo "$audi_str"
    echo "$powr_str"
}

# Power submenu
power_menu() {
    echo "🔌 Poweroff"
    echo "🔄 Reboot"
    echo "💤 Suspend"
    echo "🔒 Lock"
    echo "⬅️  Back"
}

# File manager submenu
file_menu() {
    echo "🏠 Home"
    echo "📂 Documents"
    echo "⬇️  Downloads"
    echo "🖼️  Pictures"
    echo "⬅️  Back"
}

# Display submenu
display_menu() {
    echo "💡 Brightness"
    echo "🖥️  Monitor Setup"
    echo "🎨 Theme"
    echo "⬅️  Back"
}

# Audio submenu
audio_menu() {
    echo "🔊 Volume Up"
    echo "🔉 Volume Down"
    echo "🔇 Mute"
    echo "⬅️  Back"
}

my_rofi() {
    local title="$1"
    rofi \
        -markup-rows \
        -dmenu -i \
        -p "$title" \
        -theme-str '* {background:#E0E0E0;}' \
        -theme-str 'configuration {me-select-entry: ""; click-to-exit: true;
            me-accept-entry: "!MousePrimary"; hover-select: true;}' \
        -theme-str 'window {location: south west; anchor: south west;
            width: 300px; height: 400px; border-radius: 30px;}' \
        -theme-str 'listview {lines: 6; columns: 1; spacing: 2px;}' \
        -theme-str 'element {padding: 2px; border-radius: 12px; spacing: 0px;}' \
        -theme-str 'element-text {horizontal-align: 0; 
            vertical-align: 1; font: "JetBrains Mono Nerd Font 14";}' \
        -theme-str 'element-icon {size: 0;}' \
        -theme-str 'element selected {background-color: #BEBEBE;}' \
        -theme-str 'inputbar {enabled: false;}' \
        -theme-str 'mainbox {padding: 2px;}'
}

# Main loop
show_menu() {
    local menu="main"

    while true; do
        case $menu in
            main)
                choice=$(main_menu | my_rofi)
                case $choice in
                    "$powr_str")
                        menu="power"
                        ;;
                    "$file_str")
                        "$file_man" &
                        exit 0
                        ;;
                    "$disp_str")
                        arandr &
                        exit 0
                        ;;
                    "$audi_str")
                        pavucontrol &
                        exit 0
                        ;;
                    "")
                        exit 0
                        ;;
                esac
                ;;

            power)
                choice=$(power_menu | my_rofi "Power Options")
                case $choice in
                    "🔌 Poweroff")
                        systemctl poweroff
                        ;;
                    "🔄 Reboot")
                        systemctl reboot
                        ;;
                    "💤 Logout")
                        i3-msg exit
                        ;;
                    "🔒 Lock")
                        ~/.config/lock/i3-lock.sh &
                        exit 0
                        ;;
                    "⬅️  Back")
                        menu="main"
                        ;;
                    "")
                        exit 0
                        ;;

                esac
                ;;

            file)
                choice=$(file_menu | my_rofi "File Manager")
                case $choice in
                    "🏠 Home")
                        "$file_man" ~ & # or your file manager
                        exit 0
                        ;;
                    "📂 Documents")
                        "$file_man" ~/Documents &
                        exit 0
                        ;;
                    "⬇️  Downloads")
                        "$file_man" ~/Downloads &
                        exit 0
                        ;;
                    "🖼️  Pictures")
                        "$file_man" ~/Pictures &
                        exit 0
                        ;;
                    "⬅️  Back")
                        menu="main"
                        ;;
                    "")
                        exit 0
                        ;;

                esac
                ;;

            display)
                choice=$(display_menu | my_rofi "Display Settings")
                case $choice in
                    "💡 Brightness")
                        # Add brightness control here
                        notify-send "Brightness" "Feature not implemented"
                        menu="main"
                        ;;
                    "🖥️  Monitor Setup")
                        arandr & # or xrandr commands
                        menu="main"
                        ;;
                    "🎨 Theme")
                        lxappearance &
                        menu="main"
                        ;;
                    "⬅️  Back" | "")
                        menu="main"
                        ;;
                esac
                ;;

            audio)
                choice=$(audio_menu | my_rofi "Audio Settings")
                case $choice in
                    "🔊 Volume Up")
                        pactl set-sink-volume @DEFAULT_SINK@ +5%
                        menu="main"
                        ;;
                    "🔉 Volume Down")
                        pactl set-sink-volume @DEFAULT_SINK@ -5%
                        menu="main"
                        ;;
                    "🔇 Mute")
                        pactl set-sink-mute @DEFAULT_SINK@ toggle
                        menu="main"
                        ;;
                    "⬅️  Back" | "")
                        menu="main"
                        ;;
                esac
                ;;
        esac
    done
}

# Start the menu
show_menu
