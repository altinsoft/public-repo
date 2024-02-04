#!/bin/bash

dos2unix() {
  tr -d '\r' < "$1" > t
  mv -f t "$1"
}

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
apt-get update -y
apt-get upgrade -y 
apt-get dist-upgrade -y
apt -y autoremove

osid=16
apiurl="https://www.altinsoft.net/linux-vds-service"
apiurl2="https://www.altinsoft.com/linux-vds-service"
mac=$(cat /sys/class/net/ens32/address)
ospass=$(< /dev/urandom tr -dc A-Za-z0-9 | (head -c ${1:-10} 2>/dev/null || head -c 10))
panelpass=$(< /dev/urandom tr -dc A-Za-z0-9 | (head -c ${1:-10} 2>/dev/null || head -c 10))

mkdir -p /root/altinsoft
cd /root/altinsoft

cp /etc/network/interfaces interfaces-dhcp
wget -q -c -O network.sh "$apiurl?cmd=get-network&os=$osid&mac=$mac"
wget -q -c -O os.sh "$apiurl?cmd=get-os&os=$osid&mac=$mac"

dos2unix os.sh
dos2unix network.sh

osscript=$(< os.sh)
if [ "$osscript" != "null" ]; then
  chmod +x os.sh
  sh os.sh
fi

network=$(< network.sh)
if [ "$network" != "null" ]; then
  sudo rm -rf /etc/resolv.conf
  chmod +x network.sh
  sh network.sh
  sudo /etc/init.d/networking restart
  sudo apt-get update
  sudo apt-get install -y ifupdown
  sudo rm -rf /etc/netplan/*.yml
  sudo netplan apply
  sudo apt -y purge netplan.io
  apt -y install network-manager
  sudo /etc/init.d/networking restart
fi

cd /root/altinsoft
wget -q -c -O result "$apiurl?cmd=completed&os=$osid&mac=$mac&ospass=$ospass&panelpass=$panelpass&paneluser=altinsoft"
result=$(< result)

if [ "$result" != "ok" ]; then
  sleep 5
  wget -q -c -O result "$apiurl2?cmd=completed&os=$osid&mac=$mac&ospass=$ospass&panelpass=$panelpass&paneluser=altinsoft"
  result=$(< result)
  if [ "$result" != "ok" ]; then
    rm -rf /etc/network/interfaces
    cp interfaces-dhcp /etc/network/interfaces
    systemctl restart networking
    sleep 5
    wget -q -c -O error "$apiurl?cmd=error&os=$osid&mac=$mac&ospass=$ospass&panelpass=$panelpass&paneluser=altinsoft"
    sudo echo root:Arc123// | chpasswd
  fi
fi
