#!/bin/bash

set -e

echo "[+] Updating system"
sudo apt update

echo "[+] Installing base dependencies (including pip3)"
sudo apt install -y \
git curl wget \
python3 python3-pip \
golang \
exiftool

echo "[+] Creating tools directory"
mkdir -p tools
cd tools

echo "[+] Cloning OSINT tools from GitHub"

# Python / OSINT tools (clone only)
git clone https://github.com/soxoj/maigret.git
git clone https://github.com/sherlock-project/sherlock.git
git clone https://github.com/althonos/InstaLooter.git
git clone https://github.com/aboul3la/Sublist3r.git
git clone https://github.com/laramies/theHarvester.git

# Go-based OSINT tool
git clone https://github.com/utkusen/urlhunter.git

echo "[+] Installation complete"
