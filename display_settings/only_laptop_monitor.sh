#!/bin/sh
xrandr --output DVI-I-1-1 --off --output DP-1 --off --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off

xset r rate 300 50
/home/andre/lxlayout.sh
