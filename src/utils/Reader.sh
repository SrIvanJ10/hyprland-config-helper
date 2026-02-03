#config_file=$HOME/.config/hypr/hyprland.conf

get_value() {
    local program_text="$@"
    echo $(awk -F '= ' '{print $2}' <<< $program_text)
}

get_values() {
    section=$(awk -v start="$1" -v end="$2" '$0 ~ start, $0 ~ end' $HOME/.config/hypr/hyprland.conf)

    mapfile -t values < <(echo "$section" | grep -E "$3") #'^\$|^#\$')

    for value in "${values[@]}"; do
        echo "$value"
    done
}

get_line() { # $1 = text to find
    grep -Fxn "$1" $HOME/.config/hypr/hyprland.conf | cut -d: -f1 | head -n1
}