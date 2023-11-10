alias dstop="docker stop \$(docker ps -q)"
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}'"
alias new_mysql_docker="docker run --name mysql -e MYSQL_ROOT_PASSWORD=secret -d mysql:5.7"