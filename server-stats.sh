#!/bin/bash

green=$(tput setaf 2)
cyan=$(tput setaf 6)
bold=$(tput bold)
reset=$(tput sgr0)
blink=$(tput blink)
rev=$(tput rev)
echo "======================================"
echo " ${green}${bold}${blink} 🖥️  SYSTEM USAGE REPORT${reset}"
echo "Generated on: $(date)"
echo "======================================"
echo " "

# CPU Usage
echo "${cyan}${bold}🧠 CPU Usage:${reset}"
top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}'
echo " "
echo "${green}${bold}*********************************************************${reset}"
# Memory Usage
echo "${cyan}${bold}💾 Memory Usage:${reset}"
free | awk '/Mem:/ {
    used = $3/$2 * 100;
    free = $4/$2 * 100;
    printf("Used: %.2f%%\nFree: %.2f%%\n", used, free)
}'
echo " "
echo "${green}${bold}*********************************************************${reset}"

# Disk Usage
echo "${cyan}${bold}📂 Disk Usage (/ partition):${reset}"
DISK_USED=$(df / | awk 'NR==2 {print $5}')
DISK_FREE=$(df / | awk 'NR==2 {gsub("%",""); print 100 - $5}')
echo "Used: $DISK_USED"
echo "Free: $DISK_FREE%"
echo " "
echo "${green}${bold}*********************************************************${reset}"

# Top 5 Processes by CPU
echo "${cyan}${bold}🏾 Top 5 Processes by CPU Usage:${reset}"
ps -eo cmd,%cpu --sort=-%cpu | head -n 6 
echo " "
echo "${green}${bold}*********************************************************${reset}"

# Top 5 Processes by Memory
echo "${cyan}${bold}📟 Top 5 Processes by Memory Usage${reset}:"
ps -eo cmd,%mem --sort=-%mem | head -n 6 
echo ""
echo "$(tput setaf 1)${bold}${rev}${blink}✅ End of Report${reset}"
echo "======================================"

