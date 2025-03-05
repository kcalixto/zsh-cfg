# tools
```bash
ln .alacritty.toml ~/.alacritty.toml
ln .zshrc ~/.zshrc
ln .tmux.conf ~/.tmux.conf
```
# folders
```
ln ~/go/src/zsh-cfg/nvim ~/.config/nvim
```
# binaries
```bash
ln bin/obsidian /usr/local/bin/obsidian
```
# scripts
```bash
./crontab.sh
```
# to change tmux theme
```bash
inside tmux:
source-file ~/.tmux.conf

outside tmux:
tmux kill-server 
```
# notification placement remap
## you must use scripts editor to update this script
```bash
ln ./com.kcalixto.notifications-placement.plist ~/Library/LaunchAgents/com.kcalixto.notifications-placement.plist
launchctl load ~/Library/LaunchAgents/com.kcalixto.notifications-placement.plist
launchctl list | grep kcalixto
```
## to unload:
```bash
launchctl unload ~/Library/LaunchAgents/com.kcalixto.notifications-placement.plist
```
