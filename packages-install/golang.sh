export CHECK="\xE2\x9C\x85"

# go version mannager
&& bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) \
&& source ~/.gvm/scripts/gvm \
&& gvm install go1.19 \
&& gvm use go1.19 --default