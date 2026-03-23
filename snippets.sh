# Run command as 'kali' from an elevated execution:
sudo -u kali env \
  HOME=/home/kali \
  XDG_RUNTIME_DIR=/run/user/$(id -u kali) \
  DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u kali)/bus \
