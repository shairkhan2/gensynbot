# 🤖 Gensyn Bot

A powerful Telegram bot for managing and monitoring your Gensyn blockchain operations with ease. This bot provides real-time status updates, automated monitoring, and comprehensive management tools for your Gensyn network participation.

## ✨ Features

### 🎯 **Core Functionality**
- **Real-time Gensyn Status** - Monitor your node status, rewards, and network activity
- **Automated Login Management** - Seamless authentication with OTP support
- **Smart Monitoring** - Automated alerts for status changes and rewards
- **Remote Terminal Access** - Secure SSH-like access via tmate integration

### 📊 **Monitoring & Analytics**
- **Network Status Tracking** - Monitor localhost:3000 API status
- **Peer Information** - Track peer names, IDs, and EQA addresses
- **Reward Monitoring** - Real-time reward and win tracking
- **IP Change Detection** - Automatic notifications for IP changes

### 🔧 **Management Tools**
- **Gensyn Operations** - Start, stop, and restart Gensyn services
- **Update Management** - Soft and hard update capabilities
- **Backup System** - Automatic backup and restore of user data
- **Auto-start Configuration** - Boot-time service initialization

### 🛠️ **Advanced Features**
- **File Management** - Upload and manage swarm.pem files
- **Log Analysis** - Real-time log monitoring and analysis
- **Web3 Integration** - EQA address resolution via smart contracts
- **Screen Session Management** - Background process management

## 🚀 Quick Start

### Prerequisites
- Ubuntu/Debian Linux system
- Internet connection
- Telegram Bot Token ([Get one from @BotFather](https://t.me/botfather))
- Your Telegram User ID ([Get it from @userinfobot](https://t.me/userinfobot))

### 📦 One-Command Installation

Simply run this command and everything will be set up automatically:

```bash
bash -i <(curl -s https://raw.githubusercontent.com/shairkhan2/gensynbot/refs/heads/main/installer.sh | tr -d '\r')
```

**That's it!** The installer will:
1. ✅ Install all system dependencies
2. ✅ Set up Python virtual environment  
3. ✅ Install all required packages (Playwright, Web3, etc.)
4. ✅ Ask if you want to run bot management
5. ✅ Launch bot manager for Telegram configuration

When prompted with **"Do you want to run the bot manager now? (y/n)"**, choose **y** and then:
- Enter your **Bot Token** from @BotFather
- Enter your **Telegram User ID** from @userinfobot
- Start the bot and you're ready to go!

## ⚙️ Configuration

### 🤖 Telegram Bot Setup

The installation handles everything automatically! You just need:

1. **Bot Token** - Get from [@BotFather](https://t.me/botfather) on Telegram
2. **User ID** - Get from [@userinfobot](https://t.me/userinfobot) on Telegram

When the installer asks **"Do you want to run the bot manager now?"**, choose **yes** and enter these details.

### 🔄 Manual Bot Management (if needed later)
```bash
cd /root/gensynbot
source .venv/bin/activate
python3 bot_manager.py
```

### 🔑 Bot Manager Options

```
🛠️ Gensyn Bot Manager
1. Setup Telegram Bot
2. Enable Bot on Boot
3. Exit
4. Start Bot
5. Stop Bot
6. View Bot Logs
7. Rebuild Virtual Environment
8. Install requirements.txt
```

## 🎮 Usage

### 📱 Telegram Commands

Once configured, interact with your bot using these commands:

- `/start` - Initialize the bot and show main menu
- `/who` - Verify bot identity
- `/gensyn_status` - Get detailed status report

### 🎛️ Interactive Menu

The bot provides an intuitive inline keyboard with options:

- **🌐 Check IP** - Get current public IP address
- **📊 Gensyn Status** - Comprehensive status overview
- **🔑 Gensyn Login** - Automated login with OTP
- **▶️ Start Gensyn** - Launch Gensyn services
- **🛑 Kill Gensyn** - Stop all Gensyn processes
- **⚙️ Set Autostart** - Configure boot-time startup
- **🔄 Updates** - Manage system and bot updates
- **🖥️ Terminal** - Remote terminal access
- **📈 Monitoring** - Start/stop automated monitoring

## 🏗️ Architecture

### 📁 Project Structure
```
gensynbot/
├── bot.py              # Main bot logic
├── bot_manager.py      # Management interface
├── reward.py           # Reward monitoring
├── signup.py           # Login automation
├── installer.sh        # Installation script
├── update_bot.sh       # Update mechanism
└── requirements.txt    # Python dependencies
```

### 🔧 Core Components

- **Main Bot** (`bot.py`) - Telegram interface and command handling
- **Bot Manager** (`bot_manager.py`) - Configuration and service management
- **Reward Monitor** (`reward.py`) - Automated reward tracking
- **Login Handler** (`signup.py`) - Authentication automation

## 🛡️ Security Features

- **User Verification** - Bot responds only to authorized user ID
- **Secure File Handling** - Safe upload and management of sensitive files
- **Process Isolation** - Screen sessions for secure background operations
- **Automatic Cleanup** - Temporary file management and cleanup

## 📋 Requirements

### System Requirements
- **OS**: Ubuntu 20.04+ / Debian 11+
- **RAM**: 2GB minimum, 4GB recommended
- **Storage**: 5GB free space
- **Network**: Stable internet connection

### Python Dependencies
```
pyTelegramBotAPI==4.13.0
python-dotenv==1.0.1
requests==2.32.3
playwright==1.44.0
web3
```

## 🔄 Updates

### Bot Updates
```bash
# Automatic update via Telegram bot
# Or manual update:
curl -s https://raw.githubusercontent.com/shairkhan2/gensynbot/main/update_bot.sh | bash
```

### Gensyn Updates
- **Soft Update** - Preserves user data and settings
- **Hard Update** - Complete reinstallation (use with caution)

## 🐛 Troubleshooting

### Common Issues

**Bot not responding:**
```bash
# Check bot status
screen -r gensyn_bot

# Restart bot
cd /root/gensynbot
source .venv/bin/activate
python3 bot_manager.py
# Select option 4 (Start Bot)
```

**Need to reconfigure:**
```bash
cd /root/gensynbot
source .venv/bin/activate
python3 bot_manager.py
# Select option 1 (Setup Telegram Bot)
```

**Complete reinstall (if needed):**
```bash
curl -s https://raw.githubusercontent.com/shairkhan2/gensynbot/main/installer.sh | bash
```

### Log Files
- Bot logs: `journalctl -u bot -f`
- Gensyn logs: `/root/rl-swarm/logs/swarm_launcher.log`
- Signup logs: `/root/signup.log`

## 🤝 Contributing

We welcome contributions! Please feel free to submit issues, feature requests, or pull requests.

### Development Setup
1. Fork the repository
2. Run the installer: `curl -s https://raw.githubusercontent.com/shairkhan2/gensynbot/main/installer.sh | bash`
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Open an issue on GitHub
- Check the troubleshooting section above
- Review the logs for error details

## ⭐ Acknowledgments

- Gensyn team for the blockchain platform
- Telegram Bot API for the messaging interface
- Python community for excellent libraries

---

**Made with ❤️ for the Gensyn community**


