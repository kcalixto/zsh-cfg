echo ".zshrc loading... (10%)"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CFG_HOME="$HOME/go/src/zsh-cfg" # this repo location in your machine :)
ZSH_THEME="nicoulaj"
# frontcube
# gozilla
# kolo
# nicoulaj
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# start_time=$(python3 -c 'from time import time; print(int(round(time() * 1000)))')
echo ".zshrc loading... (30%)"
source $ZSH_CFG_HOME/env.sh
source $ZSH_CFG_HOME/aliases.sh
# end_time=$(python3 -c 'from time import time; print(int(round(time() * 1000)))')
# elapsed_time=$((end_time - start_time))
# echo "Elapsed time: $elapsed_time milliseconds"

echo ".zshrc loading... (60%)"
base_folder="$HOME/go/src/zsh-cfg/scripts"
find "$base_folder" -type f -name "*.sh" | while read -r script; do
    source "$script"
done

echo ".zshrc loading... (90%)"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

echo ".zshrc loaded (100%)"

source ~/.secrets.sh

