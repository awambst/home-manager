#!/bin/bash
case "$1" in
    "shutdown") zenity --question --text="Shutdown?" && systemctl poweroff ;;
    "reboot") zenity --question --text="Reboot?" && systemctl reboot ;;
    "logout") zenity --question --text="Logout?" && hyprctl dispatch exit ;;
esac
