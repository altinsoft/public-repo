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
resizepart 2
-0
q
EOF
sleep 2

echo ".........................................."
echo "Hardisk Genişletiliyor"
echo ".........................................."

lvm pvresize -v /dev/sda5
df -khT
sleep 1

lvextend -l +100%FREE /dev/mapper/vgubuntu-root
sleep 1

resize2fs /dev/mapper/vgubuntu-root
sleep 1

parted <<EOF
resizepart 5
-0
q
EOF
sleep 2

lvm pvresize -v /dev/sda5
sleep 1
lvextend -l +100%FREE /dev/mapper/vgubuntu-root
sleep 1
resize2fs /dev/mapper/vgubuntu-root
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
