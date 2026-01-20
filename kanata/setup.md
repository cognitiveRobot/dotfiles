
## kanata

- Installed v1.9.0 on Ubuntu as glibc was 2.35
- set up as described here upto before systemd setup 
    - systemd setup discussions - https://github.com/jtroo/kanata/discussions/130
    - https://github.com/jtroo/kanata/blob/main/docs/setup-linux.md
    ```
    cp config.kbd ~/.config/kanata/config.kbd
    cp kanata.service ~/config/systemd/user/kanata.service
    ./restart-kanata
    ```

### App launch shortcuts:
- At the moment, I decided not to use kanata cmd_allowed to run bash script for security reason. for more on the above systemd discussions.

- Using native ubuntu shortcuts which can be applied/backup as below.
https://unix.stackexchange.com/a/560567
- to backup custom keys:
    ```
    $ dconf dump / | sed -n '/\[org.gnome.settings-daemon.plugins.media-keys/,/^$/p' > custom-shortcuts.conf
    ❯ dconf dump / | sed -n '/\[org.gnome.desktop.wm.keybindings/,/^$/p' > all_keybindings.conf
    ❯ dconf dump / | sed -n '/\[org.gnome.shell.keybindings/,/^$/p' > shell.conf
    ❯ dconf dump / | sed -n '/\[org.gnome.mutter.keybindings/,/^$/p' > mutter.conf
    ❯ dconf dump / | sed -n '/\[org.gnome.mutter.wayland.keybindings/,/^$/p' > mutter_wayland.conf

    ```
- to apply stored custom keys:
    ```
    $ dconf load / < custom-shortcuts.conf # Import
    ```


