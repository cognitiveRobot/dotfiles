
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



