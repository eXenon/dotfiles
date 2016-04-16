#
# Colors
#

set background  2B303B
set c0          000000
set c8          38372C
set c1          571DC2 
set c9          7C54B0
set c2          14DB49
set c10         A2E655
set c3          403D70
set c11         9C6F59
set c4          385A70
set c12         323F5C
set c5          384894
set c13         5E6C99
set c6          4F3A5E
set c14         667D77
set c7          999999
set c15         FFFFFF


# User prompt block
if [ (whoami) != 'root' ]
    set __user_back $c12
    set __user_for $c15
else
    set __user_back $c2
    set __user_for $c0
end

# Pwd
set __pwd_back $background
set __pwd_for $c9

# Git
set __git_back $c12
set __git_for $c15

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

