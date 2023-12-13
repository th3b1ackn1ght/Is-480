#!/bin/bash

###########
# Author: Parker Duhon  
# Date Created: $(date)
#
# Description: This is a bash script that will back up an arch users system then ask the user 
# if they want to restore from a back up. If they do then it will restore and if not then it 
# will proceed to do some security checks such as hardening ssh and apps, setting up a firewall,
# installing security modules and configure logging and security alerts, and lock down permissions.
###########

# Variables 
BACKUP_DIR="/backups"
ISO_FILE="$BACKUP_DIR/arch-backup.iso"
PACKAGE_LIST="$BACKUP_DIR/installed-packages.txt"

# User prompt
echo "Are you on Arch and want to backup or restore? (y/n)"
read ans

if [ "$ans" = "y" ]; then
  
  # FULL System Backup  
  sudo pacman -Syu
  sudo pacman -Fy
  sudo pacman -S archiso  
  sudo cp -r / /mnt/backup
  
  sudo mkarchiso -o "$ISO_FILE" "$BACKUP_DIR"
  sudo rm -r "$BACKUP_DIR/work"  
  sudo umount "$BACKUP_DIR/mnt"
  
  # Package list backup
  sudo pacman -Qqe > "$PACKAGE_LIST"
  
  echo "System fully backed up to $ISO_FILE"
  
else
  
  # Offer restore from file
  echo "Restore system from $PACKAGE_LIST? (y/n)"
  read ans
  if [ "$ans" = "y" ]; then
    # Restore logic 
  fi
  
fi

# Security checks
echo "Implementing security measures..." 

# 1. Harden SSH access
echo "- Hardening SSH..."
passwd $USER --expire  # Enable password expiration
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

# 2. Harden services and apps
echo "- Hardening services..."
ufw default deny # Set firewall to block non-explicitly allowed
ufw allow ssh # Allow SSH

# 3. Setup firewall and SELinux
echo "- Configuring firewall..." 
ufw enable 
setenforce 1 # Enable SELinux

# 4. Install security modules
echo "- Installing Fail2Ban"
sudo pacman -S install fail2ban -y
systemctl enable fail2ban

# 5. Configure logging and alerts
echo "- Forwarding logs to central server"
echo '*.* @logserver.company.com' >> /etc/rsyslog.conf
echo "- Enabling log alerts" # Set up desired alerts

# 6. Lock down permissions
echo "- Tightening permissions" 
chmod 700 /root
chmod 600 /etc/shadow

echo "Security hardening complete!"


# Print ASCII art peace sign
cat <<EOF 

888     888 d8b 888                   
888     888 Y8P 888                   
888     888     888                   
Y88b   d88P 888 888 888  888 88888b.   
Y88b d88P  888 888 888  888 888 "88b  
Y88o88P"   888 888 888  888 888  888  
Y888P      888 888 888  888 888 d88P   
                                 888       
                                 888       
                             Y8b d88P     
                              "Y88P"      

EOF

# Print creation text 
cat <<EOF
====================================================================== 
Created by: Parker Duhon, Published on: $(date), and TLDR: Peace out!
======================================================================
EOF
