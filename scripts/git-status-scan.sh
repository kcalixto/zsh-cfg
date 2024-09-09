BLUE='\033[0;34m'

git-scan() {
    my_projects_folder="$HOME/go/src"

    for file in `find $my_projects_folder -type d -maxdepth 2` ; do
        (cd $file && git cherry -v)
    done
}