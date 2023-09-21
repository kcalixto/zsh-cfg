#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'

cd ..
FOLDERS=$(ls -d */)
for folder in $FOLDERS; do
    cd $folder
    echo -e "${BLUE} $folder"
    git status -s
    cd ..
done