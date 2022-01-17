function open_errors --description "Execute a command, parse out files and linenumbers and open them all"
    set OUTPUT (mktemp)
    $argv > $OUTPUT 2>&1

    string match -r "File \".*\", line \d+" (cat $OUTPUT) \
    | sed "s/File \"\(.*\)\", line \([:digit]*\)/\1:\2/p" \
    | string join " " \
    | xargs nvim
end
