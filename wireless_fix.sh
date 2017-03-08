# Author: Pedro Dousseau
# Description: Example of how to fix wifi bug on linux running on top of Macbook Pro 2013


#### SOLVE WITH B43 #######
#install drivers
sudo apt-get install b43-fwcutter firmware-b43-installer
#disable wl if exists
sudo rmmod wl
#activate b43 driver
sudo modprobe b43

####### SOLVE WITH WL ###########
sudo apt-get install  bcmwl-kernel-source
modprobe wl
