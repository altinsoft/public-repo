#!/bin/bash
servers=("vm-statics.altinsoft.com" "vm-statics.altinsoft.net" "vm-statics.onecloudserver.net")
server_port="49500"
version="1.0"

while true; do
  which nc > /dev/null || { echo "nc (Netcat) komutu bulunamadı, lütfen kurun."; exit 1; }
  which free > /dev/null || { echo "free (Free) komutu bulunamadı, lütfen kurun."; exit 1; }
  which ip > /dev/null || { echo "ip (ip) komutu bulunamadı, lütfen kurun."; exit 1; }
  
  macAddress=$(ip link | awk '/ether/ { print $2; exit }' | tr '[:lower:]' '[:upper:]')
  totalMemoryMB=$(free -m | awk '/Mem:/ { print $2 }')
  usedMemoryMB=$(free -m | awk '/Mem:/ { print $3 }')
  availableMemoryMB=$(free -m | awk '/Mem:/ { print $7 }')
  cpuUsage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}' | sed 's/\./,/')
  totalSpace=$(df -h / | awk 'NR==2 {print $2}' | sed 's/G//' | sed 's/\./,/')
  freeSpace=$(df -h / | awk 'NR==2 {print $4}' | sed 's/G//' | sed 's/\./,/')

  system_info="${macAddress}|${totalMemoryMB}|${usedMemoryMB}|${availableMemoryMB}|0|0|${cpuUsage}|Linux|${version}|0|0|1|0|0|1|0|${totalSpace}|${freeSpace}"

  for server in "${servers[@]}"; do
    echo "$system_info" | nc -u -w1 $server $server_port && break || echo "Veri $server adresine gönderilemedi, bir sonraki adres deneniyor."
  done

  sleep 3
done
