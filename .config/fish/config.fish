set -x EDITOR nvim
set -x REACT_EDITOR nvim
set -x FZF_DEFAULT_COMMAND 'ag -g ""'
set -x QT_AUTO_SCREEN_SCALE_FACTOR 1
set -x GDK_SCALE 2

source .config/fish/aliases

# eval (python3 -m virtualfish auto_activation)
# eval (docker-machine env default)

status --is-interactive
