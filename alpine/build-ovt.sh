#!/bin/sh
# VGAuth'lu open-vm-tools apk'sini Alpine'da derleyip imzalar ve repoya yazar.
# GitHub Actions tarafindan `docker run alpine:<surum> /work/alpine/build-ovt.sh`
# ile cagrilir. Ortam: $AV = Alpine surumu (3.23), $SIGN_KEY = imza ozel anahtari
# (GH secret), /work = repo checkout. Imza ozel anahtari HICBIR yerde commit
# EDILMEZ; yalniz CI calismasinda bellekte bulunur.
#
# Neden: Alpine stock open-vm-tools --without-pam --without-xerces ile derlenir,
# VGAuthService ICERMEZ. service-app VDS provision'i guest islemleri icin
# SAML/VGAuth gerektirir. Burada xmlsec1+pam acik + 2 musl yamasiyla yeniden
# derliyoruz (pkgrel=100 → stock r1'i gecer).
set -e

apk add alpine-sdk git

# Imza anahtarini secret'tan yaz; pubkey'i repodan bul (yeni surum dizini henuz
# pubkey icermiyorsa mevcut herhangi birinden kopyala).
mkdir -p /root/.abuild /etc/apk/keys
printf '%s' "$SIGN_KEY" > /root/.abuild/builder-6a18ae52.rsa
PUB="$(find /work/alpine -name 'builder-6a18ae52.rsa.pub' | head -1)"
cp "$PUB" /etc/apk/keys/
cp "$PUB" /root/.abuild/
echo 'PACKAGER_PRIVKEY="/root/.abuild/builder-6a18ae52.rsa"' > /root/.abuild/abuild.conf

# Aport'u al + vgauth'u ac
cd /root
git clone --depth 1 --filter=blob:none --sparse https://gitlab.alpinelinux.org/alpine/aports.git
cd aports && git sparse-checkout set community/open-vm-tools && cd community/open-vm-tools
sed -i 's|openssl-dev>3|openssl-dev>3 linux-pam-dev xmlsec-dev libxml2-dev|' APKBUILD
sed -i '/--without-pam/d; /--without-xerces/d' APKBUILD
sed -i '/rm -Rf .*etc\/pam.d/d' APKBUILD
sed -i 's|^pkgrel=.*|pkgrel=100|' APKBUILD
# 2 musl yamasi (Alpine vgauth kapali oldugu icin yamamamis) — prepare() override
cat >> APKBUILD <<'EOF'
prepare() {
	default_prepare
	cd open-vm-tools
	sed -i 's|<sys/unistd.h>|<unistd.h>|g' vgauth/lib/netPosix.c vgauth/serviceImpl/netPosix.c
	sed -i 's|__uint32_t|uint32_t|g; s|__uint64_t|uint64_t|g' vgauth/common/vmxrpc.c
	autoreconf -vif
}
EOF

# Root olarak derle (-F), apk + signed APKINDEX uretilir
abuild -F -r

# Yayinlanacak paketleri repoya stage et + temiz imzali index uret
ARCH="$(apk --print-arch)"
SRC="/root/packages/community/$ARCH"
MAIN="$(ls "$SRC"/open-vm-tools-[0-9]*.apk | head -1)"
VR="$(basename "$MAIN" | sed 's|^open-vm-tools-||; s|\.apk$||')"   # ornek: 13.0.0-r100
DEST="/work/alpine/v$AV/$ARCH"
mkdir -p "$DEST"
rm -f "$DEST"/*.apk "$DEST"/APKINDEX.tar.gz
for p in open-vm-tools open-vm-tools-guestinfo open-vm-tools-vix open-vm-tools-timesync \
         open-vm-tools-vmbackup open-vm-tools-hgfs open-vm-tools-deploypkg \
         open-vm-tools-plugins-all open-vm-tools-openrc; do
	cp "$SRC/${p}-${VR}.apk" "$DEST/"
done
cd "$DEST"
apk index -o APKINDEX.tar.gz *.apk
abuild-sign APKINDEX.tar.gz
# Yeni surum dizini icin pubkey'i seed et (mevcut surumde $PUB zaten ayni dosya).
DSTPUB="/work/alpine/v$AV/builder-6a18ae52.rsa.pub"
[ "$PUB" = "$DSTPUB" ] || cp "$PUB" "$DSTPUB"
echo "DONE: surum=$VR hedef=$DEST"
