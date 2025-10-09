#config_file=$HOME/.config/hypr/hyprland.conf

get_values() {
    section=$(awk -v start="$1" -v end="$2" '$0 ~ start, $0 ~ end' $HOME/.config/hypr/hyprland.conf)

    #values=($(echo "$section" | grep -E '^\$|^#\$'))
    mapfile -t values < <(echo "$section" | grep -E '^\$|^#\$')

    for value in "${values[@]}"; do
        echo "$value"
    done
}

get_line() { # $1 = text to find
    grep -Fxn "$1" $HOME/.config/hypr/hyprland.conf | cut -d: -f1 | head -n1
}