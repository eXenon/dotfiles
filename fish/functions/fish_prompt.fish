#
# Colors
#


# special
set foreground   98d1ce
set background   0a0f14
set cursorColor  98d1ce

# black
set color0       0a0f14
set color8       10151b

# red
set color1       c33027
set color9       d26939

# green
set color2       26a98b
set color10      081f2d

# yellow
set color3       edb54b
set color11      245361

# blue
set color4       195465
set color12      093748

# magenta
set color5       4e5165
set color13      888ba5

# cyan
set color6       33859d
set color14      599caa

# white
set color7       98d1ce
set color15      d3ebe9

set urgent       c33027


# User prompt block
if [ (whoami) != 'root' ]
    set __user_back $color8
    set __user_for $color15
else
    set __user_back $urgent
    set __user_for $color15
end

# Pwd
set __pwd_back $background
set __pwd_for $color15

# Git
set __git_back $color12
set __git_for $color15

#
#
#

# fish git prompt
set __fish_git_prompt_color -b $__git_back
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showstagedstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_color_branch -b $__git_back

# Status Chars
set __fish_git_prompt_char_dirtystate '• '
set __fish_git_prompt_char_stagedstate '+'
set __fish_git_prompt_char_stashstate '$'
set __fish_git_prompt_char_upstream_ahead '▲'
set __fish_git_prompt_char_upstream_behind '▼'
set __fish_git_prompt_char_upstream_equal '▸'
set __fish_git_prompt_char_untrackedfiles '… ' 

 
function fish_prompt
        set last_status $status

        # User 
        set_color -b $__user_back
        set_color $__user_for
        echo -n "$USER "

        # Transition
        set_color $__user_back
        set_color -b $__pwd_back
        echo -n \uE0B0 
        echo -n " "

        # Pwd
        set_color -b $__pwd_back
        set_color $__pwd_for
        printf '%s ' (prompt_pwd)

        # Transition
        set_color $__pwd_back
        set_color -b $__git_back
        echo -n \uE0B0

        # Git
        printf '%s ' (__fish_git_prompt)

        # End
        set_color normal
        set_color $__git_back
        echo -n \uE0B0
end

