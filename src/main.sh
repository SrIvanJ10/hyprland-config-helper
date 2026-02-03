#!/bin/bash

### FOR DEBUG ###
#exec 3>/tmp/script_debug.log
#BASH_XTRACEFD=3
#set -x

MAIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${MAIN_DIR}/utils/RWManager.sh"
source "${MAIN_DIR}/ui/common_ui.sh"
source "${MAIN_DIR}/config/common_config.sh"

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
                programsUi
                ;;
            2)
                autostartUi
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