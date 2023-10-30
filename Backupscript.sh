#!/bin/bash

# Set backup directory
BACKUP_DIR="/path/to/backups"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Backup list of installed packages
pacman -Qqe > "$BACKUP_DIR/installed-packages.txt"

# Backup package database 
pacman -Fy
pacman -Qdtq > "$BACKUP_DIR/foreign-packages.txt"

# Backup system settings
cp -r /etc/lightdm "$BACKUP_DIR/"
cp -r ~/.config/bspwm "$BACKUP_DIR/"
cp -r ~/.config/polybar "$BACKUP_DIR/"
cp -r ~/.config/rofi "$BACKUP_DIR/"
cp -r ~/.config/picom "$BACKUP_DIR/"
cp ~/.xinitrc "$BACKUP_DIR/"

# Backup wallpaper images
cp /usr/share/backgrounds "$BACKUP_DIR/"

echo "Backup complete!"
