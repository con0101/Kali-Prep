# Kali-Prep

This repository is used to customize Kali Linux to my preferred configuration and standards.

## Install:
```
curl -o kali-prep-2026.1.sh https://raw.githubusercontent.com/con0101/Kali-Prep/refs/heads/main/kali-prep-2026.1.sh && chmod +x kali-prep-2026.1.sh && sudo ./kali-prep-2026.1.sh
```

## General Packages:

|Package:  |Script: |Description:                                   |Install/Upgrade:                            |Links:                                                     |
|:-------- |:------:|:--------------------------------------------- |:------------------------------------------ |:--------------------------------------------------------- |
|gdb       | 2025.4 |GNU Debugger                                   |`apt install gdb gdb-doc gdbserver libc-dbg`|[Project](https://sourceware.org/gdb/)                     |
|ghidra    | 2025.4 |Reverse Engineering Framework                  |`apt install ghidra`                        |[Project](https://github.com/NationalSecurityAgency/ghidra)|
|CyberChef | 2025.4 |The Cyber Swiss Army Knife                     |`apt install cyberchef`                     |[Project](https://github.com/gchq/CyberChef)               |
|pwntools  | 2025.4 |Python Exploit Dev Toolkit                     |`apt install python3-pwntools`              |[Docs](https://docs.pwntools.com/en/stable/)               |
|pyftpdlib | 2025.4 |Python FTP server library                      |`apt install python3-pyftpdlib`             |[Docs](https://pypi.org/project/pyftpdlib/)                |
|jq        | 2025.4 |Carving JSON at the terminal                   |`apt install jq`                            |[Project](https://github.com/jqlang/jq)                    |
|tmux      | 2025.4 |Terminal Multiplexer                           |`apt install tmux`                          |[Project](https://github.com/tmux/tmux/wiki)               |
|ncat      | 2025.4 |Enhanced `nc`                                  |`apt install ncat`                          |[Project](https://nmap.org/ncat)                           |
|rlwrap    | 2025.4 |Readline wrapper at the terminal               |`apt install rlwrap`                        |[Project](https://github.com/hanslub42/rlwrap)             |
|seclists  | 2025.4 |Collection of Wordlists                        |`apt install seclists`                      |[Project](https://github.com/danielmiessler/SecLists)      |
|peass-ng  | 2025.4 |Privilege Escalation Awesome Scripts SUITE     |`apt install peass`                         |[Project](https://github.com/peass-ng/PEASS-ng)            |
|netexec   | 2025.4 |Network Service Exploitation Tool              |`apt install netexec`                       |[Project](https://github.com/Pennyw0rth/NetExec)           |
|exiftool  | 2025.4 |Read and write meta info in files              |`apt install libimage-exiftool-perl`        |[Project](https://exiftool.org/)                           |
|pv        | 2025.4 |Monitor the progress of data through a pipe    |`apt install pv`                            |[Project](https://ivarch.com/p/pv)                         |
|xxd       | 2025.4 |Display HEX/Binary data at the terminal        |`apt install xxd`                           |[Info](https://linuxhandbook.com/xxd-command/)             |
|gobuster  | 2025.4 |Brute Force Dir/File, DNS, Virtual Host, & More|`apt install gobuster`                      |[Project](https://github.com/OJ/gobuster)                  |
|ffuf      | 2025.4 |Fuzz Faster U Fool                             |`apt install ffuf`                          |[Project](https://github.com/ffuf/ffuf)                    |
|wfuzz     | 2025.4 |Web application bruteforcer                    |`apt install wfuzz`                         |[Info](https://www.kali.org/tools/wfuzz/)                  |
|nmap      | 2025.4 |Network Mapper                                 |`apt install nmap`                          |[Project](https://nmap.org/)                               |
|masscan   | 2025.4 |TCP port scanner                               |`apt install masscan`                       |[Project](https://github.com/robertdavidgraham/masscan)    |
|mimikatz  | 2025.4 |Uses admin rights on Windows to grab passwords |`apt install mimikatz`                      |[Project](https://blog.gentilkiwi.com/mimikatz)            |
|impacket  | 2025.4 |Python3 module to build/dissect network protos |`apt install python3-impacket`              |[Project](https://github.com/fortra/impacket)              |
|john      | 2025.4 |John the Ripper Password Cracker               |`apt install john`                          |[Project](https://github.com/openwall/john)                |
|hydra     | 2025.4 |Very fast network logon cracker                |`apt install hydra`                         |[Project](https://github.com/vanhauser-thc/thc-hydra)      |
|xfreerdp  | 2025.4 |Remote Desktop Protocol Implementation         |`apt install freerdp3-x11`                  |[Project](https://www.freerdp.com/)                        |
|evil-winrm| 2025.4 |Ultimate WinRM shell for hacking/pentesting    |`apt install evil-winrm`                    |[Project](https://github.com/Hackplayers/evil-winrm)       |
|smbclient | 2025.4 |Command-line SMB/CIFS clients for Unix         |`apt install smbclient`                     |[Info](https://www.kali.org/tools/samba/#smbclient)        |
|dnsrecon  | 2025.4 |Powerful DNS enumeration script                |`apt install dnsrecon`                      |[Project](https://github.com/darkoperator/dnsrecon)        |
|wpscan    | 2025.4 |Black box WordPress vulnerability scanner      |`apt install wpscan`                        |[Project](https://wpscan.com/wordpress-cli-scanner/)       |
|enum4linux| 2025.4 |Enumerates info from Windows and Samba systems |`apt install enum4linux`                    |[Info](https://www.kali.org/tools/enum4linux/)             |
|burpsuite | 2025.4 |Proxy for testing of Web Applications          |`apt install burpsuite`                     |[Info](https://portswigger.net/)                           |

Many of the packages listed above are already included with Kali Linux.  However, on the off chance these packages are removed from futrure releases, the `kali-prep-YYYY.Q.sh` script will attempt to add them.

## Local Copies of Common Tools/Utilities:

### PayloadAllTheThings
Documentation: [https://swisskyrepo.github.io/PayloadsAllTheThings/](https://swisskyrepo.github.io/PayloadsAllTheThings/)  
`git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git /usr/share/PayloadsAllTheThings/`

### Nishang (Offensive Powershell Framework)
Project: [https://github.com/samratashok/nishang](https://github.com/samratashok/nishang)  
`git clone https://github.com/samratashok/nishang.git /usr/share/nishang/`

## Tweaks:

### Thunar Settings (Show Hidden Files, Detailed View, and Toolbar Items):
```bash
xfconf-query --channel thunar --property /last-show-hidden --create --type bool --set true
xfconf-query --channel thunar --property /last-view --create --type string --set ThunarDetailsView
xfconf-query --channel thunar --property /last-toolbar-items --create --type string --set menu:0,back:1,forward:1,open-parent:1,open-home:1,new-tab:1,new-window:0,toggle-split-view:0,undo:0,redo:0,zoom-out:0,zoom-in:0,zoom-reset:0,view-as-icons:0,view-as-detailed-list:0,view-as-compact-list:0,view-switcher:0,location-bar:1,reload:0,search:1,uca-action-1-1:0,uca-action-3-3:0
```

### Display Settings (Disable Screenlocking and Screensaver):
```bash
xfconf-query -c xfce4-screensaver -p /saver/enabled -n -t bool -s false
xfconf-query -c xfce4-screensaver -p /lock/enabled -n -t bool -s false
xset s off -dpms s noblank
```

### Bash/Zsh History Increased Size:
```
File: "/home/kali/.bashrc"
  "HISTSIZE" "1000000"
  "HISTFILESIZE" "2000000"
File: "/home/kali/.zshrc"
  "HISTSIZE" "1000000"
  "SAVEHIST" "1000000"
```

### VIM Settings:
```bash
rm -f /home/kali/.vimrc
echo "filetype plugin on" >> /home/kali/.vimrc
echo "syntax on" >> /home/kali/.vimrc
echo "set number" >> /home/kali/.vimrc
echo "set list" >> /home/kali/.vimrc
```

### Modify `ll` alias to show hidden files in zsh and bash:
```bash
sed -i "s/^alias ll=.*/alias ll='ls -lah'/" /home/kali/.zshrc
sed -i "s/^alias ll=.*/alias ll='ls -lah'/" /home/kali/.bashrc
```

### GEF (GDB Enhanced Features):
Project: [https://github.com/hugsy/gef](https://github.com/hugsy/gef)
```bash
wget -O /home/kali/.gdbinit-gef.py -q https://gef.blah.cat/py
echo source /home/kali/.gdbinit-gef.py >> /home/kali/.gdbinit
```

## Firefox:
```
add policies.json restricting Firefox from AI and adding various bookmoarks
/usr/share/firefox-esr/distribution/policies.json
```

