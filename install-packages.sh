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

# packages
&& brew install openjdk nvm vim gh colima docker awscli aws-sam-cli \
&& brew install --cask mysqlworkbench firefox postman visual-studio-code warp zulu11 \
&& echo -e "\n $CHECK packages installed" \

# go version mannager
&& bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) \
&& source /Users/kcalixto/.gvm/scripts/gvm \
&& gvm install go1.19 \
&& gvm use go1.19 --default