# dotfiles

## Installation

## terminal - wezterm
```
https://wezterm.org/install/linux.html
ln -s <Path-to-dotfiles>/wezterm /home/<username>/.config/wezterm
```
## shell - zsh
- Install zsh 
```sudo apt install zsh
chsh -s $(which zsh)
```

### essential CLIs
- Install zoxide - https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
```
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
export PATH="$PATH:/home/zulfi/.local/bin"
Add eval "$(zoxide init zsh)" to ~/.zshrc
```
- Install fzf
```
sudo apt install fzf
```
- Install fd
```
sudo apt install fd-find
https://github.com/sharkdp/fd#installation
```
- Install ripgrep
```
sudo apt install ripgrep
```

- cp .zshrc file to HOME
- run `exec zsh`

## Node

- Install node  
- Install tree-sitter-cli
```
npm install -g tree-sitter-cli
npm install -g eslint
```
- Install python3-venv 
```
sudo apt install python3-venv
```
## keyd

- Install
```
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable --now keyd
```
- copy config file.
```
sudo cp ./keyd/default.conf /etc/keyd/.
```
- reload keyd
```
sudo keyd reload
or 
sudo keyd.rvaiya reload
```


## nvim 
- https://neovim.io/doc/install/
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
ln -s <Path-to-dotfiles>/nvim /home/<username>/.config/nvim
```
- install gcc - if not there already
```
sudo apt install build-essential
gcc --version
```

## tmux
```
- Install tmux
- Install tmux plugin manager - https://github.com/tmux-plugins/tpm
    - reload conf - tmux source-file ~/.config/tmux/tmux.conf
- Install plugins -  `prefix` + shift i
```
```
ln -s <Path-to-dotfiles>/tmux /home/<username>/.config/tmux
```

## issues

- ModuleNotFoundError: No module named 'pylsp.plugins.rope_rename
  ref: https://github.com/python-lsp/python-lsp-server/issues/588#issuecomment-2815787889

```
Make sure `python-lsp-server` version on mason python and local python are same.

$ source $HOME/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/activate && pip list | grep python-lsp-server
$ source <local-python>/bin/activate && pip list | grep python-lsp-server
```
