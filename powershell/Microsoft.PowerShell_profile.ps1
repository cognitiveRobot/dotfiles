Write-Host "PROFILE LOADED"
# PowerShell 7.6.0-preview.6

Remove-Item Alias:ls -ErrorAction SilentlyContinue
function ls {
    eza --icons --group-directories-first
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })

Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function ForwardWord
Set-PSReadLineKeyHandler -Chord "Ctrl+e" -Function ForwardChar

Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function PreviousHistory

