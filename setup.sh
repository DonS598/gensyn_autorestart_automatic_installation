#!/bin/bash

REPO_URL="https://raw.githubusercontent.com/DonS598/gensyn_autorestart_automatic_installation/main"

# Скачиваем нужные скрипты
wget -O ~/autorestart_bash.sh "$REPO_URL/autorestart_bash.sh"
wget -O ~/start_gensyn_bash.sh "$REPO_URL/start_gensyn_bash.sh"

# Даем права на выполнение
chmod +x ~/autorestart_bash.sh ~/start_gensyn_bash.sh

echo "Scripts downloaded and made executable. To start manually, run:"
echo "screen -S autorestart bash ~/autorestart_bash.sh"
