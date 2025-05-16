# dotfiles

## Install

```
ln -s /home/zulfi/workdir/dotfiles/nvim /home/zulfi/.config/nvim
ln -s /home/zulfi/workdir/dotfiles/tmux /home/zulfi/.config/tmux
ln -s /home/zulfi/workdir/dotfiles/wezterm /home/zulfi/.config/wezterm
```

## Plugins to try

- plugins-list - https://neovimcraft.com/
- Onedark - https://github.com/navarasu/onedark.nvim?tab=readme-ov-file
- zenmode - https://github.com/folke/zen-mode.nvim?tab=readme-ov-file
- treesitter-context - https://github.com/nvim-treesitter/nvim-treesitter-context
- molten - https://github.com/benlubas/molten-nvim?tab=readme-ov-file
- magma - https://github.com/dccsillag/magma-nvim

## Issues

- ModuleNotFoundError: No module named 'pylsp.plugins.rope_rename
  ref: https://github.com/python-lsp/python-lsp-server/issues/588#issuecomment-2815787889

```
Make sure `python-lsp-server` version on mason python and local python are same.

$ source $HOME/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/activate && pip list | grep python-lsp-server
$ source <local-python>/bin/activate && pip list | grep python-lsp-server
```
