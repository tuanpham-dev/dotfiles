#!/bin/bash

# install zsh
sudo apt install zsh -y

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# copy .zshrc files
cp ./.zshrc* ~/

# change default shell to zsh
chsh -s $(which zsh)

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# run setup.sh
zsh setup

# run zsh after all
zsh
