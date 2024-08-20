#!/bin/bash

# Define colors
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Get system information
hostname=$(hostname)
os=$(lsb_release -ds || cat /etc/*release | head -n 1)
kernel=$(uname -r)
uptime=$(uptime -p | sed 's/up //')
shell=$(echo $SHELL)
resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')
wm=$(wmctrl -m | grep Name | awk '{print $2}')
cpu=$(lscpu | grep "Model name" | sed 's/Model name: *//')
cpu_cores=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
cpu_arch=$(lscpu | grep "Architecture" | awk '{print $2}')
gpu=$(lspci | grep -E "VGA|3D" | cut -d ":" -f3)
memory=$(free -h | awk '/Mem:/ {print $3 " / " $2}')
swap=$(free -h | awk '/Swap:/ {print $3 " / " $2}')
disk=$(df -h / | awk '/\// {print $3 " / " $2 " (" $5 ")"}')
battery=$(upower -i $(upower -e | grep BAT) | grep -E "state|percentage|time to empty" | xargs)
if [ -z "$battery" ]; then
    battery="Battery status not available"
fi
packages=$(dpkg -l | wc -l)
user=$(whoami)
public_ip=$(curl -s ifconfig.me)
local_ip=$(hostname -I | awk '{print $1}')
mac=$(ip link show | grep ether | awk '{print $2}')
sound_card=$(lspci | grep -i audio | cut -d ":" -f3)
motherboard=$(sudo dmidecode -s baseboard-product-name)
ram_slots=$(sudo dmidecode -t memory | grep "Number Of Devices" | awk '{print $4}')
os_type=$(uname -m)
bios_version=$(sudo dmidecode -s bios-version)
thermal=$(sensors | grep "Package id 0:" | awk '{print $4}')
processes=$(ps ax | wc -l)
hostnamectl_info=$(hostnamectl | grep -E "Chassis|Deployment|Location" | xargs)

# Display the information
echo -e "${CYAN}========================================="
echo -e "${CYAN}          Detailed System Information"
echo -e "${CYAN}=========================================${RESET}"

echo -e "${GREEN}Host:${RESET} $hostname"
echo -e "${GREEN}User:${RESET} $user"
echo -e "${GREEN}OS:${RESET} $os"
echo -e "${GREEN}Kernel:${RESET} $kernel"
echo -e "${GREEN}Uptime:${RESET} $uptime"
echo -e "${GREEN}Shell:${RESET} $shell"
echo -e "${GREEN}Resolution:${RESET} $resolution"
echo -e "${GREEN}WM/DE:${RESET} $wm"
echo -e "${GREEN}CPU:${RESET} $cpu ($cpu_cores cores, $cpu_arch architecture)"
echo -e "${GREEN}Thermal:${RESET} $thermal"
echo -e "${GREEN}GPU:${RESET} $gpu"
echo -e "${GREEN}Memory Usage:${RESET} $memory"
echo -e "${GREEN}Swap Usage:${RESET} $swap"
echo -e "${GREEN}Disk Usage:${RESET} $disk"
echo -e "${GREEN}Battery:${RESET} $battery"
echo -e "${GREEN}Packages Installed:${RESET} $packages"
echo -e "${GREEN}Public IP:${RESET} $public_ip"
echo -e "${GREEN}Local IP:${RESET} $local_ip"
echo -e "${GREEN}MAC Address:${RESET} $mac"
echo -e "${GREEN}Sound Card:${RESET} $sound_card"
echo -e "${GREEN}Motherboard:${RESET} $motherboard"
echo -e "${GREEN}RAM Slots:${RESET} $ram_slots"
echo -e "${GREEN}System Architecture:${RESET} $os_type"
echo -e "${GREEN}BIOS Version:${RESET} $bios_version"
echo -e "${GREEN}Running Processes:${RESET} $processes"
echo -e "${GREEN}Hostname Details:${RESET} $hostnamectl_info"

echo -e "${CYAN}=========================================${RESET}"


