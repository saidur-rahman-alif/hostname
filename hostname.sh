#!/bin/bash

read -p "New hostname: " H
[ -z "$H" ] && echo "Empty hostname!" && exit 1

# Get current hostname
OLD_HOST=$(hostname)

echo "Updating hostname from '$OLD_HOST' to '$H'..."

# Update /etc/hostname
echo "$H" | sudo tee /etc/hostname >/dev/null

# Apply hostname using hostnamectl (works on both Debian & Ubuntu)
sudo hostnamectl set-hostname "$H"

# Update /etc/hosts to avoid sudo warnings
if grep -q "$OLD_HOST" /etc/hosts; then
    sudo sed -i "s/$OLD_HOST/$H/g" /etc/hosts
else
    # Add entry if missing
    echo "127.0.1.1   $H" | sudo tee -a /etc/hosts >/dev/null
fi

echo "Hostname successfully updated to '$H'"
echo "A reboot is recommended for all services to recognize the change."
