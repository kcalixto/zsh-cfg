################################################################################
# Golang
################################################################################
# go version mannager
# gvm use go1.19 --default
# [[ -s "/Users/kaua.calixto/.gvm/scripts/gvm" ]] && source "/Users/kaua.calixto/.gvm/scripts/gvm"
source "/Users/kaua.calixto/.gvm/scripts/gvm"

# export GOROOT=/Users/kaua.calixto/.gvm/gos/go1.19
# export GOROOT_BOOTSTRAP=$GOROOT
# # don't forget to add ssh over https in .gitconfig
export GOPATH=$HOME/go/src
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
################################################################################
# Node
################################################################################
# node version mannager
# install nvm cmd: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
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

