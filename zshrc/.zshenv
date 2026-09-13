# Make Homebrew-managed tools available to interactive, remote, and
# non-interactive zsh processes (including Herdr's remote server).
typeset -U path PATH

if [[ -d /opt/homebrew/bin ]]; then
  path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
elif [[ -d /home/linuxbrew/.linuxbrew/bin ]]; then
  path=(/home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin $path)
fi

export PATH
