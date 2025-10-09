SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../utils/RWManager.sh"
source "${SCRIPT_DIR}/../config/programs_config.sh"

addNewProgram() { #$1 last program name in the list
    local last_program_text=$1
    local result
    
    result=$(dialog --stdout --clear \
           --title "NEW PROGRAM" \
           --inputbox "Write the new program config:" 15 50 )

    if [ $? -eq 0 ]; then
        #modify data
        #set -x

        addItem "$last_program_text" "$result"
        
        #sleep 100
        #return 0
    else
        return 1
    fi
}

activateOrDesactivate() { #$1 = program line

    local program_text="$1"
    new_status=$(switchActiveStatus "${program_text}")

    editItem "${program_text}" "${new_status}"
}

programOptions() {
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
            activateOrDesactivate "${program_text}"
            ;;
        2)
            programEditorUi "${program_text}"
            ;;
        3)
            editItem "${program_text}" ""
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
        
        #sleep 100
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

            if [ "$choice" = "+" ]; then

                if [ ${#programs[@]} -gt 0 ]; then
                    addNewProgram "${programs[-1]}"
                else
                    return 1
                fi
            else

                programOptions "${programs[$((choice-1))]}"
            fi
        else
            return 1
        fi
    done
}