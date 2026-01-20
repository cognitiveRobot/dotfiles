# dotfiles

## Install

```
ln -s /home/zulfi/workdir/dotfiles/nvim /home/zulfi/.config/nvim
ln -s /home/zulfi/workdir/dotfiles/tmux /home/zulfi/.config/tmux
ln -s /home/zulfi/workdir/dotfiles/wezterm /home/zulfi/.config/wezterm
```
## tmux
```
- Install tmux
- Install tmux plugin manager - https://github.com/tmux-plugins/tpm
    - reload conf - tmux source-file ~/.config/tmux/tmux.conf
- Install plugins -  `prefix` + shift i
```
## zsh

- Install zoxide, fzf
- cp .zshrc file to HOME
- restart terminal


## Issues

- ModuleNotFoundError: No module named 'pylsp.plugins.rope_rename
  ref: https://github.com/python-lsp/python-lsp-server/issues/588#issuecomment-2815787889

```
Make sure `python-lsp-server` version on mason python and local python are same.

$ source $HOME/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/activate && pip list | grep python-lsp-server
$ source <local-python>/bin/activate && pip list | grep python-lsp-server
```
