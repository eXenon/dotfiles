set -gx PATH ~/.gem/ruby/2.3.0/bin $PATH

set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx DBUS_SESSION_BUS_ADDRESS unix:path=/run/user/1000/bus

set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8

set -gx KBFS /keybase/

set -gx TERM xterm

function tx
  tmux attach -t txmain; or tmux new -s txmain
end

function tx-takeover
  tmux detach -a
end

function loadavg
  uptime | grep -o '[0-9]\+\.[0-9]\+' | head -n1
end

function diskusg
  df / | tail -n1 | sed "s/  */ /g" | cut -d' ' -f 5 | cut -d'%' -f1
end

function reload
  source ~/.config/fish/config.fish
end
