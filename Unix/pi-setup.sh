#!/bin/sh

sudo apt update
sudo apt  -y upgrade
sudo apt -y install at screen rpi-connect nmon

ssh-keygen -b 2048