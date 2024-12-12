#!/bin/sh

sudo apt update
sudo apt -y upgrade
sudo apt -y install at screen rpi-connect nmon stress

ssh-keygen -b 4096