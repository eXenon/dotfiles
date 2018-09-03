#
# Colors
#


# special
set foreground   EEFFFF
set background   212121
set cursorColor  EEFFFF

# black
set color0       212121
set color8       4A4A4A

# red
set color1       F07178
set color9       F07178

# green
set color2       C3E88D
set color10      C3E88D

# yellow
set color3       FFCB6B
set color11      FFCB6B

# blue
set color4       82AAFF
set color12      82AAFF

# magenta
set color5       C792EA
set color13      C792EA

# cyan
set color6       89DDFF
set color14      89DDFF

# white
set color7       EEFFFF
set color15      FFFFFF

# Extra colors
set color16      F78C6C
set color17      FF5370
set color18      303030
set color19      353535
set color20      B2CCD6
set color21      EEFFFF


set urgent       c33027


# User prompt block
if [ (whoami) != 'root' ]
    set __user_back $color0
    set __user_for $color3
else
    set __user_back $color1
    set __user_for $color0
end

# Pwd
set __pwd_back $color3
set __pwd_for $color0

# Git
set __git_back $color18
set __git_for $color14

# End separator
set __end_back $color3
set __end_for $color0

#
#
#

# fish git prompt
set __fish_git_prompt_color $__git_for
set __fish_git_prompt_color_prefix $__git_for
set __fish_git_prompt_color -b $__git_back
set __fish_git_prompt_color_branch $__git_for
set __fish_git_prompt_color_branch -b $__git_back
set __fish_git_prompt_color_flags $__git_for
set __fish_git_prompt_color_flags -b $__git_back
set __fish_git_prompt_color_upstream -b $__git_back
set __fish_git_prompt_color_suffix -b $__git_back
set __fish_git_prompt_color_merging -b $__git_back
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showstagedstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'

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
        set_color -b $__pwd_back
        set_color $__user_back
        echo -n \uE0B0

        # Pwd
        set_color -b $__pwd_back
        set_color $__pwd_for
        printf ' %s ' (prompt_pwd)

        # Transition
        set_color $__pwd_back
        set_color -b $color0
        echo -n \uE0B0

        # Git
        printf '%s ' (__fish_git_prompt)

        # End
        set_color -b $__end_back
        set_color $__git_back
        echo -n \uE0B0
        set_color $__end_for
        echo -n ' '
        set_color $__end_back
        set_color -b $background
        echo -n \uE0B0
end

