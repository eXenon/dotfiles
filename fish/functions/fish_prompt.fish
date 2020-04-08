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
    case exenon xavier
        echo $color2
    case '*'
        echo $color4
    end
end

function __bubble --desc "Create a powerline segment with color transition"
    set bg $argv[1]
    set fg $argv[2]
    set content $argv[3]

    # A starting bubble
    set_color -b "$background"
    set_color "$bg"
    echo -n \uE0B6

    # Then the content
    set_color -b "$bg"
    set_color "$fg"
    echo -n $content

    # And finish the bubble 
    set_color -b "$background"
    set_color "$bg"
    echo -n \uE0B4

    # Reset colors
    set_color "$foreground"
end

function fish_prompt
	echo -n " "
        __bubble $color4 (__user_color) ">"
	echo -n " "
end

function fish_right_prompt
	# Pwd
	__bubble $color1 $color4 (prompt_pwd)

	echo -n " "

	# Root
	if test $USER = "root"
		__bubble $color9 $color11 "🗲"
		echo -n " "
	end

        # Git
	set git_prompt (__fish_git_prompt)
	if git rev-parse --git-dir > /dev/null 2>&1;
		__bubble $color5 $color15 $git_prompt
	end
end
