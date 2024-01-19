export ZSH="$HOME/.oh-my-zsh"
# this repo location in your machine :)
export ZSH_CFG_HOME="$HOME/go/src/zsh-cfg"

ZSH_THEME="robbyrussell"
plugins=(git web-search)
source $ZSH/oh-my-zsh.sh

base_folder="$HOME/go/src/zsh-cfg/zshrc-utils"
find "$base_folder" -type f -name "*.sh" | while read -r script; do
    source "$script"
done

base_folder="$HOME/go/src/zsh-cfg/scripts"
find "$base_folder" -type f -name "*.sh" | while read -r script; do
    source "$script"
done

echo "🤖  Loaded .zshrc"
