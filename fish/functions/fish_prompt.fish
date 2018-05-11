#
# Colors
#


# special
set foreground   c0c5ce
set background   2b303b
set cursorColor  c0c5ce

# black
set color0       2b303b
set color8       65737e

# red
set color1       bf616a
set color9       bf616a

# green
set color2       a3be8c
set color10      a3be8c

# yellow
set color3       ebcb8b
set color11      ebcb8b

# blue
set color4       8fa1b3
set color12      8fa1b3

# magenta
set color5       b48ead
set color13      b48ead

# cyan
set color6       96b5b4
set color14      96b5b4

# white
set color7       c0c5ce
set color15      eff1f5


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
set __git_back $color8
set __git_for $color15

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
        printf '%s' (__fish_git_prompt)

        # End
        set_color normal
        set_color $__git_back
        echo -n \uE0B0
end

