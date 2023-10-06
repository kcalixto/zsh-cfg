export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git web-search)

source $ZSH/oh-my-zsh.sh

alias src="source ~/.zshrc"
alias caws="code ~/.aws/credentials"
alias gr1="git reset --soft HEAD~1"
alias gmain="git checkout main && git pull"
alias gnext="git checkout next && git pull"
alias gdev="git checkout development && git pull"
alias gstash="git stash save -u"
alias gapply="git stash apply"
alias gpick="git cherry-pick --no-commit"
alias glog="git log --oneline"
alias goinit="go mod init && go mod tidy"

# Docker
alias dstop="docker stop \$(docker ps -q)"
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}'"
alias new_mysql_docker="docker run --name mysql -e MYSQL_ROOT_PASSWORD=secret -d mysql:5.7"

# Obsidian Vault
obsidian() {
    # get command flags
    local action=$1
    local target=$2

    export OBSIDIAN_PATH=~/Documents/obsidian
    export VAULT_NAME=main-vault

    case $action in
        "push")
            case $target in
                "-a")
                    echo -e "\xE2\x9D\x97 pushing everything to git \n" \
                    && cd "$OBSIDIAN_PATH" \
                    && git add . \
                    && git reset "$VAULT_NAME/_private" \
                    && git commit -m "🤖 auto commit all" \
                    && git push \
                    && cd - \
                    && echo -e "\n \xE2\x9C\x85 done!"
                    ;;
                *)
                    echo -e "\xE2\x9C\x85 pushing already committed files only \n" \
                    && cd "$OBSIDIAN_PATH" \
                    && git commit -am "📦 auto update commit" \
                    && git push \
                    && cd - \
                    && echo -e "\n \xE2\x9C\x85 done!"
                    ;;
            esac
        ;;
        "reset")
            echo "resetting last commit (be aware that it's using push --hard)"
            git reset --soft HEAD~1
            git push --force
        ;;
        *)
        echo -e "\xE2\x9D\x8C no action specified. Use 'push' to push to remote repo or 'reset' to undo last commit"
        ;;
    esac
}

# create poc github repos :)
poc() {
    local repo_name=$1

    if [ -z "$repo_name" ]; then
        echo -e "\xE2\x9D\x8C no repo name specified"
        return
    fi

    echo -e "creating repo $repo_name"
    
    gh repo create poc-$repo_name --public --add-readme --clone
    code poc-$repo_name

    echo -e "\xE2\x9C\x85 done!"
}

# java - brew install openjdk
# export JAVA_HOME=/usr/local/opt/openjdk  // TESTE

# node version mannager
# install nvm cmd: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPATH=$HOME/go

# PATH
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/sbin
# export PATH=$PATH:$JAVA_HOME/bin // TESTE

# bun completions
[ -s "/Users/kcalixto/.bun/_bun" ] && source "/Users/kcalixto/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# react native development
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/10.0/bin


# go version mannager
# gvm use go1.19 --default

echo "🤖  Load .zshrc"
[[ -s "/Users/kcalixto/.gvm/scripts/gvm" ]] && source "/Users/kcalixto/.gvm/scripts/gvm"