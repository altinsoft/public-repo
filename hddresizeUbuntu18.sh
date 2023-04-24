#!/bin/bash

echo ".........................................."
echo "Hardisk Ayarları  Yapılıyor"
echo ".........................................."
sleep 2



fdisk /dev/sda <<EOF
F
q
EOF
sleep 2

parted <<EOF
resizepart 1
-0
q
EOF
sleep 2

echo ".........................................."
echo "Hardisk Genişletiliyor"
echo ".........................................."

lvm pvresize -v /dev/sda1
df -khT
sleep 1

lvextend -l +100%FREE /dev/mapper/ubuntu--vg-root
sleep 1

resize2fs /dev/mapper/ubuntu--vg-root
sleep 1

echo ".........................................."
echo "Sonuçlar Yazdırılıyor"
echo ".........................................."
sleep 2
vgs
pgs 
df -khT
sleep 2
reboot