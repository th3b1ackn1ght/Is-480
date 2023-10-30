#!/bin/bash







# Set backup directory 
BACKUP_DIR="/path/to/backup"
ISO_FILE="$BACKUP_DIR/manjaro-backup.iso"

# Perform system and settings backup from previous script

# Backup all system files
sudo pacman -Syu
sudo pacman -Fy
sudo pacman -S archiso
sudo cp -r / /mnt/backup

# Build ISO 
sudo mkarchiso -v -w "$BACKUP_DIR" -o "$ISO_FILE" "$BACKUP_DIR"

# Clean up working files
sudo rm -r "$BACKUP_DIR/work"
sudo umount "$BACKUP_DIR/mnt"

echo "Backup ISO created at $ISO_FILE"
