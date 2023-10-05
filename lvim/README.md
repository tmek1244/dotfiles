# LunarVim installation

### Required packages: git, make, pip, python

## Neovim Installation

```bash
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
tar xzvf nvim-linux64.tar.gz
sudo mv nvim-linux64 /opt/
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
```

## Rust Installation

```bash
curl https://sh.rustup.rs -sSf | sh
```
Reload the shell to update the environment

## NVM and Node.js Installation

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
source ~/.bashrc
nvm install v18.17.0 # latest LTS version available on the day of writing that 
npm install -g npm
```

## LunarVim Installation

The latest available version on the day of writing that was 0.9
https://www.lunarvim.org/docs/installation
```bash
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
```

## Nerd Fonts Installation

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
```

Download [https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts](Nerd Fonts) and set them up as the default font in the terminal
Updating the font cache may be needed `fc-cache -f -v`


# Cloning configuration

```bash
git clone git@github.com:tmek1244/lvim-config.git ~/.config/lvim/
```

