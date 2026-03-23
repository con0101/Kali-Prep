#!/usr/bin/env bash

###########################################################################
# Kali Prep Script
# Version 0.6
# Author: con0101
# https://github.com/con0101
# Notes:
# This script is specifically designed to be used with
#                                       VMware Virtual Machine Kali 2025.4.
###########################################################################

# Check if running as root, if not message the user and quit:
if [[ $EUID -ne 0 ]]; then
   echo "ERROR: This script must be run as root. Please use sudo or login as root." 
   exit 1
fi
#apt update

#echo "------> CyberChef:"
#apt install -y cyberchef

echo "------> VIM Settings..."
sudo -u kali rm -f /home/kali/.vimrc
sudo -u kali echo "filetype plugin on" >> /home/kali/.vimrc
sudo -u kali echo "syntax on" >> /home/kali/.vimrc
sudo -u kali echo "set number" >> /home/kali/.vimrc
sudo -u kali echo "set list" >> /home/kali/.vimrc

echo "------> Modify ll alias to show hidden files in zsh and bash..."
sudo -u kali sed -i "s/^alias ll=.*/alias ll='ls -lah'/" /home/kali/.zshrc
sudo -u kali sed -i "s/^alias ll=.*/alias ll='ls -lah'/" /home/kali/.bashrc



sudo curl https://raw.githubusercontent.com/con0101/Kali-Mods/refs/heads/main/firefox/policies.json -o policies.json
sudo rm /usr/share/firefox-esr/distribution/policies.json
sudo mv policies.json /usr/share/firefox-esr/distribution/policies.json
