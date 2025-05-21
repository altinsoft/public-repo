#!/bin/bash
systemctl stop stats.service
rm -rf /usr/local/bin/stats.s
rm -rf /etc/systemd/system/stats.service
systemctl daemon-reload

URL="https://raw.githubusercontent.com/altinsoft/public-repo/main/stats.sh"
DOWNLOAD_PATH="/usr/local/bin/stats.sh"
SERVICE_FILE="/etc/systemd/system/stats.service"
wget -O $DOWNLOAD_PATH $URL
chmod +x $DOWNLOAD_PATH
cat << EOF > $SERVICE_FILE
[Unit]
Description=Linux Statistics service

[Service]
ExecStart=$DOWNLOAD_PATH

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable stats.service
systemctl start stats.service
systemctl status stats.service

echo "stats.sh servisi başarıyla oluşturuldu ve başlatıldı."
