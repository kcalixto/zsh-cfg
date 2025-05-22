alias caws="vim ~/.aws/credentials"
alias dstop="docker stop \$(docker ps -q)"
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}'"
alias new_mysql_docker="docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -d mysql:5.7"
alias gr1="git reset --soft HEAD~1"
alias gtag="git fetch && git describe --abbrev=0 --tags"
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
alias gm="git merge --no-edit"
alias gmm="git merge main --no-edit"
alias goinit="go mod init && go mod tidy"
alias src="source ~/.zshrc"

# https://www.reddit.com/r/git/comments/avv34g/nicer_gitstatus/
gs() {
    pwd=$(pwd)
    dir=$(basename $pwd)
    echo -e "# \033[1;32m$dir\033[0m"
    awk -vOFS='' '
    NR==FNR {
        all[i++] = $0;
        difffiles[$1] = $0;
        next;
    }
    ! ($2 in difffiles) {
        print; next;
    }
    {
        gsub($2, difffiles[$2]);
        print;
    }
    END {
        if (NR != FNR) {
            # Had diff output
            exit;
        }
        # Had no diff output, just print lines from git status -sb
        for (i in all) {
            print all[i];
        }
    }
' \
    <(git diff --color --stat=$(($(tput cols) - 3)) HEAD | sed '$d; s/^ //')\
    <(git -c color.status=always status -sb)
}
