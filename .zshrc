export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git web-search)

source $ZSH/oh-my-zsh.sh

folders=(
    "./zshrc-utils/aliases"
    "./zshrc-utils/scripts"
    "./zshrc-utils/env"
)

for folder in "${folders[@]}"; do
    # Loop through each file in the folder and source it
    for file in "$folder"/*.sh; do
        source "$file"
    done
done

echo "🤖  Load .zshrc"