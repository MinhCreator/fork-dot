#!/usr/bin/env bash

# чистимо історію і кеш
cliphist wipe
rm -rf /tmp/cliphist/*

# виводимо повідомлення для rofi
echo "✅ history wiped"