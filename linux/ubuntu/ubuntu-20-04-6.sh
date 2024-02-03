# Post-installation script
d-i preseed/late_command string \
    in-target wget -O /root/post-install-script.sh https://raw.githubusercontent.com/altinsoft/public-repo/main/linux/ubuntu/ubuntu-20-04-6.sh; \
    in-target chmod +x /root/post-install-script.sh; \
    in-target /root/post-install-script.sh
