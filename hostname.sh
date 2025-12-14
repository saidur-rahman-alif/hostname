#!/bin/bash
read -p "New hostname: " H
[ -z "$H" ] && echo "Empty hostname!" && exit 1
echo "$H" | sudo tee /etc/hostname >/dev/null
sudo hostnamectl set-hostname "$H"
echo "Updated hostname to $H"