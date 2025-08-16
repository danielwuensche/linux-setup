export VISUAL=nvim
export EDITOR=$VISUAL
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

[[ -f "$HOME/.profile-local_$(hostname)" ]] && source "$HOME/.profile-local_$(hostname)"
