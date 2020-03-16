#
# Colors
#



# special
set foreground "c5c8c6"
set background "1d1f21"
set cursorColor "c5c8c6"

# black
set color0 "282a2e"
set color8 "373b41"

# red
set color1 "a54242"
set color9 "cc6666"

# green
set color2 "8c9440"
set color10 "b5bd68"

# yellow
set color3 "de935f"
set color11 "f0c674"

# blue
set color4 "5f819d"
set color12 "81a2be"

# magenta
set color5 "85678f"
set color13 "b294bb"

# cyan
set color6 "5e8d87"
set color14 "8abeb7"

# white
set color7 "707880"
set color15 "c5c8c6"

# Status Chars
set __fish_git_prompt_char_dirtystate '•'
set __fish_git_prompt_char_stagedstate '+'
set __fish_git_prompt_char_stashstate '$'
set __fish_git_prompt_char_upstream_ahead '▲'
set __fish_git_prompt_char_upstream_behind '▼'
set __fish_git_prompt_char_upstream_equal '▸'
set __fish_git_prompt_char_untrackedfiles '…'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showstagedstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'

function __user_color --desc "Return background color depending on active user"
    switch $USER
    case root
        echo $color1
    case exenon
        echo $color2
    case '*'
        echo $color4
    end
end

function __segment --desc "Create a powerline segment with color transition"
    set bg1 $argv[1]
    set fg1 $argv[2]
    set bg2 $argv[3]
    set fg2 $argv[4]

    # A final space
    set_color -b "$bg1"
    set_color "$fg1"
    echo -n " "

    # Then the arrow
    set_color -b "$bg2"
    set_color "$bg1"
    echo -n \uE0B0

    # Then a space with color transition
    set_color "$fg2"
    echo -n " "
end

function fish_prompt
        # User
        set_color $foreground
        set_color -b (__user_color)
        echo -n "$USER "

        # Pwd
        __segment (__user_color) $background $color0 $foreground
        echo -n (prompt_pwd)

        # Git
        __segment $color0 $foreground $color8 $foreground
        printf "%s" (__fish_git_prompt)

        # End
        __segment $color8 $foreground normal normal
end

