# Set up ssh-agent
if test -z "$SSH_AGENT_PID"
    eval $(ssh-agent | sed "s/; e/ e/g" | head -n 2)
    ssh-add > /dev/null
end
