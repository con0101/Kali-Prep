#!/bin/bash

# 1. Install prerequisites
sudo apt update && sudo apt install -y curl gpg

# 2. Download and verify the GPG key from the community repo
# This repo is recommended by the official VSCodium project for Debian-based systems.
GPG_KEY_URL="https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg"
KEYRING_PATH="/usr/share/keyrings/vscodium-archive-keyring.gpg"

echo "Downloading VSCodium GPG key..."
if curl -fSsL "$GPG_KEY_URL" | gpg --dearmor | sudo tee "$KEYRING_PATH" > /dev/null; then
    echo "Key successfully added."
else
    echo "Error: Failed to download or process GPG key. Please check your internet connection."
    exit 1
fi

# 3. Add the VSCodium repository
echo "Adding VSCodium repository..."
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

# 4. Final installation
sudo apt update && sudo apt install codium -y

echo "Installation complete. Launch with 'codium'."
