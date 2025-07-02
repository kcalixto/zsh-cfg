################################################################################
# Golang
################################################################################
# export GOROOT=/Users/kaua.calixto/.gvm/gos/go1.19
# export GOROOT_BOOTSTRAP=$GOROOT
export GVM_ROOT="$HOME/.gvm"
if [ -s "$GVM_ROOT/scripts/gvm" ] && [ -z "$GVM_VERSION" ]; then
    source "$GVM_ROOT/scripts/gvm"
fi

# # don't forget to add ssh over https in .gitconfig
export GOPATH=$HOME/go/src
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
################################################################################
# Node
################################################################################
# node version mannager
# install nvm cmd: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash 

start_nvm() {
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        \. "$NVM_DIR/nvm.sh"  # This loads nvm
    else
        echo "NVM is not installed or not found in $NVM_DIR"
    fi
}

# npm install -g yarn serverless bun pnpm

# bun completions
# [ -s "/Users/kaua.calixto/.bun/_bun" ] && source "/Users/kaua.calixto/.bun/_bun"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# react native development
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/10.0/bin

################################################################################
# Java
################################################################################
# export JAVA_HOME="/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home"

#? react native
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home"

################################################################################
# Path
################################################################################
# bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/bin
export PATH=$PATH:/Users/kaua.calixto/.local/bin

################################################################################
# Others
################################################################################
export NOTE_PATH="~/go/src/obsidian-vault/main-vault/notes/"
source "$(brew --prefix)/etc/profile.d/z.sh" 
