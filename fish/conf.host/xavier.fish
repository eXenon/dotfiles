set -xg KBFS /home/xavier/kbfs/
set -xg DOTFILES /root/dotfiles/

# Start X at login
if test (id -u) -eq 0
    # Root user. Dont start X. 
else
    if status is-login
        if test -z "$DISPLAY" -a $XDG_VTNR = 1
            exec ssh-agent Hyprland
        end
    end
end

# Direnv
# Kitty setup
kitty + complete setup fish | source

# Add execs to path
set -xg PATH /home/xavier/execs:$PATH
