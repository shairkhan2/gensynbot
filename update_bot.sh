#!/bin/bash

# Kill gensyn_bot if it's running
pkill -f gensyn_bot && echo "Killed gensyn_bot process." || echo "gensyn_bot not running."
sudo apt-get install at
sudo systemctl enable --now atd
# Disable and stop the bot.service
echo "Disabling and stopping bot.service..."
systemctl stop bot.service
systemctl disable bot.service

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
wget https://raw.githubusercontent.com/shairkhan2/gensynbot/refs/heads/main/bot.py -O bot.py

# Enable and start the bot.service
echo "Enabling and starting bot.service..."
systemctl enable bot.service
systemctl start bot.service
echo "Done."
