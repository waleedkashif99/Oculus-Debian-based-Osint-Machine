#!/bin/bash

# ===============================
#   OCULUS OSINT MACHINE
# ===============================

clear
cat << "EOF"

 ██████╗  ██████╗██╗   ██╗██╗     ██╗   ██╗███████╗
██╔═══██╗██╔════╝██║   ██║██║     ██║   ██║██╔════╝
██║   ██║██║     ██║   ██║██║     ██║   ██║███████╗
██║   ██║██║     ██║   ██║██║     ██║   ██║╚════██║
╚██████╔╝╚██████╗╚██████╔╝███████╗╚██████╔╝███████║
 ╚═════╝  ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝

        OCULUS OSINT MACHINE

EOF

# Paths
BASE="$HOME/osint"
VENV="$BASE/venv"
RESULT="$BASE/result.txt"
URLHUNTER_DIR="$BASE/tools/urlhunter"

# Activate venv
if [ -f "$VENV/bin/activate" ]; then
    source "$VENV/bin/activate"
else
    echo "[!] Python virtual environment not found"
    exit 1
fi

echo "===============================" | tee -a "$RESULT"
echo "OCULUS OSINT SESSION - $(date)" | tee -a "$RESULT"
echo "===============================" | tee -a "$RESULT"

while true; do
    echo
    echo "1) Username OSINT (Maigret + Sherlock)"
    echo "2) Instagram OSINT (InstaLooter)"
    echo "3) Domain Recon (Sublist3r + theHarvester)"
    echo "4) URL Recon (urlhunter)"
    echo "5) Image Metadata (ExifTool)"
    echo "6) Exit"
    echo
    read -p "Choose option: " opt

    case $opt in

    1)
        read -p "Username: " user
        echo "---- USERNAME OSINT: $user ----" | tee -a "$RESULT"

        echo "[Maigret]" | tee -a "$RESULT"
        maigret "$user" | tee -a "$RESULT"

        echo "[Sherlock]" | tee -a "$RESULT"
        sherlock "$user" | tee -a "$RESULT"
        ;;

    2)
        read -p "Instagram username: " ig
        echo "---- INSTAGRAM OSINT: $ig ----" | tee -a "$RESULT"

        instalooter profile "$ig" | tee -a "$RESULT"
        ;;

    3)
        read -p "Domain: " domain
        echo "---- DOMAIN OSINT: $domain ----" | tee -a "$RESULT"

        sublist3r -d "$domain" | tee -a "$RESULT"
        theHarvester -d "$domain" -b all | tee -a "$RESULT"
        ;;

    4)
        read -p "Domain for URLHunter: " ud
        echo "---- URLHUNTER: $ud ----" | tee -a "$RESULT"

        cd "$URLHUNTER_DIR" || exit
        ./urlhunter -d "$ud" | tee -a "$RESULT"
        cd ~
        ;;

    5)
        read -p "Image path: " img
        echo "---- EXIF DATA: $img ----" | tee -a "$RESULT"

        exiftool "$img" | tee -a "$RESULT"
        ;;

    6)
        echo "Exiting OCULUS."
        exit 0
        ;;

    *)
        echo "Invalid option"
        ;;
    esac
done

