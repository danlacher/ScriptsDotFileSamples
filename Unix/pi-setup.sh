#!/bin/sh

sudo apt update
sudo apt -y upgrade
sudo apt -y full-upgrade
sudo apt -y install at screen rpi-connect nmon stress pigz git nmap
sudo apt -y autoremove

ssh-keygen -b 4096

rpi-connect on
rpi-connect signin
rpi-connect status

mkdir GitHub
cd GitHub
git clone https://github.com/danlacher/ScriptsDotFileSamples


# kali
# sudo apt -y install nmap legion kali-linux-default