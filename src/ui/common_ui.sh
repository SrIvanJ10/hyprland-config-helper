SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/programs_ui.sh"
source "${SCRIPT_DIR}/autostart_ui.sh"

addNewItem() { #$1 last line text $2 name
    local result
    local template="$3"
    
    result=$(dialog --stdout --clear \
           --title "NEW $2" \
           --inputbox "Write the new config:" 15 50 \
           "${template}")

    if [ $? -eq 0 ]; then

        addItem "$1" "$result"
        
    else
        return 1
    fi
}

activate_Desactivate() { #$1 = program line

    local program_text="$1"
    new_status=$(switchActiveStatus "${program_text}")

    editItem "${program_text}" "${new_status}"
}

EditorUi() { # $1 actual program name
    local program_text="$1"
    local result

    local RED='\e[0;31m'
    local NC='\e[0m'
    
    result=$(dialog --stdout --clear \
           --title "-- EDITOR --" \
           --inputbox "Current State: $(get_value $program_text)" 15 50 \
           "${program_text}")
    
    if [ $? -eq 0 ]; then
        #modify data
        #set -x

        editItem "$program_text" "$result"
        
        #sleep 100
        #return 0
    else
        return 1
    fi


}

Options() {
    local program_text=$1

    choice=$(dialog  --stdout \
            --title "Hyprland Config Helper" \
            --menu "Please select one option for ${program_text}:" 15 50 3 \
            1 "Activate/Desactivate (this put/cut a #)" \
            2 "Edit" \
            3 "Delete (Backup is not working yet!!)")
        
    clear
    
    case $choice in
        1)
            activate_Desactivate "${program_text}"
            ;;
        2)
            EditorUi "${program_text}"
            ;;
        3)
            editItem "${program_text}" ""
            ;;
        *)
            
            ;;
    esac

}