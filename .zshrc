# Path to your Oh My Zsh installation.
export ZSH=$HOME/.oh-my-zsh

## Startup Oh My Zsh
ZSH_THEME="lambda-gitster" # set by `omz`
plugins=(git)
source $ZSH/oh-my-zsh.sh

## Startup pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

## Homebrew options
export HOMEBREW_AUTO_UPDATE_SECS=86400
export HOMEBREW_NO_ENV_HINTS=1

export PATH=$HOME/.config/cutefetch:$PATH
export PATH=$HOME/.local/lib/python3.12/site-packages:$PATH
export PATH=$HOME/bin:$PATH

## Display cutefetch on terminal startup
cutefetch $(printf '-k\n-b\n-p' | shuf -n 1) $(shuf -i 1-13 -n 1)

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# node options
export NODE_OPTIONS=$NODE_OPTIONS' --openssl-legacy-provider'

# gemini key
[ -s "$HOME/.config/.secrets" ] && source "$HOME/.config/.secrets"

eval "$(zoxide init zsh)"

alias cd='z'
alias cat='bat'
alias src='source s'
alias fzf="fzf --style full --walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

. "$HOME/.local/bin/env"

export PATH=/Users/kappke/.bun/bin:/Users/kappke/bin:/Users/kappke/.local/lib/python3.12/site-packages:/Users/kappke/.config/cutefetch:/Users/kappke/.pyenv/shims:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin:/usr/local/share/dotnet:~/.dotnet/tools:/Users/kappke/.local/bin:/Users/kappke/.bun/bin:/Users/kappke/.local/lib/python3.12/site-packages:/Users/kappke/.config/cutefetch:/Users/kappke/.cargo/bin:/Applications/Ghostty.app/Contents/MacOS:/Users/kappke/go/bin
