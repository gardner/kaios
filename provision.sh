#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# BEGIN apt-fast bullshit
/bin/bash -c "$(curl -sL https://git.io/vokNn)"

cat << EOF > /etc/apt-fast.conf
DOWNLOADBEFORE=true
_MAXNUM=5
_MAXCONPERSRV=10
_SPLITCON=8
_MINSPLITSZ=1M
MIRRORS=( 'http://archive.ubuntu.com/ubuntu, http://ubuntu.mirrors.theom.nz/ubuntu, http://ftp.citylink.co.nz/ubuntu, http://mirror.fsmg.org.nz/ubuntu, http://ucmirror.canterbury.ac.nz/ubuntu' )
EOF

echo debconf apt-fast/maxdownloads string 16 | debconf-set-selections
echo debconf apt-fast/dlflag boolean true | debconf-set-selections
echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections
# END apt-fast bullshit

apt-fast update
apt-fast install -y ubuntu-gnome-desktop htop virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms

# Download the KaiOS development environment
aria2c -x4 "https://developer.kaiostech.com/simulator/linux"
tar jxvf *.tar.bz2
cd kaiosrt*
tar jxvf *.tar.bz2
mv kaiosrt /home/vagrant/

# Make an auto-start link
mkdir -p /home/vagrant/.config/autostart/
cat << EOF > /home/vagrant/.config/autostart/KaiOS.desktop
[Desktop Entry]
Type=Application
Exec=/home/vagrant/kaiosrt/kaiosrt
Hidden=false
X-GNOME-Autostart-enabled=true
Name=kaiosrt
Comment=KaiOS Development
EOF
gio set /home/vagrant/.config/autostart/KaiOS.desktop "metadata::trusted" yes

# Enable automatic login
sed -i 's/.*AutomaticLoginEnable.*/AutomaticLoginEnable = true/' /etc/gdm3/custom.conf
sed -i 's/.*AutomaticLogin = user1/AutomaticLogin = vagrant/' /etc/gdm3/custom.conf

# Reboot to start the window manager
sudo reboot
