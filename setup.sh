#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Ask for the username
read -p "Enter the username to grant passwordless sudo access: " USERNAME

# Validate if the username exists
if ! id -u "$USERNAME" &>/dev/null; then
    echo "User '$USERNAME' does not exist."
    exit 1
fi

COMMAND="/Adobe-Photoshop/drive_c/launcher.sh"

# Add entry to sudoers file
echo "$USERNAME ALL=(ALL) NOPASSWD: $COMMAND" | sudo EDITOR='tee -a' visudo

echo "Passwordless sudo access for '$COMMAND' has been granted to user '$USERNAME'."

wget https://github.com/Jan64X/photoshop4linux/blob/main/Adobe_Photoshop_Express_logo.svg
wget https://github.com/Jan64X/photoshop4linux/blob/main/photoshop.desktop
mv Adobe_Photoshop_Express_logo.svg /Adobe-Photoshop/drive_c/
mv photoshop.desktop /usr/share/applications/
