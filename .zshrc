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