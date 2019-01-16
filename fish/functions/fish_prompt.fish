#
# Colors
#



# special
set foreground      "FFFFFF"
set foreground_bold "FFFFFF"
set cursor          "FFFFFF"
set background      "000000"

# black
set color0  "2E3436"
set color8  "555753"

# red
set color1  "A31604"
set color9  "C60001"

# green
set color2  "447241"
set color10 "27A343"

# yellow
set color3  "C1951A"
set color11 "D5A30E"

# blue
set color4  "425387"
set color12 "4A5A8D"

# magenta
set color5  "965D98"
set color13 "893C8C"

# cyan
set color6  "06989A"
set color14 "12BCCB"

# white
set color7  "D3D7CF"
set color15 "EEEEEC"

# Extra coloRS
set color16 "000000"
set color17 "FFFFFF"

# Status Chars
set __fish_git_prompt_char_dirtystate '•'
set __fish_git_prompt_char_stagedstate '+'
set __fish_git_prompt_char_stashstate '$'
set __fish_git_prompt_char_upstream_ahead '▲'
set __fish_git_prompt_char_upstream_behind '▼'
set __fish_git_prompt_char_upstream_equal '▸'
set __fish_git_prompt_char_untrackedfiles '…'

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
        set_color white
        set_color -b blue
        echo -n "$USER "

        # Pwd
        __segment blue white green white
        echo -n (prompt_pwd)

        # Git
        __segment green white red white
        printf "%s" (__fish_git_prompt)

        # End
        __segment red white normal normal
end

