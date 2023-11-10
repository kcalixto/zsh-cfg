export CHECK="\xE2\x9C\x85"

brew install nvm \
&& nvm install node \
&& nvm use node \
&& echo -e "\n $CHECK node installed!" \

# node packages
&& source ~/.zshrc \
&& npm install -g yarn serverless bun pnpm