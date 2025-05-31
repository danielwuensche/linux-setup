export VISUAL=nvim
export EDITOR=$VISUAL
export GPG_TTY=$(tty)

[[ -f "$HOME/.profile-local_$(hostname)" ]] && source "$HOME/.profile-local_$(hostname)"
