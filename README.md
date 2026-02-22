# .dotfiles

Backup of my dots for niri with cachyos.

## Packages needed

### Polkit & Stuff

```
polkit polkit-kde-agent polkit-qt5 polkit-qt6 archlinux-xdg-menu desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-desktop-portal-kde kwallet kwallet-pam kwallet5 kwalletmanager gnome-keyring
```

### Shell

```
noctalia-shell swayidle
```

### Terminal

```
kitty fish fisher fastfetch bat micro eza nano
```

### Monitor

```
wdisplays shikane
```

### Audio

```
easyeffects
```

### Media

```
mpv mpv-mpris gwenview
```

### File manager

```
dolphin dolphin-plugins nautilus
```

### Dev

```
visual-studio-code-bin sublime-text-4 antigravity nvm pnpm tree gitkraken github-cli
```

### Browser

```
helium-browser-bin vivaldi-snapshot
```

### Games

```
lutris bottles protonplus protontricks gamescope goverlay
```

### Keyboard multi language 

```
fcitx5 fcitx5-mozc fcitx5-gtk fcitx5-qt fcitx5-configtool 
```

### Virtual Keyboard

```
sysboard
```

### Screenshot

```
wayscriber wayfreeze slurp satty grim wl-copy
```

### Utils

```
gearlever bitwarden freedownloadmanager stacher7 losslesscut-bin obs-studio obs-plugin-browser obs-vkcapture obs-pipewire-audio-capture nmgui-bin netbird netbird-ui-bin mission-center megabasterd-git mailspring evolution lm_sensors coolercontrol coolercontrold input-remapper-git
```


## Some Game Utils


### Helper for discord RPC

https://github.com/Dadangdut33/discord-customrpc-manager


### Clipboard Copy & Paste when running Gamescope

Use `/home/{username}/.local/bin/gs-bridge.sh`.

Usage: 

```
/path/to/gs-bridge.sh --start [id]
/path/to/gs-bridge.sh --stop [id]
/path/to/gs-bridge.sh --kill-all
/path/to/gs-bridge.sh --status
```

Steam launch option example:

```
/path/to/gs-bridge.sh --start mygame & gamescope -f -w 1920 -h 1080 -- %command% ; /path/to/gs-bridge.sh --stop mygame
```

You can easily use this in lutris pre-launch and post-launch option. Example:


```
# Pre-launch
/path/to/gs-bridge.sh --start endfield
# Post-launch
/path/to/gs-bridge.sh --stop endfield
```