#!/usr/bin/env bash

options="Connect\nDisconnect\nWiFi On\nWiFi Off"

action=$(echo -e "$options" | \
wofi --dmenu --normal-window -p "Network")

iface=$(nmcli -t -f DEVICE,TYPE dev status | grep wifi | cut -d: -f1)

case "$action" in
  Connect)
    nmcli -f IN-USE,SSID,SIGNAL,SECURITY dev wifi list | tail -n +2 | \
    wofi --dmenu --normal-window -p "Select SSID" | \
    sed 's/^\* //; s/^  //' | \
    xargs nmcli dev wifi connect
    ;;
  Disconnect)
    nmcli dev disconnect "$iface"
    ;;
  "WiFi On")
    nmcli radio wifi on
    ;;
  "WiFi Off")
    nmcli radio wifi off
    ;;
esac