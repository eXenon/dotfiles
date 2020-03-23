#
# Colors
#

# special
set foreground ffffff
set cursor ffffff
set background 181c30

# black
set color0 1b1d1e
set color8 505354

# red
set color1 f92672
set color9 ff5995

# green
set color2 82b414
set color10 b6e354

# yellow
set color3 fd971f
set color11 feed6c

# blue
set color4 0066cc
set color12 333399

# magenta
set color5 8c54fe
set color13 9e6ffe

# cyan
set color6 465457
set color14 899ca1

# white
set color7 ccccc6
set color15 f8f8f2

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

