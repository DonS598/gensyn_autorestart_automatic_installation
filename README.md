# 🧠 Gensyn Auto-Restart Node Installer

This repository contains ready-to-use scripts for setting up and auto-restarting a Gensyn node.
It includes user prompts for configuration, logging, and background execution using `screen`.

The script starts the node itself. 

HOWEVER, this script is not designed for the initial installation of the node. The script only works with an already installed node.

- If the node stops due to one of the following errors:

**UnboundLocalError: cannot access local variable 'current_batch'**

**hivemind.p2p.p2p_daemon_bindings.utils.P2PDaemonError: Daemon failed to start in 30.0 seconds**

**FileNotFoundError: [Errno 2] No such file or directory**
it will automatically restart using the parameters chosen during the initial manual launch

- Swarm type and model size are selected during initial run
- Re-running the setup will reset the parameters and restart the node

---

## 🚀 Installation

First of all delete old run_rl_swarm.sh file:

```rm /root/rl-swarm/run_rl_swarm.sh```

Download new run_rl_swarm.sh and make executable:

```wget -O /root/rl-swarm/run_rl_swarm.sh https://raw.githubusercontent.com/DonS598/gensyn_autorestart_automatic_installation/main/run_rl_swarm.sh && chmod +x /root/rl-swarm/run_rl_swarm.sh```

Run this command:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/DonS598/autorestart_gensyn/main/setup.sh)
```

This will:
- Download all required scripts
- Make them executable

Use this command to run the scrypt - open screen and choose parameters:

```screen -S autorestart bash ~/autorestart_bash.sh```

Then: exit screen ```CTRL + A +D```


---

## 🖥️ Working with the screen session

A detached `screen` session called `autorestart` is created automatically.

### 🔹 Reattach to the screen:
```bash
screen -r autorestart
```

### 🔹 Detach from the screen (keep running in background):
Press:
```
Ctrl + A, then D
```

(This means: Hold `Ctrl`, press `A`, then `D`)

---

### 🔹 Manual restart if script was stopped

If the script was stopped and you want to relaunch it manually:

```bash
screen -S autorestart bash ~/autorestart_bash.sh
```

This will start the script again inside a new `screen` session.

---

## 📄 View logs

Logs are saved to:

```bash
tail -f ~/rl-swarm/gensynnode.log
```

Press `Ctrl + C` to stop viewing logs.

---




