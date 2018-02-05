#!/bin/sh
LOG=~/update.log 
echo "*** $(date -R) ***" >> $LOG 
sudo apt update && sudo apt -y upgrade >> $LOG && sudo reboot