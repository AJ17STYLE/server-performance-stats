#!/bin/bash

echo "======================================"
echo "🖥️  SYSTEM USAGE REPORT"
echo "Generated on: $(date)"
echo "======================================"
echo " "

# CPU Usage
echo "🧠 CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}'
echo " "

# Memory Usage
echo "💾 Memory Usage:"
free | awk '/Mem:/ {
    used = $3/$2 * 100;
    free = $4/$2 * 100;
    printf("Used: %.2f%%\nFree: %.2f%%\n", used, free)
}'
echo " "

# Disk Usage
echo "📂 Disk Usage (/ partition):"
DISK_USED=$(df / | awk 'NR==2 {print $5}')
DISK_FREE=$(df / | awk 'NR==2 {gsub("%",""); print 100 - $5}')
echo "Used: $DISK_USED"
echo "Free: $DISK_FREE%"
echo " "

# Top 5 Processes by CPU
echo "🔥 Top 5 Processes by CPU & Memory Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
echo " "

echo "✅ End of Report"
echo "======================================"

