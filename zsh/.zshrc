# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# Created by `pipx` on 2024-12-17 14:17:16
export PATH="$PATH:/Users/gabrielvolpini/.local/bin"
export PATH=/Users/gabrielvolpini/.pyenv/versions/3.8.16/bin:/Users/gabrielvolpini/.pyenv/versions/3.8.16/bin:/Users/gabrielvolpini/.nvm/versions/node/v22.12.0/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/gabrielvolpini/.local/bin:/Users/gabrielvolpini/.local/bin export PATH="$(pyenv root)/versions/3.8.16/bin:$PATH"

ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

alias ls="eza --icons=always --tree --level=1 --group-directories-first"

alias stow="stow -v -t ~"
alias v="nvim"
eval "$(zoxide init zsh)"
alias cd="z"


# bun completions
[ -s "/Users/gabrielvolpini/.bun/_bun" ] && source "/Users/gabrielvolpini/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#Avante nvim
export PATH="$HOME/.cargo/bin:$PATH"

# Where to store history
HISTFILE=~/.zsh_history
# How many entries to keep in memory and on disk
HISTSIZE=100000
SAVEHIST=100000

# Better history behavior
setopt APPEND_HISTORY         # append rather than overwrite
setopt INC_APPEND_HISTORY     # write to file immediately
setopt SHARE_HISTORY          # share history across sessions
setopt HIST_IGNORE_DUPS       # skip immediate duplicates
# setopt HIST_IGNORE_ALL_DUPS # (optional) remove older duplicates


function http() {
  if [[ "$1" == "--edit" || "$1" == "-e" ]]; then
    nvim "$HOME/.local/share/posting/default"
    return 0
  fi

  env_path="$HOME/.local/share/posting/default/dev.env"  # default

  if [[ "$1" == "--dev" || "$1" == "-d" ]]; then
    shift
    # keep default
  elif [[ "$1" == "--test" || "$1" == "-t" ]]; then
    env_path="$HOME/.local/share/posting/default/test.env"
    shift
  fi

  posting --env "$env_path" "$@"
}

function sql() {
    ssh -i "/Users/gabrielvolpini/Documents/deliverThat/db-bastion.pem" \
    -L 15432:dev-deliveries-db.cluster-cjw6me40mpzn.us-east-1.rds.amazonaws.com:5432 ec2-user@ec2-54-144-252-229.compute-1.amazonaws.com \
    -N &

    SSH_PID=$!

    sleep 1

    trap "echo Encerrando túnel SSH...; kill $SSH_PID" EXIT

    rainfrog --url "postgres://postgres:thoChoflw2droz4jltHu@localhost:15432/postgres"

}

export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="$JAVA_HOME/bin:$PATH"
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

# history fuzzy finder
history() {
  local cmd
  cmd=$(
    cat ~/.zsh_history \
    | sed 's/^: [0-9]*:[0-9]*;//' \
    | grep -v -i -E 'SECRET_KEY|password|token' \
    | tail -r | awk '!seen[$0]++' \
    | fzf --no-sort --height 80% --border --prompt='history> '
  ) || return
  [[ -n "$cmd" ]] && print -z -- "$cmd"
}

# opencode
export PATH=/Users/gabrielvolpini/.opencode/bin:$PATH
