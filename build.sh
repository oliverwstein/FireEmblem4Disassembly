#!/usr/bin/env bash
# Build the Fire Emblem 4 disassembly and check it against the original ROM.
#
# Usage:
#   ./build.sh             build FE4Disassembly.sfc and compare it to fe4.sfc
#   ./build.sh coverage    also report how much of the ROM is built from source
#   ./build.sh pad SECTION N
#                          padding test: also build FE4Padded.sfc with N bytes
#                          inserted at the start of SECTION, and check that its
#                          block moved cleanly (tools/pad_test.py); then run
#                          that ROM to catch the addresses no check can see
#   ./build.sh clean       remove generated files
#
# Needs: python3 with Pillow, 64tass (brew install tass64), tools/c2a.py,
# tools/process_dialogue.py, and a headerless fe4.sfc (Japanese 1.0) in this
# directory.

set -euo pipefail
cd "$(dirname "$0")"

ROOT=$PWD
ROM=fe4.sfc
OUT=FE4Disassembly.sfc
EXPECTED_SHA1=90f0bdeaf0151899f96281258fcb30899fbd0d44
ASFLAGS=(-x -f -C -a -Wall -Wno-portable -Wno-shadow -Wno-deprecated)

clean() {
  find text -name '*.dialogue.txt' -delete
  find data -name '*.csv.asm' -delete
  find gfx \( -name '*.4bpp' -o -name '*.2bpp' \) -delete
  find gfx \( -name '*.4bpp.lz' -o -name '*.bin.lz' -o -name Layout.asm \) -delete
  find audio -name '*.bin.lz' -delete
  rm -f "$OUT" FE4Padded.sfc log.txt labels.txt
}

# Convert dialogue text and CSV tables to assembly. Only files whose source is
# newer than their output are converted.
generate() {
  local font=text/dialogue/DialogueFont.txt t out
  while IFS= read -r t; do
    out=${t%.txt}.dialogue.txt
    if [[ ! -e $out || $t -nt $out || $font -nt $out ]]; then
      python3 tools/process_dialogue.py "$t" "$font" "$out"
    fi
  done < <(find text/dialogue -mindepth 2 -name '*.txt' ! -name '*.dialogue.txt')

  while IFS= read -r t; do
    case $t in
      data/character/CharacterData.csv|data/item/ItemData.csv) continue ;;
    esac
    out=${t%.csv}.csv.asm
    if [[ ! -e $out || $t -nt $out ]]; then
      python3 tools/c2a.py "$t" "$out"
    fi
  done < <(find data -name '*.csv')

  # Graphics: gfx/**/NAME.4bpp.png and NAME.2bpp.png (indexed) to NAME.4bpp, NAME.2bpp.
  while IFS= read -r t; do
    out=${t%.png}
    if [[ ! -e $out || $t -nt $out ]]; then
      python3 tools/gfx.py png2bpp "$t" "$out"
    fi
  done < <(find gfx \( -name '*.4bpp.png' -o -name '*.2bpp.png' \))

  # Compressed graphics: NAME.4bpp to NAME.4bpp.lz, keeping the committed
  # original stream NAME.4bpp.comp while it still decompresses to NAME.4bpp.
  while IFS= read -r t; do
    bpp=${t%.comp}; out=$bpp.lz
    if [[ -e $bpp && ( ! -e $out || $bpp -nt $out || $t -nt $out ) ]]; then
      python3 tools/gfx.py lz "$bpp" "$t" "$out"
    fi
  done < <(find gfx -name '*.4bpp.comp')

  # Other compressed data (tilemaps and the like): NAME.bin to NAME.bin.lz, the
  # same way, keeping NAME.bin.comp while it still decompresses to NAME.bin.
  while IFS= read -r t; do
    bin=${t%.comp}; out=$bin.lz
    if [[ -e $bin && ( ! -e $out || $bin -nt $out || $t -nt $out ) ]]; then
      python3 tools/gfx.py lz "$bin" "$t" "$out"
    fi
  done < <(find gfx audio -name '*.bin.comp')

  # Streams laid out across bank halves: LIST.streams to Layout.asm beside it.
  while IFS= read -r t; do
    python3 tools/stream_layout.py "$t" "$(dirname "$t")/Layout.asm"
  done < <(find gfx -name '*.streams')

  (cd data/character && python3 "$ROOT/tools/FE4c2a.py" CharacterData.csv CharacterDataHelper.h CharacterData.csv.asm)
  (cd data/item && python3 "$ROOT/tools/FE4c2a.py" ItemData.csv ItemDataHelper.h ItemData.csv.asm)
}

assemble() { # assemble <output> <log>
  if ! 64tass "${ASFLAGS[@]}" -o "$1" --vice-labels -l labels.txt build.asm >"$2" 2>&1; then
    grep -iE 'error' "$2" | head -20 >&2
    echo "Assembly failed; see $2" >&2
    exit 1
  fi
}

verify() {
  local sha
  sha=$(shasum -a1 "$OUT" | cut -d' ' -f1)
  if [[ $sha == "$EXPECTED_SHA1" ]]; then
    echo "OK: $OUT matches the original ROM"
  else
    echo "MISMATCH: $OUT differs from the original ROM" >&2
    python3 - "$ROM" "$OUT" <<'EOF' >&2
import sys
a, b = (open(p, 'rb').read() for p in sys.argv[1:3])
if len(a) != len(b):
    print(f"  size differs: original {len(a):,} bytes, built {len(b):,} bytes")
diffs = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
for i in diffs[:10]:
    # HiROM: file offset $XXXXXX is CPU address $C0XXXX-$FFXXXX (code uses the $80-$BF mirror)
    print(f"  {0xC00000 + i:06X}: original {a[i]:02X}, built {b[i]:02X}")
print(f"  {len(diffs):,} bytes differ")
EOF
    exit 1
  fi
}

# Build twice more with the base ROM replaced by $00 and by $FF. Bytes that come
# out the same both times come from source rather than from the base ROM.
coverage() {
  local tmp
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' RETURN
  rsync -a --exclude .git --exclude '*.smc' --exclude "$OUT" ./ "$tmp/src/"
  for fill in 00 FF; do
    python3 -c "open('$tmp/src/$ROM','wb').write(bytes([0x$fill])*0x400000)"
    (cd "$tmp/src" && 64tass "${ASFLAGS[@]}" -o "../$fill.sfc" build.asm >/dev/null 2>&1)
  done
  python3 - "$tmp/00.sfc" "$tmp/FF.sfc" <<'EOF'
import sys
a, b = (open(p, 'rb').read() for p in sys.argv[1:3])
n = sum(x == y for x, y in zip(a, b))
print(f"Coverage: {n:,} of {len(a):,} bytes built from source ({n / len(a) * 100:.2f}%)")
EOF
}

case ${1:-build} in
  clean) clean ;;
  build) [[ -f $ROM ]] || { echo "Missing $ROM" >&2; exit 1; }
         generate; python3 tools/check_paths.py; assemble "$OUT" log.txt; verify ;;
  coverage) [[ -f $ROM ]] || { echo "Missing $ROM" >&2; exit 1; }
         generate; python3 tools/check_paths.py; assemble "$OUT" log.txt; verify; coverage ;;
  pad)   [[ -f $ROM ]] || { echo "Missing $ROM" >&2; exit 1; }
         [[ $# -eq 3 ]] || { echo "Usage: $0 pad SECTION N" >&2; exit 2; }
         generate; python3 tools/check_paths.py; assemble "$OUT" log.txt; verify
         python3 tools/pad_test.py "$2" "$3" -- "${ASFLAGS[@]}" ;;
  *) echo "Usage: $0 [build|coverage|clean|pad SECTION N]" >&2; exit 2 ;;
esac
