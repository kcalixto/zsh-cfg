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