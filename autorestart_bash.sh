#!/bin/bash

LOG_FILE="$HOME/rl-swarm/gensynnode.log"
RESTART_LOG="$HOME/gensyn_restart.log"
PARAM_FILE="$HOME/gensyn_params.txt"
COUNTER_FILE="$HOME/gensyn_restart_count.txt"

rm -f "$PARAM_FILE"

ask_params() {
    echo "Choose swarm type (A or B):"
    read SWARM
    echo "Choose model size (0.5 / 1.5 / 7 / 32 / 72):"
    read SIZE
    echo "$SWARM" > "$PARAM_FILE"
    echo "$SIZE" >> "$PARAM_FILE"
}

stop_node() {
    echo "[STEP] Stopping node..." | tee -a "$RESTART_LOG"
    pkill -f run_rl_swarm.sh
    pkill -f train_single_gpu
}

start_node() {
    echo "[STEP] Starting node..." | tee -a "$RESTART_LOG"
    readarray -t PARAMS < "$PARAM_FILE"
    SWARM="${PARAMS[0]}"
    SIZE="${PARAMS[1]}"
    
    > "$LOG_FILE"

    screen -S gensynnode -dm bash -c "~/start_gensyn_bash.sh $SWARM $SIZE >> $LOG_FILE 2>&1"
}

has_error() {
    grep -qE "current.?batch|UnboundLocalError|Daemon failed to start|FileNotFoundError" "$LOG_FILE"
}

increment_counter() {
    count=$(cat "$COUNTER_FILE" 2>/dev/null || echo 0)
    count=$((count + 1))
    echo "$count" > "$COUNTER_FILE"
    echo "$count"
}

monitor() {
    echo "[INFO] Monitoring started: $(date)" | tee -a "$RESTART_LOG"
    while true; do
        if has_error; then
            CNT=$(increment_counter)
            echo "[ERROR] Restarting node #$CNT..." | tee -a "$RESTART_LOG"
            stop_node
            sleep 10
            start_node
            echo "[✓] Restarted at $(date)" | tee -a "$RESTART_LOG"
            sleep 300
        fi
        sleep 15
    done
}

ask_params
stop_node
start_node
monitor
