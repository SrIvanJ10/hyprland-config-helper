SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../utils/RWManager.sh"

programsUi() {

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

    case $choice in
        1)
            echo "Configurando Terminal..."
            sleep 2
            ;;
        2)
            echo "Configurando Browser..."
            sleep 2
            ;;
        3)
            echo "Configurando Editor..."
            sleep 2
            ;;
        *)
            echo "Cancelado"
            ;;
    esac
}