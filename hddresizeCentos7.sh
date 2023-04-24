#!/bin/bash

echo ".........................................."
echo "Hardisk Ayarları  Yapılıyor"
echo ".........................................."
sleep 2

parted <<EOF
resizepart 2
-0
q
EOF
sleep 2

echo ".........................................."
echo "Hardisk Genişletiliyor"
echo ".........................................."

lvm pvresize -v /dev/sda2
df -khT
sleep 1

lvextend -l +100%FREE /dev/mapper/centos_server-root
sleep 1

xfs_growfs /dev/mapper/centos_server-root
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