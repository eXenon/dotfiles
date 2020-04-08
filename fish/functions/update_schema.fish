function __update_color
    set name $argv[1]
    set val $argv[2]

    # Fish prompt
    sed -i "s/set $name .*/set $name $val/g" "$DOTFILES/fish/functions/fish_prompt.fish"

    # Kitty
    sed -i "s/$name .*/$name #$val/g" "$DOTFILES/kitty.conf"
end

function __get_col
    set name $argv[1]

    echo (cat "$DOTFILES/Xresources" | grep "*.$name:" | cut -d"#" -f 2)
    return 0
end


function update_schema --desc "Update the global color schema"
    for col in (seq 0 15)
        __update_color "color$col" (__get_col "color$col")
    end
    __update_color "foreground" (__get_col "foreground")
    __update_color "background" (__get_col "background")
    __update_color "cursor" (__get_col "cursorColor")
end
