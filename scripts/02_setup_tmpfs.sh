#!/bin/bash
set -e

SVC_NAME="bgdsvc_dipto"
MOUNT_POINT="/mnt/${SVC_NAME}_tmp"

if findmnt "$MOUNT_POINT" > /dev/null 2>&1; then
echo "tmpfs already mounted at $MOUNT_POINT, skipping."
else
mkdir -p "$MOUNT_POINT"
mount -t tmpfs -o size=256M tmpfs "$MOUNT_POINT"
chown "$SVC_NAME:$SVC_NAME" "$MOUNT_POINT"
echo "tmpfs mounted at $MOUNT_POINT"
fi

echo "Verifying:"
df -h "/mnt/${SVC_NAME}_tmp"