autostartUi() {
    while true; do
        mapfile -t programs < <(get_values "AUTOSTART" "ENVIRONMENT VARIABLES" 'exec-once')

        local options=()
        for ((i=0; i<${#programs[@]}; i++)); do
            options+=("$((i+1))")
            options+=("${programs[i]}")
        done
        
        choice=$(dialog --clear \
                        --title "AUTOSART PROGRAMS" \
                        --menu "Please select one option: " 15 50 3 \
                        "${options[@]}" \
                        "+" "Add new program" \
                        3>&1 1>&2 2>&3)
        
        exit_status=$?
        clear

        if [ $exit_status -eq 0 ]; then

            if [ "$choice" = "+" ]; then

                if [ ${#programs[@]} -gt 0 ]; then
                    addNewItem "${programs[-1]}" "AUTOSTART" "exec-once = "
                else
                    return 1
                fi
            else

                Options "${programs[$((choice-1))]}"
            fi
        else
            return 1
        fi
    done
}