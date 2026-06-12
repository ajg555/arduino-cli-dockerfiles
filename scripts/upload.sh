#!/bin/bash

if [ -z "$1" ]; then
   CODE_DIR="."
else
   CODE_DIR="$1"
fi

arduino-cli compile -b "$BOARD" "$CODE_DIR" && \
arduino-cli upload -b "$BOARD" -p "$PORT" "$CODE_DIR"
