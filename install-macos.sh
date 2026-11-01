# macOS counterpart of install.sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install stow neovim tree-sitter-cli ripgrep fzf zoxide fd bat direnv
# Mason installs ts_ls, eslint, html, pyright, yamlls, ansiblels and prettierd
# through npm, and ansible-lint through a python venv -- without these they fail.
brew install node python
brew install --cask kitty karabiner-elements rectangle alt-tab

# Stow karabiner BEFORE first launching Karabiner-Elements, so ~/.config/karabiner
# becomes a symlink to the whole directory (Karabiner rewrites karabiner.json in place).
stow zsh nvim kitty karabiner

zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

# MesloLGS NF (font_family in kitty.conf, patched for powerlevel10k)
for style in Regular Bold Italic "Bold Italic"; do
  curl -fsSL -o ~/Library/Fonts/"MesloLGS NF $style.ttf" \
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20${style// /%20}.ttf"
done
