export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git web-search)
source $ZSH/oh-my-zsh.sh

base_folder="./zshrc-utils"
find "$base_folder" -type f -name "*.sh" | while read -r script; do
    source "$script"
done

echo "🤖  Load .zshrc"