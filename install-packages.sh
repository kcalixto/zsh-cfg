export CHECK="\xE2\x9C\x85"

# installs homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    && echo -e "\n $CHECK homebrew installed" \

# zsh
&& sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && echo -e "\n $CHECK zsh installed" \

# set zsh as default shell
&& chsh -s /bin/zsh \
    && echo -e "\n $CHECK zsh set as default shell" \

# java
&& brew install openjdk \
    && export JAVA_HOME=$(/usr/libexec/java_home -v 11) \
    && export PATH=$JAVA_HOME/bin:$PATH \
    && echo -e "\n $CHECK  java installed" \

# node version mannager
&& brew install nvm \
    && echo -e "\n $CHECK nvm installed" \

# vim
&& brew install vim \
    && echo -e "\n $CHECK vim installed" \

# gh cli tool
&& brew install gh \
    && echo -e "\n $CHECK gh installed" \

# go version mannager
&& bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) \
    && source /Users/kcalixto/.gvm/scripts/gvm \
    && gvm install go1.19 \
    && gvm use go1.19 --default \
    && export GOPATH=$HOME/go \
    && export PATH=$PATH:$GOPATH/bin \    
    && echo -e "\n $CHECK go installed" \