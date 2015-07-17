#!/usr/bin/env sh

set -e

LIB_TARGET="/usr/local/lib/automytext/"
BIN_TARGET="/usr/local/bin/"
APPLICATION_DIR="/usr/share/applications/"

if [ ! -d "$LIB_TARGET" ]; then
  mkdir $LIB_TARGET
fi

sh build.sh
cp icon.svg $LIB_TARGET
cp build/automytext $BIN_TARGET
