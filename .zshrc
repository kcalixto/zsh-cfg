#!/bin/zsh
# =============================================================================
# ZSH Configuration with Zinit
# =============================================================================

# Debug logging function
log_debug() {
    [[ "$DEBUG" == "true" ]] && echo "$1"
}

# Performance timing
start_time=$(($(date +%s%N)/1000000))

log_debug "Loading .zshrc with zinit... (10%)"

# =============================================================================
# Zinit Installation & Setup
# =============================================================================

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load essential annexes
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# =============================================================================
# Theme & Plugins
# =============================================================================

log_debug "Loading theme and plugins... (20%)"

# Load pure theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

# Load plugins with lazy loading
zinit wait lucid for \
    OMZ::plugins/git/git.plugin.zsh \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-syntax-highlighting

zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# =============================================================================
# Custom Configuration Files
# =============================================================================

log_debug "Loading custom configs... (50%)"

export ZSH_CFG_HOME="$HOME/go/src/zsh-cfg"

# Load environment and aliases
[[ -f "$ZSH_CFG_HOME/env.sh" ]] && source "$ZSH_CFG_HOME/env.sh"
[[ -f "$ZSH_CFG_HOME/aliases.sh" ]] && source "$ZSH_CFG_HOME/aliases.sh"

# =============================================================================
# Custom Scripts
# =============================================================================

log_debug "Loading custom scripts... (70%)"

# Load all custom scripts
for script in "$ZSH_CFG_HOME"/scripts/*.sh(N); do
    [[ -r "$script" ]] && source "$script"
done

# =============================================================================
# Secrets & Final Setup
# =============================================================================

log_debug "Loading secrets... (90%)"

# Load secrets (if exists)
[[ -f ~/.secrets.sh ]] && source ~/.secrets.sh

# =============================================================================
# Startup Complete
# =============================================================================

log_debug ".zshrc loaded (100%)"
end_time=$(($(date +%s%N)/1000000))

echo "⚡ Startup time: $((end_time - start_time))ms"
