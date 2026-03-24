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

echo "--> Updating APT..."
apt update
#echo "--> Upgrading Kali..."
#apt upgrade -y

echo "--> Installing General Packages..."
echo "------> gdb:"
apt install -y gdb gdb-doc gdbserver libc-dbg
echo "------> ghidra:"
apt install -y ghidra
echo "------> CyberChef:"
apt install -y cyberchef
echo "------> pwntools:"
apt install -y python3-pwntools
echo "------> pyftpdlib:"
apt install -y python3-pyftpdlib
echo "------> jq:"
apt install -y jq
echo "------> tmux:"
apt install -y tmux
echo "------> ncat:"
apt install -y ncat
echo "------> rlwrap:"
apt install -y rlwrap
echo "------> seclists:"
apt install -y seclists
echo "------> peass-ng:"
apt install -y peass
echo "------> netexec:"
apt install -y netexec
echo "------> exiftool:"
apt install -y libimage-exiftool-perl
echo "------> pv:"
apt install -y pv
echo "------> xxd:"
apt install -y xxd
echo "------> gobuster:"
apt install -y gobuster
echo "------> ffuf:"
apt install -y ffuf
echo "------> wfuzz:"
apt install -y wfuzz
echo "------> nmap:"
apt install -y nmap
echo "------> masscan:"
apt install -y masscan
echo "------> mimikatz:"
apt install -y mimikatz
echo "------> impacket:"
apt install -y python3-impacket
echo "------> john:"
apt install -y john
echo "------> hydra:"
apt install -y hydra
echo "------> xfreerdp:"
apt install -y freerdp3-x11
echo "------> evil-winrm:"
apt install -y evil-winrm
echo "------> smbclient:"
apt install -y smbclient
echo "------> dnsrecon:"
apt install -y dnsrecon
echo "------> wpscan:"
apt install -y wpscan
echo "------> enum4linux:"
apt install -y enum4linux
echo "------> burpsuite:"
apt install -y burpsuite



echo "--> Local Copies of Common Tools/Utilities..."

echo "------> Privilege Escalation Awesome Scripts SUITE new generation (PEASS-ng)"
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git /usr/share/PayloadsAllTheThings/

echo "------> Nishang (Offensive Powershell Framework)"
git clone https://github.com/samratashok/nishang.git /usr/share/nishang/

echo "[*] --> Tweaks..."

echo "[*] -----> Thunar Settings (Show Hidden Files, Detailed View, and Toolbar Items):"
sudo -u kali env HOME=/home/kali sh -c 'xfconf-query --channel thunar --property /last-show-hidden --create --type bool --set true'
sudo -u kali env HOME=/home/kali sh -c 'xfconf-query --channel thunar --property /last-view --create --type string --set ThunarDetailsView'
sudo -u kali env HOME=/home/kali sh -c 'xfconf-query --channel thunar --property /last-toolbar-items --create --type string --set menu:0,back:1,forward:1,open-parent:1,open-home:1,new-tab:1,new-window:0,toggle-split-view:0,undo:0,redo:0,zoom-out:0,zoom-in:0,zoom-reset:0,view-as-icons:0,view-as-detailed-list:0,view-as-compact-list:0,view-switcher:0,location-bar:1,reload:0,search:1,uca-action-1-1:0,uca-action-3-3:0'

echo "[*] -----> Disable Screensaver and Screenlock:"
sudo -u kali env DISPLAY=:0 xfconf-query -c xfce4-screensaver -p /saver/enabled -n -t bool -s false
sudo -u kali env DISPLAY=:0 xfconf-query -c xfce4-screensaver -p /lock/enabled -n -t bool -s false
sudo -u kali env DISPLAY=:0 xset s off -dpms s noblank

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
sudo -u kali wget -O /home/kali/.gdbinit-gef.py -q https://gef.blah.cat/py
sudo -u kali echo source /home/kali/.gdbinit-gef.py >> /home/kali/.gdbinit
echo "Script Complete"
