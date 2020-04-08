#
# Colors
#

# special
set foreground F8F8F2
set background 161D38

# black
set color0 29315A
set color8 613E9F

# red
set color1 E356A7
set color9 FF79C6

# green
set color2 42E66C
set color10 50FA7B

# yellow
set color3 E4F34A
set color11 F1FA8C

# blue
set color4 9B6BDF
set color12 BD93F9

# magenta
set color5 E64747
set color13 FF5555

# cyan
set color6 44D1EF
set color14 70D2E6

# white
set color7 EFA554
set color15 FFB86C

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
        echo AA5555
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

