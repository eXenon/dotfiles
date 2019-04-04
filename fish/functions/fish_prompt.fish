#
# Colors
#



# special
set foreground   "ffffff"
set background   "000000"
set cursorColor  "ffffff"
set color0       "2e3436"
set color8       "555753"
set color1       "cc0000"
set color9       "ef2929"
set color2       "4e9a06"
set color10      "8ae234"
set color3       "c4a000"
set color11      "fce94f"
set color4       "3465a4"
set color12      "729fcf"
set color5       "75507b"
set color13      "ad7fa8"
set color6       "06989a"
set color14      "34e2e2"
set color7       "e6eae2"
set color15      "f3f3f1"

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
    if test "$USER" = "root"
        echo $color1
    else
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

