#!/usr/bin/env bash
set -euo pipefail

if [ ! -f external/string-machine/patch.stamp ]; then
  patch -d external/string-machine -i ../../aap-support.patch -p1
  touch external/string-machine/patch.stamp
fi

if [ ! -e app/src/main/cpp ]; then
  ln -s ../../../external/string-machine app/src/main/cpp
fi
