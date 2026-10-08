swayidle -w \
    timeout 150 'brightnessctl -s set 10 && brightnessctl -d 'platform::kbd_backlight' set 0' \
        resume 'brightnessctl -r && brightnessctl -rd 'platform::kbd_backlight'' \
    timeout 300 'pidof hyprlock || hyprlock' \
    timeout 330 'wlopm --off \*' \
        resume 'wlopm --on \* && brightnessctl -r' \
    lock 'pidof hyprlock || hyprlock' \
    before-sleep 'loginctl lock-session' \
    after-resume 'wlopm --on \*'