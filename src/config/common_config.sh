
switchActiveStatus() { #$1 = program line
    #view if it's desactiveted already
    if [[ "$1" == "#"* ]]; then
        #Delete # to activate
        echo "$@" | tr -d "#"
    else
        echo "#$@"
    fi
}

#switchActiveStatus $1