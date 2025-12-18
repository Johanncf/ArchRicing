#!/bin/bash

WALLPAPER_DIRECTORY=~/.config/hypr/wallpapers

LOADED=$(hyprctl hyprpaper listloaded)

WALLPAPER=$(find "$WALLPAPER_DIRECTORY" ! -wholename "$LOADED" -type f | shuf -n 1)

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ",$WALLPAPER"

sleep 1

hyprctl hyprpaper unload unused
