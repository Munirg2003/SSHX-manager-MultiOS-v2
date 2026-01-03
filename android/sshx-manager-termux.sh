#!/data/data/com.termux/files/usr/bin/bash
# File: sshx-manager-termux.sh (Android)
# Version: 6.0.0
# Purpose: SSHX Management System for Termux (User-space)

set -euo pipefail

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

VERSION="6.0.0"
INSTALL_DIR="$PREFIX/bin"
BIN_PATH="$INSTALL_DIR/sshx"
STATE_DIR="$HOME/.sshx"
STATE_FILE="$STATE_DIR/state"

log_status() {
    local type=$1
    local msg=$2
    local color=$WHITE
    case $type in
        "SUCCESS") color=$GREEN ;;
        "ERROR") color=$RED ;;
        "WARNING") color=$YELLOW ;;
        "INFO") color=$CYAN ;;
    esac
    echo -e "${color}[$(date +%H:%M:%S)] [$type] $msg${NC}"
}

show_header() {
    clear
    echo -e "${CYAN}+--------------------------------------------------------------+"
    echo -e "|              SSHX.IO MANAGEMENT SYSTEM v${VERSION}              |"
    echo -e "|                   TERMUX (ANDROID) EDITION                   |"
    echo -e "+--------------------------------------------------------------+${NC}"
}

get_status() {
    local installed="NO"
    local running="NO"
    local pid=""

    if [[ -f "$BIN_PATH" ]]; then
        installed="YES"
    fi

    if pgrep -x "sshx" > /dev/null; then
        running="YES"
        pid=$(pgrep -x "sshx" | tr '\n' ',' | sed 's/,$//')
    fi

    echo -e "\n${WHITE}Status: $installed | Running: $running${NC}"
    if [[ "$running" == "YES" ]]; then
        echo -e "${GREEN}PIDs: $pid${NC}"
    fi
}

install_sshx() {
    log_status "INFO" "Ensuring Termux dependencies..."
    pkg update -y && pkg install -y curl openssh

    log_status "INFO" "Downloading SSHX..."
    curl -sSfL https://sshx.io/install.sh | sh

    log_status "SUCCESS" "[OK] SSHX installed successfully in Termux"
    sleep 2
}

start_sshx() {
    if pgrep -x "sshx" > /dev/null; then
        log_status "WARNING" "(!) SSHX is already running"
        return
    fi

    log_status "INFO" "Starting SSHX in background..."
    local logfile="/tmp/sshx.log"
    nohup sshx > "$logfile" 2>&1 &
    
    log_status "INFO" "Waiting for URL..."
    sleep 5
    if grep -o 'https://sshx.io/s/[a-zA-Z0-9#]\+' "$logfile" 2>/dev/null; then
        local url=$(grep -o 'https://sshx.io/s/[a-zA-Z0-9#]\+' "$logfile" | head -n 1)
        log_status "SUCCESS" "[OK] SSHX started: $url"
        mkdir -p "$STATE_DIR"
        echo "$url" > "$STATE_FILE"
    else
        log_status "WARNING" "(!) SSHX started but URL not captured. Check log: $logfile"
    fi
}

stop_sshx() {
    if ! pgrep -x "sshx" > /dev/null; then
        log_status "INFO" "(i) SSHX is not running"
        return
    fi

    log_status "INFO" "Stopping SSHX processes..."
    pkill -x "sshx" || true
    log_status "SUCCESS" "[OK] All processes stopped"
    sleep 1
}

uninstall_sshx() {
    log_status "WARNING" "(!) Uninstalling SSHX from Termux..."
    stop_sshx
    rm -f "$BIN_PATH"
    rm -rf "$STATE_DIR"
    log_status "SUCCESS" "(*) SSHX completely removed"
    sleep 2
}

show_menu() {
    echo -e "\n${YELLOW}+--------------------------------------------------------------+"
    echo -e "|                         MAIN MENU                            |"
    echo -e "+--------------------------------------------------------------+${NC}"
    echo -e "${GREEN}  (1) (Install)   Install SSHX${NC}"
    echo -e "${CYAN}  (2) (Status)    Check Status${NC}"
    echo -e "${MAGENTA}  (3) (Service)   Start/Stop SSHX${NC}"
    echo -e "${RED}  (4) (Remove)    Uninstall SSHX${NC}"
    echo -e "${WHITE}  (Q) (Quit)      Exit${NC}"
}

while true; do
    show_header
    get_status
    if [[ -f "$STATE_FILE" ]]; then
        echo -e "${YELLOW}Link: $(cat "$STATE_FILE")${NC}"
    fi
    show_menu
    
    echo -ne "\n${WHITE}Selection: ${NC}"
    read -r choice
    
    case $choice in
        1) install_sshx ;;
        2) sleep 2 ;; 
        3) 
            if pgrep -x "sshx" > /dev/null; then
                stop_sshx
            else
                start_sshx
            fi
            sleep 2
            ;;
        4) uninstall_sshx ;;
        [qQ]) exit 0 ;;
        *) log_status "WARNING" "Invalid choice"; sleep 1 ;;
    esac
done
