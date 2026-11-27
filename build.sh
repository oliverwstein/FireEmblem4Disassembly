#!/usr/bin/env bash
# Build the Fire Emblem 4 disassembly and check it against the original ROM.
#
# Usage:
#   ./build.sh             build FE4Disassembly.sfc and compare it to fe4.sfc
#   ./build.sh mod [--disable-checks]
#                          build FE4Disassembly.sfc and update code/header
#                          checksums without comparing to fe4.sfc
#   ./build.sh coverage    also report how much of the ROM is built from source
#   ./build.sh pad SECTION N
#                          padding test: also build FE4Padded.sfc with N bytes
#                          inserted at the start of SECTION, and check that its
#                          block moved cleanly (tools/pad_test.py)
#   ./build.sh test [--full]
#                          run static checks and tool self-tests
#   ./build.sh clean       remove generated files

set -euo pipefail
cd "$(dirname "$0")"
exec python3 build.py "$@"
