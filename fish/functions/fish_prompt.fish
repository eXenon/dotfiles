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
    echo FF0000
  case exenon xavier
    echo $color2
  case '*'
    echo $color4
  end
end

function __user_prompt --desc "Return small prompt based on user"
  switch $USER
  case root
    echo "🗲"
    __vi_mode
  case exenon xavier
    __vi_mode
  case '*'
    echo "?"
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

function __vi_mode --desc "Translate the vi mode into a single caracter"
  switch $fish_bind_mode
    case default
      echo '_'
    case insert
      set_color --bold green
      echo '>'
    case replace_one
      set_color --bold green
      echo 'r'
    case visual
      set_color --bold brmagenta
      echo 'v'
    case '*'
      set_color --bold red
      echo '?'
  end
  set_color normal
end

function fish_prompt
  set -g __prompt_status (echo $status)
  echo "" # Leave a line
  echo -n " "
  __bubble $color0 (__user_color) (__user_prompt)
  echo -n " "
end

function fish_right_prompt
  # Git
  set git_prompt (__fish_git_prompt)
  if git rev-parse --git-dir > /dev/null 2>&1;
    __bubble $color8 $color3 $git_prompt
    echo -n " "
  end

  # Pwd
  __bubble $color0 $color4 (prompt_pwd)
  echo -n " "

  # Background jobs
  if test (jobs -p | wc -l) -gt 0
    __bubble $color3 $color0 (jobs -p | wc -l)
    echo -n " "
  end

  # Failed commands
  if test $__prompt_status -eq 127
    __bubble $color1 $color0 "?"
    echo -n " "
  else if test $__prompt_status -ne 0
    __bubble $color1 $color0 "$__prompt_status"
    echo -n " "
  end
end
