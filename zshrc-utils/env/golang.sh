# go version mannager
# gvm use go1.19 --default
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export GOROOT=$HOME/.gvm/gos/go1.19
export GOROOT_BOOTSTRAP=$GOROOT

export GOPATH=$HOME/go/src

export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
