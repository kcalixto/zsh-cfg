export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

alias caws="code ~/.aws/credentials"
alias gr1="git reset --soft HEAD~1"
alias gh="git reset --hard"
alias gmain="git checkout main && git pull"
alias gnext="git checkout next && git pull"
alias gstash="git stash save -u"
alias gapply="git stash apply"
alias gpick="git cherry-pick --no-commit"
alias glog="git log --oneline"
alias goinit="go mod init && go mod tidy"
alias dstop="docker stop \$(docker ps -q)"

export GO111MODULE=on
export PATH=$PATH:$GOROOT/bin

# node version mannager
# install nvm cmd: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
