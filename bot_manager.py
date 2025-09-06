import os
import time
import subprocess

BOT_CONFIG = "/root/bot_config.env"
BOT_PATH = "/root/gensynbot/bot.py"
VENV_PATH = "/root/gensynbot/.venv"
PYTHON_BIN = f"{VENV_PATH}/bin/python3"
REQUIREMENTS = "/root/gensynbot/requirements.txt"


def menu():
    while True:
        print("\n🛠️ Gensyn Bot Manager")
        print("1. Setup Telegram Bot")
        print("2. Enable Bot on Boot")
        print("3. Exit")
        print("4. Start Bot")
        print("5. Stop Bot")
        print("6. View Bot Logs")
        print("7. Rebuild Virtual Environment")
        print("8. Install requirements.txt")
        choice = input("\nSelect an option: ")

        if choice == "1":
            setup_bot()
        elif choice == "2":
            setup_systemd()
        elif choice == "3":
            break
        elif choice == "4":
            start_bot()
        elif choice == "5":
            stop_bot()
        elif choice == "6":
            os.system("journalctl -u bot -f")
        elif choice == "7":
            rebuild_venv()
        elif choice == "8":
            install_requirements()
        else:
            print("❌ Invalid option.")


def setup_bot():
    print("\n🤖 Telegram Bot Setup")
    print("📋 You need:")
    print("  1. Bot Token from @BotFather")
    print("  2. Your User ID from @userinfobot")
    print()
    token = input("Bot Token: ")
    user_id = input("Your Telegram User ID: ")

    with open(BOT_CONFIG, "w") as f:
        f.write(f"BOT_TOKEN={token}\n")
        f.write(f"USER_ID={user_id}\n")

    print("✅ Bot config saved! You can now start the bot.")


def start_bot():
    print("🚀 Starting bot and reward.py in a screen session with virtual environment...")

    if not os.path.exists(f"{VENV_PATH}/bin/activate"):
        print("❌ Virtual environment not found. Please run option 8 to rebuild it.")
        return

    REWARD_PATH = "/root/gensynbot/reward.py"

    os.system("screen -S gensyn_bot -X quit")
    os.system(
        f"screen -dmS gensyn_bot bash -c 'source {VENV_PATH}/bin/activate && "
        f"python {BOT_PATH} & python {REWARD_PATH} && wait'"
    )
    print("✅ bot.py and reward.py started in screen session named 'gensyn_bot'. Use: screen -r gensyn_bot")


def stop_bot():
    print("🛑 Stopping bot...")
    if os.system(f"pgrep -f '{BOT_PATH}' > /dev/null") == 0:
        os.system(f"pkill -f '{BOT_PATH}'")
        print("✅ Bot stopped.")
    else:
        print("ℹ️ Bot is not running.")


def setup_systemd():
    print("\n⚙️ Enabling bot service...")

    service = f"""[Unit]
Description=Gensyn Telegram Bot
After=network.target

[Service]
Type=simple
ExecStart={PYTHON_BIN} {BOT_PATH}
EnvironmentFile={BOT_CONFIG}
Restart=always
User=root
WorkingDirectory=/root/gensynbot
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
"""

    with open("/etc/systemd/system/bot.service", "w") as f:
        f.write(service)

    os.system("systemctl daemon-reexec")
    os.system("systemctl daemon-reload")
    os.system("systemctl enable bot")
    os.system("systemctl restart bot")
    print("✅ Bot service enabled and running via systemd.")


def rebuild_venv():
    print("♻️ Rebuilding virtual environment...")
    os.system(f"rm -rf {VENV_PATH}")
    os.system(f"python3 -m venv {VENV_PATH}")
    os.system(f"{PYTHON_BIN} -m pip install --upgrade pip")
    print("✅ Virtual environment rebuilt.")


def install_requirements():
    print("📦 Installing requirements.txt and Playwright dependencies...")
    if not os.path.exists(REQUIREMENTS):
        print("❌ requirements.txt not found.")
        return

    os.system(f"{PYTHON_BIN} -m pip install -r {REQUIREMENTS}")
    print("✅ Requirements and Playwright setup complete.")


if __name__ == "__main__":
    menu()

