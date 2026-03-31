#!/bin/bash
# ============================================================
# Script 1 : System Identity Report
# Author   : Bellappagari Monisha (24MEI10134)
# Course   : Open Source Software - CSE0002
# Software : Git (chosen for OSS Audit)
# Purpose  : Displays a system identity report as a formatted
#            welcome screen, showing OS, kernel, user, uptime,
#            and the open-source license of the Linux kernel.
#
# Date     : March 2026
# ============================================================

# --- VARIABLES ---

# Student and project information
STUDENT_NAME="Bellappagari Monisha"
ROLL_NUMBER="24MEI10134"
SOFTWARE_CHOICE="Git"

# System information using command substitution
KERNEL=$(uname -r)
USERNAME=$(whoami)
HOME_DIR=$HOME
UPTIME=$(uptime -p 2>/dev/null || uptime)

# Get formatted date and time
DATETIME=$(date '+%A, %d %B %Y, %H:%M:%S %Z')

# Get Linux distribution name
if [ -f /etc/os-release ]; then
    DISTRO=$(grep '^PRETTY_NAME' /etc/os-release | cut -d '=' -f2 | tr -d '"')
elif command -v lsb_release &>/dev/null; then
    DISTRO=$(lsb_release -d | cut -d ':' -f2 | xargs)
else
    DISTRO=$(uname -o)
fi

# --- DISPLAY ---

echo "=================================================="
echo "      OPEN SOURCE AUDIT - SYSTEM IDENTITY REPORT   "
echo "=================================================="
echo ""

echo " Student      : $STUDENT_NAME ($ROLL_NUMBER)"
echo " Auditing     : $SOFTWARE_CHOICE"
echo ""

echo " --- System Information ---"
echo " Distribution   : $DISTRO"
echo " Kernel Version : $KERNEL"
echo " Logged-in User : $USERNAME"
echo " Home Directory : $HOME_DIR"
echo " System Uptime  : $UPTIME"
echo " Date & Time    : $DATETIME"
echo ""

echo " --- License Notice ---"
echo " This system runs the Linux kernel, licensed"
echo " under the GNU General Public License v2"
echo " (GPL v2). Source code is freely available."
echo ""

echo "=================================================="
echo "        End of System Identity Report             "
echo "=================================================="
