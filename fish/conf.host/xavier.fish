set -xg KBFS /home/xavier/kbfs/

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
direnv hook fish | source

# Kitty setup
kitty + complete setup fish | source

