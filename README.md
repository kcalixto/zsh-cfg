# tools
```bash
ln .zshrc ~/.zshrc
ln .tmux.conf ~/.tmux.conf
ln .gitconfig ~/.gitconfig
ln ./.claude/CLAUDE.md ~/.claude/CLAUDE.md
```

# folders
```bash
ln -s "$(pwd)/nvim" ~/.config/nvim
ln -s "$(pwd)/.claude/skills" ~/.claude/skills
```

# to use npm private packages
```bash
> ~/.npmrc

//npm.pkg.github.com/:_authToken=COLE-SEU-TOKEN-AQUI
@SUA-ORG-AQUI:registry=https://npm.pkg.github.com/ln
```

# to change tmux theme
```bash
inside tmux:
source-file ~/.tmux.conf

outside tmux:
tmux kill-server 
```

# notification placement remap
## you must use Apple Scripts Editor to update this script
```bash
ln ./com.kcalixto.notifications-placement.plist ~/Library/LaunchAgents/com.kcalixto.notifications-placement.plist
launchctl load ~/Library/LaunchAgents/com.kcalixto.notifications-placement.plist
launchctl list | grep kcalixto
```
## to unload:
```bash
launchctl unload ~/Library/LaunchAgents/com.kcalixto.notifications-placement.plist
```
