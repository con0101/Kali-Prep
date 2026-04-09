#!/usr/bin/env bash

###########################################################################
# Kali Prep Script                                                        #
# Version 0.7                                                             #
# Author: con0101                                                         #
# https://github.com/con0101                                              #
# Notes:                                                                  #
# This script is specifically designed to be used with                    #
#         VMware Virtual Machine Kali 2026.1.                             #
###########################################################################

TARGET_USER="kali"
TARGET_HOME="/home/${TARGET_USER}"
TARGET_UID="$(id -u "${TARGET_USER}")"
RUNTIME_DIR="/run/user/${TARGET_UID}"
DBUS_ADDR="unix:path=${RUNTIME_DIR}/bus"

SKIP_UPGRADE=true

BACKUP_DIRECTORY="/home/kali/backup_files"

FIREFOX_POLICIES="ewoJInBvbGljaWVzIjogewoJCSJCbG9ja0Fib3V0Q29uZmlnIjogZmFsc2UsCgkJIkNhcHRpdmVQb3J0YWwiOiBmYWxzZSwKCQkiRGlzYWJsZUFwcFVwZGF0ZSI6IHRydWUsCgkJIkRpc2FibGVGZWVkYmFja0NvbW1hbmRzIjogdHJ1ZSwKCQkiRGlzYWJsZUZpcmVmb3hTdHVkaWVzIjogdHJ1ZSwKCQkiRGlzYWJsZVBvY2tldCI6IHRydWUsCgkJIkRpc2FibGVUZWxlbWV0cnkiOiB0cnVlLAoJCSJEaXNwbGF5Qm9va21hcmtzVG9vbGJhciI6ICJhbHdheXMiLAoJCSJEaXNwbGF5TWVudUJhciI6ICJkZWZhdWx0LW9uIiwKCQkiRE5TT3ZlckhUVFBTIjogewoJCQkiRW5hYmxlZCI6IGZhbHNlCgkJfSwKCQkiRG9udENoZWNrRGVmYXVsdEJyb3dzZXIiOiB0cnVlLAoJCSJFeHRlbnNpb25TZXR0aW5ncyI6IHsKCQkJIioiOiB7CgkJCQkiaW5zdGFsbGF0aW9uX21vZGUiOiAiYWxsb3dlZCIKCQkJfSwKCQkJImZveHlwcm94eUBlcmljLmguanVuZyI6IHsKCQkJCSJpbnN0YWxsYXRpb25fbW9kZSI6ICJub3JtYWxfaW5zdGFsbGVkIiwKCQkJCSJpbnN0YWxsX3VybCI6ICJodHRwczovL2FkZG9ucy5tb3ppbGxhLm9yZy9maXJlZm94L2Rvd25sb2Fkcy9sYXRlc3QvZm94eXByb3h5LXN0YW5kYXJkL2xhdGVzdC54cGkiLAoJCQkJImRlZmF1bHRfYXJlYSI6ICJuYXZiYXIiCgkJCX0KCQl9LAoJCSJGaXJlZm94SG9tZSI6IHsKCQkJIlNlYXJjaCI6IHRydWUsCgkJCSJUb3BTaXRlcyI6IHRydWUsCgkJCSJIaWdobGlnaHRzIjogZmFsc2UsCgkJCSJQb2NrZXQiOiBmYWxzZSwKCQkJIlNuaXBwZXRzIjogZmFsc2UsCgkJCSJMb2NrZWQiOiBmYWxzZQoJCX0sCgkJIkdlbmVyYXRpdmVBSSI6IHsKCQkJIkVuYWJsZWQiOiBmYWxzZQoJCX0sCgkJIkhvbWVwYWdlIjogewoJCQkiVVJMIjogImZpbGU6Ly8vdXNyL3NoYXJlL2thbGktZGVmYXVsdHMvd2ViL2hvbWVwYWdlLmh0bWwiLAoJCQkiTG9ja2VkIjogZmFsc2UsCgkJCSJTdGFydFBhZ2UiOiAiaG9tZXBhZ2UiCgkJfSwKCQkiTmV0d29ya1ByZWRpY3Rpb24iOiBmYWxzZSwKCQkiTm9EZWZhdWx0Qm9va21hcmtzIjogdHJ1ZSwKCQkiT3ZlcnJpZGVGaXJzdFJ1blBhZ2UiOiAiIiwKCQkiT3ZlcnJpZGVQb3N0VXBkYXRlUGFnZSI6ICIiLAoJCSJCb29rbWFya3MiOiBbCgkJCXsKCQkJCSJUaXRsZSI6ICJDeWJlckNoZWYiLAoJCQkJIlVSTCI6ICJmaWxlOi8vL3Vzci9saWIvY3liZXJjaGVmL2luZGV4Lmh0bWwiLAoJCQkJIlBsYWNlbWVudCI6ICJ0b29sYmFyIiwKCQkJCSJGb2xkZXIiOiAiVG9vbHMiCgkJCX0sCgkJCXsKCQkJCSJUaXRsZSI6ICJCdXJwU3VpdGUgQ0EiLAoJCQkJIlVSTCI6ICJodHRwOi8vYnVycHN1aXRlIiwKCQkJCSJQbGFjZW1lbnQiOiAidG9vbGJhciIsCgkJCQkiRm9sZGVyIjogIlRvb2xzIgoJCQl9CgkJXQoJfQp9Cg=="



# Check if running as root, if not message the user and quit:
if [[ $EUID -ne 0 ]]; then
   echo "ERROR: This script must be run as root. Please use sudo or login as root." 
   exit 1
fi



# Verify Target User Exists:
if ! id "${TARGET_USER}" >/dev/null 2>&1; then
    echo "ERROR: User '${TARGET_USER}' does not exist."
    exit 1
fi

# Common Functions:

# run_as_user():
#   Runs a command as the specified user including environment
#     Usage: run_as_user <command>
run_as_user() {
    sudo -u "${TARGET_USER}" env \
        HOME="${TARGET_HOME}" \
        XDG_RUNTIME_DIR="${RUNTIME_DIR}" \
        DBUS_SESSION_BUS_ADDRESS="${DBUS_ADDR}" \
        "$@"
}

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

# Get current Date/Time to time the script
TIME_START="$(date -u +%s)"
echo
echo "Starting Script @ $TIME_START"
echo

# Backup Modified Files:
echo -n "[*] --> Backing up configuration files to '/home/kali/backup_files/"
mkdir /home/kali/backup_files
cp /home/kali/.bashrc ${BACKUP_DIRECTORY}/.bashrc
cp /home/kali/.zshrc ${BACKUP_DIRECTORY}/.zshrc
cp /home/kali/.vim ${BACKUP_DIRECTORY}/.vim
chown -R "kali:kali" ${BACKUP_DIRECTORY}


: << 'END_COMMENT'
END_COMMENT

echo "[*] --> Updating APT:"
apt update -q
echo "[*] --> Upgrading Kali:" #apt upgrade -y
echo "[*] --> Installing General Packages:"
echo "[*] -----> gdb:"
apt install -q -y gdb gdb-doc gdbserver libc-dbg
echo "[*] -----> ghidra:"
apt install -q -y ghidra
echo "[*] -----> CyberChef:"
apt install -q -y cyberchef
echo "[*] -----> pwntools:"
apt install -q -y python3-pwntools
echo "[*] -----> pyftpdlib:"
apt install -q -y python3-pyftpdlib
echo "[*] -----> jq:"
apt install -q -y jq
echo "[*] -----> tmux:"
apt install -q -y tmux
echo "[*] -----> ncat:"
apt install -q -y ncat
echo "[*] -----> rlwrap:"
apt install -q -y rlwrap
echo "[*] -----> seclists:"
apt install -q -y seclists
echo "[*] -----> peass-ng:"
apt install -q -y peass
echo "[*] -----> netexec:"
apt install -q -y netexec
echo "[*] -----> exiftool:"
apt install -q -y libimage-exiftool-perl
echo "[*] -----> pv:"
apt install -q -y pv
echo "[*] -----> xxd:"
apt install -q -y xxd
echo "[*] -----> gobuster:"
apt install -q -y gobuster
echo "[*] -----> ffuf:"
apt install -q -y ffuf
echo "[*] -----> wfuzz:"
apt install -q -y wfuzz
echo "[*] -----> nmap:"
apt install -q -y nmap
echo "[*] -----> masscan:"
apt install -q -y masscan
echo "[*] -----> mimikatz:"
apt install -q -y mimikatz
echo "[*] -----> impacket:"
apt install -q -y python3-impacket
echo "[*] -----> john:"
apt install -q -y john
echo "[*] -----> hydra:"
apt install -q -y hydra
echo "[*] -----> xfreerdp:"
apt install -q -y freerdp3-x11
echo "[*] -----> evil-winrm:"
apt install -q -y evil-winrm
echo "[*] -----> smbclient:"
apt install -q -y smbclient
echo "[*] -----> dnsrecon:"
apt install -q -y dnsrecon
echo "[*] -----> wpscan:"
apt install -q -y wpscan
echo "[*] -----> enum4linux:"
apt install -q -y enum4linux
echo "[*] -----> burpsuite:"
apt install -q -y burpsuite
echo "[*] --> Local Copies of Common Tools/Utilities:"
echo "[*] -----> Privilege Escalation Awesome Scripts SUITE new generation (PEASS-ng):" #git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git /usr/share/PayloadsAllTheThings/
echo "[*] -----> Nishang (Offensive Powershell Framework):" #git clone https://github.com/samratashok/nishang.git /usr/share/nishang/
echo "[*] --> Tweaks:"
echo "[*] -----> Thunar Settings (Show Hidden Files, Detailed View, and Toolbar Items):"
run_as_user xfconf-query --channel thunar --property /last-show-hidden --create --type bool --set true
run_as_user xfconf-query --channel thunar --property /last-view --create --type string --set ThunarDetailsView
run_as_user xfconf-query --channel thunar --property /last-toolbar-items --create --type string --set menu:0,back:1,forward:1,open-parent:1,open-home:1,new-tab:1,new-window:0,toggle-split-view:0,undo:0,redo:0,zoom-out:0,zoom-in:0,zoom-reset:0,view-as-icons:0,view-as-detailed-list:0,view-as-compact-list:0,view-switcher:0,location-bar:1,reload:0,search:1,uca-action-1-1:0,uca-action-3-3:0

echo "[*] -----> Disable Screensaver and Screenlock:"
run_as_user xfconf-query -c xfce4-screensaver -p /saver/enabled -n -t bool -s false
run_as_user xfconf-query -c xfce4-screensaver -p /lock/enabled -n -t bool -s false
run_as_user xset s off -dpms s noblank

echo "[*] -----> Bash/Zsh History Increased Size:"
ensure_file_key_value "/home/kali/.bashrc" "HISTSIZE" "1000000"
ensure_file_key_value "/home/kali/.bashrc" "HISTFILESIZE" "2000000"
ensure_file_key_value "/home/kali/.zshrc" "HISTSIZE" "1000000"
ensure_file_key_value "/home/kali/.zshrc" "SAVEHIST" "1000000"
chown "kali:kali" "/home/kali/.bashrc" "/home/kali/.zshrc"

echo "[*] -----> VIM Settings:"
sudo -u kali env HOME=/home/kali sh -c '
cat > "$HOME/.vimrc" <<EOF
filetype plugin on
syntax on
set number
set list
EOF
'

echo "[*] -----> Modify 'll' alias to show hidden files in zsh and bash:"
sudo -u kali sed -i "s/^alias ll=.*/alias ll='ls -lah'/" /home/kali/.zshrc
sudo -u kali sed -i "s/^alias ll=.*/alias ll='ls -lah'/" /home/kali/.bashrc

echo "[*] -----> GEF (GDB Enhanced Features):"
run_as_user wget -O /home/kali/.gdbinit-gef.py -q https://gef.blah.cat/py
run_as_user echo source /home/kali/.gdbinit-gef.py >> /home/kali/.gdbinit



echo "[*] --> Firefox:"
echo "[*] -----> Adding policies.json (inc Bookmarks, Settings):"
cp /usr/share/firefox-esr/distribution/policies.json ${BACKUP_DIRECTORY}/firefox-esr-policies.json
cp /usr/share/firefox-esr/distribution/policies.json /usr/share/firefox-esr/distribution/policies.json.bak
cp /usr/share/firefox-esr/distribution/distribution.ini ${BACKUP_DIRECTORY}/firefox-esr-distribution.ini
mv /usr/share/firefox-esr/distribution/distribution.ini /usr/share/firefox-esr/distribution/distribution.ini.bak
echo ${FIREFOX_POLICIES} | base64 -d > /usr/share/firefox-esr/distribution/policies.json


echo "Script Complete"

# Get current Date/Time to time the script
TIME_END="$(date -u +%s)"
TIME_ELASPED="$(($TIME_END-$TIME_START))"
echo
echo "Ending Script @ $TIME_END"
echo "Total Elapsed Time: $TIME_ELASPED seconds"
echo
