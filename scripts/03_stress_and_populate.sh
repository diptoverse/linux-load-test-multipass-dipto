#!/bin/bash

set -e

SVC_NAME="bgdsvc_dipto"
MOUNT_POINT="/mnt/${SVC_NAME}_tmp"

case "$1" in

  --cpu)
    echo
    echo "/-- CPU TEST --/"
    echo

    cd "$MOUNT_POINT"
    sudo -u "$SVC_NAME" stress-ng --cpu 2 --timeout 30s

    echo
    echo "/-- CPU TEST DONE & RESULT --/"
    echo

    top -b -n 1 | head -n 5
    ;;

  --mem)
    echo
    echo "/-- MEMORY TEST --/"
    echo

    cd "$MOUNT_POINT"
    sudo -u "$SVC_NAME" stress-ng \
      --vm 1 \
      --vm-bytes 200M \
      --timeout 30s

    echo
    echo "/-- MEMORY TEST DONE & RESULT --/"
    echo

    free -h
    ;;

  --disk)
    echo
    echo "/-- DISK TEST --/"
    echo

    for i in $(seq 1 20); do
      dd if=/dev/urandom \
        of="${MOUNT_POINT}/file_$i.dat" \
        bs=1M count=10

      df -h "$MOUNT_POINT"
    done

    echo
    echo "/-- DISK TEST DONE & RESULT --/"
    echo

    df -h "$MOUNT_POINT"
    ;;

  --all)
    echo
    echo "/-- CURRENT STATUS --/"
    echo

    echo "Memory:"
    free -h

    echo
    echo "CPU:"
    top -b -n 1 | head -n 5

    echo
    echo "Disk:"
    df -h "$MOUNT_POINT"

    echo
    echo "/-- ALL TESTING STARTED --/"
    echo

    cd "$MOUNT_POINT"
    sudo -u "$SVC_NAME" stress-ng \
      --cpu 2 \
      --vm 1 \
      --vm-bytes 200M \
      --timeout 30s

    for i in $(seq 21 50); do
      dd if=/dev/urandom \
        of="${MOUNT_POINT}/file_$i.dat" \
        bs=1M count=10 || true

      df -h "$MOUNT_POINT"
    done

    echo
    echo "/-- ALL TESTING DONE & FINAL RESULT --/"
    echo

    echo "Memory:"
    free -h

    echo
    echo "CPU:"
    top -b -n 1 | head -n 5

    echo
    echo "Disk:"
    df -h "$MOUNT_POINT"
    ;;

  *)
    echo "Usage: $0 {--cpu|--mem|--disk|--all}"
    exit 1
    ;;

esac