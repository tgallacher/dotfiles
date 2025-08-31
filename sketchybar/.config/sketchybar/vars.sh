#!/usr/bin/env bash
# shellcheck disable=2034

## Misc ##
PADDINGS=3
RADIUS=0

## FONTS ##
NERD_FONT="Monaspace Krypton NF" # Needs to have Regular, Bold, Semibold, Heavy and Black variants
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

COLOR_BAR=0xff1D2021
COLOR_BG=0xff504945
COLOR_DLABEL=0xffd4be98 # Default label colour
COLOR_DICON=0xffd4be98 # Default icon colour

COLOR_PRIMARY=0xffe78a4e
COLOR_SECONDARY=0xff89b482
COLOR_TERTIARY=0xfff7daea3

COLOR_SUCCESS=0xffa9b665
COLOR_ERROR=0xffea6962
COLOR_WARNING=0xffda8657
COLOR_INFORMATION=0xffffffff

COLOR_WHITE=0xffffffff
COLOR_TRANSPARENT=0x00000000
