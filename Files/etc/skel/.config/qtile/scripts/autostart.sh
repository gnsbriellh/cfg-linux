#!/bin/sh

# Screen/Monitor
    xrandr -s 1920x1080 -r 165 ;

# Wallpaper
    #feh --bg-fill /home/gnsbriellh/Desktop/cfg-linux/Media/Pictures/Wallpaper/people.png # Set Wallpaper;
    nitrogen --set-zoom-fill --random ~/Media/Pictures/Wallpapers/ ;

# Picom
    picom --experimental-backends --config ~/.config/picom/picom.conf -b ;

# System Tray Icons
