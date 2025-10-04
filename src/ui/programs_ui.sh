programsUi() {
    choice=$(dialog --clear \
                    --title "MY PROGRAMS" \
                    --menu "Please select one option:" 15 50 3 \
                    1 "Terminal" \
                    2 "Browser" \
                    3 "Editor" \
                    3>&1 1>&2 2>&3)
    
    exit_status=$?
    clear

    # Depuración
    echo "Exit status: $exit_status"
    echo "Choice: '$choice'"
    read -p "Presiona Enter para continuar..."

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