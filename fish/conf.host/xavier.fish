set -xg KBFS /home/xavier/kbfs/
set -xg DOTFILES /root/dotfiles/

# Start X at login
if test (id -u) -eq 0
    # Root user. Dont start X. 
else
    if status is-login
        if test -z "$DISPLAY" -a $XDG_VTNR = 1
            exec ssh-agent startx -- -keeptty
        end
    end
end

# Direnv
eval (asdf direnv hook fish)
function direnv
  asdf exec direnv "$argv"
end

# Kitty setup
kitty + complete setup fish | source

# Add execs to path
set -xg PATH /home/xavier/execs:$PATH

# Screen switch functions
function only_hdmi
  set external (xrandr | grep " connected" | grep -v eDP | head -n 1 | cut -d" " -f 1)
  set internal (xrandr | grep " connected" | grep eDP | head -n 1 | cut -d" " -f 1)

  # First step : deactivate the internal screen, then change the scaling.
  # Turns out i3 has weird behavior when changing everything at once
  xrandr --output $external --mode 1920x1080 --pos 0x0 --rotate normal --output $internal --off

  # Refresh i3
  i3-msg restart

  # Set monitor to exernal
  xrandr --output $external --mode 1920x1080 --pos 0x0 --rotate normal --scale 1.6x1.6 --output $internal --off

  # Set keyboard to bépo
  setxkbmap fr bepo
  touch "/tmp/bepo"
end

function only_internal
  set external (xrandr | grep " connected" | grep -v eDP | head -n 1 | cut -d" " -f 1)
  set internal (xrandr | grep " connected" | grep eDP | head -n 1 | cut -d" " -f 1)

  # Set monitor to internal
  xrandr --output $internal --mode 2560x1440 --pos 0x0 --rotate normal --primary --output $external --off

  # Set keyboard to french
  setxkbmap fr
  rm -f "/tmp/bepo"
end

function both_screens
  set external (xrandr | grep " connected" | grep -v eDP | head -n 1 | cut -d" " -f 1)
  set internal (xrandr | grep " connected" | grep eDP | head -n 1 | cut -d" " -f 1)

  # Set monitor to internal
  xrandr --output $internal --mode 2560x1440 --pos 0x2160 --rotate normal --primary --output $external --mode 1920x1080 --pos 0x0 --rotate normal --scale 1.6x1.6

  # Set keyboard to french
  setxkbmap fr
  rm -f "/tmp/bepo"
end
