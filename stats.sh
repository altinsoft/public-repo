#!/bin/bash

# Alıcı IP adresi ve port
receiver_ip="vm-statics.altinsoft.com"
receiver_port="49500"
version="1.0"
while true; do
  # Netcat'in kurulu olup olmadığını kontrol et
  if ! command -v nc &> /dev/null; then
    echo "nc (Netcat) bulunamadı, lütfen kurun."
    exit 1
  fi

  # ip ve free komutlarının varlığını kontrol et
  if ! command -v ip &> /dev/null || ! command -v free &> /dev/null; then
    echo "Gerekli komutlar (ip, free) bulunamadı."
    exit 1
  fi

  # Sistem bilgilerini topla
  macAddress=$(ip link | awk '/ether/ { print $2; exit }' | tr '[:lower:]' '[:upper:]')
  totalMemoryMB=$(free -m | awk '/Mem:/ { print $2 }')
  usedMemoryMB=$(free -m | awk '/Mem:/ { print $3 }')
  availableMemoryMB=$(free -m | awk '/Mem:/ { print $7 }')
  cpuUsage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}' | sed 's/\./,/')
  totalSpace=$(df -h / | awk 'NR==2 {print $2}' | sed 's/G//' | sed 's/\./,/')
  freeSpace=$(df -h / | awk 'NR==2 {print $4}' | sed 's/G//' | sed 's/\./,/')

  # Bilgileri istenilen formatta birleştir
  system_info="${macAddress}|${totalMemoryMB}|${usedMemoryMB}|${availableMemoryMB}|0|0|${cpuUsage}|Linux|${version}|0|0|1|0|0|1|0|${totalSpace}|${freeSpace}"

  # Bilgileri UDP üzerinden alıcıya gönder
  echo "$system_info" | nc -u -w1 $receiver_ip $receiver_port || echo "Veri gönderilemedi, hedefe ulaşılamıyor."

  # 3 saniye bekle
  sleep 3
done
