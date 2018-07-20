```
sudo apt install zsh curl
cd ~
git clone git@github.com:ybbarng/zsh.git .zsh
ln -s .zsh/zshrc.zsh .zshrc
chsh -s $(which zsh)
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```
