#!/bin/bash
  set -e

  SVC_NAME="bgdsvc_dipto"
  ###checking if the user is already created or not. And it is called Idempotency
  if id "$SVC_NAME" &>/dev/null; then
      echo "User $SVC_NAME already exists — skipping"
  else
      sudo useradd -r -m -s /usr/sbin/nologin "$SVC_NAME"
      echo "User $SVC_NAME created"
  fi

  echo "Verifying:"
  id "$SVC_NAME"
  getent passwd "$SVC_NAME"