BLUE='\033[0;34m'

git-scan() {
    my_projects_folder="$HOME/go/src"

    cd $my_projects_folder
    FOLDERS=$(ls -d */)
    for folder in $FOLDERS; do
        cd $folder
        echo -e "${BLUE} $folder"
        git status -s
        cd ..
    done

    # goes back to original dir
    cd -
}