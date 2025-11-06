#!/bin/bash
layout=$(hyprctl getoption keyboard.layout 2>/dev/null)
case "$layout" in
  us) echo "EN" ;;
  ua) echo "UA" ;;
  ru) echo "RU" ;;
  *) echo "$layout" ;;
esac