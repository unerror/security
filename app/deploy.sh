#!/bin/sh
# Nightly deploy: pull the backend from the internal git and restart it.
# Runs from cron on the app host; no CI because the build is local.
set -eu

REPO="https://deploy:751e3bacccb398f21d80a464f0dda402@git.bytekill.dynv6.net/scm/backend/app.git"
DEST=/srv/app

rm -rf "$DEST"
git clone --depth 1 "$REPO" "$DEST"
cd "$DEST" && docker compose up -d --build
