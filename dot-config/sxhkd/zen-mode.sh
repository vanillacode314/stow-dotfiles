#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

if [ ! -e "$SCRIPT_DIR"/state/zen_mode ]; then
  echo 0 >"$SCRIPT_DIR"/state/zen_mode
fi

ZEN_MODE=$(cat "$SCRIPT_DIR"/state/zen_mode)

if [ "$ZEN_MODE" -eq 0 ]; then
  bspc config border_width >"$SCRIPT_DIR"/state/border_width
  bspc config bottom_padding >"$SCRIPT_DIR"/state/bottom_padding
  bspc config top_padding >"$SCRIPT_DIR"/state/top_padding
  bspc config window_gap >"$SCRIPT_DIR"/state/window_gap
  bspc config border_width 0
  bspc config bottom_padding 0
  bspc config top_padding 0
  bspc config window_gap 0
  echo 1 >"$SCRIPT_DIR"/state/zen_mode
else
  bspc config border_width "$(cat "$SCRIPT_DIR"/state/border_width)"
  bspc config bottom_padding "$(cat "$SCRIPT_DIR"/state/bottom_padding)"
  bspc config top_padding "$(cat "$SCRIPT_DIR"/state/top_padding)"
  bspc config window_gap "$(cat "$SCRIPT_DIR"/state/window_gap)"
  echo 0 >"$SCRIPT_DIR"/state/zen_mode
fi
