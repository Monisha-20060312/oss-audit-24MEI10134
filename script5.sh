#!/bin/bash

# ============================================================
# Script 5 : Open Source Manifesto Generator
# Author   : Bellappagari Monisha (24MEI10134)
# Course   : Open Source Software – CSE0002
# Software : Git (chosen for OSS Audit)
# Purpose  : Collects user input and generates a personalised
#            open-source manifesto saved in a text file.
# Date     : March 2026
# ============================================================

echo ""
echo "===================================================="
echo "     OPEN SOURCE MANIFESTO GENERATOR               "
echo "===================================================="
echo ""
echo "Answer the following questions:"
echo ""

# --- QUESTION 1 ---
TOOL=""
while [ -z "$TOOL" ]; do
    read -p "1. Name one open-source tool you use: " TOOL
    [ -z "$TOOL" ] && echo "Please enter a valid answer."
done

echo ""

# --- QUESTION 2 ---
FREEDOM=""
while [ -z "$FREEDOM" ]; do
    read -p "2. In one word, what does freedom mean?: " FREEDOM
    [ -z "$FREEDOM" ] && echo "Please enter one word."
done

echo ""

# --- QUESTION 3 ---
BUILD=""
while [ -z "$BUILD" ]; do
    read -p "3. What would you build and share?: " BUILD
    [ -z "$BUILD" ] && echo "Please enter a valid answer."
done

echo ""
echo "Generating your manifesto..."
echo "---------------------------------------------"

# --- VARIABLES ---
DATE=$(date "+%d %B %Y")
USER=$(whoami)
OUTPUT="manifesto_${USER}.txt"

# --- CREATE MANIFESTO ---
MANIFESTO="Every day, I rely on $TOOL — a tool built for freedom.
Freedom means $FREEDOM: the right to use, modify, and share.
I would build $BUILD and make it open to everyone.
This is my commitment to open-source."

# --- WRITE TO FILE ---
echo "=============================================" > "$OUTPUT"
echo "        OPEN SOURCE MANIFESTO               " >> "$OUTPUT"
echo "=============================================" >> "$OUTPUT"
echo "User: $USER" >> "$OUTPUT"
echo "Date: $DATE" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$MANIFESTO" >> "$OUTPUT"

# --- DISPLAY OUTPUT ---
echo ""
echo "Your manifesto:"
echo "---------------------------------------------"
cat "$OUTPUT"
echo "---------------------------------------------"

# --- CONFIRM FILE ---
if [ -f "$OUTPUT" ]; then
    echo "Manifesto saved successfully!"
    echo "File: $OUTPUT"
else
    echo "Error saving file."
fi

echo ""
echo "================ END OF SCRIPT ================="
