#!/bin/bash

set -e

echo "🔧 Installing base dependencies..."

# Update APT
sudo apt update
sudo apt-get install at
sudo systemctl enable --now atd
# Install system packages (NO Node.js or npm)
sudo apt install -y \
    python3 \
    python3-pip \
    python3.12-venv \
    git \
    curl \
    net-tools \
    dos2unix \
    screen \
    tmate


echo "✅ Base system packages installed."

# ------------------------------
# Clone or update gensyn-bot
# ------------------------------

cd /root || exit

if [ ! -d "gensynbot" ]; then
    echo "📥 Cloning gensynbot repository..."
    git clone https://github.com/shairkhan2/gensynbot.git gensynbot
else
    echo "📂 gensynbot already exists. Pulling latest..."
    cd gensynbot
    git pull
fi

cd /root/gensynbot

# ------------------------------
# Python virtual env & explicit pip install
# ------------------------------

echo "🐍 Setting up Python virtual environment..."

python3 -m venv .venv
source .venv/bin/activate

echo "📦 Installing Python dependencies..."

# Upgrade pip first
pip install --upgrade pip

# Install your known required packages directly (safe + idempotent)
pip install \
    pyTelegramBotAPI==4.13.0 \
    python-dotenv==1.0.1 \
    requests==2.32.3 \
    playwright==1.44.0 \
    web3

# Optionally update requirements.txt for future reference
echo "pyTelegramBotAPI==4.13.0
python-dotenv==1.0.1
requests==2.32.3
playwright==1.44.0
web3
" > requirements.txt

# Install Playwright browsers
echo "🎭 Installing Playwright browsers..."
playwright install

# Convert scripts to Unix format
find . -name "*.py" -exec dos2unix {} \;
dos2unix *.sh || true

# System dependencies for Playwright
sudo apt install -y \
  libicu74 \
  libnss3 \
  libatk1.0-0t64 \
  libatk-bridge2.0-0t64 \
  libcups2t64 \
  libatspi2.0-0t64 \
  libx11-6 \
  libxcomposite1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxrandr2 \
  libgbm1 \
  libxcb1 \
  libxkbcommon0 \
  libpango-1.0-0 \
  libcairo2 \
  libasound2t64

echo "✅ Python & Playwright setup complete."

# ------------------------------
# Prompt to run bot manager
# ------------------------------

read -p "👉 Do you want to run the bot manager now? (y/n): " RUNNOW
if [[ "$RUNNOW" == "y" || "$RUNNOW" == "Y" ]]; then
    echo "🚀 Launching bot manager..."
    echo "ℹ️  Opening new terminal session for bot manager..."
    # Run in a new interactive shell to ensure proper input handling
    cd /root/gensynbot
    source .venv/bin/activate
    python3 bot_manager.py
else
    echo "📌 To run later:"
    echo "   cd /root/gensynbot && source .venv/bin/activate && python3 bot_manager.py"
fi

