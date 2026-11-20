   
  structDecompressionEntry .struct
    Source  .long ? ; $00
    Dest    .long ? ; $03
  .endstruct

  ; An entry for rlHandleMapMenuDecompressionDMA: Count bytes to VRAM at
  ; Destination from Source, which is a stream for rlDecompressor if Compressed
  ; (decompressed to aDecompressionBuffer first) or the data itself if not.
  structDecompressionDMAEntry .struct Source, Count, Destination, Compressed=true
    Count       .word \Count
    Destination .word \Destination
    Compressed  .byte int(\Compressed)
    Source      .long \Source
  .endstruct
