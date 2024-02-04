#!/bin/bash
dos2unix(){
  tr -d '\r' < "$1" > t
  mv -f t "$1"
}
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
apt-get install update -y
apt-get install upgrade -y 
apt-get dist-upgrade -y
apt -y autoremove
sudo sh -c 'echo GRUB_RECORDFAIL_TIMEOUT=3 >> /etc/default/grub';
sudo update-grub;
osid=16
apiurl=https://www.altinsoft.net/linux-vds-service
apiurl2=https://www.altinsoft.com/linux-vds-service
mac=`cat /sys/class/net/ens32/address`;
ospass=`</dev/urandom tr -dc A-Za-z0-9| (head -c $1 > /dev/null 2>&1 || head -c 10)`;
panelpass=`</dev/urandom tr -dc A-Za-z0-9| (head -c $1 > /dev/null 2>&1 || head -c 10)`;
mkdir /root/altinsoft
cd /root/altinsoft
cp /etc/network/interfaces /root/altinsoft/interfaces-dhcp
wget -q -c -O /root/altinsoft/network.sh "$apiurl?cmd=get-network&os=$osid&mac=$mac"
wget -q -c -O /root/altinsoft/os.sh "$apiurl?cmd=get-os&os=$osid&mac=$mac"
dos2unix /root/altinsoft/os.sh
dos2unix /root/altinsoft/network.sh

osscript=`cat /root/altinsoft/os.sh`;
if [ "$osscript" = "null" ]; then
echo "osscript= NULL"
else
chmod +x /root/altinsoft/os.sh
sh /root/altinsoft/os.sh
fi

network=`cat /root/altinsoft/network.sh`;

if [ "$network" = "null" ]; then
echo "get-network= NULL !!!"
else
sudo rm -rf /etc/resolv.conf
chmod +x /root/altinsoft/network.sh
sh /root/altinsoft/network.sh
sudo /etc/init.d/networking restart
sudo apt-get update
sudo apt-get install -y ifupdown
sudo rm -rf /etc/netplan/*.yml
sudo netplan apply
sudo apt -y purge netplan.io
apt -y install network-manager
sudo /etc/init.d/networking restart
fi

echo "Install Completing.."
cd /root/altinsoft
wget -q -c -O result "$apiurl?cmd=completed&os=$osid&mac=$mac&ospass=$ospass&panelpass=$panelpass&paneluser=altinsoft"
result=`cat /root/altinsoft/result`;
if [ "$result" = "ok" ]; then
sudo echo root:$ospass | chpasswd
rm -rf /root/altinsoft
else
	sleep 5
	wget -q -c -O result "$apiurl2?cmd=completed&os=$osid&mac=$mac&ospass=$ospass&panelpass=$panelpass&paneluser=altinsoft"
	result=`cat /root/altinsoft/result`;
	if [ "$result" = "ok" ]; then
	sudo echo root:$ospass | chpasswd
	rm -rf /root/altinsoft
	else
    	rm -rf /etc/network/interfaces
	cp /root/altinsoft/interfaces-dhcp /etc/network/interfaces
	systemctl restart networking
	sleep 5
	wget -q -c -O error "$apiurl?cmd=error&os=$osid&mac=$mac&ospass=$ospass&panelpass=$panelpass&paneluser=altinsoft"
	sudo echo root:Arc123// | chpasswd
	fi
fi
