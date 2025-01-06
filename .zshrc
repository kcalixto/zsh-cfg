# TODO - organize this shit again

export ZSH="$HOME/.oh-my-zsh"
# this repo location in your machine :)
export ZSH_CFG_HOME="$HOME/go/src/zsh-cfg"

ZSH_THEME="robbyrussell"
# ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git web-search zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

base_folder="$HOME/go/src/zsh-cfg/zshrc-utils"
find "$base_folder" -type f -name "*.sh" | while read -r script; do
    source "$script"
done

base_folder="$HOME/go/src/zsh-cfg/scripts"
find "$base_folder" -type f -name "*.sh" | while read -r script; do
    source "$script"
done

aws_logs() {
    local log_group
    local log_stream
    log_group=$(aws logs describe-log-groups --region sa-east-1 | jq -r ".logGroups[].logGroupName" | fzf --preview '')
    option=$(echo -e "search\ntail" | fzf --preview '')

    if [ "$option" = "search" ]; then
        log_stream=$(aws logs describe-log-streams --region sa-east-1 --log-group-name "$log_group" --max-items 5 --order-by LastEventTime --descending | jq -r '.logStreams[].logStreamName' | fzf --preview '')
        aws logs get-log-events --log-stream-name "$log_stream" --log-group-name "$log_group" --region sa-east-1 | jq ".events[].message" | fzf --preview 'echo {}' --preview-window wrap
    elif [ "$option" = "tail" ]; then
        aws logs tail $log_group --follow --region sa-east-1 --since 1h
    else
        echo "Invalid option"
    fi
}

# oh my posh
# eval "$(oh-my-posh init zsh --config '/Users/kaua.calixto/go/src/zsh-cfg/oh-my-posh/config.omp.json')"

echo "🤖  Loaded .zshrc"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
