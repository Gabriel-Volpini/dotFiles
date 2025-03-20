# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
