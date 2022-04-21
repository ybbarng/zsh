```
sudo apt install zsh curl
# Install starship: https://starship.rs/guide/#%F0%9F%9A%80-installation
cd ~
git clone git@github.com:ybbarng/zsh.git .zsh
ln -s .zsh/zshrc.zsh .zshrc
chsh -s $(which zsh)
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```
