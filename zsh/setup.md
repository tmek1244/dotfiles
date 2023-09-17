# Setup ZSH

## Install ZSH

```bash
sudo apt-get install zsh
```

## Change shell to use zsh

```bash
chsh -s $(which zsh)
```

## Install ZSH ZAP

```bash
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
```

## Run stow ZSH

```bash
stow zsh
```

## Relog
