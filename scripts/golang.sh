#!/bin/bash

gomodinit() {
    go_mod_name="${PWD#*/go/src/}"
    echo "What's the repository account name?"
    read account
    if [ -z "$account" ]; then
        echo "Please provide the repository account name."
        return 0
    fi

    module_name="github.com/$account/$go_mod_name"
    echo "confirm the module $module_name (y/n)"
    read confirm
    echo "confirm: $confirm"
    if [ "$confirm" != "y" ]; then
        echo "Operation canceled."
        return 0
    fi

    go mod init $module_name
}