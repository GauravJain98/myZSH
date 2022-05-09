# myZSH

Assuming you already have [oh my zsh](https://ohmyz.sh/#install) setup

## Run the following script to add my zsh to your zsh shell

```bash

# only for ubuntu 
sudo apt install neofetch

# install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# keeping last working zshrc for backup
mv ~/.zshrc ~/.zshrc_backup
curl https://raw.githubusercontent.com/GauravJain98/myZSH/master/.zshrc > ~/.zshrc
```
