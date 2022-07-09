#!/bin/sh

# Screen/Monitor
    xrandr --output DisplayPort-2 --mode 1920x1080 --rate 165 ;     # Set Monitor Resolution and Refresh Rate
    xset s off -dpms                                          ;     # Disable Monitor Power Management

# Wallpaper
    #feh --bg-fill /home/gnsbriellh/Desktop/cfg-linux/Media/Pictures/Wallpaper/people.png ;     # Set Wallpaper (feh)
    nitrogen --set-zoom-fill --random ~/Media/Pictures/Wallpapers/                        ;     # Set Wallpaper (Nitrogen)

# Picom
    picom --experimental-backends --config ~/.config/picom/picom.conf -b ;      # Start Picom (Compositor)

# System Tray Icons
    #
