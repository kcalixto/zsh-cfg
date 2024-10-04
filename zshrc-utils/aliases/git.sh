alias gr1="git reset --soft HEAD~1"
alias gtag="git describe --abbrev=0 --tags"
alias gcb="git checkout -b "
alias gc="git checkout "
alias gc-="git checkout -"
alias gmain="git checkout main && git pull origin main"
alias gnext="git checkout next && git pull origin next"
alias gdev="git checkout development && git pull origin development"
alias gstash="git stash save -u"
alias gapply="git stash apply"
alias gpick="git cherry-pick --no-commit"
alias glog="git log --oneline"
alias gpr="$ZSH_CFG_HOME/scripts/git-see-prs.sh"
alias gm="git merge --no-edit"
alias gmm="git merge main --no-edit"