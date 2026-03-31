#!/bin/bash

# ==========================================================
# Script 2 : FOSS Package Inspector
# Author : Bellappagari Monisha (24MEI10134)
# Course : Open Source Software - CSE0002
# Software : Git (chosen for OSS Audit)
# Purpose : Checks if Git is installed, retrieves package info,
#           and prints open-source philosophy notes for a set
#           of well-known FOSS packages using a case statement.
# Date : March 2026
# ==========================================================

# --- VARIABLES ---
PRIMARY_PACKAGE="git"

# List of packages
PACKAGES=("git" "apache2" "httpd" "mysql-server" "mysql" "vlc" "firefox" "python3")

# --- DETECT PACKAGE MANAGER ---
if command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
elif command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
else
    PKG_MANAGER="unknown"
fi

echo "======================================="
echo "        FOSS PACKAGE INSPECTOR         "
echo "======================================="
echo "Primary Package: $PRIMARY_PACKAGE"
echo "Package Manager Detected: $PKG_MANAGER"
echo ""

# --- PRIMARY PACKAGE CHECK ---
echo "... Checking: $PRIMARY_PACKAGE ..."

if [ "$PKG_MANAGER" = "dpkg" ]; then
    if dpkg -l "$PRIMARY_PACKAGE" 2>/dev/null | grep -q "^ii"; then
        echo "Status : INSTALLED"
        VERSION=$(dpkg -s "$PRIMARY_PACKAGE" | grep ^Version | cut -d' ' -f2)
        SUMMARY=$(dpkg -s "$PRIMARY_PACKAGE" | grep ^Description | cut -d':' -f2 | xargs)
        echo "Version : $VERSION"
        echo "Summary : $SUMMARY"
        echo "License : GPL v2"
    else
        echo "Status : NOT INSTALLED"
        echo "sudo apt update && sudo apt install git -y"
    fi

elif [ "$PKG_MANAGER" = "rpm" ]; then
    if rpm -q "$PRIMARY_PACKAGE" &>/dev/null; then
        echo "Status : INSTALLED"
        rpm -qi "$PRIMARY_PACKAGE" | grep -E 'Version|License|Summary'
    else
        echo "Status : NOT INSTALLED"
        echo "sudo yum install git -y"
    fi

else
    if command -v git &>/dev/null; then
        echo "Status : INSTALLED (via PATH)"
        git --version
    else
        echo "Status : NOT INSTALLED"
    fi
fi

echo ""
echo "--- Open Source Philosophy Notes ---"

# --- CASE STATEMENT ---
for PKG in "${PACKAGES[@]}"; do
    case $PKG in
        git)
            NOTE="Git: born from necessity when Linus Torvalds rejected proprietary control."
            ;;
        apache2|httpd)
            NOTE="Apache: backbone of the open web."
            ;;
        mysql|mysql-server)
            NOTE="MySQL: open-source database powering millions of apps."
            ;;
        vlc)
            NOTE="VLC: powerful open media player built by students."
            ;;
        firefox)
            NOTE="Firefox: keeps the web open and user-focused."
            ;;
        python3)
            NOTE="Python: community-driven language with simplicity."
            ;;
        *)
            NOTE="$PKG: contributes to FOSS ecosystem."
            ;;
    esac

    echo "[$PKG] $NOTE"
done

echo ""
echo "--- Installation Summary ---"

INSTALLED_COUNT=0

for PKG in "${PACKAGES[@]}"; do
    if command -v "$PKG" &>/dev/null; then
        INSTALLED_COUNT=$((INSTALLED_COUNT+1))
    fi
done

echo "Packages checked : ${#PACKAGES[@]}"
echo "Packages found   : $INSTALLED_COUNT"

echo "======================================="
echo " End of FOSS Package Inspector "
echo "======================================="
