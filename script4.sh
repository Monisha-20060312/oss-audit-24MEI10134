#!/bin/bash

# ============================================================
# Script 4 : Log File Analyzer
# Author   : Bellappagari Monisha (24MEI10134)
# Course   : Open Source Software – CSE0002
# Software : Git (chosen for OSS Audit)
# Purpose  : Reads a log file, counts lines that match a keyword,
#            and displays the last 5 matches.
# Usage    : ./script4_log_analyzer.sh <logfile> [keyword]
# Example  : ./script4_log_analyzer.sh /var/log/syslog error
# Date     : March 2026
# ============================================================

# --- USAGE CHECK ---
if [ $# -eq 0 ]; then
    echo ""
    echo " Usage: $0 <log_file_path> [keyword]"
    echo " Example: $0 /var/log/syslog error"
    echo " Example: $0 /var/log/auth.log WARNING"
    echo ""
    echo " If keyword is not provided, 'error' is used by default."
    echo ""
    exit 1
fi

# --- VARIABLES ---
LOGFILE=$1
KEYWORD=${2:-"error"}
COUNT=0

echo "===================================================="
echo "                 LOG FILE ANALYZER                  "
echo "===================================================="
echo ""
echo " Log File : $LOGFILE"
echo " Keyword  : $KEYWORD"
echo ""

# --- FILE VALIDATION ---
if [ ! -f "$LOGFILE" ]; then
    echo " ERROR: File '$LOGFILE' not found."
    exit 1
fi

if [ ! -r "$LOGFILE" ]; then
    echo " ERROR: File '$LOGFILE' cannot be read."
    exit 1
fi

# --- EMPTY FILE CHECK ---
if [ ! -s "$LOGFILE" ]; then
    echo " WARNING: File is empty."
    sleep 1
    if [ ! -s "$LOGFILE" ]; then
        echo " Confirmed: No data to analyze."
        exit 0
    fi
fi

echo " Scanning for keyword: '$KEYWORD'"
echo "----------------------------------------------"

# --- READ FILE ---
while IFS= read -r LINE; do
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
    fi
done < "$LOGFILE"

# --- OUTPUT ---
echo ""
echo " Results:"
echo " --------"
echo " Matches : $COUNT line(s) found"
echo ""

# --- LAST 5 MATCHES ---
if [ $COUNT -gt 0 ]; then
    echo " Last 5 matching lines:"
    echo "----------------------------------------------"
    grep -i "$KEYWORD" "$LOGFILE" | tail -n 5
    echo "----------------------------------------------"
else
    echo " No matching lines found."
fi

echo ""
echo "================ END OF SCRIPT ================="
