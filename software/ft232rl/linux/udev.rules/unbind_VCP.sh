#!/bin/sh

sudo cp -fv usbftdi.sh /usr/local/bin/usbftdi.sh
sudo cp -fv 99-usbftdi.rules /etc/udev/rules.d/99-usbftdi.rules
sudo cp -fv usbftdi.service /etc/systemd/system/usbftdi.service
sudo udevadm control --log-priority=debug
sudo udevadm control --reload-rules
sudo udevadm control --reload
sudo service udev restart
sudo udevadm trigger
#sudo systemctl restart udev.service
#sudo systemctl restart systemd-udevd.service
#read _

#udevadm monitor --environment
#systemctl status systemd-udevd.service
#journalctl -xe

#/sbin/modprobe -vrf ftdi-sio
#/sbin/modprobe -v ftdi-sio

#lsmod | grep -a "ftdi_sio"
