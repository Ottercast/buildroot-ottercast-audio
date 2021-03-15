#!/bin/sh

set -e

BOARD_DIR="$(dirname $0)"

cp -r "$BOARD_DIR"/skeleton/* "$TARGET_DIR"


OTTERCAST_CONFFILE="$BINARIES_DIR"/config.sh

if ! [ -f "$OTTERCAST_CONFFILE" ]; then
	touch "$OTTERCAST_CONFFILE"
fi

ln -fs /usr/lib/systemd/system/ifplugd\@.service \
	"$TARGET_DIR"/usr/lib/systemd/system/multi-user.target.wants/ifplugd\@eth0.service
