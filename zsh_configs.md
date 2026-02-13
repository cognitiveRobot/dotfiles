## Coming from bash
```
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
```
## fzf
On ubuntu: use as follows
```
# eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
```
## Aliases
```
#Import other aliases
if [ -f "$HOME/.aliases" ]; then
   source "$HOME/.aliases"
fi
```
## Nvim
```
#neovim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
```
## Nodejs
if you install zsh after installing node you need to add the following
```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```
## Conda
```
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/<>/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/<>/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/<>/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/<>/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
```
## mssql
```
export PATH="$PATH:/opt/mssql-tools18/bin"
```
