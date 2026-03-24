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

# Common Functions:

# ensure_file_key_value():
#   Ensures that a key is set to a specified value:
#     if the key exists, it is updated, if not, it is created.
#     Usage: ensure_file_key_value "<FILE_FULL_PATH>" "<KEY>" "<VALUE>"
ensure_file_key_value() {
    local file="$1"
    local key="$2"
    local value="$3"
    if grep -Eq "^[[:space:]]*${key}=" "$file"; then
        sed -i "s|^[[:space:]]*${key}=.*|${key}=${value}|" "$file"
    else
        printf '%s=%s\n' "$key" "$value" >> "$file"
    fi
}

# Backup Modified Files:
mkdir /home/kali/backup_files
cp /home/kali/.bashrc /home/kali/backup_files/.bashrc
cp /home/kali/.zshrc /home/kali/backup_files/.zshrc
cp /home/kali/.vim /home/kali/backup_files/.vim
chown "kali:kali" "/home/kali/backup_files" "/home/kali/backup_files/*"












echo "[*] --> Updating APT..." #apt update
echo "[*] --> Upgrading Kali..." #apt upgrade -y
echo "[*] --> Installing General Packages..." # REMOVED TO TEST OTHER CODE
echo "[*] --> Local Copies of Common Tools/Utilities..."
echo "[*] ------> Privilege Escalation Awesome Scripts SUITE new generation (PEASS-ng)" #git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git /usr/share/PayloadsAllTheThings/
echo "[*] ------> Nishang (Offensive Powershell Framework)" #git clone https://github.com/samratashok/nishang.git /usr/share/nishang/
echo "[*] --> Tweaks..."
echo "[*] -----> Thunar Settings (Show Hidden Files, Detailed View, and Toolbar Items):"
sudo -u kali env HOME=/home/kali sh -c 'xfconf-query --channel thunar --property /last-show-hidden --create --type bool --set true'
sudo -u kali env HOME=/home/kali sh -c 'xfconf-query --channel thunar --property /last-view --create --type string --set ThunarDetailsView'
sudo -u kali env HOME=/home/kali sh -c 'xfconf-query --channel thunar --property /last-toolbar-items --create --type string --set menu:0,back:1,forward:1,open-parent:1,open-home:1,new-tab:1,new-window:0,toggle-split-view:0,undo:0,redo:0,zoom-out:0,zoom-in:0,zoom-reset:0,view-as-icons:0,view-as-detailed-list:0,view-as-compact-list:0,view-switcher:0,location-bar:1,reload:0,search:1,uca-action-1-1:0,uca-action-3-3:0'

echo "[*] -----> Disable Screensaver and Screenlock:"
sudo -u kali env DISPLAY=:0 xfconf-query -c xfce4-screensaver -p /saver/enabled -n -t bool -s false
sudo -u kali env DISPLAY=:0 xfconf-query -c xfce4-screensaver -p /lock/enabled -n -t bool -s false
sudo -u kali env DISPLAY=:0 xset s off -dpms s noblank

echo "[*] -----> Bash/Zsh History Increased Size:"
ensure_file_key_value "/home/kali/.bashrc" "HISTSIZE" "1000000"
ensure_file_key_value "/home/kali/.bashrc" "HISTFILESIZE" "2000000"
ensure_file_key_value "/home/kali/.zshrc" "HISTSIZE" "1000000"
ensure_file_key_value "/home/kali/.zshrc" "SAVEHIST" "1000000"
chown "kali:kali" "/home/kali/.bashrc" "/home/kali/.zshrc"

echo "------> VIM Settings..."
sudo -u kali env HOME=/home/kali sh -c '
cat > "$HOME/.vimrc" <<EOF
filetype plugin on
syntax on
set number
set list
EOF
'

echo "------> Modify ll alias to show hidden files in zsh and bash..."
sudo -u kali sed -i "s/^alias ll=.*/alias ll='ls -lah'/" /home/kali/.zshrc
sudo -u kali sed -i "s/^alias ll=.*/alias ll='ls -lah'/" /home/kali/.bashrc

echo "------> GEF (GDB Enhanced Features)..."
#sudo -u kali wget -O /home/kali/.gdbinit-gef.py -q https://gef.blah.cat/py
#sudo -u kali echo source /home/kali/.gdbinit-gef.py >> /home/kali/.gdbinit
echo "Script Complete"
