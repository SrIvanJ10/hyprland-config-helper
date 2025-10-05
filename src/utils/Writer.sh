#config_file="~/.config/hypr/hyprland.conf"

write_change() { # $1 = line number, $2 = text to write
    sed -i "${1}i\\${2}" $HOME/.config/hypr/hyprland.conf
}

erease_line() { # $1 = line number
    sed -i.bak -e "${1}d" $HOME/.config/hypr/hyprland.conf
}