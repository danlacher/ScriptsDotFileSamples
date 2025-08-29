#!/usr/bin/python
# -*- coding:utf-8 -*-
import sys
import os
import netifaces
import time

picdir = os.path.join(os.path.dirname(os.path.dirname(os.path.realpath(__file__))), 'pic')
libdir = os.path.join(os.path.dirname(os.path.dirname(os.path.realpath(__file__))), 'lib')
if os.path.exists(libdir):
    sys.path.append(libdir)

import logging
from waveshare_epd import epd2in13_V4
from PIL import Image,ImageDraw,ImageFont
import traceback

#logging.basicConfig(level=logging.DEBUG)

# Declare IP Address
wlan0_ip_address = 'null'
wlan0_ip_address_old = 'null'
eth0_ip_address = 'null'
eth0_ip_address_old = 'null'

def check_ping(hostname):
    response = os.system("ping -c 1 " + hostname)
    if response == 0:
        pingstatus = hostname + " reachable" 
    else:
        pingstatus = hostname + " un-reachable" 
    return pingstatus


# Function to fetch IP Address
def Get_IP(eth):
    ip = '0.0.0.0'

    # Get interfaces in case they change
    interfaces = netifaces.interfaces()
    
    if eth == 'wlan0':
        if "wlan0" in interfaces:
            if len(netifaces.ifaddresses('wlan0')) > 1:
                ip = netifaces.ifaddresses('wlan0')[netifaces.AF_INET][0]['addr']
    if eth == 'eth0':
        if "eth0" in interfaces:
            if len(netifaces.ifaddresses('eth0')) > 1:
                ip = netifaces.ifaddresses('eth0')[netifaces.AF_INET][0]['addr']
    
    return ip

def Refresh_Display(epd, wlan0, eth0, check):
    epd.init()
    image = Image.new('1', (epd.height, epd.width), 255)  # 255: clear the frame
    draw = ImageDraw.Draw(image)
    draw.text((0, 0), 'dan@danlacher.com', font = font15, fill = 0)
    draw.text((0, 15), '+1.989.859.3642', font = font15, fill = 0)
    draw.text((0, 45), 'wlan0: ' + wlan0, font = font15, fill = 0)
    draw.text((0, 60), 'eth0: ' + eth0, font = font15, fill = 0)
    draw.text((0, 80), check, font = font15, fill = 0)
    draw.text((190, 0), time.strftime('%H:%M:%S'), font = font15, fill = 0)
    image = image.rotate(180) # rotate
    #epd.display(epd.getbuffer(image))
    return image

try:
    #logging.info("epd2in13_V4 Demo")

    epd = epd2in13_V4.EPD()
    #logging.info("init and Clear")
    epd.init()
    epd.Clear(0xFF)

    # Drawing on the image
    font12 = ImageFont.truetype(os.path.join(picdir, 'Font.ttc'), 12)
    font15 = ImageFont.truetype(os.path.join(picdir, 'Font.ttc'), 15)
    font24 = ImageFont.truetype(os.path.join(picdir, 'Font.ttc'), 24)

    epd.display(epd.getbuffer(Refresh_Display(epd, wlan0_ip_address, eth0_ip_address, check_ping('8.8.8.8'))))
    time.sleep(5)

    while (True):
        # Get current IP address
        wlan0_ip_address = Get_IP('wlan0')
        eth0_ip_address = Get_IP('eth0')

        # Compare IP address since last check
        if (wlan0_ip_address != wlan0_ip_address_old) or (eth0_ip_address != eth0_ip_address_old):
            wlan0_ip_address_old = wlan0_ip_address
            eth0_ip_address_old = eth0_ip_address
            epd.display(epd.getbuffer(Refresh_Display(epd, wlan0_ip_address, eth0_ip_address, check_ping('8.8.8.8'))))

        time.sleep(5)

    #logging.info("Clear...")
    epd.init()
    epd.Clear(0xFF)

    #logging.info("Goto Sleep...")
    epd.sleep()

except IOError as e:
    logging.info(e)

except KeyboardInterrupt:
    #logging.info("ctrl + c:")
    epd.init()
    epd.Clear(0xFF)
    epd.sleep()
    epd2in13_V4.epdconfig.module_exit(cleanup=True)
    exit()

# https://pypi.org/project/netifaces/
