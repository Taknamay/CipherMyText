#!/usr/bin/env sh

set -e

LIB_TARGET="/usr/local/lib/automytext/"
BIN_TARGET="/usr/local/bin/"
APPLICATION_DIR="/usr/share/applications/"

rm $LIB_TARGET/icon.svg
rmdir $LIB_TARGET
rm $BIN_TARGET/automytext
