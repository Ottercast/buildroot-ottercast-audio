#!/bin/sh

set -e

BOARD_DIR="$(dirname $0)"

cp -r "$BOARD_DIR"/skeleton/* "$TARGET_DIR"


OTTERCAST_CONFFILE="$BINARIES_DIR"/config.sh

if ! [ -f "$OTTERCAST_CONFFILE" ]; then
	touch "$OTTERCAST_CONFFILE"
fi
