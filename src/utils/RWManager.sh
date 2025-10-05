SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/Reader.sh"
source "${SCRIPT_DIR}/Writer.sh"

editItem() { # $1 = old text, $2 = new text
    line=$(get_line $1)
    new_text=$2

    #erease line
    $(erease_line $line)

    #Write new data
    $(write_change $line "$new_text")
}