#!/bin/sh

set -e

BOARD_DIR="$(dirname $0)"

cp -r "$BOARD_DIR"/skeleton/* "$TARGET_DIR"

OTTERCAST_CONFFILE="$BINARIES_DIR"/config.ini

if ! [ -f "$OTTERCAST_CONFFILE" ]; then
	touch "$OTTERCAST_CONFFILE"
fi

cd "$TARGET_DIR"

ln -fs /usr/lib/systemd/system/ifplugd\@.service \
	"$TARGET_DIR"/usr/lib/systemd/system/multi-user.target.wants/ifplugd\@eth0.service

mkdir -p "$TARGET_DIR"/root/.ssh
ln -fsr mnt/ssh_authorized_keys "$TARGET_DIR"/root/.ssh/authorized_keys

# Environment for Snapclient (written by Ottercast-Webinterface/apply_config.php)
ln -fsr tmp/snapclient_env "$TARGET_DIR"/etc/default/snapclient

ln -fsr tmp/resolv.conf "$TARGET_DIR"/etc/resolv.conf

ln -fsr tmp/hostname "$TARGET_DIR"/etc/hostname
ln -fsr tmp/hosts "$TARGET_DIR"/etc/hosts
touch "$TARGET_DIR"/tmp/hosts

ln -fsr tmp/default.pa "$TARGET_DIR"/etc/pulse/default.pa
ln -fsr tmp/daemon.conf "$TARGET_DIR"/etc/pulse/daemon.conf

mkdir -p "$TARGET_DIR"/root/.config/pulse
mkdir -p "$TARGET_DIR"/var/lib/pulse
mkdir -p "$TARGET_DIR"/var/lib/systemd/timesync
