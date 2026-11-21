  ; The sound data (audio/sound_data.asm; formats in tools/sound.py).

  ; Chunk table flags.
  SOUND_CHUNK_COMPRESSED = $01 ; decompressed into a WRAM buffer before the upload
  SOUND_CHUNK_BUFFER2    = $02 ; that buffer is $7E6358 (last chunk in $0504), not $7E5358 ($0502)
