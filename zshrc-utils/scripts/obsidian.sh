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