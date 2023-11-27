export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git web-search)
source $ZSH/oh-my-zsh.sh

base_folder="$HOME/go/src/zsh-cfg/zshrc-utils"
find "$base_folder" -type f -name "*.sh" | while read -r script; do
    source "$script"
done

echo "🤖  Loaded .zshrc"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kaua.calixto/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kaua.calixto/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kaua.calixto/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kaua.calixto/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
