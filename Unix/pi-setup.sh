#!/bin/sh

sudo apt update
sudo apt -y upgrade
sudo apt -y install at screen rpi-connect nmon stress pigz git
sudo apt -y autoremove

ssh-keygen -b 4096

rpi-connect on
rpi-connect signin
rpi-connect status

mkdir GitHub
cd GitHub
git clone https://github.com/danlacher/ScriptsDotFileSamples