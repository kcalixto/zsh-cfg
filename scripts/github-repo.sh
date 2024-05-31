# create poc github repos :)
poc() {
    echo "This command was deprecated :( Please use 'repo poc <repo_name>' now!"
}

# create a new github repo :)
repo() {
    local action=$1

    if [ -z $2 ]; then
        echo -e "\xE2\x9D\x8C no repo name specified"
        return
    fi
    
    # Check if there's a folder with the same name
    if [ -d $2 ]; then
        echo -e "\xE2\x9D\x8C folder $2 already exists"
        return
    fi
    
    case $action in 
        "poc")
            local repo_name="poc-$2"
            echo -e "creating repo $repo_name"        
            gh repo create $repo_name --public --add-readme --clone
            if [ $? -ne 0 ]; then
                echo -e "\xE2\x9D\x8C failed to create repo $repo_name"
                return
            fi
            code $repo_name
            echo -e "\xE2\x9C\x85 done!"
        ;;
        "new")
            local repo_name=$2
            echo -e "creating repo $repo_name"
            gh repo create $repo_name --public --add-readme --clone
            if [ $? -ne 0 ]; then
                echo -e "\xE2\x9D\x8C failed to create repo $repo_name"
                return
            fi
            code $repo_name
            echo -e "\xE2\x9C\x85 done!"
        ;;
        *)
            echo -e "\xE2\x9D\x8C invalid action. Use 'poc' to create a poc repo or 'create' to create a new repo"
        ;;
    esac
}