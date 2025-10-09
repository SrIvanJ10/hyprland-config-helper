#!/bin/bash

#exec 2> >(tee /tmp/script_debug.log)

#set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/ui/programs_ui.sh"

# Función para mostrar el menú principal
mainMenu() {
    while true; do
        choice=$(dialog \
                        --title "Hyprland Config Helper" \
                        --menu "Please select one option:" 15 50 3 \
                        1 "MY PROGRAMS" \
                        2 "AUTOSTART" \
                        3 "KEYBINDINGS" \
                        3>&1 1>&2 2>&3)
        
        clear
        
        case $choice in
            1)
                $(programsUi)
                ;;
            2)
                # autostartUi (cuando lo implementes)
                echo "AUTOSTART - Working"
                read -p "Press Enter to continue..."
                ;;
            3)
                # keybindingsUi (cuando lo implementes)
                echo "KEYBINDINGS - Working"
                read -p "Press Enter to continue..."
                ;;
            *)
                echo "Goodbye!"
                exit 0
                ;;
        esac
    done
}

# Iniciar el menú principal
mainMenu