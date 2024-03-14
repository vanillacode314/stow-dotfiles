#! /bin/sh

device_name=$1
upower --dump | awk "/$device_name/{found=NR+8} found && NR==found" | cut -d: -f2 | tr -d '[:space:]%'
