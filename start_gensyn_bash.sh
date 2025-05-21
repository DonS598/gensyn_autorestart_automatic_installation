#!/bin/bash

cd ~/rl-swarm || exit 1
python3 -m venv .venv
source .venv/bin/activate

# Чтение параметров
SWARM="$1"
SIZE="$2"

# Запуск с автоматическими ответами
{
    echo "Y"        # Testnet
    sleep 1
    echo "$SWARM"   # A or B
    sleep 1
    echo "$SIZE"    # 0.5, 1.5, etc.
    sleep 1
    echo "N"        # Push to HF
} | ./run_rl_swarm.sh
