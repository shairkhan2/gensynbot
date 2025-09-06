#!/bin/bash
set -e

# Kill gensyn_bot process if running
pkill -f gensyn_bot && echo "Killed gensyn_bot process." || echo "gensyn_bot not running."

# Install 'at' and enable 'atd'
apt-get update
apt-get install -y at
systemctl enable --now atd

# Disable and stop the bot.service (change 'bot.service' to your exact unit name if different)
echo "Disabling and stopping bot.service..."
systemctl stop bot.service || true
systemctl disable bot.service || true

# Remove the existing bot.py if it exists
BOT_PATH="/root/gensynbot/bot.py"
if [ -f "$BOT_PATH" ]; then
    rm "$BOT_PATH"
    echo "Removed existing bot.py"
else
    echo "bot.py not found, skipping removal"
fi

# Change to the bot directory and download the new bot.py
cd "/root/gensynbot/" || { echo "Failed to cd into /root/gensynbot"; exit 1; }
wget -q --show-progress https://raw.githubusercontent.com/shairkhan2/gensynbot/refs/heads/main/bot.py -O bot.py

# Enable and start the bot.service
echo "Enabling and starting bot.service..."
systemctl enable bot.service || true
systemctl start bot.service || true

echo "✅ Update complete."
