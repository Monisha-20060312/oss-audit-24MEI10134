#!/bin/bash

# ============================================================
# Script 3 : Disk and Permission Auditor
# Author  : Bellappagari Monisha (24MEI10134)
# Course  : Open Source Software – CSE0002
# Software: Git
# Purpose : Audits key system directories for permissions,
#           ownership, and disk usage using a loop.
#           Also checks Git configuration files.
# Date    : March 2026
# ============================================================

# --- VARIABLES ---

# Array of directories to audit
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share/git-core")

# Column widths
COL1=25
COL2=15
COL3=12
COL4=12
COL5=8

echo "=========================================================="
echo "           DISK AND PERMISSION AUDITOR                    "
echo "=========================================================="
echo ""

# Table Header
printf "%-${COL1}s %-${COL2}s %-${COL3}s %-${COL4}s %-${COL5}s\n" \
"Directory" "Permissions" "Owner" "Group" "Size"

printf '%0.s-' {1..75}
echo ""

# --- MAIN LOOP ---
for DIR in "${DIRS[@]}"; do

    if [ -d "$DIR" ]; then
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        printf "%-${COL1}s %-${COL2}s %-${COL3}s %-${COL4}s %-${COL5}s\n" \
        "$DIR" "$PERMS" "$OWNER" "$GROUP" "${SIZE:-N/A}"

    else
        printf "%-${COL1}s %s\n" "$DIR" "[NOT FOUND]"
    fi

done

echo ""
printf '%0.s-' {1..75}
echo ""
echo ""

# --- GIT CONFIGURATION CHECK ---

echo "---- Git Configuration File Audit ----"
echo ""

# System-level config
SYSTEM_CONFIG="/etc/gitconfig"

if [ -f "$SYSTEM_CONFIG" ]; then
    PERMS=$(ls -l "$SYSTEM_CONFIG" | awk '{print $1}')
    OWNER=$(ls -l "$SYSTEM_CONFIG" | awk '{print $3}')

    echo "System config : $SYSTEM_CONFIG"
    echo "Permissions   : $PERMS (Owner: $OWNER)"
    echo "Status        : EXISTS"
else
    echo "System config : NOT FOUND"
fi

echo ""

# User-level config
USER_CONFIG="$HOME/.gitconfig"

if [ -f "$USER_CONFIG" ]; then
    PERMS=$(ls -l "$USER_CONFIG" | awk '{print $1}')
    OWNER=$(ls -l "$USER_CONFIG" | awk '{print $3}')

    echo "User config   : $USER_CONFIG"
    echo "Permissions   : $PERMS (Owner: $OWNER)"

    if git config --global user.name &>/dev/null; then
        GIT_USER=$(git config --global user.name)
        echo "Git user.name : $GIT_USER"
        echo "Status        : Configured"
    else
        echo "Status        : user.name NOT SET"
    fi
else
    echo "User config   : NOT FOUND"
    echo "Note          : Run 'git config --global user.name \"Your Name\"'"
fi

echo ""
echo "=========================================================="
echo "     End of Disk and Permission Auditor                  "
echo "=========================================================="
