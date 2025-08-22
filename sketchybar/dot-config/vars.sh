#!/usr/bin/env bash

## Misc ##
PADDINGS=3
RADIUS=0

## FONTS ##
NERD_FONT="JetBrainsMono Nerd Font" # Needs to have Regular, Bold, Semibold, Heavy and Black variants
SKETCHYAPP_FONT="sketchybar-app-font"
SF_FONT="SF Pro"

## COLORS ##
getOpacity()
             {
  opacity=$1

  local o100=0xff
  local o75=0xbf
  local o50=0x80
  local o25=0x40
  local o10=0x1a
  local o0=0x00

  case $opacity in
    75) local opacity=$o75 ;;
    50) local opacity=$o50 ;;
    25) local opacity=$o25 ;;
    10) local opacity=$o10 ;;
    0) local opacity=$o0 ;;
    *) local opacity=$o100 ;;
  esac

  echo "$opacity"
}

COLOR_BAR="$(getOpacity 75)292c36"
COLOR_BG=0xff474160
COLOR_DLABEL=0xffd8d8d8 # Default label colour
COLOR_DICON=0xffd8d8d8 # Default icon colour

COLOR_PRIMARY=0xffb74989 # mauve
COLOR_SECONDARY=0xffe8e8e8 # rosewater
COLOR_TERTIARY=0xfff8f8f8 # lavendar

COLOR_SUCCESS=0xff95c76f
COLOR_ERROR=0xfff84547
COLOR_WARNING=0xffefa16b
COLOR_INFORMATION=0xff64878f

COLOR_WHITE=0xffffffff
COLOR_TRANSPARENT=0x00000000
