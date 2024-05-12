# Set up ssh-agent
if test -z "$SSH_AGENT_PID"
    eval $(ssh-agent | sed "s/; e/ e/g" | head -n 2)
    ssh-add > /dev/null
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/exenon/.ghcup/bin # ghcup-env
