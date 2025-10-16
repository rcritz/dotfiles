# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

bindkey -e

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt CORRECT
setopt CORRECT_ALL
setopt PROMPT_SUBST
setopt NO_CASE_GLOB
setopt RM_STAR_SILENT

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# expand history
HISTSIZE=50000
SAVEHIST=$HISTSIZE
HISTDUP=erase

# other shell configuration
CORRECT_IGNORE_FILE='.git'

# set environment variables including PATH
export GPG_TTY=$(tty)
export GOPATH=$HOME/goprojects
export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
export PATH=$JAVA_HOME/bin:$GOPATH/bin:/usr/local/sbin:$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export SWIFTPATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:"${PATH}"
export OLDPATH=$PATH
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_AUTO_UPDATE=1
export EDITOR='nvim'

# make sure non-GUI connections get a GPG prompt they can actually see
if test "$SSH_CONNECTION" != ""
then
    export PINENTRY_USER_DATA="USE_CURSES=1"
fi

# set up aliases
alias flushDNS="sudo killall -HUP mDNSResponder"
alias birdie='Xnest :2 -query birdie -geometry 1500x1000&'
alias kickstart="sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
alias sublime="open -a /Applications/Sublime\ Text.app/"
alias -g stt='open -b com.sublimetext.4'
alias ls='eza --color=always --icons=always'
alias l.="$aliases[ls] -d .*"
alias ll="$aliases[ls] -l --git"
alias lla="$aliases[ls] -la --git"
alias tree="$aliases[ls] --tree"
alias mute='osascript -e "set volume output muted true"'
alias unmute='osascript -e "set volume output muted false"'
alias empty='osascript -e "tell application \"Finder\" to empty trash"'
alias -g lint-project='swiftlint --no-cache --config ~/com.raywenderlich.swiftlint.yml . 2>&1 | grep -v Linting'
alias cdf='pwdf; cd "$(pwdf)"'
alias ta='tmux attach'
alias vi='nvim'
alias lg='lazygit'
alias gg='lazygit'
alias yy='yazi'
alias cat='bat'
alias cd='z'
alias ff='fastfetch'

# use antigen to add to configuration
source $(brew --prefix)/share/antigen/antigen.zsh
ZSH_GIT_PROMPT_SHOW_STASH=1
antigen bundle woefe/git-prompt.zsh
#antigen bundle docker
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle Aloxaf/fzf-tab
antigen apply

# autoloads
fpath+=~/Dropbox/zshfunctions
autoload zmv
autoload xcswitch
autoload manp
autoload mant
autoload -U select-word-style && select-word-style bash
autoload compinit && compinit
compdef _swift-completions swift # use the definition from `swift package completion-tool` instead of default

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# set prompt
if [[ -z "$SSH_CLIENT" ]]; then
    PROMPT='%(?.%F{green}√.%F{red}X)%f %B%2~%b $(gitprompt)%# '
else
    PROMPT='%(?.%F{green}√.%F{red}X)%f %n@%m %B%2~%b $(gitprompt)%# '
fi

#eval $(thefuck --alias)

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export BAT_THEME="Catppuccin Latte"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
source <(fzf --zsh)
source ~/.config/fzf-git.sh/fzf-git.sh
eval "$(zoxide init zsh)"
#source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"
