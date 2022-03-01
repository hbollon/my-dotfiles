#  _____    _
# |__  /___| |__  _ __ ___
#   / // __| '_ \| '__/ __|
#  / /_\__ \ | | | | | (__
# /____|___/_| |_|_|  \___|
# Aliases for a few useful commands

## Alias section 
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias mirrorUpdate='sudo pacman-mirrors -f0'
alias mirrorUpgrade='sudo pacman-mirrors -f0 && sudo pacman -Syyu'
alias pacmanGhost='~/.scripts/pacman.sh'
alias shivita='toilet -f mono12 -F rainbow 'hbollon' | ponythink -f winona'
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias ip='ip -c'
alias rm='rm -i'
alias x='ranger'
alias h='htop'
alias pc='sudo pacman -Rns $(pacman -Qtdq)'
alias pcc='sudo pacman -Sc'

setopt COMPLETE_ALIASES
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt appendhistory
setopt autocd
setopt correct
setopt extendedglob
setopt nocaseglob
setopt nobeep
setopt rcexpandparam
setopt incappendhistory
setopt nomatch
setopt notify
setopt sharehistory

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

unsetopt beep
#bindkey -e
autoload -Uz compinit promptinit bashcompinit
compinit
promptinit
bashcompinit
zstyle :compinstall filename '$HOME/.zshrc'
complete -o nospace -C /usr/bin/vault vault
complete -o nospace -C /usr/bin/terraform terraform

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
    colorize
    copyfile
    docker
    docker-compose
    emacs
    fzf
    git
    gitfast
    golang
    history-substring-search
    kubectl
    rust
    safe-paste
    tmux
    virtualenv
)

# Source Oh My ZSH for plugins and zsh-autosuggestions, zsh-syntax-highlighting,
# zsh-history-substring-search and the powerlevel10k theme.
while IFS= read -r script
do
    source "$script"
done < <(find /usr/share/zsh/plugins/ -maxdepth 2 -type f -name "*.zsh" ! -name '*plugin.zsh')
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Use powerline
USE_POWERLINE="true"

export PATH=$PATH:/usr/local/go/bin:/home/hbollon/go/bin

