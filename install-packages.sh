# install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && echo -e "\n $CHECK zsh installed!" \

&& sleep 5 \

# set zsh as default shell
&& chsh -s /bin/zsh \
    && echo -e "\n $CHECK zsh set as default shell!" \

&& sleep 5 \

&& /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    && echo -e "\n $CHECK homebrew installed!"

base_folder="./packages-install"
find "$base_folder" -type f -name "*.sh" | while read -r script; do
    source "$script"
done

echo "done installing packages!"