#!/bin/bash
# Script to change the desktop background when switching workspaces.
# compiled from various sources
 
F=$0
 
OLD_DESK="x"
OLD_IMG="x"
 
xprop -root -spy _NET_CURRENT_DESKTOP | (
   while read -r; do
      # Getting the desktop and wallpaper
      DESK=${REPLY:${#REPLY}-1:1}
      IMG=$(gsettings get org.mate.background picture-filename)
 
      # Init last desktop and wallpaper
      if [ "$OLD_DESK" == "x" ]
      then
          OLD_DESK=$DESK
          OLD_IMG=$IMG
      fi
 
      # If it has been wallpaper has been changed then we save it
        [ -e $F.$OLD_DESK ] && \
        [ $DESK != $OLD_DESK ] && \
        [ $IMG != $(<$F.$OLD_DESK) ] && \
           echo $IMG > $F.$OLD_DESK 
   
 
      # If there is no wallpaper saved then we save it, else we change it
      if [ ! -e $F.$DESK ]
      then
         echo $IMG >$F.$DESK
      else
         gsettings set org.mate.background picture-filename $(<$F.$DESK)
      fi
 
      # Getting the last desktop and wallpaper
      OLD_IMG=$IMG
      OLD_DESK=$DESK
 
   done
   )
