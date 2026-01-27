#!/usr/bin/env bash

# Using a temp file to track toggle state since hyprctl returns null for bitdepth
STATE_FILE="/tmp/hypr_hdr_active"

if [ -f "$STATE_FILE" ]; then
    # Switch to SDR
    # We explicitly set bitdepth 8 and disable the flags that trigger the OSD
    hyprctl keyword monitor "DP-3, 3840x2160@240, 0x0, 1, bitdepth, 8"
    rm "$STATE_FILE"
    echo "Mode: SDR"
else
    # Switch to HDR
    # Using your explicit string that works
    #hyprctl keyword monitor "DP-3, 3840x2160@240, 0x0, 1, bitdepth, 10, cm, hdr, sdrbrightness, 1.2"
    hyprctl keyword monitor "DP-3, 3840x2160@240, 0x0, 1, bitdepth, 10, cm, hdr, sdrbrightness, 1.0"

    touch "$STATE_FILE"
    echo "Mode: HDR"
fi
