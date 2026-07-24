sudo apt-get update
sudo apt-get install stow
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
mkdir ~/.local/bin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
echo 'kitty.desktop' > ~/.config/xdg-terminals.list
sudo apt install zsh
chsh -s $(which zsh)

## relog

zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
ln -s /opt/nvim-linux-x86_64/bin/nvim ~/.local/bin

sudo apt-get install ripgrep
sudo apt-get install fzf zoxide fd-find direnv
# Debian ships fd as fdfind; the fzf/zf config looks for `fd`.
ln -sf "$(command -v fdfind)" ~/.local/bin/fd
# Only if migrating from a machine that used autojump:
# zoxide import autojump --merge
sudo apt install python3-pip
sudo apt install python3-neovim
sudo apt install python3-venv
