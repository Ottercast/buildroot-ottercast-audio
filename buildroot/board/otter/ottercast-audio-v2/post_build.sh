#!/bin/sh

set -e

BOARD_DIR="$(dirname $0)"

cp -r "$BOARD_DIR"/skeleton/* "$TARGET_DIR"
