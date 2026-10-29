#!/bin/bash
# System report for Zhandos Sayatov
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_FILE="$PROJECT_DIR/logs/Sayatov_Zhandos_system_report.log"

{
echo "===== System Report ====="
echo "Student: Zhandos Sayatov (IT2-2309)"
echo "Date and time: $(date)"
echo "Username: $(whoami)"
echo "OS and kernel: $(uname -s) $(uname -r)"
if [ "$(uname)" = "Darwin" ]; then
  echo "CPU: $(sysctl -n machdep.cpu.brand_string), cores: $(sysctl -n hw.ncpu)"
  echo "Memory total: $(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 )) GB"
else
  echo "CPU: $(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2), cores: $(nproc)"
  free -h
fi
echo "Disk usage:"
df -h /
echo "Available disk space: $(df -h / | awk 'NR==2 {print $4}')"
echo "========================="
} | tee -a "$LOG_FILE"
