SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../utils/RWManager.sh"

programOptions() {
    local program_text=$1

    choice=$(dialog \
            --title "Hyprland Config Helper" \
            --menu "Please select one option for ${program_text}:" 15 50 3 \
            1 "Activate/Desactivate [Working] (this put/cut a #)" \
            2 "Edit" \
            3 "Delete [Working] " \
            3>&1 1>&2 2>&3)
        
        clear
        
        case $choice in
            1)
                echo "Activate/Desactivate - Working"
                read -p "Press Enter to continue..."
                ;;
            2)
                programEditorUi "${program_text}"
                ;;
            3)
                # keybindingsUi (cuando lo implementes)
                echo "Delete - Working"
                read -p "Press Enter to continue..."
                ;;
            *)
                
                ;;
        esac
}

programEditorUi() { # $1 actual program name
    local program_text=$1
    local result
    
    result=$(dialog --stdout --clear \
           --title "EDITOR -- ${program_text}" \
           --inputbox "Edit program config:" 15 50 \
           "${program_text}")
    
    if [ $? -eq 0 ]; then
        #modify data
        #set -x

        editItem "$program_text" "$result"
        
        #return 0
    else
        return 1
    fi


}

programsUi() {
    while true; do
        #programs=$(get_values "MY PROGRAMS" "AUTOSTART")
        mapfile -t programs < <(get_values "MY PROGRAMS" "AUTOSTART")

        local options=()
        for ((i=0; i<${#programs[@]}; i++)); do
            options+=("$((i+1))")
            options+=("${programs[i]}")
        done

        choice=$(dialog --clear \
                        --title "MY PROGRAMS" \
                        --menu "Please select one option: " 15 50 3 \
                        "${options[@]}" \
                        "+" "Add new item" \
                        3>&1 1>&2 2>&3)
        
        exit_status=$?
        clear

        if [ $exit_status -eq 0 ]; then
            #Editor UI

            programOptions "${programs[$((choice-1))]}"
            #programEditorUi "${programs[$((choice-1))]}"

            #return 0
        else
            return 1
        fi
    done
}