#
#   Simple aliases
#
alias tmux="tmux -2"
alias vim="nvim"
alias txp="tmuxp"
alias txl="tmuxp load"

set -xg ERL_AFLAGS "-kernel shell_history enabled"
set -xg PATH ~/.local/bin/ $PATH

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

# Kitty setup
kitty + complete setup fish | source

# Direnv
direnv hook fish | source

# fnm
set PATH $HOME/.fnm $PATH
fnm env --multi | source
