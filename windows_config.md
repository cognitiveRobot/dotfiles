## NVIM config dir
```
# linux ~/.config/nvim
C:\Users\<user>\AppData\Local\nvim

# linux  ~/.local/share/nvim
C:\Users\<user>\AppData\Local\nvim-data
```

## Wezterm config dir
```
C:\Users\<user>\.config\wezterm
```
- default shell @wezterm.lua
```
default_prog = { "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" },
```

## gcc compiler
- Install MSYS2 https://www.msys2.org
- Install gcc compiler
```
$ pacman -S mingw-w64-ucrt-x86_64-gcc
```
- Add Path to user environment PATH - Win key - type environment should show
```
# New under user then add
C:\msys64\ucrt64\bin
```

## Prettier ls output with eza for Powershell
- Install eza https://github.com/eza-community/eza/blob/main/INSTALL.md
- Add alias for ls on Profile (should be somewhere around ~\My Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1)
```
# check profile
nvim $PROFILE
```
- Add followings
```
Write-Host "PROFILE LOADED"

Remove-Item Alias:ls -ErrorAction SilentlyContinue
function ls {
    eza --icons --group-directories-first
}
```
- Reload
```
. $PROFILE
```
