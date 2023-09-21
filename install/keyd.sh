cd /tmp
git clone https://github.com/rvaiya/keyd
make -C keyd && sudo make install -C keyd
sudo systemctl enable keyd && sudo systemctl start keyd
cd -

sudo cp -f default.conf /etc/keyd/
sudo keyd reload