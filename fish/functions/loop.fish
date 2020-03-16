function line
    set_color normal
    set_color $argv[1]
    set width (tput cols)
    printf "$color%*s$reset" "$width" | sed 's/ /━/g'
    set_color normal
end

function loop
    while true
        line 999999
        eval $argv
        if test $status -eq 0
            line 00FF00
        else
            line FF0000
        end
        inotifywait --quiet --quiet --recursive --exclude .git --event modify .
    end
end

