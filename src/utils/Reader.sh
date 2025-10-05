get_values() {
    section=$(awk -v start="$1" -v end="$2" '$0 ~ start, $0 ~ end' ~/.config/hypr/hyprland.conf)

    #values=($(echo "$section" | grep -E '^\$|^#\$'))
    mapfile -t values < <(echo "$section" | grep -E '^\$|^#\$')

    for value in "${values[@]}"; do
        echo "$value"
    done
}