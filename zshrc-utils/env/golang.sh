# go version mannager
# gvm use go1.19 --default
[[ -s "/Users/kaua.calixto/.gvm/scripts/gvm" ]] && source "/Users/kaua.calixto/.gvm/scripts/gvm"

export GOROOT=/Users/kaua.calixto/.gvm/gos/go1.19
export GOROOT_BOOTSTRAP=$GOROOT

export GOPATH=$HOME/go/src

export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
