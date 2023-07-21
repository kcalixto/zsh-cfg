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

# installs love of my life
&& brew install openjdk \
    && export JAVA_HOME=$(/usr/libexec/java_home -v 11) \
    && export PATH=$JAVA_HOME/bin:$PATH \
    && echo -e "\n $CHECK  java installed" \

# installs what i use to make money
&& brew install go \
    && export GOPATH=$HOME/go \
    && export PATH=$PATH:$GOPATH/bin \
    && echo -e "\n $CHECK go installed" \

# node version mannager
&& brew install nvm \
    && echo -e "\n $CHECK nvm installed" \

# vim
&& brew install vim \
    && echo -e "\n $CHECK vim installed" \

