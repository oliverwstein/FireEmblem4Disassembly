; The sound data: everything the sound loader reads, from aSoundHeader to the
; end of the ROM. Written by tools/sound.py, which describes the formats; the
; flags are in include/Sound.h. Chunks and the SPC driver are files in audio/.
; The macros are here, not in include/, because 64tass opens a file named in
; a macro relative to the file that defines the macro.

  ; A chunk table entry: where the chunk is (address, then its bank relative to
  ; aSoundHeader's), its size (decompressed, if compressed), the SPC address
  ; to upload it to (0: after the previous chunk) and the flags.
  soundChunk .macro Data, Size, Dest, Flags
    .word <>\Data
    .byte (`\Data) - (`aSoundHeader)
    .word \Size, \Dest
    .byte \Flags
  .endmacro

  ; A file in the sound data, which the sound code reads straight across bank
  ; boundaries. A file that reaches one is written in two parts with the
  ; program counter set again in between; that only quiets 64tass's warning
  ; about the program counter crossing a bank. It still warns once at the
  ; .dsection and once at the .here in build.asm, since the block as a whole
  ; spans banks $F7-$FF, which is what the sound code expects.
  soundBinary .macro File
    _Data := binary(\File)
    _Room := $10000 - (* & $FFFF)
    .if len(_Data) > _Room
      .text _Data[:_Room]
      * := *
      .text _Data[_Room:]
    .else
      .text _Data
    .endif
    .if (* & $FFFF) == 0
      * := *
    .endif
  .endmacro

    .section SoundDataSection

      aSoundHeader .block ; F7/7C00
        Driver         .word <>aSoundDriver
                       .byte (`aSoundDriver) - (`aSoundHeader), 0
        Scripts        .word <>aSoundScripts
        ScriptData     .word <>aSoundScriptF7957E
        UploadLists    .word <>aSoundUploadLists
        UploadData     .word <>aSoundUploadF79C62
        Chunks         .word <>aSoundChunks
        StartUpload    .word <>aSoundStartUpload
        DriverID       .word <>aSoundDriverID
        Unknown12      .word <>aSoundUnknownF7AD9C
        TerrainUploads .word <>aSoundTerrainUploads
      .endblock

      aSoundChunks ; F7/7C16

        ; label, size, SPC address (0: after the previous chunk), flags; chunk ID in the comment
        .soundChunk aSoundChunk064, $00F1, $D400, SOUND_CHUNK_COMPRESSED ; $064
        .soundChunk aSoundChunk065, $0E90, $C500, SOUND_CHUNK_COMPRESSED ; $065
        .soundChunk aSoundChunk066, $0E94, $C500, SOUND_CHUNK_COMPRESSED ; $066
        .soundChunk aSoundChunk067, $0D0A, $C500, SOUND_CHUNK_COMPRESSED ; $067
        .soundChunk aSoundChunk068, $0A1A, $C500, SOUND_CHUNK_COMPRESSED ; $068
        .soundChunk aSoundChunk069, $0BF6, $C500, SOUND_CHUNK_COMPRESSED ; $069
        .soundChunk aSoundChunk06A, $0B11, $C500, SOUND_CHUNK_COMPRESSED ; $06A
        .soundChunk aSoundChunk06B, $0BA1, $C500, SOUND_CHUNK_COMPRESSED ; $06B
        .soundChunk aSoundChunk06C, $092C, $C500, SOUND_CHUNK_COMPRESSED ; $06C
        .soundChunk aSoundChunk06D, $0B4F, $C500, SOUND_CHUNK_COMPRESSED ; $06D
        .soundChunk aSoundChunk06E, $0A21, $C500, SOUND_CHUNK_COMPRESSED ; $06E
        .soundChunk aSoundChunk06F, $0A73, $C500, SOUND_CHUNK_COMPRESSED ; $06F
        .soundChunk aSoundChunk070, $0F90, $C500, SOUND_CHUNK_COMPRESSED ; $070
        .soundChunk aSoundChunk071, $0901, $C500, SOUND_CHUNK_COMPRESSED ; $071
        .soundChunk aSoundChunk072, $0AEE, $C500, SOUND_CHUNK_COMPRESSED ; $072
        .soundChunk aSoundChunk073, $0A89, $C500, SOUND_CHUNK_COMPRESSED ; $073
        .soundChunk aSoundChunk074, $07F9, $C500, SOUND_CHUNK_COMPRESSED ; $074
        .soundChunk aSoundChunk075, $0AD5, $C500, SOUND_CHUNK_COMPRESSED ; $075
        .soundChunk aSoundChunk076, $096D, $C500, SOUND_CHUNK_COMPRESSED ; $076
        .soundChunk aSoundChunk077, $08F2, $C500, SOUND_CHUNK_COMPRESSED ; $077
        .soundChunk aSoundChunk078, $0ADA, $C500, SOUND_CHUNK_COMPRESSED ; $078
        .soundChunk aSoundChunk079, $0D68, $C500, SOUND_CHUNK_COMPRESSED ; $079
        .soundChunk aSoundChunk07A, $09B3, $C500, SOUND_CHUNK_COMPRESSED ; $07A
        .soundChunk aSoundChunk07B, $0EDF, $C500, SOUND_CHUNK_COMPRESSED ; $07B
        .soundChunk aSoundChunk07C, $09A5, $C500, SOUND_CHUNK_COMPRESSED ; $07C
        .soundChunk aSoundChunk07D, $05F9, $C500, SOUND_CHUNK_COMPRESSED ; $07D
        .soundChunk aSoundChunk07E, $066D, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $07E
        .soundChunk aSoundChunk07F, $06FC, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $07F
        .soundChunk aSoundChunk080, $028D, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $080
        .soundChunk aSoundChunk081, $04BF, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $081
        .soundChunk aSoundChunk082, $02E8, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $082
        .soundChunk aSoundChunk083, $04A5, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $083
        .soundChunk aSoundChunk084, $0A14, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $084
        .soundChunk aSoundChunk085, $0263, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $085
        .soundChunk aSoundChunk086, $02F7, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $086
        .soundChunk aSoundChunk087, $03F2, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $087
        .soundChunk aSoundChunk088, $0CB0, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $088
        .soundChunk aSoundChunk089, $0323, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $089
        .soundChunk aSoundChunk08A, $02C8, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08A
        .soundChunk aSoundChunk08B, $02E6, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08B
        .soundChunk aSoundChunk08C, $0C83, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08C
        .soundChunk aSoundChunk08D, $0353, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08D
        .soundChunk aSoundChunk08E, $0388, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08E
        .soundChunk aSoundChunk08F, $0585, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08F
        .soundChunk aSoundChunk090, $0489, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $090
        .soundChunk aSoundChunk091, $03C7, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $091
        .soundChunk aSoundChunk092, $0353, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $092
        .soundChunk aSoundChunk093, $040B, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $093
        .soundChunk aSoundChunk094, $075B, $C500, SOUND_CHUNK_COMPRESSED ; $094
        .soundChunk aSoundChunk095, $173C, $BC00, SOUND_CHUNK_COMPRESSED ; $095
        .soundChunk aSoundChunk096, $0A09, $C500, SOUND_CHUNK_COMPRESSED ; $096
        .soundChunk aSoundChunk097, $1DC2, $B500, SOUND_CHUNK_COMPRESSED ; $097
        .soundChunk aSoundChunk098, $181F, $B500, SOUND_CHUNK_COMPRESSED ; $098
        .soundChunk aSoundChunk099, $0A94, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $099
        .soundChunk aSoundChunk09A, $05C5, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09A
        .soundChunk aSoundChunk09B, $051C, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09B
        .soundChunk aSoundChunk09C, $07A9, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09C
        .soundChunk aSoundChunk09D, $0921, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09D
        .soundChunk aSoundChunk09E, $04B0, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09E
        .soundChunk aSoundChunk09F, $0716, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09F
        .soundChunk aSoundChunk0A0, $04DE, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A0
        .soundChunk aSoundChunk0A1, $0303, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A1
        .soundChunk aSoundChunk0A2, $0249, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A2
        .soundChunk aSoundChunk0A3, $06CF, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A3
        .soundChunk aSoundChunk0A4, $0C3A, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A4
        .soundChunk aSoundChunk0A5, $043E, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A5
        .soundChunk aSoundChunk0A6, $021E, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A6
        .soundChunk aSoundChunk0A7, $0FCC, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A7
        .soundChunk aSoundChunk0A8, $0680, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A8
        .soundChunk aSoundChunk0A9, $05B0, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A9
        .soundChunk aSoundChunk0AA, $04B0, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AA
        .soundChunk aSoundChunk0AB, $030F, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AB
        .soundChunk aSoundChunk0AC, $0295, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AC
        .soundChunk aSoundChunk0AD, $0157, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AD
        .soundChunk aSoundChunk0AE, $0340, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AE
        .soundChunk aSoundChunk0AF, $0501, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AF
        .soundChunk aSoundChunk0B0, $0798, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B0
        .soundChunk aSoundChunk0B1, $097A, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B1
        .soundChunk aSoundChunk0B2, $02F2, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B2
        .soundChunk aSoundChunk0B3, $0789, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B3
        .soundChunk aSoundChunk0B4, $0984, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B4
        .soundChunk aSoundChunk0B5, $06F4, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B5
        .soundChunk aSoundChunk0B6, $03FB, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B6
        .soundChunk aSoundChunk0B7, $0930, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B7
        .soundChunk aSoundChunk0B8, $0311, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B8
        .soundChunk aSoundChunk0B9, $082E, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B9
        .soundChunk aSoundChunk0BA, $04DB, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BA
        .soundChunk aSoundChunk0BB, $0551, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BB
        .soundChunk aSoundChunk0BC, $02A7, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BC
        .soundChunk aSoundChunk0BD, $0484, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BD
        .soundChunk aSoundChunk0BE, $03EE, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BE
        .soundChunk aSoundChunk0BF, $053B, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BF
        .soundChunk aSoundChunk0C0, $03F2, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C0
        .soundChunk aSoundChunk0C1, $026E, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C1
        .soundChunk aSoundChunk0C2, $099A, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C2
        .soundChunk aSoundChunk0C3, $063C, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C3
        .soundChunk aSoundChunk0C4, $0588, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C4
        .soundChunk aSoundChunk0C5, $061F, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C5
        .soundChunk aSoundChunk0C6, $043B, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C6
        .soundChunk aSoundChunk0C7, $03CC, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C7
        .soundChunk aSoundChunk0C8, $09D8, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C8
        .soundChunk aSoundChunk0C9, $05F6, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C9
        .soundChunk aSoundChunk0CA, $0550, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CA
        .soundChunk aSoundChunk0CB, $0410, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CB
        .soundChunk aSoundChunk0CC, $053D, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CC
        .soundChunk aSoundChunk0CD, $04E7, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CD
        .soundChunk aSoundChunk0CE, $0B34, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CE
        .soundChunk aSoundChunk0CF, $0A3D, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CF
        .soundChunk aSoundChunk0D0, $0A5A, $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0D0
        .soundChunk aSoundChunk0D1, $03E0, $C500, SOUND_CHUNK_COMPRESSED ; $0D1
        .soundChunk aSoundChunk0D2, $029B, $C500, SOUND_CHUNK_COMPRESSED ; $0D2
        .soundChunk aSoundChunk0D3, $1DF7, $B500, SOUND_CHUNK_COMPRESSED ; $0D3
        .soundChunk aSoundChunk0D4, len(binary("chunks/0D4.bin")), $2380, 0 ; $0D4
        .soundChunk aSoundChunk0D5, len(binary("chunks/0D5.bin")), $2380, 0 ; $0D5
        .soundChunk aSoundChunk0D6, len(binary("chunks/0D6.bin")), $2380, 0 ; $0D6
        .soundChunk aSoundChunk0D7, len(binary("chunks/0D7.bin")), $0000, 0 ; $0D7
        .soundChunk aSoundChunk0D8, len(binary("chunks/0D8.bin")), $0000, 0 ; $0D8
        .soundChunk aSoundChunk0D9, len(binary("chunks/0D9.bin")), $0000, 0 ; $0D9
        .soundChunk aSoundChunk0DA, len(binary("chunks/0DA.bin")), $0000, 0 ; $0DA
        .soundChunk aSoundChunk0DB, len(binary("chunks/0DB.bin")), $0000, 0 ; $0DB
        .soundChunk aSoundChunk0DC, len(binary("chunks/0DC.bin")), $0000, 0 ; $0DC
        .soundChunk aSoundChunk0DD, len(binary("chunks/0DD.bin")), $0000, 0 ; $0DD
        .soundChunk aSoundChunk0DE, len(binary("chunks/0DE.bin")), $0000, 0 ; $0DE
        .soundChunk aSoundChunk0DF, len(binary("chunks/0DF.bin")), $0000, 0 ; $0DF
        .soundChunk aSoundChunk0E0, len(binary("chunks/0E0.bin")), $0000, 0 ; $0E0
        .soundChunk aSoundChunk0E1, len(binary("chunks/0E1.bin")), $0000, 0 ; $0E1
        .soundChunk aSoundChunk0E2, len(binary("chunks/0E2.bin")), $0000, 0 ; $0E2
        .soundChunk aSoundChunk0E3, len(binary("chunks/0E3.bin")), $0000, 0 ; $0E3
        .soundChunk aSoundChunk0E4, len(binary("chunks/0E4.bin")), $0000, 0 ; $0E4
        .soundChunk aSoundChunk0E5, len(binary("chunks/0E5.bin")), $0000, 0 ; $0E5
        .soundChunk aSoundChunk0E6, len(binary("chunks/0E6.bin")), $0000, 0 ; $0E6
        .soundChunk aSoundChunk0E7, len(binary("chunks/0E7.bin")), $0000, 0 ; $0E7
        .soundChunk aSoundChunk0E8, len(binary("chunks/0E8.bin")), $0000, 0 ; $0E8
        .soundChunk aSoundChunk0E9, len(binary("chunks/0E9.bin")), $0000, 0 ; $0E9
        .soundChunk aSoundChunk0EA, len(binary("chunks/0EA.bin")), $0000, 0 ; $0EA
        .soundChunk aSoundChunk0EB, len(binary("chunks/0EB.bin")), $0000, 0 ; $0EB
        .soundChunk aSoundChunk0EC, len(binary("chunks/0EC.bin")), $0000, 0 ; $0EC
        .soundChunk aSoundChunk0ED, len(binary("chunks/0ED.bin")), $0000, 0 ; $0ED
        .soundChunk aSoundChunk0EE, len(binary("chunks/0EE.bin")), $0000, 0 ; $0EE
        .soundChunk aSoundChunk0EF, len(binary("chunks/0EF.bin")), $0000, 0 ; $0EF
        .soundChunk aSoundChunk0F0, len(binary("chunks/0F0.bin")), $0000, 0 ; $0F0
        .soundChunk aSoundChunk0F1, len(binary("chunks/0F1.bin")), $0000, 0 ; $0F1
        .soundChunk aSoundChunk0F2, len(binary("chunks/0F2.bin")), $0000, 0 ; $0F2
        .soundChunk aSoundChunk0F3, len(binary("chunks/0F3.bin")), $0000, 0 ; $0F3
        .soundChunk aSoundChunk0F4, len(binary("chunks/0F4.bin")), $0000, 0 ; $0F4
        .soundChunk aSoundChunk0F5, len(binary("chunks/0F5.bin")), $0000, 0 ; $0F5
        .soundChunk aSoundChunk0F6, len(binary("chunks/0F6.bin")), $0000, 0 ; $0F6
        .soundChunk aSoundChunk0F7, len(binary("chunks/0F7.bin")), $0000, 0 ; $0F7
        .soundChunk aSoundChunk0F8, len(binary("chunks/0F8.bin")), $0000, 0 ; $0F8
        .soundChunk aSoundChunk0F9, len(binary("chunks/0F9.bin")), $0000, 0 ; $0F9
        .soundChunk aSoundChunk0FA, len(binary("chunks/0FA.bin")), $0000, 0 ; $0FA
        .soundChunk aSoundChunk0FB, len(binary("chunks/0FB.bin")), $0000, 0 ; $0FB
        .soundChunk aSoundChunk0FC, len(binary("chunks/0FC.bin")), $0000, 0 ; $0FC
        .soundChunk aSoundChunk0FD, len(binary("chunks/0FD.bin")), $0000, 0 ; $0FD
        .soundChunk aSoundChunk0FE, len(binary("chunks/0FE.bin")), $0000, 0 ; $0FE
        .soundChunk aSoundChunk0FF, len(binary("chunks/0FF.bin")), $0000, 0 ; $0FF
        .soundChunk aSoundChunk100, len(binary("chunks/100.bin")), $0000, 0 ; $100
        .soundChunk aSoundChunk101, len(binary("chunks/101.bin")), $0000, 0 ; $101
        .soundChunk aSoundChunk102, len(binary("chunks/102.bin")), $0000, 0 ; $102
        .soundChunk aSoundChunk103, len(binary("chunks/103.bin")), $0000, 0 ; $103
        .soundChunk aSoundChunk104, len(binary("chunks/104.bin")), $0000, 0 ; $104
        .soundChunk aSoundChunk105, len(binary("chunks/105.bin")), $0000, 0 ; $105
        .soundChunk aSoundChunk106, len(binary("chunks/106.bin")), $0000, 0 ; $106
        .soundChunk aSoundChunk107, len(binary("chunks/107.bin")), $0000, 0 ; $107
        .soundChunk aSoundChunk108, len(binary("chunks/108.bin")), $0000, 0 ; $108
        .soundChunk aSoundChunk109, len(binary("chunks/109.bin")), $0000, 0 ; $109
        .soundChunk aSoundChunk10A, len(binary("chunks/10A.bin")), $0000, 0 ; $10A
        .soundChunk aSoundChunk10B, len(binary("chunks/10B.bin")), $0000, 0 ; $10B
        .soundChunk aSoundChunk10C, len(binary("chunks/10C.bin")), $0000, 0 ; $10C
        .soundChunk aSoundChunk10D, len(binary("chunks/10D.bin")), $0000, 0 ; $10D
        .soundChunk aSoundChunk10E, len(binary("chunks/10E.bin")), $0000, 0 ; $10E
        .soundChunk aSoundChunk10F, len(binary("chunks/10F.bin")), $0000, 0 ; $10F
        .soundChunk aSoundChunk110, len(binary("chunks/110.bin")), $0000, 0 ; $110
        .soundChunk aSoundChunk111, len(binary("chunks/111.bin")), $0000, 0 ; $111
        .soundChunk aSoundChunk112, len(binary("chunks/112.bin")), $0000, 0 ; $112
        .soundChunk aSoundChunk113, len(binary("chunks/113.bin")), $0000, 0 ; $113
        .soundChunk aSoundChunk114, len(binary("chunks/114.bin")), $0000, 0 ; $114
        .soundChunk aSoundChunk115, len(binary("chunks/115.bin")), $0000, 0 ; $115
        .soundChunk aSoundChunk116, len(binary("chunks/116.bin")), $0000, 0 ; $116
        .soundChunk aSoundChunk117, len(binary("chunks/117.bin")), $0000, 0 ; $117
        .soundChunk aSoundChunk118, len(binary("chunks/118.bin")), $0000, 0 ; $118
        .soundChunk aSoundChunk119, len(binary("chunks/119.bin")), $0000, 0 ; $119
        .soundChunk aSoundChunk11A, len(binary("chunks/11A.bin")), $0000, 0 ; $11A
        .soundChunk aSoundChunk11B, len(binary("chunks/11B.bin")), $0000, 0 ; $11B
        .soundChunk aSoundChunk11C, len(binary("chunks/11C.bin")), $0000, 0 ; $11C
        .soundChunk aSoundChunk11D, len(binary("chunks/11D.bin")), $0000, 0 ; $11D
        .soundChunk aSoundChunk11E, len(binary("chunks/11E.bin")), $0000, 0 ; $11E
        .soundChunk aSoundChunk11F, len(binary("chunks/11F.bin")), $0000, 0 ; $11F
        .soundChunk aSoundChunk120, len(binary("chunks/120.bin")), $0000, 0 ; $120
        .soundChunk aSoundChunk121, len(binary("chunks/121.bin")), $0000, 0 ; $121
        .soundChunk aSoundChunk122, len(binary("chunks/122.bin")), $0000, 0 ; $122
        .soundChunk aSoundChunk123, len(binary("chunks/123.bin")), $0000, 0 ; $123
        .soundChunk aSoundChunk124, len(binary("chunks/124.bin")), $0000, 0 ; $124
        .soundChunk aSoundChunk125, len(binary("chunks/125.bin")), $0000, 0 ; $125
        .soundChunk aSoundChunk126, len(binary("chunks/126.bin")), $0000, 0 ; $126
        .soundChunk aSoundChunk127, len(binary("chunks/127.bin")), $0000, 0 ; $127
        .soundChunk aSoundChunk128, len(binary("chunks/128.bin")), $0000, 0 ; $128
        .soundChunk aSoundChunk129, len(binary("chunks/129.bin")), $0000, 0 ; $129
        .soundChunk aSoundChunk12A, len(binary("chunks/12A.bin")), $0000, 0 ; $12A
        .soundChunk aSoundChunk12B, len(binary("chunks/12B.bin")), $0000, 0 ; $12B
        .soundChunk aSoundChunk12C, len(binary("chunks/12C.bin")), $0000, 0 ; $12C
        .soundChunk aSoundChunk12D, len(binary("chunks/12D.bin")), $0000, 0 ; $12D
        .soundChunk aSoundChunk12E, len(binary("chunks/12E.bin")), $0000, 0 ; $12E
        .soundChunk aSoundChunk12F, len(binary("chunks/12F.bin")), $0000, 0 ; $12F
        .soundChunk aSoundChunk130, len(binary("chunks/130.bin")), $0000, 0 ; $130
        .soundChunk aSoundChunk131, len(binary("chunks/131.bin")), $0000, 0 ; $131
        .soundChunk aSoundChunk132, len(binary("chunks/132.bin")), $0000, 0 ; $132
        .soundChunk aSoundChunk133, len(binary("chunks/133.bin")), $0000, 0 ; $133
        .soundChunk aSoundChunk134, len(binary("chunks/134.bin")), $0000, 0 ; $134
        .soundChunk aSoundChunk135, len(binary("chunks/135.bin")), $0000, 0 ; $135
        .soundChunk aSoundChunk136, len(binary("chunks/136.bin")), $0000, 0 ; $136
        .soundChunk aSoundChunk137, len(binary("chunks/137.bin")), $0000, 0 ; $137
        .soundChunk aSoundChunk138, len(binary("chunks/138.bin")), $0000, 0 ; $138
        .soundChunk aSoundChunk139, len(binary("chunks/139.bin")), $0000, 0 ; $139
        .soundChunk aSoundChunk13A, len(binary("chunks/13A.bin")), $0000, 0 ; $13A
        .soundChunk aSoundChunk13B, len(binary("chunks/13B.bin")), $0000, 0 ; $13B
        .soundChunk aSoundChunk13C, len(binary("chunks/13C.bin")), $0000, 0 ; $13C
        .soundChunk aSoundChunk13D, len(binary("chunks/13D.bin")), $0000, 0 ; $13D
        .soundChunk aSoundChunk13E, len(binary("chunks/13E.bin")), $0000, 0 ; $13E
        .soundChunk aSoundChunk13F, len(binary("chunks/13F.bin")), $0000, 0 ; $13F
        .soundChunk aSoundChunk140, len(binary("chunks/140.bin")), $0000, 0 ; $140
        .soundChunk aSoundChunk141, len(binary("chunks/141.bin")), $0000, 0 ; $141
        .soundChunk aSoundChunk142, len(binary("chunks/142.bin")), $0000, 0 ; $142
        .soundChunk aSoundChunk143, len(binary("chunks/143.bin")), $0000, 0 ; $143
        .soundChunk aSoundChunk144, len(binary("chunks/144.bin")), $0000, 0 ; $144
        .soundChunk aSoundChunk145, len(binary("chunks/145.bin")), $0000, 0 ; $145
        .soundChunk aSoundChunk146, len(binary("chunks/146.bin")), $FE00, 0 ; $146
        .soundChunk aSoundChunk147, len(binary("chunks/147.bin")), $FD00, 0 ; $147
        .soundChunk aSoundChunk148, len(binary("chunks/148.bin")), $FE00, 0 ; $148
        .soundChunk aSoundChunk149, len(binary("chunks/149.bin")), $FD00, 0 ; $149
        .soundChunk aSoundChunk14A, len(binary("chunks/14A.bin")), $FE00, 0 ; $14A
        .soundChunk aSoundChunk14B, len(binary("chunks/14B.bin")), $FD00, 0 ; $14B
        .soundChunk aSoundChunk14C, len(binary("chunks/14C.bin")), $FE00, 0 ; $14C
        .soundChunk aSoundChunk14D, len(binary("chunks/14D.bin")), $FD00, 0 ; $14D
        .soundChunk aSoundChunk14E, len(binary("chunks/14E.bin")), $FE00, 0 ; $14E
        .soundChunk aSoundChunk14F, len(binary("chunks/14F.bin")), $FD00, 0 ; $14F
        .soundChunk aSoundChunk150, len(binary("chunks/150.bin")), $FE00, 0 ; $150
        .soundChunk aSoundChunk151, len(binary("chunks/151.bin")), $FD00, 0 ; $151
        .soundChunk aSoundChunk152, len(binary("chunks/152.bin")), $FE00, 0 ; $152
        .soundChunk aSoundChunk153, len(binary("chunks/153.bin")), $FD00, 0 ; $153
        .soundChunk aSoundChunk154, len(binary("chunks/154.bin")), $FE00, 0 ; $154
        .soundChunk aSoundChunk155, len(binary("chunks/155.bin")), $FD00, 0 ; $155
        .soundChunk aSoundChunk156, len(binary("chunks/156.bin")), $FE00, 0 ; $156
        .soundChunk aSoundChunk157, len(binary("chunks/157.bin")), $FD00, 0 ; $157
        .soundChunk aSoundChunk158, len(binary("chunks/158.bin")), $FE00, 0 ; $158
        .soundChunk aSoundChunk159, len(binary("chunks/159.bin")), $FD00, 0 ; $159
        .soundChunk aSoundChunk15A, len(binary("chunks/15A.bin")), $FE00, 0 ; $15A
        .soundChunk aSoundChunk15B, len(binary("chunks/15B.bin")), $FD00, 0 ; $15B
        .soundChunk aSoundChunk15C, len(binary("chunks/15C.bin")), $FE00, 0 ; $15C
        .soundChunk aSoundChunk15D, len(binary("chunks/15D.bin")), $FD00, 0 ; $15D
        .soundChunk aSoundChunk15E, len(binary("chunks/15E.bin")), $FE00, 0 ; $15E
        .soundChunk aSoundChunk15F, len(binary("chunks/15F.bin")), $FD00, 0 ; $15F
        .soundChunk aSoundChunk160, len(binary("chunks/160.bin")), $FE00, 0 ; $160
        .soundChunk aSoundChunk161, len(binary("chunks/161.bin")), $FD00, 0 ; $161
        .soundChunk aSoundChunk162, len(binary("chunks/162.bin")), $FE00, 0 ; $162
        .soundChunk aSoundChunk163, len(binary("chunks/163.bin")), $FD00, 0 ; $163
        .soundChunk aSoundChunk164, len(binary("chunks/164.bin")), $FE00, 0 ; $164
        .soundChunk aSoundChunk165, len(binary("chunks/165.bin")), $FD00, 0 ; $165
        .soundChunk aSoundChunk166, len(binary("chunks/166.bin")), $FE00, 0 ; $166
        .soundChunk aSoundChunk167, len(binary("chunks/167.bin")), $FD00, 0 ; $167
        .soundChunk aSoundChunk168, len(binary("chunks/168.bin")), $FE00, 0 ; $168
        .soundChunk aSoundChunk169, len(binary("chunks/169.bin")), $FD00, 0 ; $169
        .soundChunk aSoundChunk16A, len(binary("chunks/16A.bin")), $FE00, 0 ; $16A
        .soundChunk aSoundChunk16B, len(binary("chunks/16B.bin")), $FD00, 0 ; $16B
        .soundChunk aSoundChunk16C, len(binary("chunks/16C.bin")), $FE00, 0 ; $16C
        .soundChunk aSoundChunk16D, len(binary("chunks/16D.bin")), $FD00, 0 ; $16D
        .soundChunk aSoundChunk16E, len(binary("chunks/16E.bin")), $FE00, 0 ; $16E
        .soundChunk aSoundChunk16F, len(binary("chunks/16F.bin")), $FD00, 0 ; $16F
        .soundChunk aSoundChunk170, len(binary("chunks/170.bin")), $FE00, 0 ; $170
        .soundChunk aSoundChunk171, len(binary("chunks/171.bin")), $FD00, 0 ; $171
        .soundChunk aSoundChunk172, len(binary("chunks/172.bin")), $FE00, 0 ; $172
        .soundChunk aSoundChunk173, len(binary("chunks/173.bin")), $FD00, 0 ; $173
        .soundChunk aSoundChunk174, len(binary("chunks/174.bin")), $FE00, 0 ; $174
        .soundChunk aSoundChunk175, len(binary("chunks/175.bin")), $FD00, 0 ; $175
        .soundChunk aSoundChunk176, len(binary("chunks/176.bin")), $FE00, 0 ; $176
        .soundChunk aSoundChunk177, len(binary("chunks/177.bin")), $FD00, 0 ; $177
        .soundChunk aSoundChunk178, len(binary("chunks/178.bin")), $FE00, 0 ; $178
        .soundChunk aSoundChunk179, len(binary("chunks/179.bin")), $FD00, 0 ; $179
        .soundChunk aSoundChunk17A, len(binary("chunks/17A.bin")), $FE00, 0 ; $17A
        .soundChunk aSoundChunk17B, len(binary("chunks/17B.bin")), $FD00, 0 ; $17B
        .soundChunk aSoundChunk17C, len(binary("chunks/17C.bin")), $FE00, 0 ; $17C
        .soundChunk aSoundChunk17D, len(binary("chunks/17D.bin")), $FD00, 0 ; $17D
        .soundChunk aSoundChunk17E, len(binary("chunks/17E.bin")), $FE00, 0 ; $17E
        .soundChunk aSoundChunk17F, len(binary("chunks/17F.bin")), $FD00, 0 ; $17F
        .soundChunk aSoundChunk180, len(binary("chunks/180.bin")), $FE00, 0 ; $180
        .soundChunk aSoundChunk181, len(binary("chunks/181.bin")), $FD00, 0 ; $181
        .soundChunk aSoundChunk182, len(binary("chunks/182.bin")), $FE00, 0 ; $182
        .soundChunk aSoundChunk183, len(binary("chunks/183.bin")), $FD00, 0 ; $183
        .soundChunk aSoundChunk184, len(binary("chunks/184.bin")), $FE00, 0 ; $184
        .soundChunk aSoundChunk185, len(binary("chunks/185.bin")), $FD00, 0 ; $185
        .soundChunk aSoundChunk186, len(binary("chunks/186.bin")), $FE00, 0 ; $186
        .soundChunk aSoundChunk187, len(binary("chunks/187.bin")), $FD00, 0 ; $187
        .soundChunk aSoundChunk188, len(binary("chunks/188.bin")), $FE00, 0 ; $188
        .soundChunk aSoundChunk189, len(binary("chunks/189.bin")), $FD00, 0 ; $189
        .soundChunk aSoundChunk18A, len(binary("chunks/18A.bin")), $FE00, 0 ; $18A
        .soundChunk aSoundChunk18B, len(binary("chunks/18B.bin")), $FD00, 0 ; $18B
        .soundChunk aSoundChunk18C, len(binary("chunks/18C.bin")), $FE00, 0 ; $18C
        .soundChunk aSoundChunk18D, len(binary("chunks/18D.bin")), $FD00, 0 ; $18D
        .soundChunk aSoundChunk18E, len(binary("chunks/18E.bin")), $FE00, 0 ; $18E
        .soundChunk aSoundChunk18F, len(binary("chunks/18F.bin")), $FD00, 0 ; $18F
        .soundChunk aSoundChunk190, len(binary("chunks/190.bin")), $FE00, 0 ; $190
        .soundChunk aSoundChunk191, len(binary("chunks/191.bin")), $FD00, 0 ; $191
        .soundChunk aSoundChunk192, len(binary("chunks/192.bin")), $FE00, 0 ; $192
        .soundChunk aSoundChunk193, len(binary("chunks/193.bin")), $FD00, 0 ; $193
        .soundChunk aSoundChunk194, len(binary("chunks/194.bin")), $FE00, 0 ; $194
        .soundChunk aSoundChunk195, len(binary("chunks/195.bin")), $FD00, 0 ; $195
        .soundChunk aSoundChunk196, len(binary("chunks/196.bin")), $FE00, 0 ; $196
        .soundChunk aSoundChunk197, len(binary("chunks/197.bin")), $FD00, 0 ; $197
        .soundChunk aSoundChunk198, len(binary("chunks/198.bin")), $FE00, 0 ; $198
        .soundChunk aSoundChunk199, len(binary("chunks/199.bin")), $FD00, 0 ; $199
        .soundChunk aSoundChunk19A, len(binary("chunks/19A.bin")), $FE00, 0 ; $19A
        .soundChunk aSoundChunk19B, len(binary("chunks/19B.bin")), $FD00, 0 ; $19B
        .soundChunk aSoundChunk19C, len(binary("chunks/19C.bin")), $FE00, 0 ; $19C
        .soundChunk aSoundChunk19D, len(binary("chunks/19D.bin")), $FD00, 0 ; $19D
        .soundChunk aSoundChunk19E, len(binary("chunks/19E.bin")), $FE00, 0 ; $19E
        .soundChunk aSoundChunk19F, len(binary("chunks/19F.bin")), $FD00, 0 ; $19F
        .soundChunk aSoundChunk1A0, len(binary("chunks/1A0.bin")), $FE00, 0 ; $1A0
        .soundChunk aSoundChunk1A1, len(binary("chunks/1A1.bin")), $FD00, 0 ; $1A1
        .soundChunk aSoundChunk1A2, len(binary("chunks/1A2.bin")), $FE00, 0 ; $1A2
        .soundChunk aSoundChunk1A3, len(binary("chunks/1A3.bin")), $FD00, 0 ; $1A3
        .soundChunk aSoundChunk1A4, len(binary("chunks/1A4.bin")), $FE00, 0 ; $1A4
        .soundChunk aSoundChunk1A5, len(binary("chunks/1A5.bin")), $FD00, 0 ; $1A5
        .soundChunk aSoundChunk1A6, len(binary("chunks/1A6.bin")), $FE00, 0 ; $1A6
        .soundChunk aSoundChunk1A7, len(binary("chunks/1A7.bin")), $FD00, 0 ; $1A7
        .soundChunk aSoundChunk1A8, len(binary("chunks/1A8.bin")), $FE00, 0 ; $1A8
        .soundChunk aSoundChunk1A9, len(binary("chunks/1A9.bin")), $FD00, 0 ; $1A9
        .soundChunk aSoundChunk1AA, len(binary("chunks/1AA.bin")), $FE00, 0 ; $1AA
        .soundChunk aSoundChunk1AB, len(binary("chunks/1AB.bin")), $FD00, 0 ; $1AB
        .soundChunk aSoundChunk1AC, len(binary("chunks/1AC.bin")), $FE00, 0 ; $1AC
        .soundChunk aSoundChunk1AD, len(binary("chunks/1AD.bin")), $FD00, 0 ; $1AD
        .soundChunk aSoundChunk1AE, len(binary("chunks/1AE.bin")), $FE00, 0 ; $1AE
        .soundChunk aSoundChunk1AF, len(binary("chunks/1AF.bin")), $FD00, 0 ; $1AF
        .soundChunk aSoundChunk1B0, len(binary("chunks/1B0.bin")), $FE00, 0 ; $1B0
        .soundChunk aSoundChunk1B1, len(binary("chunks/1B1.bin")), $FD00, 0 ; $1B1
        .soundChunk aSoundChunk1B2, len(binary("chunks/1B2.bin")), $FE00, 0 ; $1B2
        .soundChunk aSoundChunk1B3, len(binary("chunks/1B3.bin")), $FD00, 0 ; $1B3
        .soundChunk aSoundChunk1B4, len(binary("chunks/1B4.bin")), $FE00, 0 ; $1B4
        .soundChunk aSoundChunk1B5, len(binary("chunks/1B5.bin")), $FD00, 0 ; $1B5
        .soundChunk aSoundChunk1B6, len(binary("chunks/1B6.bin")), $FE00, 0 ; $1B6
        .soundChunk aSoundChunk1B7, len(binary("chunks/1B7.bin")), $FD00, 0 ; $1B7
        .soundChunk aSoundChunk1B8, len(binary("chunks/1B8.bin")), $FE00, 0 ; $1B8
        .soundChunk aSoundChunk1B9, len(binary("chunks/1B9.bin")), $FD00, 0 ; $1B9
        .soundChunk aSoundChunk1BA, len(binary("chunks/1BA.bin")), $FE00, 0 ; $1BA
        .soundChunk aSoundChunk1BB, len(binary("chunks/1BB.bin")), $FD00, 0 ; $1BB
        .soundChunk aSoundChunk1BC, len(binary("chunks/1BC.bin")), $FE00, 0 ; $1BC
        .soundChunk aSoundChunk1BD, len(binary("chunks/1BD.bin")), $FD00, 0 ; $1BD
        .soundChunk aSoundChunk1BE, len(binary("chunks/1BE.bin")), $FE00, 0 ; $1BE
        .soundChunk aSoundChunk1BF, len(binary("chunks/1BF.bin")), $FD00, 0 ; $1BF
        .soundChunk aSoundChunk1C0, len(binary("chunks/1C0.bin")), $FE00, 0 ; $1C0
        .soundChunk aSoundChunk1C1, len(binary("chunks/1C1.bin")), $FD00, 0 ; $1C1
        .soundChunk aSoundChunk1C2, len(binary("chunks/1C2.bin")), $FE00, 0 ; $1C2
        .soundChunk aSoundChunk1C3, len(binary("chunks/1C3.bin")), $FD00, 0 ; $1C3
        .soundChunk aSoundChunk1C4, len(binary("chunks/1C4.bin")), $FE00, 0 ; $1C4
        .soundChunk aSoundChunk1C5, len(binary("chunks/1C5.bin")), $FD00, 0 ; $1C5
        .soundChunk aSoundChunk1C6, len(binary("chunks/1C6.bin")), $FE00, 0 ; $1C6
        .soundChunk aSoundChunk1C7, len(binary("chunks/1C7.bin")), $FD00, 0 ; $1C7
        .soundChunk aSoundChunk1C8, len(binary("chunks/1C8.bin")), $FE00, 0 ; $1C8
        .soundChunk aSoundChunk1C9, len(binary("chunks/1C9.bin")), $FD00, 0 ; $1C9
        .soundChunk aSoundChunk1CA, len(binary("chunks/1CA.bin")), $FE00, 0 ; $1CA
        .soundChunk aSoundChunk1CB, len(binary("chunks/1CB.bin")), $FD00, 0 ; $1CB
        .soundChunk aSoundChunk1CC, len(binary("chunks/1CC.bin")), $FE00, 0 ; $1CC
        .soundChunk aSoundChunk1CD, len(binary("chunks/1CD.bin")), $FD00, 0 ; $1CD
        .soundChunk aSoundChunk1CE, len(binary("chunks/1CE.bin")), $FE00, 0 ; $1CE
        .soundChunk aSoundChunk1CF, len(binary("chunks/1CF.bin")), $FD00, 0 ; $1CF
        .soundChunk aSoundChunk1D0, len(binary("chunks/1D0.bin")), $FE00, 0 ; $1D0
        .soundChunk aSoundChunk1D1, len(binary("chunks/1D1.bin")), $FD00, 0 ; $1D1
        .soundChunk aSoundChunk1D2, len(binary("chunks/1D2.bin")), $FE00, 0 ; $1D2
        .soundChunk aSoundChunk1D3, len(binary("chunks/1D3.bin")), $FD00, 0 ; $1D3
        .soundChunk aSoundChunk1D4, len(binary("chunks/1D4.bin")), $FE00, 0 ; $1D4
        .soundChunk aSoundChunk1D5, len(binary("chunks/1D5.bin")), $FD00, 0 ; $1D5
        .soundChunk aSoundChunk1D6, len(binary("chunks/1D6.bin")), $FE00, 0 ; $1D6
        .soundChunk aSoundChunk1D7, len(binary("chunks/1D7.bin")), $FD00, 0 ; $1D7
        .soundChunk aSoundChunk1D8, len(binary("chunks/1D8.bin")), $FE00, 0 ; $1D8
        .soundChunk aSoundChunk1D9, len(binary("chunks/1D9.bin")), $FD00, 0 ; $1D9
        .soundChunk aSoundChunk1DA, len(binary("chunks/1DA.bin")), $FE00, 0 ; $1DA
        .soundChunk aSoundChunk1DB, len(binary("chunks/1DB.bin")), $FD00, 0 ; $1DB
        .soundChunk aSoundChunk1DC, len(binary("chunks/1DC.bin")), $FE00, 0 ; $1DC
        .soundChunk aSoundChunk1DD, len(binary("chunks/1DD.bin")), $FD00, 0 ; $1DD
        .soundChunk aSoundChunk1DE, len(binary("chunks/1DE.bin")), $FE00, 0 ; $1DE
        .soundChunk aSoundChunk1DF, len(binary("chunks/1DF.bin")), $FD00, 0 ; $1DF
        .soundChunk aSoundChunk1E0, len(binary("chunks/1E0.bin")), $FE00, 0 ; $1E0
        .soundChunk aSoundChunk1E1, len(binary("chunks/1E1.bin")), $FD00, 0 ; $1E1
        .soundChunk aSoundChunk1E2, len(binary("chunks/1E2.bin")), $FE00, 0 ; $1E2
        .soundChunk aSoundChunk1E3, len(binary("chunks/1E3.bin")), $FD00, 0 ; $1E3
        .soundChunk aSoundChunk1E4, len(binary("chunks/1E4.bin")), $FE00, 0 ; $1E4
        .soundChunk aSoundChunk1E5, len(binary("chunks/1E5.bin")), $FD00, 0 ; $1E5
        .soundChunk aSoundChunk1E6, len(binary("chunks/1E6.bin")), $FE00, 0 ; $1E6
        .soundChunk aSoundChunk1E7, len(binary("chunks/1E7.bin")), $FD00, 0 ; $1E7
        .soundChunk aSoundChunk1E8, len(binary("chunks/1E8.bin")), $FE00, 0 ; $1E8
        .soundChunk aSoundChunk1E9, len(binary("chunks/1E9.bin")), $FD00, 0 ; $1E9
        .soundChunk aSoundChunk1EA, len(binary("chunks/1EA.bin")), $FE00, 0 ; $1EA
        .soundChunk aSoundChunk1EB, len(binary("chunks/1EB.bin")), $FD00, 0 ; $1EB
        .soundChunk aSoundChunk1EC, len(binary("chunks/1EC.bin")), $FE00, 0 ; $1EC
        .soundChunk aSoundChunk1ED, len(binary("chunks/1ED.bin")), $FD00, 0 ; $1ED
        .soundChunk aSoundChunk1EE, len(binary("chunks/1EE.bin")), $FE00, 0 ; $1EE
        .soundChunk aSoundChunk1EF, len(binary("chunks/1EF.bin")), $FD00, 0 ; $1EF
        .soundChunk aSoundChunk1F0, len(binary("chunks/1F0.bin")), $FE00, 0 ; $1F0
        .soundChunk aSoundChunk1F1, len(binary("chunks/1F1.bin")), $FD00, 0 ; $1F1
        .soundChunk aSoundChunk1F2, len(binary("chunks/1F2.bin")), $FE00, 0 ; $1F2
        .soundChunk aSoundChunk1F3, len(binary("chunks/1F3.bin")), $FD00, 0 ; $1F3
        .soundChunk aSoundChunk1F4, len(binary("chunks/1F4.bin")), $FE00, 0 ; $1F4
        .soundChunk aSoundChunk1F5, len(binary("chunks/1F5.bin")), $FD00, 0 ; $1F5
        .soundChunk aSoundChunk1F6, len(binary("chunks/1F6.bin")), $FE00, 0 ; $1F6
        .soundChunk aSoundChunk1F7, len(binary("chunks/1F7.bin")), $FD00, 0 ; $1F7
        .soundChunk aSoundChunk1F8, len(binary("chunks/1F8.bin")), $FE00, 0 ; $1F8
        .soundChunk aSoundChunk1F9, len(binary("chunks/1F9.bin")), $FD00, 0 ; $1F9
        .soundChunk aSoundChunk1FA, len(binary("chunks/1FA.bin")), $FE00, 0 ; $1FA
        .soundChunk aSoundChunk1FB, len(binary("chunks/1FB.bin")), $FD00, 0 ; $1FB
        .soundChunk aSoundChunk1FC, len(binary("chunks/1FC.bin")), $FE00, 0 ; $1FC
        .soundChunk aSoundChunk1FD, len(binary("chunks/1FD.bin")), $FD00, 0 ; $1FD
        .soundChunk aSoundChunk1FE, len(binary("chunks/1FE.bin")), $FE00, 0 ; $1FE
        .soundChunk aSoundChunk1FF, len(binary("chunks/1FF.bin")), $FD00, 0 ; $1FF
        .soundChunk aSoundChunk200, len(binary("chunks/200.bin")), $FE00, 0 ; $200
        .soundChunk aSoundChunk201, len(binary("chunks/201.bin")), $FD00, 0 ; $201
        .soundChunk aSoundChunk202, len(binary("chunks/202.bin")), $FE00, 0 ; $202
        .soundChunk aSoundChunk203, len(binary("chunks/203.bin")), $FD00, 0 ; $203
        .soundChunk aSoundChunk204, len(binary("chunks/204.bin")), $FE00, 0 ; $204
        .soundChunk aSoundChunk205, len(binary("chunks/205.bin")), $FD00, 0 ; $205
        .soundChunk aSoundChunk206, len(binary("chunks/206.bin")), $FE00, 0 ; $206
        .soundChunk aSoundChunk207, len(binary("chunks/207.bin")), $FD00, 0 ; $207
        .soundChunk aSoundChunk208, len(binary("chunks/208.bin")), $FE00, 0 ; $208
        .soundChunk aSoundChunk209, len(binary("chunks/209.bin")), $FD00, 0 ; $209
        .soundChunk aSoundChunk20A, len(binary("chunks/20A.bin")), $FE00, 0 ; $20A
        .soundChunk aSoundChunk20B, len(binary("chunks/20B.bin")), $FD00, 0 ; $20B
        .soundChunk aSoundChunk20C, len(binary("chunks/20C.bin")), $FE00, 0 ; $20C
        .soundChunk aSoundChunk20D, len(binary("chunks/20D.bin")), $FD00, 0 ; $20D
        .soundChunk aSoundChunk20E, len(binary("chunks/20E.bin")), $FE00, 0 ; $20E
        .soundChunk aSoundChunk20F, len(binary("chunks/20F.bin")), $FD00, 0 ; $20F
        .soundChunk aSoundChunk210, len(binary("chunks/210.bin")), $FE00, 0 ; $210
        .soundChunk aSoundChunk211, len(binary("chunks/211.bin")), $FD00, 0 ; $211
        .soundChunk aSoundChunk212, len(binary("chunks/212.bin")), $FE00, 0 ; $212
        .soundChunk aSoundChunk213, len(binary("chunks/213.bin")), $FD00, 0 ; $213
        .soundChunk aSoundChunk214, len(binary("chunks/214.bin")), $FE00, 0 ; $214
        .soundChunk aSoundChunk215, len(binary("chunks/215.bin")), $FD00, 0 ; $215
        .soundChunk aSoundChunk216, len(binary("chunks/216.bin")), $FE00, 0 ; $216
        .soundChunk aSoundChunk217, len(binary("chunks/217.bin")), $FD00, 0 ; $217
        .soundChunk aSoundChunk218, len(binary("chunks/218.bin")), $FE00, 0 ; $218
        .soundChunk aSoundChunk219, len(binary("chunks/219.bin")), $FD00, 0 ; $219
        .soundChunk aSoundChunk21A, len(binary("chunks/21A.bin")), $FE00, 0 ; $21A
        .soundChunk aSoundChunk21B, len(binary("chunks/21B.bin")), $FD00, 0 ; $21B
        .soundChunk aSoundChunk21C, len(binary("chunks/21C.bin")), $FE00, 0 ; $21C
        .soundChunk aSoundChunk21D, len(binary("chunks/21D.bin")), $FD00, 0 ; $21D
        .soundChunk aSoundChunk21E, len(binary("chunks/21E.bin")), $FE00, 0 ; $21E
        .soundChunk aSoundChunk21F, len(binary("chunks/21F.bin")), $FD00, 0 ; $21F
        .soundChunk aSoundChunk220, len(binary("chunks/220.bin")), $FE00, 0 ; $220
        .soundChunk aSoundChunk221, len(binary("chunks/221.bin")), $FD00, 0 ; $221
        .soundChunk aSoundChunk222, len(binary("chunks/222.bin")), $FE00, 0 ; $222
        .soundChunk aSoundChunk223, len(binary("chunks/223.bin")), $FD00, 0 ; $223
        .soundChunk aSoundChunk224, len(binary("chunks/224.bin")), $FE00, 0 ; $224
        .soundChunk aSoundChunk225, len(binary("chunks/225.bin")), $FD00, 0 ; $225
        .soundChunk aSoundChunk226, len(binary("chunks/226.bin")), $FE00, 0 ; $226
        .soundChunk aSoundChunk227, len(binary("chunks/227.bin")), $FD00, 0 ; $227
        .soundChunk aSoundChunk228, len(binary("chunks/228.bin")), $FE00, 0 ; $228
        .soundChunk aSoundChunk229, len(binary("chunks/229.bin")), $FD00, 0 ; $229
        .soundChunk aSoundChunk22A, len(binary("chunks/22A.bin")), $FE00, 0 ; $22A
        .soundChunk aSoundChunk22B, len(binary("chunks/22B.bin")), $FD00, 0 ; $22B
        .soundChunk aSoundChunk22C, len(binary("chunks/22C.bin")), $FF50, 0 ; $22C
        .soundChunk aSoundChunk22D, len(binary("chunks/22D.bin")), $FDE0, 0 ; $22D
        .soundChunk aSoundChunk22E, len(binary("chunks/22E.bin")), $51E0, 0 ; $22E
        .soundChunk aSoundChunk22F, len(binary("chunks/22F.bin")), $FF68, 0 ; $22F
        .soundChunk aSoundChunk230, len(binary("chunks/230.bin")), $FDF0, 0 ; $230
        .soundChunk aSoundChunk22E, len(binary("chunks/22E.bin")), $62F0, 0 ; $231
        .soundChunk aSoundChunk232, len(binary("chunks/232.bin")), $FF50, 0 ; $232
        .soundChunk aSoundChunk233, len(binary("chunks/233.bin")), $FDE0, 0 ; $233
        .soundChunk aSoundChunk234, len(binary("chunks/234.bin")), $51E0, 0 ; $234
        .soundChunk aSoundChunk235, len(binary("chunks/235.bin")), $FF68, 0 ; $235
        .soundChunk aSoundChunk236, len(binary("chunks/236.bin")), $FDF0, 0 ; $236
        .soundChunk aSoundChunk234, len(binary("chunks/234.bin")), $62F0, 0 ; $237
        .soundChunk aSoundChunk238, len(binary("chunks/238.bin")), $FF50, 0 ; $238
        .soundChunk aSoundChunk239, len(binary("chunks/239.bin")), $FDE0, 0 ; $239
        .soundChunk aSoundChunk23A, len(binary("chunks/23A.bin")), $51E0, 0 ; $23A
        .soundChunk aSoundChunk23B, len(binary("chunks/23B.bin")), $FF68, 0 ; $23B
        .soundChunk aSoundChunk23C, len(binary("chunks/23C.bin")), $FDF0, 0 ; $23C
        .soundChunk aSoundChunk23A, len(binary("chunks/23A.bin")), $62F0, 0 ; $23D
        .soundChunk aSoundChunk23E, len(binary("chunks/23E.bin")), $FF50, 0 ; $23E
        .soundChunk aSoundChunk23F, len(binary("chunks/23F.bin")), $FDE0, 0 ; $23F
        .soundChunk aSoundChunk240, len(binary("chunks/240.bin")), $51E0, 0 ; $240
        .soundChunk aSoundChunk241, len(binary("chunks/241.bin")), $FF68, 0 ; $241
        .soundChunk aSoundChunk242, len(binary("chunks/242.bin")), $FDF0, 0 ; $242
        .soundChunk aSoundChunk240, len(binary("chunks/240.bin")), $62F0, 0 ; $243
        .soundChunk aSoundChunk244, len(binary("chunks/244.bin")), $FF50, 0 ; $244
        .soundChunk aSoundChunk245, len(binary("chunks/245.bin")), $FDE0, 0 ; $245
        .soundChunk aSoundChunk246, len(binary("chunks/246.bin")), $51E0, 0 ; $246
        .soundChunk aSoundChunk247, len(binary("chunks/247.bin")), $FF68, 0 ; $247
        .soundChunk aSoundChunk248, len(binary("chunks/248.bin")), $FDF0, 0 ; $248
        .soundChunk aSoundChunk246, len(binary("chunks/246.bin")), $62F0, 0 ; $249
        .soundChunk aSoundChunk24A, len(binary("chunks/24A.bin")), $FF50, 0 ; $24A
        .soundChunk aSoundChunk24B, len(binary("chunks/24B.bin")), $FDE0, 0 ; $24B
        .soundChunk aSoundChunk24C, len(binary("chunks/24C.bin")), $51E0, 0 ; $24C
        .soundChunk aSoundChunk24D, len(binary("chunks/24D.bin")), $FF68, 0 ; $24D
        .soundChunk aSoundChunk24E, len(binary("chunks/24E.bin")), $FDF0, 0 ; $24E
        .soundChunk aSoundChunk24C, len(binary("chunks/24C.bin")), $62F0, 0 ; $24F
        .soundChunk aSoundChunk250, len(binary("chunks/250.bin")), $FF50, 0 ; $250
        .soundChunk aSoundChunk251, len(binary("chunks/251.bin")), $FDE0, 0 ; $251
        .soundChunk aSoundChunk252, len(binary("chunks/252.bin")), $51E0, 0 ; $252
        .soundChunk aSoundChunk253, len(binary("chunks/253.bin")), $FF68, 0 ; $253
        .soundChunk aSoundChunk254, len(binary("chunks/254.bin")), $FDF0, 0 ; $254
        .soundChunk aSoundChunk252, len(binary("chunks/252.bin")), $62F0, 0 ; $255
        .soundChunk aSoundChunk256, len(binary("chunks/256.bin")), $FF50, 0 ; $256
        .soundChunk aSoundChunk257, len(binary("chunks/257.bin")), $FDE0, 0 ; $257
        .soundChunk aSoundChunk258, len(binary("chunks/258.bin")), $51E0, 0 ; $258
        .soundChunk aSoundChunk259, len(binary("chunks/259.bin")), $FF68, 0 ; $259
        .soundChunk aSoundChunk25A, len(binary("chunks/25A.bin")), $FDF0, 0 ; $25A
        .soundChunk aSoundChunk258, len(binary("chunks/258.bin")), $62F0, 0 ; $25B
        .soundChunk aSoundChunk25C, len(binary("chunks/25C.bin")), $FF50, 0 ; $25C
        .soundChunk aSoundChunk25D, len(binary("chunks/25D.bin")), $FDE0, 0 ; $25D
        .soundChunk aSoundChunk25E, len(binary("chunks/25E.bin")), $51E0, 0 ; $25E
        .soundChunk aSoundChunk25F, len(binary("chunks/25F.bin")), $FF68, 0 ; $25F
        .soundChunk aSoundChunk260, len(binary("chunks/260.bin")), $FDF0, 0 ; $260
        .soundChunk aSoundChunk25E, len(binary("chunks/25E.bin")), $62F0, 0 ; $261
        .soundChunk aSoundChunk262, len(binary("chunks/262.bin")), $FF50, 0 ; $262
        .soundChunk aSoundChunk263, len(binary("chunks/263.bin")), $FDE0, 0 ; $263
        .soundChunk aSoundChunk264, len(binary("chunks/264.bin")), $51E0, 0 ; $264
        .soundChunk aSoundChunk265, len(binary("chunks/265.bin")), $FF68, 0 ; $265
        .soundChunk aSoundChunk266, len(binary("chunks/266.bin")), $FDF0, 0 ; $266
        .soundChunk aSoundChunk264, len(binary("chunks/264.bin")), $62F0, 0 ; $267
        .soundChunk aSoundChunk268, len(binary("chunks/268.bin")), $FF50, 0 ; $268
        .soundChunk aSoundChunk269, len(binary("chunks/269.bin")), $FDE0, 0 ; $269
        .soundChunk aSoundChunk26A, len(binary("chunks/26A.bin")), $51E0, 0 ; $26A
        .soundChunk aSoundChunk26B, len(binary("chunks/26B.bin")), $FF68, 0 ; $26B
        .soundChunk aSoundChunk26C, len(binary("chunks/26C.bin")), $FDF0, 0 ; $26C
        .soundChunk aSoundChunk26A, len(binary("chunks/26A.bin")), $62F0, 0 ; $26D
        .soundChunk aSoundChunk26E, len(binary("chunks/26E.bin")), $FF50, 0 ; $26E
        .soundChunk aSoundChunk26F, len(binary("chunks/26F.bin")), $FDE0, 0 ; $26F
        .soundChunk aSoundChunk270, len(binary("chunks/270.bin")), $51E0, 0 ; $270
        .soundChunk aSoundChunk271, len(binary("chunks/271.bin")), $FF68, 0 ; $271
        .soundChunk aSoundChunk272, len(binary("chunks/272.bin")), $FDF0, 0 ; $272
        .soundChunk aSoundChunk270, len(binary("chunks/270.bin")), $62F0, 0 ; $273
        .soundChunk aSoundChunk274, len(binary("chunks/274.bin")), $FF50, 0 ; $274
        .soundChunk aSoundChunk275, len(binary("chunks/275.bin")), $FDE0, 0 ; $275
        .soundChunk aSoundChunk276, len(binary("chunks/276.bin")), $51E0, 0 ; $276
        .soundChunk aSoundChunk277, len(binary("chunks/277.bin")), $FF68, 0 ; $277
        .soundChunk aSoundChunk278, len(binary("chunks/278.bin")), $FDF0, 0 ; $278
        .soundChunk aSoundChunk276, len(binary("chunks/276.bin")), $62F0, 0 ; $279
        .soundChunk aSoundChunk27A, len(binary("chunks/27A.bin")), $FF50, 0 ; $27A
        .soundChunk aSoundChunk27B, len(binary("chunks/27B.bin")), $FDE0, 0 ; $27B
        .soundChunk aSoundChunk27C, len(binary("chunks/27C.bin")), $51E0, 0 ; $27C
        .soundChunk aSoundChunk27D, len(binary("chunks/27D.bin")), $FF68, 0 ; $27D
        .soundChunk aSoundChunk27E, len(binary("chunks/27E.bin")), $FDF0, 0 ; $27E
        .soundChunk aSoundChunk27C, len(binary("chunks/27C.bin")), $62F0, 0 ; $27F
        .soundChunk aSoundChunk280, len(binary("chunks/280.bin")), $FF50, 0 ; $280
        .soundChunk aSoundChunk281, len(binary("chunks/281.bin")), $FDE0, 0 ; $281
        .soundChunk aSoundChunk282, len(binary("chunks/282.bin")), $51E0, 0 ; $282
        .soundChunk aSoundChunk283, len(binary("chunks/283.bin")), $FF68, 0 ; $283
        .soundChunk aSoundChunk284, len(binary("chunks/284.bin")), $FDF0, 0 ; $284
        .soundChunk aSoundChunk282, len(binary("chunks/282.bin")), $62F0, 0 ; $285
        .soundChunk aSoundChunk286, len(binary("chunks/286.bin")), $FF50, 0 ; $286
        .soundChunk aSoundChunk287, len(binary("chunks/287.bin")), $FDE0, 0 ; $287
        .soundChunk aSoundChunk288, len(binary("chunks/288.bin")), $51E0, 0 ; $288
        .soundChunk aSoundChunk289, len(binary("chunks/289.bin")), $FF68, 0 ; $289
        .soundChunk aSoundChunk28A, len(binary("chunks/28A.bin")), $FDF0, 0 ; $28A
        .soundChunk aSoundChunk288, len(binary("chunks/288.bin")), $62F0, 0 ; $28B
        .soundChunk aSoundChunk28C, len(binary("chunks/28C.bin")), $FF50, 0 ; $28C
        .soundChunk aSoundChunk28D, len(binary("chunks/28D.bin")), $FDE0, 0 ; $28D
        .soundChunk aSoundChunk28E, len(binary("chunks/28E.bin")), $51E0, 0 ; $28E
        .soundChunk aSoundChunk28F, len(binary("chunks/28F.bin")), $FF68, 0 ; $28F
        .soundChunk aSoundChunk290, len(binary("chunks/290.bin")), $FDF0, 0 ; $290
        .soundChunk aSoundChunk28E, len(binary("chunks/28E.bin")), $62F0, 0 ; $291
        .soundChunk aSoundChunk292, len(binary("chunks/292.bin")), $FF50, 0 ; $292
        .soundChunk aSoundChunk293, len(binary("chunks/293.bin")), $FDE0, 0 ; $293
        .soundChunk aSoundChunk294, len(binary("chunks/294.bin")), $51E0, 0 ; $294
        .soundChunk aSoundChunk295, len(binary("chunks/295.bin")), $FF68, 0 ; $295
        .soundChunk aSoundChunk296, len(binary("chunks/296.bin")), $FDF0, 0 ; $296
        .soundChunk aSoundChunk294, len(binary("chunks/294.bin")), $62F0, 0 ; $297
        .soundChunk aSoundChunk298, len(binary("chunks/298.bin")), $FF50, 0 ; $298
        .soundChunk aSoundChunk299, len(binary("chunks/299.bin")), $FDE0, 0 ; $299
        .soundChunk aSoundChunk29A, len(binary("chunks/29A.bin")), $51E0, 0 ; $29A
        .soundChunk aSoundChunk29B, len(binary("chunks/29B.bin")), $FF68, 0 ; $29B
        .soundChunk aSoundChunk29C, len(binary("chunks/29C.bin")), $FDF0, 0 ; $29C
        .soundChunk aSoundChunk29A, len(binary("chunks/29A.bin")), $62F0, 0 ; $29D
        .soundChunk aSoundChunk29E, len(binary("chunks/29E.bin")), $FF50, 0 ; $29E
        .soundChunk aSoundChunk29F, len(binary("chunks/29F.bin")), $FDE0, 0 ; $29F
        .soundChunk aSoundChunk2A0, len(binary("chunks/2A0.bin")), $51E0, 0 ; $2A0
        .soundChunk aSoundChunk2A1, len(binary("chunks/2A1.bin")), $FF68, 0 ; $2A1
        .soundChunk aSoundChunk2A2, len(binary("chunks/2A2.bin")), $FDF0, 0 ; $2A2
        .soundChunk aSoundChunk2A0, len(binary("chunks/2A0.bin")), $62F0, 0 ; $2A3
        .soundChunk aSoundChunk2A4, len(binary("chunks/2A4.bin")), $FF62, 0 ; $2A4
        .soundChunk aSoundChunk2A5, len(binary("chunks/2A5.bin")), $FDEC, 0 ; $2A5
        .soundChunk aSoundChunk2A6, len(binary("chunks/2A6.bin")), $5F74, 0 ; $2A6
        .soundChunk aSoundChunk2A7, len(binary("chunks/2A7.bin")), $FF7A, 0 ; $2A7
        .soundChunk aSoundChunk2A8, len(binary("chunks/2A8.bin")), $FDFC, 0 ; $2A8
        .soundChunk aSoundChunk2A6, len(binary("chunks/2A6.bin")), $7084, 0 ; $2A9
        .soundChunk aSoundChunk2AA, len(binary("chunks/2AA.bin")), $FF62, 0 ; $2AA
        .soundChunk aSoundChunk2AB, len(binary("chunks/2AB.bin")), $FDEC, 0 ; $2AB
        .soundChunk aSoundChunk2AC, len(binary("chunks/2AC.bin")), $5F74, 0 ; $2AC
        .soundChunk aSoundChunk2AD, len(binary("chunks/2AD.bin")), $FF7A, 0 ; $2AD
        .soundChunk aSoundChunk2AE, len(binary("chunks/2AE.bin")), $FDFC, 0 ; $2AE
        .soundChunk aSoundChunk2AC, len(binary("chunks/2AC.bin")), $7084, 0 ; $2AF
        .soundChunk aSoundChunk2B0, len(binary("chunks/2B0.bin")), $FF62, 0 ; $2B0
        .soundChunk aSoundChunk2B1, len(binary("chunks/2B1.bin")), $FDEC, 0 ; $2B1
        .soundChunk aSoundChunk2B2, len(binary("chunks/2B2.bin")), $5F74, 0 ; $2B2
        .soundChunk aSoundChunk2B3, len(binary("chunks/2B3.bin")), $FF7A, 0 ; $2B3
        .soundChunk aSoundChunk2B4, len(binary("chunks/2B4.bin")), $FDFC, 0 ; $2B4
        .soundChunk aSoundChunk2B2, len(binary("chunks/2B2.bin")), $7084, 0 ; $2B5
        .soundChunk aSoundChunk2B6, len(binary("chunks/2B6.bin")), $FF62, 0 ; $2B6
        .soundChunk aSoundChunk2B7, len(binary("chunks/2B7.bin")), $FDEC, 0 ; $2B7
        .soundChunk aSoundChunk2B8, len(binary("chunks/2B8.bin")), $5F74, 0 ; $2B8
        .soundChunk aSoundChunk2B9, len(binary("chunks/2B9.bin")), $FF7A, 0 ; $2B9
        .soundChunk aSoundChunk2BA, len(binary("chunks/2BA.bin")), $FDFC, 0 ; $2BA
        .soundChunk aSoundChunk2B8, len(binary("chunks/2B8.bin")), $7084, 0 ; $2BB
        .soundChunk aSoundChunk2BC, len(binary("chunks/2BC.bin")), $FF62, 0 ; $2BC
        .soundChunk aSoundChunk2BD, len(binary("chunks/2BD.bin")), $FDEC, 0 ; $2BD
        .soundChunk aSoundChunk2BE, len(binary("chunks/2BE.bin")), $5F74, 0 ; $2BE
        .soundChunk aSoundChunk2BF, len(binary("chunks/2BF.bin")), $FF7A, 0 ; $2BF
        .soundChunk aSoundChunk2C0, len(binary("chunks/2C0.bin")), $FDFC, 0 ; $2C0
        .soundChunk aSoundChunk2BE, len(binary("chunks/2BE.bin")), $7084, 0 ; $2C1
        .soundChunk aSoundChunk2C2, len(binary("chunks/2C2.bin")), $FF62, 0 ; $2C2
        .soundChunk aSoundChunk2C3, len(binary("chunks/2C3.bin")), $FDEC, 0 ; $2C3
        .soundChunk aSoundChunk2C4, len(binary("chunks/2C4.bin")), $5F74, 0 ; $2C4
        .soundChunk aSoundChunk2C5, len(binary("chunks/2C5.bin")), $FF7A, 0 ; $2C5
        .soundChunk aSoundChunk2C6, len(binary("chunks/2C6.bin")), $FDFC, 0 ; $2C6
        .soundChunk aSoundChunk2C4, len(binary("chunks/2C4.bin")), $7084, 0 ; $2C7
        .soundChunk aSoundChunk2C8, len(binary("chunks/2C8.bin")), $FF62, 0 ; $2C8
        .soundChunk aSoundChunk2C9, len(binary("chunks/2C9.bin")), $FDEC, 0 ; $2C9
        .soundChunk aSoundChunk2CA, len(binary("chunks/2CA.bin")), $5F74, 0 ; $2CA
        .soundChunk aSoundChunk2CB, len(binary("chunks/2CB.bin")), $FF7A, 0 ; $2CB
        .soundChunk aSoundChunk2CC, len(binary("chunks/2CC.bin")), $FDFC, 0 ; $2CC
        .soundChunk aSoundChunk2CA, len(binary("chunks/2CA.bin")), $7084, 0 ; $2CD
        .soundChunk aSoundChunk2CE, len(binary("chunks/2CE.bin")), $FF62, 0 ; $2CE
        .soundChunk aSoundChunk2CF, len(binary("chunks/2CF.bin")), $FDEC, 0 ; $2CF
        .soundChunk aSoundChunk2D0, len(binary("chunks/2D0.bin")), $5F74, 0 ; $2D0
        .soundChunk aSoundChunk2D1, len(binary("chunks/2D1.bin")), $FF7A, 0 ; $2D1
        .soundChunk aSoundChunk2D2, len(binary("chunks/2D2.bin")), $FDFC, 0 ; $2D2
        .soundChunk aSoundChunk2D0, len(binary("chunks/2D0.bin")), $7084, 0 ; $2D3
        .soundChunk aSoundChunk2D4, len(binary("chunks/2D4.bin")), $FF62, 0 ; $2D4
        .soundChunk aSoundChunk2D5, len(binary("chunks/2D5.bin")), $FDEC, 0 ; $2D5
        .soundChunk aSoundChunk2D6, len(binary("chunks/2D6.bin")), $5F74, 0 ; $2D6
        .soundChunk aSoundChunk2D7, len(binary("chunks/2D7.bin")), $FF7A, 0 ; $2D7
        .soundChunk aSoundChunk2D8, len(binary("chunks/2D8.bin")), $FDFC, 0 ; $2D8
        .soundChunk aSoundChunk2D6, len(binary("chunks/2D6.bin")), $7084, 0 ; $2D9
        .soundChunk aSoundChunk2DA, len(binary("chunks/2DA.bin")), $FF62, 0 ; $2DA
        .soundChunk aSoundChunk2DB, len(binary("chunks/2DB.bin")), $FDEC, 0 ; $2DB
        .soundChunk aSoundChunk2DC, len(binary("chunks/2DC.bin")), $5F74, 0 ; $2DC
        .soundChunk aSoundChunk2DD, len(binary("chunks/2DD.bin")), $FF7A, 0 ; $2DD
        .soundChunk aSoundChunk2DE, len(binary("chunks/2DE.bin")), $FDFC, 0 ; $2DE
        .soundChunk aSoundChunk2DC, len(binary("chunks/2DC.bin")), $7084, 0 ; $2DF
        .soundChunk aSoundChunk2E0, len(binary("chunks/2E0.bin")), $FF62, 0 ; $2E0
        .soundChunk aSoundChunk2E1, len(binary("chunks/2E1.bin")), $FDEC, 0 ; $2E1
        .soundChunk aSoundChunk2E2, len(binary("chunks/2E2.bin")), $5F74, 0 ; $2E2
        .soundChunk aSoundChunk2E3, len(binary("chunks/2E3.bin")), $FF7A, 0 ; $2E3
        .soundChunk aSoundChunk2E4, len(binary("chunks/2E4.bin")), $FDFC, 0 ; $2E4
        .soundChunk aSoundChunk2E2, len(binary("chunks/2E2.bin")), $7084, 0 ; $2E5
        .soundChunk aSoundChunk2E6, len(binary("chunks/2E6.bin")), $FF62, 0 ; $2E6
        .soundChunk aSoundChunk2E7, len(binary("chunks/2E7.bin")), $FDEC, 0 ; $2E7
        .soundChunk aSoundChunk2E8, len(binary("chunks/2E8.bin")), $5F74, 0 ; $2E8
        .soundChunk aSoundChunk2E9, len(binary("chunks/2E9.bin")), $FF7A, 0 ; $2E9
        .soundChunk aSoundChunk2EA, len(binary("chunks/2EA.bin")), $FDFC, 0 ; $2EA
        .soundChunk aSoundChunk2E8, len(binary("chunks/2E8.bin")), $7084, 0 ; $2EB
        .soundChunk aSoundChunk2EC, len(binary("chunks/2EC.bin")), $FF62, 0 ; $2EC
        .soundChunk aSoundChunk2ED, len(binary("chunks/2ED.bin")), $FDEC, 0 ; $2ED
        .soundChunk aSoundChunk2EE, len(binary("chunks/2EE.bin")), $5F74, 0 ; $2EE
        .soundChunk aSoundChunk2EF, len(binary("chunks/2EF.bin")), $FF7A, 0 ; $2EF
        .soundChunk aSoundChunk2F0, len(binary("chunks/2F0.bin")), $FDFC, 0 ; $2F0
        .soundChunk aSoundChunk2EE, len(binary("chunks/2EE.bin")), $7084, 0 ; $2F1
        .soundChunk aSoundChunk2F2, len(binary("chunks/2F2.bin")), $FF62, 0 ; $2F2
        .soundChunk aSoundChunk2F3, len(binary("chunks/2F3.bin")), $FDEC, 0 ; $2F3
        .soundChunk aSoundChunk2F4, len(binary("chunks/2F4.bin")), $5F74, 0 ; $2F4
        .soundChunk aSoundChunk2F5, len(binary("chunks/2F5.bin")), $FF7A, 0 ; $2F5
        .soundChunk aSoundChunk2F6, len(binary("chunks/2F6.bin")), $FDFC, 0 ; $2F6
        .soundChunk aSoundChunk2F4, len(binary("chunks/2F4.bin")), $7084, 0 ; $2F7
        .soundChunk aSoundChunk2F8, len(binary("chunks/2F8.bin")), $FF62, 0 ; $2F8
        .soundChunk aSoundChunk2F9, len(binary("chunks/2F9.bin")), $FDEC, 0 ; $2F9
        .soundChunk aSoundChunk2FA, len(binary("chunks/2FA.bin")), $5F74, 0 ; $2FA
        .soundChunk aSoundChunk2FB, len(binary("chunks/2FB.bin")), $FF7A, 0 ; $2FB
        .soundChunk aSoundChunk2FC, len(binary("chunks/2FC.bin")), $FDFC, 0 ; $2FC
        .soundChunk aSoundChunk2FA, len(binary("chunks/2FA.bin")), $7084, 0 ; $2FD
        .soundChunk aSoundChunk2FE, len(binary("chunks/2FE.bin")), $FF62, 0 ; $2FE
        .soundChunk aSoundChunk2FF, len(binary("chunks/2FF.bin")), $FDEC, 0 ; $2FF
        .soundChunk aSoundChunk300, len(binary("chunks/300.bin")), $5F74, 0 ; $300
        .soundChunk aSoundChunk301, len(binary("chunks/301.bin")), $FF7A, 0 ; $301
        .soundChunk aSoundChunk302, len(binary("chunks/302.bin")), $FDFC, 0 ; $302
        .soundChunk aSoundChunk300, len(binary("chunks/300.bin")), $7084, 0 ; $303
        .soundChunk aSoundChunk304, len(binary("chunks/304.bin")), $FF62, 0 ; $304
        .soundChunk aSoundChunk305, len(binary("chunks/305.bin")), $FDEC, 0 ; $305
        .soundChunk aSoundChunk306, len(binary("chunks/306.bin")), $5F74, 0 ; $306
        .soundChunk aSoundChunk307, len(binary("chunks/307.bin")), $FF7A, 0 ; $307
        .soundChunk aSoundChunk308, len(binary("chunks/308.bin")), $FDFC, 0 ; $308
        .soundChunk aSoundChunk306, len(binary("chunks/306.bin")), $7084, 0 ; $309
        .soundChunk aSoundChunk30A, len(binary("chunks/30A.bin")), $FF62, 0 ; $30A
        .soundChunk aSoundChunk30B, len(binary("chunks/30B.bin")), $FDEC, 0 ; $30B
        .soundChunk aSoundChunk30C, len(binary("chunks/30C.bin")), $5F74, 0 ; $30C
        .soundChunk aSoundChunk30D, len(binary("chunks/30D.bin")), $FF7A, 0 ; $30D
        .soundChunk aSoundChunk30E, len(binary("chunks/30E.bin")), $FDFC, 0 ; $30E
        .soundChunk aSoundChunk30C, len(binary("chunks/30C.bin")), $7084, 0 ; $30F
        .soundChunk aSoundChunk310, len(binary("chunks/310.bin")), $FF62, 0 ; $310
        .soundChunk aSoundChunk311, len(binary("chunks/311.bin")), $FDEC, 0 ; $311
        .soundChunk aSoundChunk312, len(binary("chunks/312.bin")), $5F74, 0 ; $312
        .soundChunk aSoundChunk313, len(binary("chunks/313.bin")), $FF7A, 0 ; $313
        .soundChunk aSoundChunk314, len(binary("chunks/314.bin")), $FDFC, 0 ; $314
        .soundChunk aSoundChunk312, len(binary("chunks/312.bin")), $7084, 0 ; $315
        .soundChunk aSoundChunk316, len(binary("chunks/316.bin")), $FF62, 0 ; $316
        .soundChunk aSoundChunk317, len(binary("chunks/317.bin")), $FDEC, 0 ; $317
        .soundChunk aSoundChunk318, len(binary("chunks/318.bin")), $5F74, 0 ; $318
        .soundChunk aSoundChunk319, len(binary("chunks/319.bin")), $FF7A, 0 ; $319
        .soundChunk aSoundChunk31A, len(binary("chunks/31A.bin")), $FDFC, 0 ; $31A
        .soundChunk aSoundChunk318, len(binary("chunks/318.bin")), $7084, 0 ; $31B
        .soundChunk aSoundChunk31C, len(binary("chunks/31C.bin")), $FF62, 0 ; $31C
        .soundChunk aSoundChunk31D, len(binary("chunks/31D.bin")), $FDEC, 0 ; $31D
        .soundChunk aSoundChunk31E, len(binary("chunks/31E.bin")), $5F74, 0 ; $31E
        .soundChunk aSoundChunk31F, len(binary("chunks/31F.bin")), $FF7A, 0 ; $31F
        .soundChunk aSoundChunk320, len(binary("chunks/320.bin")), $FDFC, 0 ; $320
        .soundChunk aSoundChunk31E, len(binary("chunks/31E.bin")), $7084, 0 ; $321
        .soundChunk aSoundChunk322, len(binary("chunks/322.bin")), $FF62, 0 ; $322
        .soundChunk aSoundChunk323, len(binary("chunks/323.bin")), $FDEC, 0 ; $323
        .soundChunk aSoundChunk324, len(binary("chunks/324.bin")), $5F74, 0 ; $324
        .soundChunk aSoundChunk325, len(binary("chunks/325.bin")), $FF7A, 0 ; $325
        .soundChunk aSoundChunk326, len(binary("chunks/326.bin")), $FDFC, 0 ; $326
        .soundChunk aSoundChunk324, len(binary("chunks/324.bin")), $7084, 0 ; $327
        .soundChunk aSoundChunk328, len(binary("chunks/328.bin")), $FE6C, 0 ; $328
        .soundChunk aSoundChunk329, len(binary("chunks/329.bin")), $FD48, 0 ; $329
        .soundChunk aSoundChunk32A, len(binary("chunks/32A.bin")), $3204, 0 ; $32A
        .soundChunk aSoundChunk32B, len(binary("chunks/32B.bin")), $FEE4, 0 ; $32B
        .soundChunk aSoundChunk32C, len(binary("chunks/32C.bin")), $FD98, 0 ; $32C
        .soundChunk aSoundChunk32D, len(binary("chunks/32D.bin")), $4BA7, 0 ; $32D
        .soundChunk aSoundChunk32E, len(binary("chunks/32E.bin")), $FEE4, 0 ; $32E
        .soundChunk aSoundChunk32F, len(binary("chunks/32F.bin")), $FD98, 0 ; $32F
        .soundChunk aSoundChunk330, len(binary("chunks/330.bin")), $4BA7, 0 ; $330
        .soundChunk aSoundChunk331, len(binary("chunks/331.bin")), $FEE4, 0 ; $331
        .soundChunk aSoundChunk332, len(binary("chunks/332.bin")), $FD98, 0 ; $332
        .soundChunk aSoundChunk333, len(binary("chunks/333.bin")), $4BA7, 0 ; $333
        .soundChunk aSoundChunk334, len(binary("chunks/334.bin")), $FE66, 0 ; $334
        .soundChunk aSoundChunk335, len(binary("chunks/335.bin")), $FD44, 0 ; $335
        .soundChunk aSoundChunk336, len(binary("chunks/336.bin")), $AA70, 0 ; $336
        .soundChunk aSoundChunk337, len(binary("chunks/337.bin")), $FFF8, 0 ; $337
        .soundChunk aSoundChunk338, len(binary("chunks/338.bin")), $FFF8, 0 ; $338
        .soundChunk aSoundChunk339, len(binary("chunks/339.bin")), $FFF8, 0 ; $339
        .soundChunk aSoundChunk33A, len(binary("chunks/33A.bin")), $FFF8, 0 ; $33A
        .soundChunk aSoundChunk33B, len(binary("chunks/33B.bin")), $FF9E, 0 ; $33B
        .soundChunk aSoundChunk33C, len(binary("chunks/33C.bin")), $FF9E, 0 ; $33C
        .soundChunk aSoundChunk33D, len(binary("chunks/33D.bin")), $FF9E, 0 ; $33D
        .soundChunk aSoundChunk33E, len(binary("chunks/33E.bin")), $FF9E, 0 ; $33E
        .soundChunk aSoundChunk33F, len(binary("chunks/33F.bin")), $FF9E, 0 ; $33F
        .soundChunk aSoundChunk340, len(binary("chunks/340.bin")), $FFF8, 0 ; $340
        .soundChunk aSoundChunk341, len(binary("chunks/341.bin")), $FFF8, 0 ; $341
        .soundChunk aSoundChunk342, len(binary("chunks/342.bin")), $FFF8, 0 ; $342
        .soundChunk aSoundChunk343, len(binary("chunks/343.bin")), $FF50, 0 ; $343
        .soundChunk aSoundChunk344, len(binary("chunks/344.bin")), $FDE0, 0 ; $344
        .soundChunk aSoundChunk12D, len(binary("chunks/12D.bin")), $51E0, 0 ; $345
        .soundChunk aSoundChunk346, len(binary("chunks/346.bin")), $FF68, 0 ; $346
        .soundChunk aSoundChunk347, len(binary("chunks/347.bin")), $FDF0, 0 ; $347
        .soundChunk aSoundChunk12D, len(binary("chunks/12D.bin")), $62F0, 0 ; $348
        .soundChunk aSoundChunk349, len(binary("chunks/349.bin")), $FF50, 0 ; $349
        .soundChunk aSoundChunk34A, len(binary("chunks/34A.bin")), $FDE0, 0 ; $34A
        .soundChunk aSoundChunk11F, len(binary("chunks/11F.bin")), $51E0, 0 ; $34B
        .soundChunk aSoundChunk34C, len(binary("chunks/34C.bin")), $FF68, 0 ; $34C
        .soundChunk aSoundChunk34D, len(binary("chunks/34D.bin")), $FDF0, 0 ; $34D
        .soundChunk aSoundChunk11F, len(binary("chunks/11F.bin")), $62F0, 0 ; $34E
        .soundChunk aSoundChunk34F, len(binary("chunks/34F.bin")), $FE66, 0 ; $34F
        .soundChunk aSoundChunk350, len(binary("chunks/350.bin")), $FD44, 0 ; $350
        .soundChunk aSoundChunk276, len(binary("chunks/276.bin")), $A000, 0 ; $351
        .soundChunk aSoundChunk352, len(binary("chunks/352.bin")), $FE00, 0 ; $352
        .soundChunk aSoundChunk353, len(binary("chunks/353.bin")), $FD00, 0 ; $353
        .soundChunk aSoundChunk126, len(binary("chunks/126.bin")), $2800, 0 ; $354
        .soundChunk aSoundChunk27C, len(binary("chunks/27C.bin")), $0000, 0 ; $355
        .soundChunk aSoundChunk23A, len(binary("chunks/23A.bin")), $0000, 0 ; $356
        .soundChunk aSoundChunk357, len(binary("chunks/357.bin")), $FF62, 0 ; $357
        .soundChunk aSoundChunk358, len(binary("chunks/358.bin")), $FF7A, 0 ; $358
        .soundChunk aSoundChunk359, len(binary("chunks/359.bin")), $FF62, 0 ; $359
        .soundChunk aSoundChunk35A, len(binary("chunks/35A.bin")), $FF7A, 0 ; $35A
        .soundChunk aSoundChunk35B, len(binary("chunks/35B.bin")), $FF62, 0 ; $35B
        .soundChunk aSoundChunk35C, len(binary("chunks/35C.bin")), $FF7A, 0 ; $35C
        .soundChunk aSoundChunk35D, len(binary("chunks/35D.bin")), $FF62, 0 ; $35D
        .soundChunk aSoundChunk35E, len(binary("chunks/35E.bin")), $FF7A, 0 ; $35E
        .soundChunk aSoundChunk35F, len(binary("chunks/35F.bin")), $FF62, 0 ; $35F
        .soundChunk aSoundChunk360, len(binary("chunks/360.bin")), $FF7A, 0 ; $360
        .soundChunk aSoundChunk361, len(binary("chunks/361.bin")), $FF62, 0 ; $361
        .soundChunk aSoundChunk362, len(binary("chunks/362.bin")), $FF7A, 0 ; $362
        .soundChunk aSoundChunk363, len(binary("chunks/363.bin")), $FF62, 0 ; $363
        .soundChunk aSoundChunk364, len(binary("chunks/364.bin")), $FF7A, 0 ; $364
        .soundChunk aSoundChunk365, len(binary("chunks/365.bin")), $FF62, 0 ; $365
        .soundChunk aSoundChunk366, len(binary("chunks/366.bin")), $FF7A, 0 ; $366
        .soundChunk aSoundChunk367, len(binary("chunks/367.bin")), $FF62, 0 ; $367
        .soundChunk aSoundChunk368, len(binary("chunks/368.bin")), $FF7A, 0 ; $368

      aSoundScripts ; F7/943E

        ; Indexed by request - 1.
        .word <>aSoundScriptF795EA ; 1
        .word <>aSoundScriptF795F0 ; 2
        .word <>aSoundScriptF795F6 ; 3
        .word <>aSoundScriptF7988A ; 4
        .word <>aSoundScriptF79588 ; 5
        .word <>aSoundScriptF795B8 ; 6
        .word <>aSoundScriptF795BE ; 7
        .word <>aSoundScriptF795CA ; 8
        .word <>aSoundScriptF795A4 ; 9
        .word <>aSoundScriptF795AE ; 10
        .word <>aSoundScriptF795FC ; 11
        .word <>aSoundScriptF79614 ; 12
        .word <>aSoundScriptF7961A ; 13
        .word <>aSoundScriptF7960E ; 14
        .word <>aSoundScriptF79626 ; 15
        .word <>aSoundScriptF7957E ; 16
        .word <>aSoundScriptF7962C ; 17
        .word <>aSoundScriptF79636 ; 18
        .word <>aSoundScriptF79640 ; 19
        .word <>aSoundScriptF7964A ; 20
        .word <>aSoundScriptF795D6 ; 21
        .word <>aSoundScriptF795E4 ; 22
        .word <>aSoundScriptF79726 ; 23
        .word <>aSoundScriptF79654 ; 24
        .word <>aSoundScriptF79730 ; 25
        .word <>aSoundScriptF798F8 ; 26
        .word <>aSoundScriptF7965E ; 27
        .word <>aSoundScriptF79668 ; 28
        .word <>aSoundScriptF79672 ; 29
        .word <>aSoundScriptF7967C ; 30
        .word <>aSoundScriptF79686 ; 31
        .word <>aSoundScriptF79690 ; 32
        .word <>aSoundScriptF796CC ; 33
        .word <>aSoundScriptF796D6 ; 34
        .word <>aSoundScriptF796E0 ; 35
        .word <>aSoundScriptF796EA ; 36
        .word <>aSoundScriptF796F4 ; 37
        .word <>aSoundScriptF796FE ; 38
        .word <>aSoundScriptF79708 ; 39
        .word <>aSoundScriptF79712 ; 40
        .word <>aSoundScriptF7971C ; 41
        .word <>aSoundScriptF7969A ; 42
        .word <>aSoundScriptF796A4 ; 43
        .word <>aSoundScriptF796AE ; 44
        .word <>aSoundScriptF796B8 ; 45
        .word <>aSoundScriptF796C2 ; 46
        .word <>aSoundScriptF795C4 ; 47
        .word <>aSoundScriptF795D0 ; 48
        .word <>aSoundScriptF79764 ; 49
        .word <>aSoundScriptF79756 ; 50
        .word <>aSoundScriptF797EC ; 51
        .word <>aSoundScriptF7973A ; 52
        .word <>aSoundScriptF79748 ; 53
        .word <>aSoundScriptF7978E ; 54
        .word <>aSoundScriptF79772 ; 55
        .word <>aSoundScriptF79780 ; 56
        .word <>aSoundScriptF797BE ; 57
        .word <>aSoundScriptF797D0 ; 58
        .word <>aSoundScriptF797DE ; 59
        .word <>aSoundScriptF7979C ; 60
        .word <>aSoundScriptF797A6 ; 61
        .word <>aSoundScriptF797B0 ; 62
        .word <>aSoundScriptF797C4 ; 63
        .word <>aSoundScriptF797CA ; 64
        .word <>aSoundScriptF79826 ; 65
        .word <>aSoundScriptF7981C ; 66
        .word <>aSoundScriptF798EE ; 67
        .word <>aSoundScriptF79808 ; 68
        .word <>aSoundScriptF79812 ; 69
        .word <>aSoundScriptF79844 ; 70
        .word <>aSoundScriptF79830 ; 71
        .word <>aSoundScriptF7983A ; 72
        .word <>aSoundScriptF7986C ; 73
        .word <>aSoundScriptF79876 ; 74
        .word <>aSoundScriptF79880 ; 75
        .word <>aSoundScriptF79826 ; 76
        .word <>aSoundScriptF7984E ; 77
        .word <>aSoundScriptF79858 ; 78
        .word <>aSoundScriptF79862 ; 79
        .word <>aSoundScriptF797FA ; 80
        .word <>aSoundScriptF799A2 ; 81
        .word <>aSoundScriptF79608 ; 82
        .word <>aSoundScriptF799D4 ; 83
        .word <>aSoundScriptF7990C ; 84
        .word <>aSoundScriptF79916 ; 85
        .word <>aSoundScriptF79920 ; 86
        .word <>aSoundScriptF798C6 ; 87
        .word <>aSoundScriptF7992A ; 88
        .word <>aSoundScriptF79A24 ; 89
        .word <>aSoundScriptF79620 ; 90
        .word <>aSoundScriptF79A10 ; 91
        .word <>aSoundScriptF79A42 ; 92
        .word <>aSoundScriptF799B6 ; 93
        .word <>aSoundScriptF79A1A ; 94
        .word <>aSoundScriptF799DE ; 95
        .word <>aSoundScriptF799CA ; 96
        .word <>aSoundScriptF79A2E ; 97
        .word <>aSoundScriptF79A38 ; 98
        .word <>aSoundScriptF79934 ; 99
        .word <>aSoundScriptF79A9C ; 100
        .word <>aSoundScriptF79A92 ; 101
        .word <>aSoundScriptF79AA6 ; 102
        .word <>aSoundScriptF79AB0 ; 103
        .word <>aSoundScriptF79ABA ; 104
        .word <>aSoundScriptF79AC4 ; 105
        .word <>aSoundScriptF79ACE ; 106
        .word <>aSoundScriptF79AD8 ; 107
        .word <>aSoundScriptF79B28 ; 108
        .word <>aSoundScriptF798DA ; 109
        .word <>aSoundScriptF798E4 ; 110
        .word <>aSoundScriptF799AC ; 111
        .word <>aSoundScriptF799E8 ; 112
        .word <>aSoundScriptF798D0 ; 113
        .word <>aSoundScriptF799C0 ; 114
        .word <>aSoundScriptF79902 ; 115
        .word <>aSoundScriptF79AE2 ; 116
        .word <>aSoundScriptF79AEC ; 117
        .word <>aSoundScriptF79AF6 ; 118
        .word <>aSoundScriptF79B14 ; 119
        .word <>aSoundScriptF79B1E ; 120
        .word <>aSoundScriptF7962C ; 121
        .word <>aSoundScriptF7993E ; 122
        .word <>aSoundScriptF79948 ; 123
        .word <>aSoundScriptF79B00 ; 124
        .word <>aSoundScriptF79B0A ; 125
        .word <>aSoundScriptF79984 ; 126
        .word <>aSoundScriptF7962C ; 127
        .word <>aSoundScriptF7962C ; 128
        .word <>aSoundScriptF79952 ; 129
        .word <>aSoundScriptF7995C ; 130
        .word <>aSoundScriptF79966 ; 131
        .word <>aSoundScriptF79970 ; 132
        .word <>aSoundScriptF7998E ; 133
        .word <>aSoundScriptF79998 ; 134
        .word <>aSoundScriptF7997A ; 135
        .word <>aSoundScriptF79894 ; 136
        .word <>aSoundScriptF7989E ; 137
        .word <>aSoundScriptF798A8 ; 138
        .word <>aSoundScriptF798B2 ; 139
        .word <>aSoundScriptF798BC ; 140
        .word <>aSoundScriptF79602 ; 141
        .word <>aSoundScriptF7958E ; 142
        .word <>aSoundScriptF79598 ; 143
        .word <>aSoundScriptF7959E ; 144
        .word <>aSoundScriptF799F2 ; 145
        .word <>aSoundScriptF799FC ; 146
        .word <>aSoundScriptF79A06 ; 147
        .word <>aSoundScriptF79A4C ; 148
        .word <>aSoundScriptF79A56 ; 149
        .word <>aSoundScriptF79A60 ; 150
        .word <>aSoundScriptF79A6A ; 151
        .word <>aSoundScriptF79A74 ; 152
        .word <>aSoundScriptF79A7E ; 153
        .word <>aSoundScriptF79A88 ; 154
        .word <>aSoundScriptF7962C ; 155
        .word <>aSoundScriptF7962C ; 156
        .word <>aSoundScriptF7962C ; 157
        .word <>aSoundScriptF7962C ; 158
        .word <>aSoundScriptF7962C ; 159
        .word <>aSoundScriptF7962C ; 160

      aSoundScriptF7957E
        .word $2C00, <>aSoundUploadF79C62
        .word $0C00, $0031
        .word $0000

      aSoundScriptF79588
        .word $2C00, <>aSoundUploadF79C6C
        .word $0000

      aSoundScriptF7958E
        .word $2C00, <>aSoundUploadF79C9E
        .word $4400, $00C9
        .word $0000

      aSoundScriptF79598
        .word $0C00, $0003
        .word $0000

      aSoundScriptF7959E
        .word $1400, $00D0
        .word $0000

      aSoundScriptF795A4
        .word $2C00, <>aSoundUploadF79CBC
        .word $0C2E, $000C
        .word $0000

      aSoundScriptF795AE
        .word $2C00, <>aSoundUploadF79CCA
        .word $0C2C, $000D
        .word $0000

      aSoundScriptF795B8
        .word $2C00, <>aSoundUploadF79CD8
        .word $0000

      aSoundScriptF795BE
        .word $0C00, $000E
        .word $0000

      aSoundScriptF795C4
        .word $0C00, $000F
        .word $0000

      aSoundScriptF795CA
        .word $1800, $08C8
        .word $0000

      aSoundScriptF795D0
        .word $0C00, $000D
        .word $0000

      aSoundScriptF795D6
        .word $2C00, <>aSoundUploadF79CF4
        .word $4404, $00C4
        .word $0C00, $0004
        .word $0000

      aSoundScriptF795E4
        .word $0C00, $0012
        .word $0000

      aSoundScriptF795EA
        .word $2C00, <>aSoundUploadF7ACE6
        .word $0000

      aSoundScriptF795F0
        .word $2C00, <>aSoundUploadF7AD02
        .word $0000

      aSoundScriptF795F6
        .word $2C00, <>aSoundUploadF7AD24
        .word $0000

      aSoundScriptF795FC
        .word $2C00, <>aSoundUploadF7AD74
        .word $0000

      aSoundScriptF79602
        .word $2C00, <>aSoundUploadF7AD46
        .word $0000

      aSoundScriptF79608
        .word $2C00, <>aSoundUploadF7AD60
        .word $0000

      aSoundScriptF7960E
        .word $2C00, <>aSoundUploadF7A7AA
        .word $0000

      aSoundScriptF79614
        .word $2C00, <>aSoundUploadF7A7D2
        .word $0000

      aSoundScriptF7961A
        .word $2C00, <>aSoundUploadF7A76A
        .word $0000

      aSoundScriptF79620
        .word $2C00, <>aSoundUploadF7A78A
        .word $0000

      aSoundScriptF79626
        .word $2C00, <>aSoundUploadF7A7FA
        .word $0000

      aSoundScriptF7962C
        .word $2C04, <>aSoundUploadF7A058
        .word $4400, $00CB
        .word $0000

      aSoundScriptF79636
        .word $2C04, <>aSoundUploadF7A072
        .word $4400, $00CB
        .word $0000

      aSoundScriptF79640
        .word $2C04, <>aSoundUploadF7A098
        .word $4400, $00CB
        .word $0000

      aSoundScriptF7964A
        .word $2C04, <>aSoundUploadF7A0BC
        .word $4400, $00CB
        .word $0000

      aSoundScriptF79654
        .word $2C04, <>aSoundUploadF7A0F4
        .word $4400, $00CB
        .word $0000

      aSoundScriptF7965E
        .word $2C04, <>aSoundUploadF7A10E
        .word $4400, $00CB
        .word $0000

      aSoundScriptF79668
        .word $2C04, <>aSoundUploadF7A12E
        .word $4400, $00CB
        .word $0000

      aSoundScriptF79672
        .word $2C04, <>aSoundUploadF7A14E
        .word $4400, $00CB
        .word $0000

      aSoundScriptF7967C
        .word $2C04, <>aSoundUploadF7A168
        .word $4400, $00CB
        .word $0000

      aSoundScriptF79686
        .word $2C04, <>aSoundUploadF7A186
        .word $4400, $00CB
        .word $0000

      aSoundScriptF79690
        .word $2C04, <>aSoundUploadF7A1A0
        .word $4400, $00CB
        .word $0000

      aSoundScriptF7969A
        .word $2C04, <>aSoundUploadF7A1BE
        .word $4400, $00CB
        .word $0000

      aSoundScriptF796A4
        .word $2C04, <>aSoundUploadF7A1DA
        .word $4400, $00CB
        .word $0000

      aSoundScriptF796AE
        .word $2C04, <>aSoundUploadF7A1F6
        .word $4400, $00CB
        .word $0000

      aSoundScriptF796B8
        .word $2C04, <>aSoundUploadF7A21A
        .word $4400, $00CB
        .word $0000

      aSoundScriptF796C2
        .word $2C04, <>aSoundUploadF7A21A
        .word $4400, $00CC
        .word $0000

      aSoundScriptF796CC
        .word $2C04, <>aSoundUploadF7A23E
        .word $4400, $00CB
        .word $0000

      aSoundScriptF796D6
        .word $2C04, <>aSoundUploadF7A258
        .word $4400, $00CB
        .word $0000

      aSoundScriptF796E0
        .word $2C04, <>aSoundUploadF7A276
        .word $4400, $00CB
        .word $0000

      aSoundScriptF796EA
        .word $2C04, <>aSoundUploadF7A292
        .word $4400, $00CB
        .word $0000

      aSoundScriptF796F4
        .word $2C04, <>aSoundUploadF7A2B0
        .word $4400, $00CB
        .word $0000

      aSoundScriptF796FE
        .word $2C04, <>aSoundUploadF7A2CC
        .word $4400, $00CB
        .word $0000

      aSoundScriptF79708
        .word $2C04, <>aSoundUploadF7A2E8
        .word $4400, $00CB
        .word $0000

      aSoundScriptF79712
        .word $2C04, <>aSoundUploadF7A302
        .word $4400, $00CB
        .word $0000

      aSoundScriptF7971C
        .word $2C04, <>aSoundUploadF7A322
        .word $4400, $00CB
        .word $0000

      aSoundScriptF79726
        .word $2C04, <>aSoundUploadF7A0D8
        .word $4400, $00CB
        .word $0000

      aSoundScriptF79730
        .word $2C04, <>aSoundUploadF7A0D8
        .word $4400, $00CC
        .word $0000

      aSoundScriptF7973A
        .word $2C00, <>aSoundUploadF7A33C
        .word $4804, $0000
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79748
        .word $2C00, <>aSoundUploadF7A366
        .word $4804, $0000
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79756
        .word $2C00, <>aSoundUploadF7A38E
        .word $4804, $0000
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79764
        .word $2C00, <>aSoundUploadF7A3AE
        .word $4804, $0000
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79772
        .word $2C00, <>aSoundUploadF7A3D4
        .word $4804, $0001
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79780
        .word $2C00, <>aSoundUploadF7A3F0
        .word $4804, $0000
        .word $4400, $00C8
        .word $0000

      aSoundScriptF7978E
        .word $2C00, <>aSoundUploadF7A414
        .word $4804, $0000
        .word $4400, $00C8
        .word $0000

      aSoundScriptF7979C
        .word $2C00, <>aSoundUploadF7A43A
        .word $4400, $00C8
        .word $0000

      aSoundScriptF797A6
        .word $2C00, <>aSoundUploadF7A452
        .word $4400, $00C8
        .word $0000

      aSoundScriptF797B0
        .word $2C00, <>aSoundUploadF7A472
        .word $4804, $0000
        .word $4400, $00C8
        .word $0000

      aSoundScriptF797BE
        .word $2C00, <>aSoundUploadF7A49A
        .word $0000

      aSoundScriptF797C4
        .word $3400, <>aSoundUploadF7A49A
        .word $0000

      aSoundScriptF797CA
        .word $2C00, <>aSoundUploadF7A4AE
        .word $0000

      aSoundScriptF797D0
        .word $2C00, <>aSoundUploadF7A4C2
        .word $4804, $0000
        .word $4400, $00C8
        .word $0000

      aSoundScriptF797DE
        .word $3400, <>aSoundUploadF7A4DC
        .word $4804, $0000
        .word $4400, $00C8
        .word $0000

      aSoundScriptF797EC
        .word $2C00, <>aSoundUploadF7A4FA
        .word $4804, $0000
        .word $4400, $00C8
        .word $0000

      aSoundScriptF797FA
        .word $2C00, <>aSoundUploadF7A51C
        .word $4804, $0000
        .word $4400, $00C9
        .word $0000

      aSoundScriptF79808
        .word $2C00, <>aSoundUploadF7A53C
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79812
        .word $2C00, <>aSoundUploadF7A55C
        .word $4400, $00C8
        .word $0000

      aSoundScriptF7981C
        .word $2C00, <>aSoundUploadF7A57A
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79826
        .word $2C00, <>aSoundUploadF7A590
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79830
        .word $2C00, <>aSoundUploadF7A5AC
        .word $4400, $00C8
        .word $0000

      aSoundScriptF7983A
        .word $2C00, <>aSoundUploadF7A5BE
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79844
        .word $2C00, <>aSoundUploadF7A5D8
        .word $4400, $00C9
        .word $0000

      aSoundScriptF7984E
        .word $2C00, <>aSoundUploadF7A5F4
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79858
        .word $2C00, <>aSoundUploadF7A606
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79862
        .word $2C00, <>aSoundUploadF7A61C
        .word $4400, $00C8
        .word $0000

      aSoundScriptF7986C
        .word $2C00, <>aSoundUploadF7A63A
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79876
        .word $2C00, <>aSoundUploadF7A64E
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79880
        .word $2C00, <>aSoundUploadF7A65E
        .word $4400, $00C9
        .word $0000

      aSoundScriptF7988A
        .word $2C00, <>aSoundUploadF7A68C
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79894
        .word $2C00, <>aSoundUploadF7A69E
        .word $4400, $00CB
        .word $0000

      aSoundScriptF7989E
        .word $2C00, <>aSoundUploadF7A6E4
        .word $4400, $00CB
        .word $0000

      aSoundScriptF798A8
        .word $2C00, <>aSoundUploadF7A6FC
        .word $4400, $00CB
        .word $0000

      aSoundScriptF798B2
        .word $2C00, <>aSoundUploadF7A714
        .word $4400, $00CB
        .word $0000

      aSoundScriptF798BC
        .word $2C00, <>aSoundUploadF7A72A
        .word $4400, $00CB
        .word $0000

      aSoundScriptF798C6
        .word $2C00, <>aSoundUploadF7A742
        .word $4400, $00CB
        .word $0000

      aSoundScriptF798D0
        .word $2C00, <>aSoundUploadF7A754
        .word $4400, $00CB
        .word $0000

      aSoundScriptF798DA
        .word $2C00, <>aSoundUploadF7A6B6
        .word $4400, $00CB
        .word $0000

      aSoundScriptF798E4
        .word $2C00, <>aSoundUploadF7A6CA
        .word $4400, $00CB
        .word $0000

      aSoundScriptF798EE
        .word $2C00, <>aSoundUploadF7A81E
        .word $4400, $00C8
        .word $0000

      aSoundScriptF798F8
        .word $2C00, <>aSoundUploadF7A836
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79902
        .word $2C00, <>aSoundUploadF7A852
        .word $4400, $00C8
        .word $0000

      aSoundScriptF7990C
        .word $2C00, <>aSoundUploadF7A888
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79916
        .word $2C00, <>aSoundUploadF7A8A0
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79920
        .word $2C00, <>aSoundUploadF7A8BA
        .word $4400, $00C8
        .word $0000

      aSoundScriptF7992A
        .word $2C00, <>aSoundUploadF7A8D2
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79934
        .word $2C00, <>aSoundUploadF7A8E8
        .word $4400, $00C8
        .word $0000

      aSoundScriptF7993E
        .word $2C00, <>aSoundUploadF7A900
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79948
        .word $2C00, <>aSoundUploadF7A914
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79952
        .word $2C00, <>aSoundUploadF7A928
        .word $4400, $00C8
        .word $0000

      aSoundScriptF7995C
        .word $2C00, <>aSoundUploadF7A940
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79966
        .word $2C00, <>aSoundUploadF7A95C
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79970
        .word $2C00, <>aSoundUploadF7A972
        .word $4400, $00C8
        .word $0000

      aSoundScriptF7997A
        .word $2C00, <>aSoundUploadF7A988
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79984
        .word $2C00, <>aSoundUploadF7A988
        .word $4400, $00C9
        .word $0000

      aSoundScriptF7998E
        .word $2C00, <>aSoundUploadF7A9A8
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79998
        .word $2C00, <>aSoundUploadF7A9BE
        .word $4400, $00C8
        .word $0000

      aSoundScriptF799A2
        .word $2C00, <>aSoundUploadF7A9D0
        .word $4400, $00C8
        .word $0000

      aSoundScriptF799AC
        .word $2C00, <>aSoundUploadF7A9E6
        .word $4400, $00C8
        .word $0000

      aSoundScriptF799B6
        .word $2C00, <>aSoundUploadF7A9FE
        .word $4400, $00C8
        .word $0000

      aSoundScriptF799C0
        .word $2C00, <>aSoundUploadF7A9FE
        .word $4400, $00C9
        .word $0000

      aSoundScriptF799CA
        .word $2C00, <>aSoundUploadF7AA12
        .word $4400, $00C8
        .word $0000

      aSoundScriptF799D4
        .word $2C00, <>aSoundUploadF7AA24
        .word $4400, $00C8
        .word $0000

      aSoundScriptF799DE
        .word $2C00, <>aSoundUploadF7AA24
        .word $4400, $00C9
        .word $0000

      aSoundScriptF799E8
        .word $2C00, <>aSoundUploadF7AA38
        .word $4400, $00C8
        .word $0000

      aSoundScriptF799F2
        .word $2C00, <>aSoundUploadF7AA50
        .word $4400, $00C8
        .word $0000

      aSoundScriptF799FC
        .word $2C00, <>aSoundUploadF7AA6A
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A06
        .word $2C00, <>aSoundUploadF7AA82
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A10
        .word $2C00, <>aSoundUploadF7AA98
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A1A
        .word $2C00, <>aSoundUploadF7AAAC
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A24
        .word $2C00, <>aSoundUploadF7AAC4
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A2E
        .word $2C00, <>aSoundUploadF7AADA
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A38
        .word $2C00, <>aSoundUploadF7AAEE
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A42
        .word $2C00, <>aSoundUploadF7AB02
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A4C
        .word $2C00, <>aSoundUploadF7AB18
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A56
        .word $2C00, <>aSoundUploadF7AB2E
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A60
        .word $2C00, <>aSoundUploadF7AB44
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A6A
        .word $2C00, <>aSoundUploadF7AB5C
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A74
        .word $2C00, <>aSoundUploadF7AB70
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A7E
        .word $2C00, <>aSoundUploadF7AB88
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A88
        .word $2C00, <>aSoundUploadF7ABA0
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A92
        .word $2C00, <>aSoundUploadF7ABB6
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79A9C
        .word $2C00, <>aSoundUploadF7ABD2
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79AA6
        .word $2C00, <>aSoundUploadF7ABE8
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79AB0
        .word $2C00, <>aSoundUploadF7AC00
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79ABA
        .word $2C00, <>aSoundUploadF7AC16
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79AC4
        .word $2C00, <>aSoundUploadF7AC2E
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79ACE
        .word $2C00, <>aSoundUploadF7AC42
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79AD8
        .word $2C00, <>aSoundUploadF7AC54
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79AE2
        .word $2C00, <>aSoundUploadF7AC6E
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79AEC
        .word $2C00, <>aSoundUploadF7AC84
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79AF6
        .word $2C00, <>aSoundUploadF7AC9C
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79B00
        .word $2C00, <>aSoundUploadF7AC9C
        .word $4400, $00C9
        .word $0000

      aSoundScriptF79B0A
        .word $2C00, <>aSoundUploadF7AC9C
        .word $4400, $00CA
        .word $0000

      aSoundScriptF79B14
        .word $2C00, <>aSoundUploadF7ACB8
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79B1E
        .word $2C00, <>aSoundUploadF7ACCE
        .word $4400, $00C8
        .word $0000

      aSoundScriptF79B28
        .word $2C00, <>aSoundUploadF7A86E
        .word $4400, $00C8
        .word $0000

      aSoundUploadLists ; F7/9B32

        .word 0 ; $00
        .word 0 ; $01
        .word 0 ; $02
        .word 0 ; $03
        .word <>aSoundUploadF79EF6 ; $04
        .word <>aSoundUploadF79EF6 ; $05
        .word <>aSoundUploadF79EF8 ; $06
        .word <>aSoundUploadF79F00 ; $07
        .word <>aSoundUploadF79EF8 ; $08
        .word <>aSoundUploadF79F00 ; $09
        .word <>aSoundUploadF79F08 ; $0A
        .word <>aSoundUploadF79F10 ; $0B
        .word <>aSoundUploadF79F18 ; $0C
        .word <>aSoundUploadF79F20 ; $0D
        .word <>aSoundUploadF79F48 ; $0E
        .word <>aSoundUploadF79F50 ; $0F
        .word <>aSoundUploadF79F58 ; $10
        .word <>aSoundUploadF79F60 ; $11
        .word <>aSoundUploadF79F68 ; $12
        .word <>aSoundUploadF79F70 ; $13
        .word <>aSoundUploadF79F28 ; $14
        .word <>aSoundUploadF79F30 ; $15
        .word <>aSoundUploadF79F38 ; $16
        .word <>aSoundUploadF79F40 ; $17
        .word <>aSoundUploadF79F78 ; $18
        .word <>aSoundUploadF79F80 ; $19
        .word <>aSoundUploadF79F88 ; $1A
        .word <>aSoundUploadF79F90 ; $1B
        .word <>aSoundUploadF79F98 ; $1C
        .word <>aSoundUploadF79FA0 ; $1D
        .word <>aSoundUploadF79FA8 ; $1E
        .word <>aSoundUploadF79FB0 ; $1F
        .word <>aSoundUploadF79FB8 ; $20
        .word <>aSoundUploadF79FC0 ; $21
        .word <>aSoundUploadF79FC8 ; $22
        .word <>aSoundUploadF79FD0 ; $23
        .word <>aSoundUploadF79FD8 ; $24
        .word <>aSoundUploadF79FE0 ; $25
        .word <>aSoundUploadF79FE8 ; $26
        .word <>aSoundUploadF79FF0 ; $27
        .word <>aSoundUploadF79FF8 ; $28
        .word <>aSoundUploadF7A000 ; $29
        .word <>aSoundUploadF7A008 ; $2A
        .word <>aSoundUploadF7A010 ; $2B
        .word <>aSoundUploadF7A018 ; $2C
        .word <>aSoundUploadF7A020 ; $2D
        .word <>aSoundUploadF7A028 ; $2E
        .word <>aSoundUploadF7A030 ; $2F
        .word <>aSoundUploadF7A038 ; $30
        .word <>aSoundUploadF7A040 ; $31
        .word <>aSoundUploadF7A048 ; $32
        .word <>aSoundUploadF7A050 ; $33
        .word 0 ; $34
        .word 0 ; $35
        .word 0 ; $36
        .word 0 ; $37
        .word 0 ; $38
        .word 0 ; $39
        .word 0 ; $3A
        .word 0 ; $3B
        .word <>aSoundUploadF79C80 ; $3C
        .word <>aSoundUploadF79C8A ; $3D
        .word <>aSoundUploadF79C94 ; $3E
        .word <>aSoundUploadF79C94 ; $3F
        .word <>aSoundUploadF79C94 ; $40
        .word <>aSoundUploadF79C94 ; $41
        .word <>aSoundUploadF79C94 ; $42
        .word <>aSoundUploadF79C94 ; $43

      aSoundTerrainUploads ; F7/9BBA

        .word <>aSoundUploadF79D06
        .word <>aSoundUploadF79D0E
        .word <>aSoundUploadF79D16
        .word <>aSoundUploadF79D1E
        .word <>aSoundUploadF79D26
        .word <>aSoundUploadF79D2E
        .word <>aSoundUploadF79D36
        .word <>aSoundUploadF79D3E
        .word <>aSoundUploadF79D46
        .word <>aSoundUploadF79D4E
        .word <>aSoundUploadF79EA6
        .word <>aSoundUploadF79EAE
        .word <>aSoundUploadF79D56
        .word <>aSoundUploadF79D5E
        .word <>aSoundUploadF79D66
        .word <>aSoundUploadF79D6E
        .word <>aSoundUploadF79D76
        .word <>aSoundUploadF79D7E
        .word <>aSoundUploadF79D86
        .word <>aSoundUploadF79D8E
        .word <>aSoundUploadF79D96
        .word <>aSoundUploadF79D9E
        .word <>aSoundUploadF79EC6
        .word <>aSoundUploadF79ECE
        .word <>aSoundUploadF79D56
        .word <>aSoundUploadF79D5E
        .word <>aSoundUploadF79D66
        .word <>aSoundUploadF79D6E
        .word <>aSoundUploadF79D76
        .word <>aSoundUploadF79D7E
        .word <>aSoundUploadF79D86
        .word <>aSoundUploadF79D8E
        .word <>aSoundUploadF79D96
        .word <>aSoundUploadF79D9E
        .word <>aSoundUploadF79EC6
        .word <>aSoundUploadF79ECE
        .word <>aSoundUploadF79DA6
        .word <>aSoundUploadF79DAE
        .word <>aSoundUploadF79DB6
        .word <>aSoundUploadF79DBE
        .word <>aSoundUploadF79DC6
        .word <>aSoundUploadF79DCE
        .word <>aSoundUploadF79DD6
        .word <>aSoundUploadF79DDE
        .word <>aSoundUploadF79DE6
        .word <>aSoundUploadF79DEE
        .word <>aSoundUploadF79ED6
        .word <>aSoundUploadF79EDE
        .word <>aSoundUploadF79DF6
        .word <>aSoundUploadF79DFE
        .word <>aSoundUploadF79E06
        .word <>aSoundUploadF79E0E
        .word <>aSoundUploadF79E16
        .word <>aSoundUploadF79E1E
        .word <>aSoundUploadF79E26
        .word <>aSoundUploadF79E2E
        .word <>aSoundUploadF79E36
        .word <>aSoundUploadF79E3E
        .word <>aSoundUploadF79EE6
        .word <>aSoundUploadF79EEE
        .word <>aSoundUploadF79E46
        .word <>aSoundUploadF79E4E
        .word <>aSoundUploadF79E46
        .word <>aSoundUploadF79E4E
        .word <>aSoundUploadF79E46
        .word <>aSoundUploadF79E4E
        .word <>aSoundUploadF79E46
        .word <>aSoundUploadF79E4E
        .word <>aSoundUploadF79E46
        .word <>aSoundUploadF79E4E
        .word <>aSoundUploadF79E46
        .word <>aSoundUploadF79E4E
        .word <>aSoundUploadF79E56
        .word <>aSoundUploadF79E5E
        .word <>aSoundUploadF79E66
        .word <>aSoundUploadF79E6E
        .word <>aSoundUploadF79E76
        .word <>aSoundUploadF79E7E
        .word <>aSoundUploadF79E86
        .word <>aSoundUploadF79E8E
        .word <>aSoundUploadF79E96
        .word <>aSoundUploadF79E9E
        .word <>aSoundUploadF79EB6
        .word <>aSoundUploadF79EBE

      aSoundUploadF79C62
        .word $003C, $0334, $0335, $0336, $0000

      aSoundUploadF79C6C
        .word $F000, $0343, $0344, $0345, $0000

      aSoundUploadF79C76
        .word $0340, $0328, $0329, $032A, $0000

      aSoundUploadF79C80
        .word $00D4, $032B, $032C, $032D, $0000

      aSoundUploadF79C8A
        .word $00D6, $032E, $032F, $0330, $0000

      aSoundUploadF79C94
        .word $00D5, $0331, $0332, $0333, $0000

      aSoundUploadF79C9E
        .word $008E, $0198, $0199, $C000, $5000, $0123, $0124, $0125
        .word $00EC, $0103, $00F5, $00D6, $0337, $F000, $0000

      aSoundUploadF79CBC
        .word $0224, $0225, $C000, $7400, $0143, $003C, $0000

      aSoundUploadF79CCA
        .word $0226, $0227, $C000, $7400, $0144, $003C, $0000

      aSoundUploadF79CD8
        .word $00A6, $0064, $0228, $0229, $C000, $7400, $00FE, $0101
        .word $0145, $0144, $003C, $033F, $033A, $0000

      aSoundUploadF79CF4
        .word $B000, $003D, $022A, $022B, $C000, $5000, $0355, $0356
        .word $0000

      aSoundUploadF79D06
        .word $02A4, $02A5, $02A6, $0000

      aSoundUploadF79D0E
        .word $02A7, $02A8, $02A9, $0000

      aSoundUploadF79D16
        .word $02AA, $02AB, $02AC, $0000

      aSoundUploadF79D1E
        .word $02AD, $02AE, $02AF, $0000

      aSoundUploadF79D26
        .word $02B0, $02B1, $02B2, $0000

      aSoundUploadF79D2E
        .word $02B3, $02B4, $02B5, $0000

      aSoundUploadF79D36
        .word $02B6, $02B7, $02B8, $0000

      aSoundUploadF79D3E
        .word $02B9, $02BA, $02BB, $0000

      aSoundUploadF79D46
        .word $02BC, $02BD, $02BE, $0000

      aSoundUploadF79D4E
        .word $02BF, $02C0, $02C1, $0000

      aSoundUploadF79D56
        .word $02C2, $02C3, $02C4, $0000

      aSoundUploadF79D5E
        .word $02C5, $02C6, $02C7, $0000

      aSoundUploadF79D66
        .word $02C8, $02C9, $02CA, $0000

      aSoundUploadF79D6E
        .word $02CB, $02CC, $02CD, $0000

      aSoundUploadF79D76
        .word $02CE, $02CF, $02D0, $0000

      aSoundUploadF79D7E
        .word $02D1, $02D2, $02D3, $0000

      aSoundUploadF79D86
        .word $02D4, $02D5, $02D6, $0000

      aSoundUploadF79D8E
        .word $02D7, $02D8, $02D9, $0000

      aSoundUploadF79D96
        .word $02DA, $02DB, $02DC, $0000

      aSoundUploadF79D9E
        .word $02DD, $02DE, $02DF, $0000

      aSoundUploadF79DA6
        .word $02E0, $02E1, $02E2, $0000

      aSoundUploadF79DAE
        .word $02E3, $02E4, $02E5, $0000

      aSoundUploadF79DB6
        .word $02E6, $02E7, $02E8, $0000

      aSoundUploadF79DBE
        .word $02E9, $02EA, $02EB, $0000

      aSoundUploadF79DC6
        .word $02EC, $02ED, $02EE, $0000

      aSoundUploadF79DCE
        .word $02EF, $02F0, $02F1, $0000

      aSoundUploadF79DD6
        .word $02F2, $02F3, $02F4, $0000

      aSoundUploadF79DDE
        .word $02F5, $02F6, $02F7, $0000

      aSoundUploadF79DE6
        .word $02F8, $02F9, $02FA, $0000

      aSoundUploadF79DEE
        .word $02FB, $02FC, $02FD, $0000

      aSoundUploadF79DF6
        .word $0357, $02E1, $02E2, $0000

      aSoundUploadF79DFE
        .word $0358, $02E4, $02E5, $0000

      aSoundUploadF79E06
        .word $0359, $02E7, $02E8, $0000

      aSoundUploadF79E0E
        .word $035A, $02EA, $02EB, $0000

      aSoundUploadF79E16
        .word $035B, $02ED, $02EE, $0000

      aSoundUploadF79E1E
        .word $035C, $02F0, $02F1, $0000

      aSoundUploadF79E26
        .word $035D, $02F3, $02F4, $0000

      aSoundUploadF79E2E
        .word $035E, $02F6, $02F7, $0000

      aSoundUploadF79E36
        .word $035F, $02F9, $02FA, $0000

      aSoundUploadF79E3E
        .word $0360, $02FC, $02FD, $0000

      aSoundUploadF79E46
        .word $02FE, $02FF, $0300, $0000

      aSoundUploadF79E4E
        .word $0301, $0302, $0303, $0000

      aSoundUploadF79E56
        .word $0361, $02AB, $02AC, $0000

      aSoundUploadF79E5E
        .word $0362, $02AE, $02AF, $0000

      aSoundUploadF79E66
        .word $0363, $02AB, $02AC, $0000

      aSoundUploadF79E6E
        .word $0364, $02AE, $02AF, $0000

      aSoundUploadF79E76
        .word $0304, $0305, $0306, $0000

      aSoundUploadF79E7E
        .word $0307, $0308, $0309, $0000

      aSoundUploadF79E86
        .word $030A, $030B, $030C, $0000

      aSoundUploadF79E8E
        .word $030D, $030E, $030F, $0000

      aSoundUploadF79E96
        .word $0365, $02BD, $02BE, $0000

      aSoundUploadF79E9E
        .word $0366, $02C0, $02C1, $0000

      aSoundUploadF79EA6
        .word $0310, $0311, $0312, $0000

      aSoundUploadF79EAE
        .word $0313, $0314, $0315, $0000

      aSoundUploadF79EB6
        .word $0316, $0317, $0318, $0000

      aSoundUploadF79EBE
        .word $0319, $031A, $031B, $0000

      aSoundUploadF79EC6
        .word $031C, $031D, $031E, $0000

      aSoundUploadF79ECE
        .word $031F, $0320, $0321, $0000

      aSoundUploadF79ED6
        .word $0322, $0323, $0324, $0000

      aSoundUploadF79EDE
        .word $0325, $0326, $0327, $0000

      aSoundUploadF79EE6
        .word $0367, $0323, $0324, $0000

      aSoundUploadF79EEE
        .word $0368, $0326, $0327, $0000

      aSoundUploadF79EF6
        .word $0000

      aSoundUploadF79EF8
        .word $022C, $022D, $022E, $0000

      aSoundUploadF79F00
        .word $022F, $0230, $0231, $0000

      aSoundUploadF79F08
        .word $0232, $0233, $0234, $0000

      aSoundUploadF79F10
        .word $0235, $0236, $0237, $0000

      aSoundUploadF79F18
        .word $0238, $0239, $023A, $0000

      aSoundUploadF79F20
        .word $023B, $023C, $023D, $0000

      aSoundUploadF79F28
        .word $023E, $023F, $0240, $0000

      aSoundUploadF79F30
        .word $0241, $0242, $0243, $0000

      aSoundUploadF79F38
        .word $0244, $0245, $0246, $0000

      aSoundUploadF79F40
        .word $0247, $0248, $0249, $0000

      aSoundUploadF79F48
        .word $025C, $025D, $025E, $0000

      aSoundUploadF79F50
        .word $025F, $0260, $0261, $0000

      aSoundUploadF79F58
        .word $0268, $0269, $026A, $0000

      aSoundUploadF79F60
        .word $026B, $026C, $026D, $0000

      aSoundUploadF79F68
        .word $0280, $0281, $0282, $0000

      aSoundUploadF79F70
        .word $0283, $0284, $0285, $0000

      aSoundUploadF79F78
        .word $024A, $024B, $024C, $0000

      aSoundUploadF79F80
        .word $024D, $024E, $024F, $0000

      aSoundUploadF79F88
        .word $0250, $0251, $0252, $0000

      aSoundUploadF79F90
        .word $0253, $0254, $0255, $0000

      aSoundUploadF79F98
        .word $0256, $0257, $0258, $0000

      aSoundUploadF79FA0
        .word $0259, $025A, $025B, $0000

      aSoundUploadF79FA8
        .word $0262, $0263, $0264, $0000

      aSoundUploadF79FB0
        .word $0265, $0266, $0267, $0000

      aSoundUploadF79FB8
        .word $026E, $026F, $0270, $0000

      aSoundUploadF79FC0
        .word $0271, $0272, $0273, $0000

      aSoundUploadF79FC8
        .word $0343, $0344, $0345, $0000

      aSoundUploadF79FD0
        .word $0346, $0347, $0348, $0000

      aSoundUploadF79FD8
        .word $0274, $0275, $0276, $0000

      aSoundUploadF79FE0
        .word $0277, $0278, $0279, $0000

      aSoundUploadF79FE8
        .word $028C, $028D, $028E, $0000

      aSoundUploadF79FF0
        .word $028F, $0290, $0291, $0000

      aSoundUploadF79FF8
        .word $0292, $0293, $0294, $0000

      aSoundUploadF7A000
        .word $0295, $0296, $0297, $0000

      aSoundUploadF7A008
        .word $0298, $0299, $029A, $0000

      aSoundUploadF7A010
        .word $029B, $029C, $029D, $0000

      aSoundUploadF7A018
        .word $029E, $029F, $02A0, $0000

      aSoundUploadF7A020
        .word $02A1, $02A2, $02A3, $0000

      aSoundUploadF7A028
        .word $027A, $027B, $027C, $0000

      aSoundUploadF7A030
        .word $027D, $027E, $027F, $0000

      aSoundUploadF7A038
        .word $0286, $0287, $0288, $0000

      aSoundUploadF7A040
        .word $0289, $028A, $028B, $0000

      aSoundUploadF7A048
        .word $0349, $034A, $034B, $0000

      aSoundUploadF7A050
        .word $034C, $034D, $034E, $0000

      aSoundUploadF7A058
        .word $0065, $0146, $0147, $C000, $7400, $00D7, $00D8, $00D9
        .word $00DA, $00DB, $0340, $003C, $0000

      aSoundUploadF7A072
        .word $006B, $0152, $0153, $C000, $7400, $00DC, $00DD, $00D8
        .word $00DE, $00DF, $00E0, $00E1, $00E2, $00E3, $00E4, $00E5
        .word $0340, $003C, $0000

      aSoundUploadF7A098
        .word $0066, $0148, $0149, $C000, $7400, $00DC, $00E0, $00D8
        .word $00E6, $00E7, $00E2, $00E3, $00E8, $00E4, $00E5, $0340
        .word $003C, $0000

      aSoundUploadF7A0BC
        .word $0069, $014E, $014F, $C000, $7400, $00DC, $00E9, $00D8
        .word $00EA, $00EB, $00EC, $0340, $003C, $0000

      aSoundUploadF7A0D8
        .word $007B, $0172, $0173, $C000, $7400, $00ED, $00EE, $00EF
        .word $00F0, $00F1, $00F2, $0340, $003C, $0000

      aSoundUploadF7A0F4
        .word $006C, $0154, $0155, $C000, $7400, $00F3, $00F4, $00E0
        .word $00F5, $00F6, $0340, $003C, $0000

      aSoundUploadF7A10E
        .word $006F, $015A, $015B, $C000, $7400, $00DC, $00F0, $00D8
        .word $00EA, $00F7, $00F8, $00E8, $00E4, $0340, $003C, $0000

      aSoundUploadF7A12E
        .word $0068, $014C, $014D, $C000, $7400, $00F9, $00FA, $00FB
        .word $00FC, $00E7, $00E2, $00E4, $00FD, $0340, $003C, $0000

      aSoundUploadF7A14E
        .word $007C, $0174, $0175, $C000, $7400, $00DC, $00ED, $00E9
        .word $00EA, $00F1, $0340, $003C, $0000

      aSoundUploadF7A168
        .word $006D, $0156, $0157, $C000, $7400, $00DC, $00EF, $00DE
        .word $00FE, $00EA, $00DA, $00FF, $0340, $003C, $0000

      aSoundUploadF7A186
        .word $0075, $0166, $0167, $C000, $7400, $00D7, $00F0, $00FB
        .word $00E6, $00EF, $0340, $003C, $0000

      aSoundUploadF7A1A0
        .word $0071, $015E, $015F, $C000, $7400, $00F9, $00F0, $0100
        .word $00DA, $00E7, $00E2, $00E4, $0340, $003C, $0000

      aSoundUploadF7A1BE
        .word $007D, $0176, $0177, $C000, $7400, $00ED, $00F0, $00EA
        .word $00E7, $00E2, $00E4, $0340, $003C, $0000

      aSoundUploadF7A1DA
        .word $006A, $0150, $0151, $C000, $7400, $00D7, $00EE, $00E9
        .word $0101, $00EA, $00F1, $0340, $003C, $0000

      aSoundUploadF7A1F6
        .word $0067, $014A, $014B, $C000, $7400, $00F9, $00FA, $00FB
        .word $00E0, $0102, $0103, $00E1, $0104, $00E8, $0105, $0340
        .word $003C, $0000

      aSoundUploadF7A21A
        .word $0070, $015C, $015D, $C000, $7400, $0106, $00D9, $00F4
        .word $00DF, $0107, $0103, $00E1, $0104, $00E4, $0105, $0340
        .word $003C, $0000

      aSoundUploadF7A23E
        .word $0072, $0160, $0161, $C000, $7400, $00DC, $00F0, $00D8
        .word $0117, $0118, $0340, $003C, $0000

      aSoundUploadF7A258
        .word $0073, $0162, $0163, $C000, $7400, $00DC, $00F0, $00D8
        .word $00E7, $00F1, $010D, $0119, $0340, $003C, $0000

      aSoundUploadF7A276
        .word $0074, $0164, $0165, $C000, $7400, $00DC, $00EF, $00D8
        .word $00F6, $00E4, $00EE, $0340, $003C, $0000

      aSoundUploadF7A292
        .word $006E, $0158, $0159, $C000, $7400, $00D7, $00EA, $00E4
        .word $00FB, $00E0, $00E6, $00F5, $0340, $003C, $0000

      aSoundUploadF7A2B0
        .word $0076, $0168, $0169, $C000, $7400, $00DC, $00D8, $011A
        .word $0117, $011B, $011C, $0340, $003C, $0000

      aSoundUploadF7A2CC
        .word $0077, $016A, $016B, $C000, $7400, $00DC, $00EF, $011D
        .word $00FF, $0119, $011E, $0340, $003C, $0000

      aSoundUploadF7A2E8
        .word $0078, $016C, $016D, $C000, $7400, $00DC, $00E9, $00D8
        .word $00EA, $00E2, $0340, $003C, $0000

      aSoundUploadF7A302
        .word $0079, $016E, $016F, $C000, $7400, $00DC, $00F0, $011F
        .word $0110, $00FF, $011D, $00EE, $00EF, $0340, $003C, $0000

      aSoundUploadF7A322
        .word $007A, $0170, $0171, $C000, $7400, $00DC, $00E9, $00F0
        .word $00E7, $00E2, $0340, $003C, $0000

      aSoundUploadF7A33C
        .word $0088, $018C, $018D, $C000, $7400, $00DC, $00D8, $010A
        .word $00D9, $00F5, $0117, $0104, $00E8, $0105, $003E, $A000
        .word $0003, $0004, $0001, $0002, $0000

      aSoundUploadF7A366
        .word $007F, $017A, $017B, $C000, $7400, $0108, $0109, $010A
        .word $010B, $010C, $00E2, $00E8, $00E4, $003E, $A000, $0003
        .word $0004, $0001, $0002, $0000

      aSoundUploadF7A38E
        .word $0080, $017C, $017D, $C000, $7400, $00DC, $00D8, $00F0
        .word $010D, $003E, $A000, $0003, $0004, $0001, $0002, $0000

      aSoundUploadF7A3AE
        .word $0081, $017E, $017F, $C000, $7400, $00DC, $010E, $00F0
        .word $00E1, $00E2, $010F, $00E4, $003E, $A000, $0003, $0004
        .word $0001, $0002, $0000

      aSoundUploadF7A3D4
        .word $0082, $0180, $0181, $C000, $7400, $0110, $0111, $003E
        .word $A000, $0003, $0004, $0001, $0002, $0000

      aSoundUploadF7A3F0
        .word $0083, $0182, $0183, $C000, $7400, $0110, $00FC, $0112
        .word $0113, $0114, $0115, $003E, $A000, $0003, $0004, $0001
        .word $0002, $0000

      aSoundUploadF7A414
        .word $0084, $0184, $0185, $C000, $7400, $00DC, $0109, $010A
        .word $010C, $00F8, $010F, $00E4, $003E, $A000, $0003, $0004
        .word $0001, $0002, $0000

      aSoundUploadF7A43A
        .word $0085, $034F, $0350, $0351, $0186, $0187, $C000, $7400
        .word $00F9, $00DD, $003E, $0000

      aSoundUploadF7A452
        .word $0086, $0188, $0189, $C000, $7400, $00DF, $0116, $0103
        .word $0111, $003E, $A000, $0003, $0004, $0001, $0002, $0000

      aSoundUploadF7A472
        .word $0087, $018A, $018B, $C000, $7400, $010A, $010E, $00F0
        .word $00E1, $00E2, $00E8, $00E4, $00DB, $003E, $A000, $0003
        .word $0004, $0001, $0002, $0000

      aSoundUploadF7A49A
        .word $0089, $018E, $018F, $C000, $7400, $0108, $00DD, $0100
        .word $0337, $0000

      aSoundUploadF7A4AE
        .word $0089, $018E, $018F, $C000, $7400, $0108, $00DD, $0100
        .word $0338, $0000

      aSoundUploadF7A4C2
        .word $008A, $0190, $0191, $C000, $7400, $0116, $003E, $A000
        .word $0003, $0004, $0001, $0002, $0000

      aSoundUploadF7A4DC
        .word $008B, $0192, $0193, $C000, $7400, $0109, $0100, $010B
        .word $003E, $A000, $0003, $0004, $0001, $0002, $0000

      aSoundUploadF7A4FA
        .word $00C9, $0218, $0219, $C000, $7400, $00DC, $00F9, $012E
        .word $00DE, $00DA, $003E, $A000, $0003, $0004, $0001, $0002
        .word $0000

      aSoundUploadF7A51C
        .word $00A5, $01CE, $01CF, $C000, $7400, $00D7, $0108, $012F
        .word $00DC, $003E, $A000, $0003, $0004, $0001, $0002, $0000

      aSoundUploadF7A53C
        .word $0088, $018C, $018D, $C000, $7400, $00DC, $00D8, $010A
        .word $00D9, $00F5, $0117, $0104, $00E8, $0105, $003C, $0000

      aSoundUploadF7A55C
        .word $007F, $017A, $017B, $C000, $7400, $0108, $0109, $010A
        .word $010B, $010C, $00E2, $00E8, $00E4, $003C, $0000

      aSoundUploadF7A57A
        .word $0080, $017C, $017D, $C000, $7400, $00DC, $00D8, $00F0
        .word $010D, $003C, $0000

      aSoundUploadF7A590
        .word $0081, $017E, $017F, $C000, $7400, $00DC, $010E, $00F0
        .word $00E1, $00E2, $010F, $00E4, $003C, $0000

      aSoundUploadF7A5AC
        .word $0082, $0180, $0181, $C000, $7400, $0110, $0111, $003C
        .word $0000

      aSoundUploadF7A5BE
        .word $0083, $0182, $0183, $C000, $7400, $0110, $00FC, $0112
        .word $0113, $0114, $0115, $003C, $0000

      aSoundUploadF7A5D8
        .word $0084, $0184, $0185, $C000, $7400, $00DC, $0109, $010A
        .word $010C, $00F8, $010F, $00E4, $003C, $0000

      aSoundUploadF7A5F4
        .word $0085, $0186, $0187, $C000, $7400, $00F9, $00DD, $003C
        .word $0000

      aSoundUploadF7A606
        .word $0086, $0188, $0189, $C000, $7400, $00DF, $0116, $0103
        .word $0111, $003C, $0000

      aSoundUploadF7A61C
        .word $0087, $018A, $018B, $C000, $7400, $010A, $010E, $00F0
        .word $00E1, $00E2, $00E8, $00E4, $00DB, $003C, $0000

      aSoundUploadF7A63A
        .word $0089, $018E, $018F, $C000, $7400, $0108, $00DD, $0100
        .word $003C, $0000

      aSoundUploadF7A64E
        .word $008A, $0190, $0191, $C000, $7400, $0116, $003C, $0000

      aSoundUploadF7A65E
        .word $008C, $0194, $0195, $C000, $4C00, $0100, $00EA, $00FC
        .word $00F5, $00E0, $0120, $0121, $0122, $00D6, $0352, $0353
        .word $0354, $0334, $0335, $0336, $F000, $0337, $0000

      aSoundUploadF7A68C
        .word $008D, $0196, $0197, $C000, $7400, $0108, $00DC, $B000
        .word $0000

      aSoundUploadF7A69E
        .word $008F, $019A, $019B, $C000, $7400, $0126, $010E, $00F0
        .word $00F6, $00E1, $003C, $0000

      aSoundUploadF7A6B6
        .word $00CA, $019C, $019D, $C000, $7400, $0126, $00EF, $0127
        .word $003C, $0000

      aSoundUploadF7A6CA
        .word $00CB, $019E, $019F, $C000, $7400, $0126, $00E0, $0128
        .word $00FC, $00E4, $00FD, $003C, $0000

      aSoundUploadF7A6E4
        .word $0090, $01A0, $01A1, $C000, $7400, $0126, $00E0, $00EA
        .word $00EC, $0128, $003C, $0000

      aSoundUploadF7A6FC
        .word $0091, $01A2, $01A3, $C000, $7400, $0126, $0110, $0119
        .word $011C, $00FF, $003C, $0000

      aSoundUploadF7A714
        .word $0092, $01A4, $01A5, $C000, $7400, $0126, $0129, $010D
        .word $0119, $003C, $0000

      aSoundUploadF7A72A
        .word $0093, $01A6, $01A7, $C000, $7400, $0126, $00DD, $0127
        .word $0113, $00E2, $003C, $0000

      aSoundUploadF7A742
        .word $009E, $01AA, $01AB, $C000, $7400, $0126, $012A, $003C
        .word $0000

      aSoundUploadF7A754
        .word $00C1, $01A8, $01A9, $C000, $7400, $0126, $00FC, $0128
        .word $00E0, $003C, $0000

      aSoundUploadF7A76A
        .word $B000, $0096, $01B0, $01B1, $C000, $4C00, $00DC, $00E6
        .word $0125, $0130, $0131, $0132, $0133, $0134, $0337, $0000

      aSoundUploadF7A78A
        .word $B000, $0096, $01B0, $01B1, $C000, $4C00, $00DC, $00E6
        .word $0125, $0130, $0131, $0132, $0133, $0134, $0338, $0000

      aSoundUploadF7A7AA
        .word $B000, $0098, $01B4, $01B5, $C000, $5000, $0135, $00DC
        .word $0107, $0100, $00D9, $00E1, $0104, $00E8, $00E4, $00E5
        .word $0101, $033D, $033A, $0000

      aSoundUploadF7A7D2
        .word $B000, $0098, $01B4, $01B5, $C000, $5000, $0135, $00DC
        .word $0107, $0100, $00D9, $00E1, $0104, $00E8, $00E4, $00E5
        .word $0101, $033E, $033A, $0000

      aSoundUploadF7A7FA
        .word $B000, $0097, $01B2, $01B3, $C000, $4C00, $0106, $00D9
        .word $00EF, $00FB, $0107, $00E6, $00DF, $00DA, $00DB, $033D
        .word $033A, $0000

      aSoundUploadF7A81E
        .word $00C9, $0218, $0219, $C000, $7400, $00DC, $00F9, $012E
        .word $00DE, $00DA, $003C, $0000

      aSoundUploadF7A836
        .word $0099, $01B8, $01B9, $C000, $7400, $00DC, $0108, $00F4
        .word $00E6, $012E, $00DE, $00E3, $003C, $0000

      aSoundUploadF7A852
        .word $009A, $01BA, $01BB, $C000, $7400, $00F9, $00EF, $0100
        .word $0137, $0117, $0104, $00E4, $003C, $0000

      aSoundUploadF7A86E
        .word $007E, $0178, $0179, $C000, $7400, $00DC, $00DD, $00D8
        .word $00DA, $00E4, $00E5, $003C, $0000

      aSoundUploadF7A888
        .word $009B, $01BC, $01BD, $C000, $7400, $00DC, $0138, $00E6
        .word $0103, $00DE, $003C, $0000

      aSoundUploadF7A8A0
        .word $009C, $01BE, $01BF, $C000, $7400, $00DC, $00E0, $012E
        .word $0139, $00E3, $00DB, $003C, $0000

      aSoundUploadF7A8BA
        .word $009D, $01C0, $01C1, $C000, $7400, $00E0, $013A, $00EA
        .word $00E6, $0106, $003C, $0000

      aSoundUploadF7A8D2
        .word $009F, $01C2, $01C3, $C000, $7400, $013A, $00E0, $0139
        .word $013B, $003C, $0000

      aSoundUploadF7A8E8
        .word $00A0, $01C4, $01C5, $C000, $7400, $012E, $013C, $00DA
        .word $00E2, $00DB, $003C, $0000

      aSoundUploadF7A900
        .word $00A1, $01C6, $01C7, $C000, $7400, $00DC, $0108, $012E
        .word $003C, $0000

      aSoundUploadF7A914
        .word $00A2, $01C8, $01C9, $C000, $7400, $0102, $0116, $013D
        .word $003C, $0000

      aSoundUploadF7A928
        .word $00A3, $01CA, $01CB, $C000, $7400, $00F9, $00D7, $0108
        .word $0138, $00DF, $003C, $0000

      aSoundUploadF7A940
        .word $00A4, $01CC, $01CD, $C000, $7400, $0106, $012E, $00E0
        .word $00D8, $00DA, $00DB, $00D9, $003C, $0000

      aSoundUploadF7A95C
        .word $00A5, $01CE, $01CF, $C000, $7400, $00D7, $0108, $012F
        .word $00DC, $003C, $0000

      aSoundUploadF7A972
        .word $00A6, $01D0, $01D1, $C000, $7400, $00FE, $0118, $0101
        .word $00DF, $003C, $0000

      aSoundUploadF7A988
        .word $00A7, $01D2, $01D3, $C000, $7400, $0108, $0139, $00D9
        .word $00D8, $0117, $00E8, $0116, $013E, $00DA, $003C, $0000

      aSoundUploadF7A9A8
        .word $00A8, $01D4, $01D5, $C000, $7400, $00DC, $0108, $011F
        .word $00DA, $003C, $0000

      aSoundUploadF7A9BE
        .word $00A9, $01D6, $01D7, $C000, $7400, $00DC, $00F9, $003C
        .word $0000

      aSoundUploadF7A9D0
        .word $00AA, $01DC, $01DD, $C000, $7400, $00FC, $0138, $012F
        .word $0110, $003C, $0000

      aSoundUploadF7A9E6
        .word $00AB, $01DE, $01DF, $C000, $7400, $0135, $012F, $0138
        .word $00EE, $0110, $003C, $0000

      aSoundUploadF7A9FE
        .word $00AC, $01E0, $01E1, $C000, $7400, $0106, $00F9, $0101
        .word $003C, $0000

      aSoundUploadF7AA12
        .word $00AD, $01E2, $01E3, $C000, $7400, $0103, $0106, $003C
        .word $0000

      aSoundUploadF7AA24
        .word $00AE, $01E4, $01E5, $C000, $7400, $00DE, $00D9, $0136
        .word $003C, $0000

      aSoundUploadF7AA38
        .word $00AF, $01E6, $01E7, $C000, $7400, $0138, $00F9, $00DC
        .word $00EA, $00E3, $003C, $0000

      aSoundUploadF7AA50
        .word $00B0, $01E8, $01E9, $C000, $7400, $00DC, $00EF, $012E
        .word $011D, $00FF, $011E, $003C, $0000

      aSoundUploadF7AA6A
        .word $00B1, $01EA, $01EB, $C000, $7400, $0138, $00DC, $011F
        .word $00D8, $00EA, $003C, $0000

      aSoundUploadF7AA82
        .word $00B2, $01EC, $01ED, $C000, $7400, $0138, $013A, $00E6
        .word $00DC, $003C, $0000

      aSoundUploadF7AA98
        .word $00B3, $01EE, $01EF, $C000, $7400, $012F, $00EA, $013D
        .word $003C, $0000

      aSoundUploadF7AAAC
        .word $00B4, $01F0, $01F1, $C000, $7400, $00DC, $012E, $00DE
        .word $013C, $013E, $003C, $0000

      aSoundUploadF7AAC4
        .word $00B5, $01F2, $01F3, $C000, $7400, $00DC, $00DA, $00DB
        .word $0100, $003C, $0000

      aSoundUploadF7AADA
        .word $00B6, $01F4, $01F5, $C000, $7400, $00DC, $00F9, $0108
        .word $003C, $0000

      aSoundUploadF7AAEE
        .word $00B7, $01F6, $01F7, $C000, $7400, $00DC, $00F9, $0108
        .word $003C, $0000

      aSoundUploadF7AB02
        .word $00B8, $01F8, $01F9, $C000, $7400, $00DC, $0108, $00E2
        .word $0100, $003C, $0000

      aSoundUploadF7AB18
        .word $00B9, $01FA, $01FB, $C000, $7400, $00F9, $00DC, $00E0
        .word $012E, $003C, $0000

      aSoundUploadF7AB2E
        .word $00BA, $01FC, $01FD, $C000, $7400, $013A, $00DC, $012E
        .word $00DA, $003C, $0000

      aSoundUploadF7AB44
        .word $00BB, $01FE, $01FF, $C000, $7400, $0138, $012E, $00D9
        .word $0106, $00E6, $003C, $0000

      aSoundUploadF7AB5C
        .word $00BC, $0200, $0201, $C000, $7400, $00E6, $00E0, $0106
        .word $003C, $0000

      aSoundUploadF7AB70
        .word $00BD, $0202, $0203, $C000, $7400, $012E, $0103, $0108
        .word $00DC, $00E4, $003C, $0000

      aSoundUploadF7AB88
        .word $00BE, $0204, $0205, $C000, $7400, $0106, $00F9, $00D9
        .word $013F, $00E3, $003C, $0000

      aSoundUploadF7ABA0
        .word $00BF, $0206, $0207, $C000, $7400, $00E6, $0140, $0103
        .word $0101, $003C, $0000

      aSoundUploadF7ABB6
        .word $00C0, $0208, $0209, $C000, $7400, $0106, $0103, $00D9
        .word $0138, $00E4, $00E5, $00E6, $003C, $0000

      aSoundUploadF7ABD2
        .word $00C2, $020A, $020B, $C000, $7400, $0141, $012E, $0139
        .word $00DC, $003C, $0000

      aSoundUploadF7ABE8
        .word $00C3, $020C, $020D, $C000, $7400, $0138, $00DC, $00F9
        .word $012E, $00E8, $003C, $0000

      aSoundUploadF7AC00
        .word $00C4, $020E, $020F, $C000, $7400, $0138, $00DE, $00F4
        .word $0142, $003C, $0000

      aSoundUploadF7AC16
        .word $00C5, $0210, $0211, $C000, $7400, $00F9, $00DD, $0100
        .word $00DA, $0142, $003C, $0000

      aSoundUploadF7AC2E
        .word $00C6, $0212, $0213, $C000, $7400, $00DC, $00F9, $0142
        .word $003C, $0000

      aSoundUploadF7AC42
        .word $00C7, $0214, $0215, $C000, $7400, $013F, $0103, $003C
        .word $0000

      aSoundUploadF7AC54
        .word $00C8, $0216, $0217, $C000, $7400, $00F9, $00DC, $012E
        .word $0100, $00E7, $0104, $003C, $0000

      aSoundUploadF7AC6E
        .word $00CC, $021A, $021B, $C000, $7400, $0103, $0108, $00DC
        .word $00DA, $003C, $0000

      aSoundUploadF7AC84
        .word $00CD, $021C, $021D, $C000, $7400, $0135, $013A, $00D9
        .word $0142, $00E3, $003C, $0000

      aSoundUploadF7AC9C
        .word $00CE, $021E, $021F, $C000, $7400, $00F9, $00DC, $012E
        .word $00E0, $00DE, $00EA, $00E3, $003C, $0000

      aSoundUploadF7ACB8
        .word $00CF, $0220, $0221, $C000, $7400, $00F9, $00DC, $0108
        .word $0100, $003C, $0000

      aSoundUploadF7ACCE
        .word $00D0, $0222, $0223, $C000, $7400, $00DC, $0108, $012E
        .word $0100, $00E4, $003C, $0000

      aSoundUploadF7ACE6
        .word $B000, $0094, $01AC, $01AD, $C000, $5000, $00DC, $012B
        .word $0108, $011A, $0103, $012C, $0337, $0000

      aSoundUploadF7AD02
        .word $B000, $0095, $01AE, $01AF, $C000, $5000, $012D, $00DC
        .word $00E3, $012E, $012F, $00DA, $00DB, $003D, $033B, $033A
        .word $0000

      aSoundUploadF7AD24
        .word $B000, $0095, $01AE, $01AF, $C000, $5000, $012D, $00DC
        .word $00E3, $012E, $012F, $00DA, $00DB, $003D, $033C, $033A
        .word $0000

      aSoundUploadF7AD46
        .word $00D1, $01D8, $01D9, $C000, $7400, $00DC, $00F9, $00E6
        .word $00DA, $00D9, $003C, $0337, $0000

      aSoundUploadF7AD60
        .word $00D2, $01DA, $01DB, $C000, $7400, $0103, $0135, $003C
        .word $0337, $0000

      aSoundUploadF7AD74
        .word $B000, $00D3, $01B6, $01B7, $C000, $7400, $0102, $0136
        .word $0116, $033D, $033A, $0000

      aSoundDriverID ; F7/AD8C
        .text "ELM SND1960327W", 0

      aSoundUnknownF7AD9C ; F7/AD9C

        ; Read by rsGetIndirectSoundUpload: from +0 for upload IDs 1 and 2, from +$140 for 3 and 4.
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $2D, $00, $00, $00, $0B
        .byte $23, $17, $1D, $21, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $0B, $0B
        .byte $0D, $0B, $15, $17, $17, $19, $1B, $17, $1D, $1D, $0F, $1F, $11, $21, $23, $25
        .byte $2F, $13, $31, $33, $2F, $0D, $0B, $0B, $05, $05, $05, $05, $05, $27, $27, $27
        .byte $29, $2B, $05, $2D, $05, $05, $05, $05, $05, $05, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $07, $19, $17, $17
        .byte $1F, $0F, $1D, $1D, $2F, $25, $23, $21, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $2E, $00, $00, $00, $0C
        .byte $24, $18, $1E, $22, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $0C, $0C
        .byte $0E, $0C, $16, $18, $18, $1A, $1C, $18, $1E, $1E, $10, $20, $12, $22, $24, $26
        .byte $30, $14, $32, $34, $30, $0E, $0C, $0C, $06, $06, $06, $06, $06, $28, $28, $28
        .byte $2A, $2C, $06, $2E, $06, $06, $06, $06, $06, $06, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $08, $1A, $18, $18
        .byte $20, $10, $1E, $1E, $30, $26, $24, $22, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $49, $49, $49, $49, $49, $49, $61, $61, $61, $61, $61, $61, $61, $61, $61, $79
        .byte $79, $79, $79, $79, $79, $01, $01, $01, $01, $01, $31, $31, $31, $31, $01, $01
        .byte $01, $01, $19, $19, $19, $19, $91, $91, $91, $91, $91, $91, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01

      aSoundStartUpload ; F7/AF2C
        .word <>aSoundUploadF79C76

      aSoundChunk337 .soundBinary "chunks/337.bin" ; F7/AF2E
      aSoundUnknownF7AF2F ; F7/AF2F, nothing points here
        .byte $00
      aSoundChunk338 .soundBinary "chunks/338.bin" ; F7/AF30
      aSoundUnknownF7AF31 ; F7/AF31, nothing points here
        .byte $00
      aSoundChunk339 .soundBinary "chunks/339.bin" ; F7/AF32
      aSoundUnknownF7AF33 ; F7/AF33, nothing points here
        .byte $00
      aSoundChunk33A .soundBinary "chunks/33A.bin" ; F7/AF34
      aSoundUnknownF7AF35 ; F7/AF35, nothing points here
        .byte $00
      aSoundChunk33D .soundBinary "chunks/33D.bin" ; F7/AF36
      aSoundChunk33E .soundBinary "chunks/33E.bin" ; F7/AF38
      aSoundChunk33F .soundBinary "chunks/33F.bin" ; F7/AF3A
      aSoundChunk33B .soundBinary "chunks/33B.bin" ; F7/AF3C
      aSoundChunk33C .soundBinary "chunks/33C.bin" ; F7/AF3E
      aSoundChunk340 .soundBinary "chunks/340.bin" ; F7/AF40
      aSoundUnknownF7AF41 ; F7/AF41, nothing points here
        .byte $00
      aSoundChunk341 .soundBinary "chunks/341.bin" ; F7/AF42
      aSoundUnknownF7AF43 ; F7/AF43, nothing points here
        .byte $00
      aSoundChunk342 .soundBinary "chunks/342.bin" ; F7/AF44
      aSoundUnknownF7AF45 ; F7/AF45, nothing points here
        .byte $00
      aSoundChunk343 .soundBinary "chunks/343.bin" ; F7/AF46
      aSoundChunk344 .soundBinary "chunks/344.bin" ; F7/AF4C
      aSoundChunk346 .soundBinary "chunks/346.bin" ; F7/AF50
      aSoundChunk347 .soundBinary "chunks/347.bin" ; F7/AF56
      aSoundChunk349 .soundBinary "chunks/349.bin" ; F7/AF5A
      aSoundChunk34A .soundBinary "chunks/34A.bin" ; F7/AF60
      aSoundChunk34C .soundBinary "chunks/34C.bin" ; F7/AF64
      aSoundChunk34D .soundBinary "chunks/34D.bin" ; F7/AF6A
      aSoundChunk34F .soundBinary "chunks/34F.bin" ; F7/AF6E
      aSoundChunk350 .soundBinary "chunks/350.bin" ; F7/AF74
      aSoundChunk352 .soundBinary "chunks/352.bin" ; F7/AF78
      aSoundChunk353 .soundBinary "chunks/353.bin" ; F7/AF7E
      aSoundChunk357 .soundBinary "chunks/357.bin" ; F7/AF82
      aSoundChunk359 .soundBinary "chunks/359.bin" ; F7/AF88
      aSoundChunk35B .soundBinary "chunks/35B.bin" ; F7/AF8E
      aSoundChunk35D .soundBinary "chunks/35D.bin" ; F7/AF94
      aSoundChunk35F .soundBinary "chunks/35F.bin" ; F7/AF9A
      aSoundChunk358 .soundBinary "chunks/358.bin" ; F7/AFA0
      aSoundChunk35A .soundBinary "chunks/35A.bin" ; F7/AFA6
      aSoundChunk35C .soundBinary "chunks/35C.bin" ; F7/AFAC
      aSoundChunk35E .soundBinary "chunks/35E.bin" ; F7/AFB2
      aSoundChunk360 .soundBinary "chunks/360.bin" ; F7/AFB8
      aSoundChunk361 .soundBinary "chunks/361.bin" ; F7/AFBE
      aSoundChunk363 .soundBinary "chunks/363.bin" ; F7/AFC4
      aSoundChunk365 .soundBinary "chunks/365.bin" ; F7/AFCA
      aSoundChunk362 .soundBinary "chunks/362.bin" ; F7/AFD0
      aSoundChunk364 .soundBinary "chunks/364.bin" ; F7/AFD6
      aSoundChunk366 .soundBinary "chunks/366.bin" ; F7/AFDC
      aSoundChunk367 .soundBinary "chunks/367.bin" ; F7/AFE2
      aSoundChunk368 .soundBinary "chunks/368.bin" ; F7/AFE8
      aSoundUnknownF7AFEE ; F7/AFEE, nothing points here
        .byte $00, $00

      aSoundDriver ; F7/AFF0

        ; SPC700 code and data in blocks of (size, SPC address, bytes), then 0 and the
        ; address to start at, as rlUploadToAPU sends them.
        .word len(binary("driver/0200.bin")), $0200
        .soundBinary "driver/0200.bin"
        .word len(binary("driver/0660.bin")), $0660
        .soundBinary "driver/0660.bin"
        .word len(binary("driver/1BC0.bin")), $1BC0
        .soundBinary "driver/1BC0.bin"
        .word len(binary("driver/C502.bin")), $C502
        .soundBinary "driver/C502.bin"
        .word len(binary("driver/FF80.bin")), $FF80
        .soundBinary "driver/FF80.bin"
        .word 0, $0200

      aSoundChunk064 .soundBinary "chunks/064.comp" ; F7/CDBC
      aSoundChunk065 .soundBinary "chunks/065.comp" ; F7/CE59
      aSoundChunk066 .soundBinary "chunks/066.comp" ; F7/D7A2
      aSoundChunk067 .soundBinary "chunks/067.comp" ; F7/E275
      aSoundChunk068 .soundBinary "chunks/068.comp" ; F7/ECE4
      aSoundChunk069 .soundBinary "chunks/069.comp" ; F7/F474
      aSoundChunk06A .soundBinary "chunks/06A.comp" ; F7/FAC4
      aSoundChunk06B .soundBinary "chunks/06B.comp" ; F8/03FE
      aSoundChunk06C .soundBinary "chunks/06C.comp" ; F8/0C44
      aSoundChunk06D .soundBinary "chunks/06D.comp" ; F8/1144
      aSoundChunk06E .soundBinary "chunks/06E.comp" ; F8/19F2
      aSoundChunk06F .soundBinary "chunks/06F.comp" ; F8/1F4C
      aSoundChunk070 .soundBinary "chunks/070.comp" ; F8/26C9
      aSoundChunk071 .soundBinary "chunks/071.comp" ; F8/33A6
      aSoundChunk072 .soundBinary "chunks/072.comp" ; F8/3924
      aSoundChunk073 .soundBinary "chunks/073.comp" ; F8/4022
      aSoundChunk074 .soundBinary "chunks/074.comp" ; F8/47F0
      aSoundChunk075 .soundBinary "chunks/075.comp" ; F8/4DDB
      aSoundChunk076 .soundBinary "chunks/076.comp" ; F8/5565
      aSoundChunk077 .soundBinary "chunks/077.comp" ; F8/5B19
      aSoundChunk078 .soundBinary "chunks/078.comp" ; F8/6162
      aSoundChunk079 .soundBinary "chunks/079.comp" ; F8/6878
      aSoundChunk07A .soundBinary "chunks/07A.comp" ; F8/726A
      aSoundChunk07B .soundBinary "chunks/07B.comp" ; F8/7913
      aSoundChunk07C .soundBinary "chunks/07C.comp" ; F8/820F
      aSoundChunk07D .soundBinary "chunks/07D.comp" ; F8/88C4
      aSoundChunk07E .soundBinary "chunks/07E.comp" ; F8/8D57
      aSoundChunk07F .soundBinary "chunks/07F.comp" ; F8/91D5
      aSoundChunk080 .soundBinary "chunks/080.comp" ; F8/96F8
      aSoundChunk081 .soundBinary "chunks/081.comp" ; F8/98C1
      aSoundChunk082 .soundBinary "chunks/082.comp" ; F8/9BCC
      aSoundChunk083 .soundBinary "chunks/083.comp" ; F8/9E49
      aSoundChunk084 .soundBinary "chunks/084.comp" ; F8/A0AC
      aSoundChunk085 .soundBinary "chunks/085.comp" ; F8/A7CB
      aSoundChunk086 .soundBinary "chunks/086.comp" ; F8/A978
      aSoundChunk087 .soundBinary "chunks/087.comp" ; F8/AB36
      aSoundChunk088 .soundBinary "chunks/088.comp" ; F8/AE78
      aSoundChunk089 .soundBinary "chunks/089.comp" ; F8/B65E
      aSoundChunk08A .soundBinary "chunks/08A.comp" ; F8/B850
      aSoundChunk08B .soundBinary "chunks/08B.comp" ; F8/B9C5
      aSoundChunk08C .soundBinary "chunks/08C.comp" ; F8/BBE0
      aSoundChunk08D .soundBinary "chunks/08D.comp" ; F8/C39A
      aSoundChunk08E .soundBinary "chunks/08E.comp" ; F8/C562
      aSoundChunk08F .soundBinary "chunks/08F.comp" ; F8/C743
      aSoundChunk090 .soundBinary "chunks/090.comp" ; F8/C92A
      aSoundChunk091 .soundBinary "chunks/091.comp" ; F8/CBEB
      aSoundChunk092 .soundBinary "chunks/092.comp" ; F8/CEA9
      aSoundChunk093 .soundBinary "chunks/093.comp" ; F8/D0B7
      aSoundChunk094 .soundBinary "chunks/094.comp" ; F8/D2BB
      aSoundChunk095 .soundBinary "chunks/095.comp" ; F8/D837
      aSoundChunk096 .soundBinary "chunks/096.comp" ; F8/E658
      aSoundChunk097 .soundBinary "chunks/097.comp" ; F8/EDAB
      aSoundChunk098 .soundBinary "chunks/098.comp" ; F9/01BA
      aSoundChunk099 .soundBinary "chunks/099.comp" ; F9/1011
      aSoundChunk09A .soundBinary "chunks/09A.comp" ; F9/16F3
      aSoundChunk09B .soundBinary "chunks/09B.comp" ; F9/1B80
      aSoundChunk09C .soundBinary "chunks/09C.comp" ; F9/1EDA
      aSoundChunk09D .soundBinary "chunks/09D.comp" ; F9/240C
      aSoundChunk09E .soundBinary "chunks/09E.comp" ; F9/290A
      aSoundChunk09F .soundBinary "chunks/09F.comp" ; F9/2BC5
      aSoundChunk0A0 .soundBinary "chunks/0A0.comp" ; F9/3159
      aSoundChunk0A1 .soundBinary "chunks/0A1.comp" ; F9/345C
      aSoundChunk0A2 .soundBinary "chunks/0A2.comp" ; F9/3696
      aSoundChunk0A3 .soundBinary "chunks/0A3.comp" ; F9/37EC
      aSoundChunk0A4 .soundBinary "chunks/0A4.comp" ; F9/3D55
      aSoundChunk0A5 .soundBinary "chunks/0A5.comp" ; F9/45DF
      aSoundChunk0A6 .soundBinary "chunks/0A6.comp" ; F9/47B2
      aSoundChunk0A7 .soundBinary "chunks/0A7.comp" ; F9/48BB
      aSoundChunk0A8 .soundBinary "chunks/0A8.comp" ; F9/5093
      aSoundChunk0A9 .soundBinary "chunks/0A9.comp" ; F9/5436
      aSoundChunk0AA .soundBinary "chunks/0AA.comp" ; F9/578C
      aSoundChunk0AB .soundBinary "chunks/0AB.comp" ; F9/5A16
      aSoundChunk0AC .soundBinary "chunks/0AC.comp" ; F9/5B99
      aSoundChunk0AD .soundBinary "chunks/0AD.comp" ; F9/5D1E
      aSoundChunk0AE .soundBinary "chunks/0AE.comp" ; F9/5DF2
      aSoundChunk0AF .soundBinary "chunks/0AF.comp" ; F9/5FA3
      aSoundChunk0B0 .soundBinary "chunks/0B0.comp" ; F9/631F
      aSoundChunk0B1 .soundBinary "chunks/0B1.comp" ; F9/681A
      aSoundChunk0B2 .soundBinary "chunks/0B2.comp" ; F9/6EED
      aSoundChunk0B3 .soundBinary "chunks/0B3.comp" ; F9/710E
      aSoundChunk0B4 .soundBinary "chunks/0B4.comp" ; F9/73E9
      aSoundChunk0B5 .soundBinary "chunks/0B5.comp" ; F9/7B61
      aSoundChunk0B6 .soundBinary "chunks/0B6.comp" ; F9/7EA5
      aSoundChunk0B7 .soundBinary "chunks/0B7.comp" ; F9/811C
      aSoundChunk0B8 .soundBinary "chunks/0B8.comp" ; F9/8571
      aSoundChunk0B9 .soundBinary "chunks/0B9.comp" ; F9/8783
      aSoundChunk0BA .soundBinary "chunks/0BA.comp" ; F9/8AAD
      aSoundChunk0BB .soundBinary "chunks/0BB.comp" ; F9/8D65
      aSoundChunk0BC .soundBinary "chunks/0BC.comp" ; F9/911F
      aSoundChunk0BD .soundBinary "chunks/0BD.comp" ; F9/92C2
      aSoundChunk0BE .soundBinary "chunks/0BE.comp" ; F9/9600
      aSoundChunk0BF .soundBinary "chunks/0BF.comp" ; F9/992C
      aSoundChunk0C0 .soundBinary "chunks/0C0.comp" ; F9/9D47
      aSoundChunk0C1 .soundBinary "chunks/0C1.comp" ; F9/9FF1
      aSoundChunk0C2 .soundBinary "chunks/0C2.comp" ; F9/A1D4
      aSoundChunk0C3 .soundBinary "chunks/0C3.comp" ; F9/A554
      aSoundChunk0C4 .soundBinary "chunks/0C4.comp" ; F9/A859
      aSoundChunk0C5 .soundBinary "chunks/0C5.comp" ; F9/AB62
      aSoundChunk0C6 .soundBinary "chunks/0C6.comp" ; F9/AE26
      aSoundChunk0C7 .soundBinary "chunks/0C7.comp" ; F9/B07D
      aSoundChunk0C8 .soundBinary "chunks/0C8.comp" ; F9/B355
      aSoundChunk0C9 .soundBinary "chunks/0C9.comp" ; F9/B86D
      aSoundChunk0CA .soundBinary "chunks/0CA.comp" ; F9/BD16
      aSoundChunk0CB .soundBinary "chunks/0CB.comp" ; F9/C017
      aSoundChunk0CC .soundBinary "chunks/0CC.comp" ; F9/C225
      aSoundChunk0CD .soundBinary "chunks/0CD.comp" ; F9/C4F4
      aSoundChunk0CE .soundBinary "chunks/0CE.comp" ; F9/C801
      aSoundChunk0CF .soundBinary "chunks/0CF.comp" ; F9/CE1F
      aSoundChunk0D0 .soundBinary "chunks/0D0.comp" ; F9/D295
      aSoundChunk0D1 .soundBinary "chunks/0D1.comp" ; F9/D911
      aSoundChunk0D2 .soundBinary "chunks/0D2.comp" ; F9/DB9E
      aSoundChunk0D3 .soundBinary "chunks/0D3.comp" ; F9/DD83
      aSoundChunk0D4 .soundBinary "chunks/0D4.bin" ; F9/F063
      aSoundChunk0D5 .soundBinary "chunks/0D5.bin" ; F9/FE48
      aSoundChunk0D6 .soundBinary "chunks/0D6.bin" ; FA/0C8C
      aSoundChunk0D7 .soundBinary "chunks/0D7.bin" ; FA/1099
      aSoundChunk0D8 .soundBinary "chunks/0D8.bin" ; FA/280C
      aSoundChunk0D9 .soundBinary "chunks/0D9.bin" ; FA/2A94
      aSoundChunk0DA .soundBinary "chunks/0DA.bin" ; FA/2FEC
      aSoundChunk0DB .soundBinary "chunks/0DB.bin" ; FA/3A0C
      aSoundChunk0DC .soundBinary "chunks/0DC.bin" ; FA/562C
      aSoundChunk0DD .soundBinary "chunks/0DD.bin" ; FA/6E02
      aSoundChunk0DE .soundBinary "chunks/0DE.bin" ; FA/7027
      aSoundChunk0DF .soundBinary "chunks/0DF.bin" ; FA/76F9
      aSoundChunk0E0 .soundBinary "chunks/0E0.bin" ; FA/7819
      aSoundChunk0E1 .soundBinary "chunks/0E1.bin" ; FA/79F6
      aSoundChunk0E2 .soundBinary "chunks/0E2.bin" ; FA/7E9A
      aSoundChunk0E3 .soundBinary "chunks/0E3.bin" ; FA/89DA
      aSoundChunk0E4 .soundBinary "chunks/0E4.bin" ; FA/8F7A
      aSoundChunk0E5 .soundBinary "chunks/0E5.bin" ; FA/951A
      aSoundChunk0E6 .soundBinary "chunks/0E6.bin" ; FA/9E1A
      aSoundChunk0E7 .soundBinary "chunks/0E7.bin" ; FA/A10E
      aSoundChunk0E8 .soundBinary "chunks/0E8.bin" ; FA/A7CE
      aSoundChunk0E9 .soundBinary "chunks/0E9.bin" ; FA/AC4E
      aSoundChunk0EA .soundBinary "chunks/0EA.bin" ; FA/B236
      aSoundChunk0EB .soundBinary "chunks/0EB.bin" ; FA/BB36
      aSoundChunk0EC .soundBinary "chunks/0EC.bin" ; FA/C436
      aSoundChunk0ED .soundBinary "chunks/0ED.bin" ; FA/DB8E
      aSoundChunk0EE .soundBinary "chunks/0EE.bin" ; FA/F32E
      aSoundChunk0EF .soundBinary "chunks/0EF.bin" ; FA/F95E
      aSoundChunk0F0 .soundBinary "chunks/0F0.bin" ; FB/05C7
      aSoundChunk0F1 .soundBinary "chunks/0F1.bin" ; FB/15BD
      aSoundChunk0F2 .soundBinary "chunks/0F2.bin" ; FB/1B5D
      aSoundChunk0F3 .soundBinary "chunks/0F3.bin" ; FB/245D
      aSoundChunk0F4 .soundBinary "chunks/0F4.bin" ; FB/41E5
      aSoundChunk0F5 .soundBinary "chunks/0F5.bin" ; FB/485D
      aSoundChunk0F6 .soundBinary "chunks/0F6.bin" ; FB/5A5D
      aSoundChunk0F7 .soundBinary "chunks/0F7.bin" ; FB/67DD
      aSoundChunk0F8 .soundBinary "chunks/0F8.bin" ; FB/6DC5
      aSoundChunk0F9 .soundBinary "chunks/0F9.bin" ; FB/7B45
      aSoundChunk0FA .soundBinary "chunks/0FA.bin" ; FB/9468
      aSoundChunk0FB .soundBinary "chunks/0FB.bin" ; FB/99AE
      aSoundChunk0FC .soundBinary "chunks/0FC.bin" ; FB/9D4D
      aSoundChunk0FD .soundBinary "chunks/0FD.bin" ; FB/A33E
      aSoundChunk0FE .soundBinary "chunks/0FE.bin" ; FB/B0BE
      aSoundChunk0FF .soundBinary "chunks/0FF.bin" ; FB/B4C9
      aSoundChunk100 .soundBinary "chunks/100.bin" ; FB/BCF1
      aSoundChunk101 .soundBinary "chunks/101.bin" ; FB/BF70
      aSoundChunk102 .soundBinary "chunks/102.bin" ; FB/C27F
      aSoundChunk103 .soundBinary "chunks/103.bin" ; FB/C7D7
      aSoundChunk104 .soundBinary "chunks/104.bin" ; FB/D506
      aSoundChunk105 .soundBinary "chunks/105.bin" ; FB/DE06
      aSoundChunk106 .soundBinary "chunks/106.bin" ; FB/E45A
      aSoundChunk107 .soundBinary "chunks/107.bin" ; FC/004D
      aSoundChunk108 .soundBinary "chunks/108.bin" ; FC/0125
      aSoundChunk109 .soundBinary "chunks/109.bin" ; FC/1472
      aSoundChunk10A .soundBinary "chunks/10A.bin" ; FC/21C5
      aSoundChunk10B .soundBinary "chunks/10B.bin" ; FC/243B
      aSoundChunk10C .soundBinary "chunks/10C.bin" ; FC/2F7B
      aSoundChunk10D .soundBinary "chunks/10D.bin" ; FC/375B
      aSoundChunk10E .soundBinary "chunks/10E.bin" ; FC/405B
      aSoundChunk10F .soundBinary "chunks/10F.bin" ; FC/472D
      aSoundChunk110 .soundBinary "chunks/110.bin" ; FC/4F0D
      aSoundChunk111 .soundBinary "chunks/111.bin" ; FC/56ED
      aSoundChunk112 .soundBinary "chunks/112.bin" ; FC/82DF
      aSoundChunk113 .soundBinary "chunks/113.bin" ; FC/8D8F
      aSoundChunk114 .soundBinary "chunks/114.bin" ; FC/91C7
      aSoundChunk115 .soundBinary "chunks/115.bin" ; FC/9353
      aSoundChunk116 .soundBinary "chunks/116.bin" ; FC/96B3
      aSoundChunk117 .soundBinary "chunks/117.bin" ; FC/A93A
      aSoundChunk118 .soundBinary "chunks/118.bin" ; FC/B23A
      aSoundChunk119 .soundBinary "chunks/119.bin" ; FC/BFBA
      aSoundChunk11A .soundBinary "chunks/11A.bin" ; FC/C67A
      aSoundChunk11B .soundBinary "chunks/11B.bin" ; FC/D844
      aSoundChunk11C .soundBinary "chunks/11C.bin" ; FC/DCC4
      aSoundChunk11D .soundBinary "chunks/11D.bin" ; FC/E798
      aSoundUnknownFCE8AF ; FC/E8AF, nothing points here
        .byte $00
      aSoundChunk11E .soundBinary "chunks/11E.bin" ; FC/E8B0
      aSoundChunk11F .soundBinary "chunks/11F.bin" ; FD/001A
      aSoundChunk120 .soundBinary "chunks/120.bin" ; FD/01CA
      aSoundChunk121 .soundBinary "chunks/121.bin" ; FD/088A
      aSoundChunk122 .soundBinary "chunks/122.bin" ; FD/0ACA
      aSoundChunk123 .soundBinary "chunks/123.bin" ; FD/36CE
      aSoundChunk124 .soundBinary "chunks/124.bin" ; FD/3C53
      aSoundChunk125 .soundBinary "chunks/125.bin" ; FD/400D
      aSoundChunk126 .soundBinary "chunks/126.bin" ; FD/632C
      aSoundChunk127 .soundBinary "chunks/127.bin" ; FD/6B0C
      aSoundChunk128 .soundBinary "chunks/128.bin" ; FD/6F0E
      aSoundChunk129 .soundBinary "chunks/129.bin" ; FD/7C4F
      aSoundChunk12A .soundBinary "chunks/12A.bin" ; FD/881F
      aSoundChunk12B .soundBinary "chunks/12B.bin" ; FD/938C
      aSoundChunk12C .soundBinary "chunks/12C.bin" ; FD/9DAC
      aSoundChunk12D .soundBinary "chunks/12D.bin" ; FD/A4FC
      aSoundChunk12E .soundBinary "chunks/12E.bin" ; FD/B0F0
      aSoundChunk12F .soundBinary "chunks/12F.bin" ; FD/B43E
      aSoundChunk130 .soundBinary "chunks/130.bin" ; FD/B9BA
      aSoundChunk131 .soundBinary "chunks/131.bin" ; FD/BFC6
      aSoundChunk132 .soundBinary "chunks/132.bin" ; FD/C3DA
      aSoundChunk133 .soundBinary "chunks/133.bin" ; FD/C85A
      aSoundChunk134 .soundBinary "chunks/134.bin" ; FD/CEAE
      aSoundChunk135 .soundBinary "chunks/135.bin" ; FD/D6CD
      aSoundChunk136 .soundBinary "chunks/136.bin" ; FD/E966
      aSoundChunk137 .soundBinary "chunks/137.bin" ; FD/F2ED
      aSoundChunk138 .soundBinary "chunks/138.bin" ; FD/FBC9
      aSoundChunk139 .soundBinary "chunks/139.bin" ; FD/FE6C
      aSoundChunk13A .soundBinary "chunks/13A.bin" ; FE/0001
      aSoundChunk13B .soundBinary "chunks/13B.bin" ; FE/08C2
      aSoundChunk13C .soundBinary "chunks/13C.bin" ; FE/0CA0
      aSoundChunk13D .soundBinary "chunks/13D.bin" ; FE/1BAC
      aSoundChunk13E .soundBinary "chunks/13E.bin" ; FE/2893
      aSoundChunk13F .soundBinary "chunks/13F.bin" ; FE/3103
      aSoundChunk140 .soundBinary "chunks/140.bin" ; FE/3802
      aSoundChunk141 .soundBinary "chunks/141.bin" ; FE/4246
      aSoundChunk142 .soundBinary "chunks/142.bin" ; FE/4594
      aSoundChunk143 .soundBinary "chunks/143.bin" ; FE/5650
      aSoundChunk144 .soundBinary "chunks/144.bin" ; FE/6190
      aSoundChunk145 .soundBinary "chunks/145.bin" ; FE/6610
      aSoundChunk146 .soundBinary "chunks/146.bin" ; FE/7810
      aSoundChunk147 .soundBinary "chunks/147.bin" ; FE/7846
      aSoundChunk148 .soundBinary "chunks/148.bin" ; FE/785A
      aSoundChunk149 .soundBinary "chunks/149.bin" ; FE/78AE
      aSoundChunk14A .soundBinary "chunks/14A.bin" ; FE/78D6
      aSoundChunk14B .soundBinary "chunks/14B.bin" ; FE/7924
      aSoundChunk14C .soundBinary "chunks/14C.bin" ; FE/794C
      aSoundChunk14D .soundBinary "chunks/14D.bin" ; FE/798E
      aSoundChunk14E .soundBinary "chunks/14E.bin" ; FE/79AE
      aSoundChunk14F .soundBinary "chunks/14F.bin" ; FE/79DE
      aSoundChunk150 .soundBinary "chunks/150.bin" ; FE/79F6
      aSoundChunk151 .soundBinary "chunks/151.bin" ; FE/7A20
      aSoundChunk152 .soundBinary "chunks/152.bin" ; FE/7A38
      aSoundChunk153 .soundBinary "chunks/153.bin" ; FE/7A7A
      aSoundChunk154 .soundBinary "chunks/154.bin" ; FE/7AA6
      aSoundChunk155 .soundBinary "chunks/155.bin" ; FE/7AC4
      aSoundChunk156 .soundBinary "chunks/156.bin" ; FE/7AD8
      aSoundChunk157 .soundBinary "chunks/157.bin" ; FE/7B0E
      aSoundChunk158 .soundBinary "chunks/158.bin" ; FE/7B2A
      aSoundChunk159 .soundBinary "chunks/159.bin" ; FE/7B54
      aSoundChunk15A .soundBinary "chunks/15A.bin" ; FE/7B70
      aSoundChunk15B .soundBinary "chunks/15B.bin" ; FE/7BB8
      aSoundChunk15C .soundBinary "chunks/15C.bin" ; FE/7BD8
      aSoundChunk15D .soundBinary "chunks/15D.bin" ; FE/7C38
      aSoundChunk15E .soundBinary "chunks/15E.bin" ; FE/7C60
      aSoundChunk15F .soundBinary "chunks/15F.bin" ; FE/7C9C
      aSoundChunk160 .soundBinary "chunks/160.bin" ; FE/7CB8
      aSoundChunk161 .soundBinary "chunks/161.bin" ; FE/7CDC
      aSoundChunk162 .soundBinary "chunks/162.bin" ; FE/7CF0
      aSoundChunk163 .soundBinary "chunks/163.bin" ; FE/7D1A
      aSoundChunk164 .soundBinary "chunks/164.bin" ; FE/7D36
      aSoundChunk165 .soundBinary "chunks/165.bin" ; FE/7D60
      aSoundChunk166 .soundBinary "chunks/166.bin" ; FE/7D78
      aSoundChunk167 .soundBinary "chunks/167.bin" ; FE/7DA8
      aSoundChunk168 .soundBinary "chunks/168.bin" ; FE/7DBC
      aSoundChunk169 .soundBinary "chunks/169.bin" ; FE/7DE6
      aSoundChunk16A .soundBinary "chunks/16A.bin" ; FE/7DFE
      aSoundChunk16B .soundBinary "chunks/16B.bin" ; FE/7E28
      aSoundChunk16C .soundBinary "chunks/16C.bin" ; FE/7E40
      aSoundChunk16D .soundBinary "chunks/16D.bin" ; FE/7E64
      aSoundChunk16E .soundBinary "chunks/16E.bin" ; FE/7E78
      aSoundChunk16F .soundBinary "chunks/16F.bin" ; FE/7EAE
      aSoundChunk170 .soundBinary "chunks/170.bin" ; FE/7ECE
      aSoundChunk171 .soundBinary "chunks/171.bin" ; FE/7EEC
      aSoundChunk172 .soundBinary "chunks/172.bin" ; FE/7F00
      aSoundChunk173 .soundBinary "chunks/173.bin" ; FE/7F36
      aSoundChunk174 .soundBinary "chunks/174.bin" ; FE/7F4E
      aSoundChunk175 .soundBinary "chunks/175.bin" ; FE/7F72
      aSoundChunk176 .soundBinary "chunks/176.bin" ; FE/7F86
      aSoundChunk177 .soundBinary "chunks/177.bin" ; FE/7FB6
      aSoundChunk178 .soundBinary "chunks/178.bin" ; FE/7FCE
      aSoundChunk179 .soundBinary "chunks/179.bin" ; FE/7FF2
      aSoundChunk17A .soundBinary "chunks/17A.bin" ; FE/800A
      aSoundChunk17B .soundBinary "chunks/17B.bin" ; FE/8040
      aSoundChunk17C .soundBinary "chunks/17C.bin" ; FE/8060
      aSoundChunk17D .soundBinary "chunks/17D.bin" ; FE/8078
      aSoundChunk17E .soundBinary "chunks/17E.bin" ; FE/8088
      aSoundChunk17F .soundBinary "chunks/17F.bin" ; FE/80B8
      aSoundChunk180 .soundBinary "chunks/180.bin" ; FE/80D4
      aSoundChunk181 .soundBinary "chunks/181.bin" ; FE/810A
      aSoundChunk182 .soundBinary "chunks/182.bin" ; FE/8112
      aSoundChunk183 .soundBinary "chunks/183.bin" ; FE/8160
      aSoundChunk184 .soundBinary "chunks/184.bin" ; FE/8178
      aSoundChunk185 .soundBinary "chunks/185.bin" ; FE/81A8
      aSoundChunk186 .soundBinary "chunks/186.bin" ; FE/81C4
      aSoundChunk187 .soundBinary "chunks/187.bin" ; FE/81D0
      aSoundChunk188 .soundBinary "chunks/188.bin" ; FE/81D8
      aSoundChunk189 .soundBinary "chunks/189.bin" ; FE/81F0
      aSoundChunk18A .soundBinary "chunks/18A.bin" ; FE/8200
      aSoundChunk18B .soundBinary "chunks/18B.bin" ; FE/8230
      aSoundChunk18C .soundBinary "chunks/18C.bin" ; FE/8250
      aSoundChunk18D .soundBinary "chunks/18D.bin" ; FE/8292
      aSoundChunk18E .soundBinary "chunks/18E.bin" ; FE/82B6
      aSoundChunk18F .soundBinary "chunks/18F.bin" ; FE/82C8
      aSoundChunk190 .soundBinary "chunks/190.bin" ; FE/82D4
      aSoundChunk191 .soundBinary "chunks/191.bin" ; FE/82DA
      aSoundChunk192 .soundBinary "chunks/192.bin" ; FE/82DE
      aSoundChunk193 .soundBinary "chunks/193.bin" ; FE/82F0
      aSoundChunk194 .soundBinary "chunks/194.bin" ; FE/82FC
      aSoundChunk195 .soundBinary "chunks/195.bin" ; FE/8338
      aSoundChunk196 .soundBinary "chunks/196.bin" ; FE/835C
      aSoundChunk197 .soundBinary "chunks/197.bin" ; FE/836E
      aSoundChunk198 .soundBinary "chunks/198.bin" ; FE/8376
      aSoundChunk199 .soundBinary "chunks/199.bin" ; FE/839A
      aSoundChunk19A .soundBinary "chunks/19A.bin" ; FE/83B2
      aSoundChunk19B .soundBinary "chunks/19B.bin" ; FE/83D0
      aSoundChunk19C .soundBinary "chunks/19C.bin" ; FE/83E4
      aSoundChunk19D .soundBinary "chunks/19D.bin" ; FE/83FC
      aSoundChunk19E .soundBinary "chunks/19E.bin" ; FE/8408
      aSoundChunk19F .soundBinary "chunks/19F.bin" ; FE/842C
      aSoundChunk1A0 .soundBinary "chunks/1A0.bin" ; FE/8444
      aSoundChunk1A1 .soundBinary "chunks/1A1.bin" ; FE/8468
      aSoundChunk1A2 .soundBinary "chunks/1A2.bin" ; FE/847C
      aSoundChunk1A3 .soundBinary "chunks/1A3.bin" ; FE/84A0
      aSoundChunk1A4 .soundBinary "chunks/1A4.bin" ; FE/84B4
      aSoundChunk1A5 .soundBinary "chunks/1A5.bin" ; FE/84D2
      aSoundChunk1A6 .soundBinary "chunks/1A6.bin" ; FE/84E2
      aSoundChunk1A7 .soundBinary "chunks/1A7.bin" ; FE/8500
      aSoundChunk1A8 .soundBinary "chunks/1A8.bin" ; FE/8514
      aSoundChunk1A9 .soundBinary "chunks/1A9.bin" ; FE/8532
      aSoundChunk1AA .soundBinary "chunks/1AA.bin" ; FE/8542
      aSoundChunk1AB .soundBinary "chunks/1AB.bin" ; FE/854E
      aSoundChunk1AC .soundBinary "chunks/1AC.bin" ; FE/8556
      aSoundChunk1AD .soundBinary "chunks/1AD.bin" ; FE/85AA
      aSoundChunk1AE .soundBinary "chunks/1AE.bin" ; FE/85C2
      aSoundChunk1AF .soundBinary "chunks/1AF.bin" ; FE/8610
      aSoundChunk1B0 .soundBinary "chunks/1B0.bin" ; FE/862C
      aSoundChunk1B1 .soundBinary "chunks/1B1.bin" ; FE/8686
      aSoundChunk1B2 .soundBinary "chunks/1B2.bin" ; FE/86A6
      aSoundChunk1B3 .soundBinary "chunks/1B3.bin" ; FE/8712
      aSoundChunk1B4 .soundBinary "chunks/1B4.bin" ; FE/8736
      aSoundChunk1B5 .soundBinary "chunks/1B5.bin" ; FE/87A2
      aSoundChunk1B6 .soundBinary "chunks/1B6.bin" ; FE/87CE
      aSoundChunk1B7 .soundBinary "chunks/1B7.bin" ; FE/8816
      aSoundChunk1B8 .soundBinary "chunks/1B8.bin" ; FE/8822
      aSoundChunk1B9 .soundBinary "chunks/1B9.bin" ; FE/8852
      aSoundChunk1BA .soundBinary "chunks/1BA.bin" ; FE/886E
      aSoundChunk1BB .soundBinary "chunks/1BB.bin" ; FE/889E
      aSoundChunk1BC .soundBinary "chunks/1BC.bin" ; FE/88BA
      aSoundChunk1BD .soundBinary "chunks/1BD.bin" ; FE/88DE
      aSoundChunk1BE .soundBinary "chunks/1BE.bin" ; FE/88F2
      aSoundChunk1BF .soundBinary "chunks/1BF.bin" ; FE/891C
      aSoundChunk1C0 .soundBinary "chunks/1C0.bin" ; FE/8934
      aSoundChunk1C1 .soundBinary "chunks/1C1.bin" ; FE/8958
      aSoundChunk1C2 .soundBinary "chunks/1C2.bin" ; FE/896C
      aSoundChunk1C3 .soundBinary "chunks/1C3.bin" ; FE/8984
      aSoundChunk1C4 .soundBinary "chunks/1C4.bin" ; FE/8994
      aSoundChunk1C5 .soundBinary "chunks/1C5.bin" ; FE/89B2
      aSoundChunk1C6 .soundBinary "chunks/1C6.bin" ; FE/89C6
      aSoundChunk1C7 .soundBinary "chunks/1C7.bin" ; FE/89DE
      aSoundChunk1C8 .soundBinary "chunks/1C8.bin" ; FE/89EA
      aSoundChunk1C9 .soundBinary "chunks/1C9.bin" ; FE/89FC
      aSoundChunk1CA .soundBinary "chunks/1CA.bin" ; FE/8A08
      aSoundChunk1CB .soundBinary "chunks/1CB.bin" ; FE/8A2C
      aSoundChunk1CC .soundBinary "chunks/1CC.bin" ; FE/8A40
      aSoundChunk1CD .soundBinary "chunks/1CD.bin" ; FE/8A70
      aSoundChunk1CE .soundBinary "chunks/1CE.bin" ; FE/8A8C
      aSoundChunk1CF .soundBinary "chunks/1CF.bin" ; FE/8AB6
      aSoundChunk1D0 .soundBinary "chunks/1D0.bin" ; FE/8AC6
      aSoundChunk1D1 .soundBinary "chunks/1D1.bin" ; FE/8ADE
      aSoundChunk1D2 .soundBinary "chunks/1D2.bin" ; FE/8AEE
      aSoundChunk1D3 .soundBinary "chunks/1D3.bin" ; FE/8B24
      aSoundChunk1D4 .soundBinary "chunks/1D4.bin" ; FE/8B48
      aSoundChunk1D5 .soundBinary "chunks/1D5.bin" ; FE/8B60
      aSoundChunk1D6 .soundBinary "chunks/1D6.bin" ; FE/8B70
      aSoundChunk1D7 .soundBinary "chunks/1D7.bin" ; FE/8B8E
      aSoundChunk1D8 .soundBinary "chunks/1D8.bin" ; FE/8B96
      aSoundChunk1D9 .soundBinary "chunks/1D9.bin" ; FE/8BB4
      aSoundChunk1DA .soundBinary "chunks/1DA.bin" ; FE/8BC8
      aSoundChunk1DB .soundBinary "chunks/1DB.bin" ; FE/8BDA
      aSoundChunk1DC .soundBinary "chunks/1DC.bin" ; FE/8BE6
      aSoundChunk1DD .soundBinary "chunks/1DD.bin" ; FE/8BFE
      aSoundChunk1DE .soundBinary "chunks/1DE.bin" ; FE/8C0E
      aSoundChunk1DF .soundBinary "chunks/1DF.bin" ; FE/8C2C
      aSoundChunk1E0 .soundBinary "chunks/1E0.bin" ; FE/8C40
      aSoundChunk1E1 .soundBinary "chunks/1E1.bin" ; FE/8C58
      aSoundChunk1E2 .soundBinary "chunks/1E2.bin" ; FE/8C64
      aSoundChunk1E3 .soundBinary "chunks/1E3.bin" ; FE/8C70
      aSoundChunk1E4 .soundBinary "chunks/1E4.bin" ; FE/8C78
      aSoundChunk1E5 .soundBinary "chunks/1E5.bin" ; FE/8C8A
      aSoundChunk1E6 .soundBinary "chunks/1E6.bin" ; FE/8C96
      aSoundChunk1E7 .soundBinary "chunks/1E7.bin" ; FE/8CB4
      aSoundChunk1E8 .soundBinary "chunks/1E8.bin" ; FE/8CC8
      aSoundChunk1E9 .soundBinary "chunks/1E9.bin" ; FE/8CF2
      aSoundChunk1EA .soundBinary "chunks/1EA.bin" ; FE/8D0A
      aSoundChunk1EB .soundBinary "chunks/1EB.bin" ; FE/8D2E
      aSoundChunk1EC .soundBinary "chunks/1EC.bin" ; FE/8D42
      aSoundChunk1ED .soundBinary "chunks/1ED.bin" ; FE/8D5A
      aSoundChunk1EE .soundBinary "chunks/1EE.bin" ; FE/8D6A
      aSoundChunk1EF .soundBinary "chunks/1EF.bin" ; FE/8D7C
      aSoundChunk1F0 .soundBinary "chunks/1F0.bin" ; FE/8D88
      aSoundChunk1F1 .soundBinary "chunks/1F1.bin" ; FE/8DB8
      aSoundChunk1F2 .soundBinary "chunks/1F2.bin" ; FE/8DCC
      aSoundChunk1F3 .soundBinary "chunks/1F3.bin" ; FE/8DEA
      aSoundChunk1F4 .soundBinary "chunks/1F4.bin" ; FE/8DFA
      aSoundChunk1F5 .soundBinary "chunks/1F5.bin" ; FE/8E0C
      aSoundChunk1F6 .soundBinary "chunks/1F6.bin" ; FE/8E18
      aSoundChunk1F7 .soundBinary "chunks/1F7.bin" ; FE/8E2A
      aSoundChunk1F8 .soundBinary "chunks/1F8.bin" ; FE/8E36
      aSoundChunk1F9 .soundBinary "chunks/1F9.bin" ; FE/8E4E
      aSoundChunk1FA .soundBinary "chunks/1FA.bin" ; FE/8E5E
      aSoundChunk1FB .soundBinary "chunks/1FB.bin" ; FE/8E76
      aSoundChunk1FC .soundBinary "chunks/1FC.bin" ; FE/8E86
      aSoundChunk1FD .soundBinary "chunks/1FD.bin" ; FE/8E9E
      aSoundChunk1FE .soundBinary "chunks/1FE.bin" ; FE/8EAE
      aSoundChunk1FF .soundBinary "chunks/1FF.bin" ; FE/8ED2
      aSoundChunk200 .soundBinary "chunks/200.bin" ; FE/8EE6
      aSoundChunk201 .soundBinary "chunks/201.bin" ; FE/8EF8
      aSoundChunk202 .soundBinary "chunks/202.bin" ; FE/8F04
      aSoundChunk203 .soundBinary "chunks/203.bin" ; FE/8F28
      aSoundChunk204 .soundBinary "chunks/204.bin" ; FE/8F3C
      aSoundChunk205 .soundBinary "chunks/205.bin" ; FE/8F5A
      aSoundChunk206 .soundBinary "chunks/206.bin" ; FE/8F6E
      aSoundChunk207 .soundBinary "chunks/207.bin" ; FE/8F86
      aSoundChunk208 .soundBinary "chunks/208.bin" ; FE/8F96
      aSoundChunk209 .soundBinary "chunks/209.bin" ; FE/8FC6
      aSoundChunk20A .soundBinary "chunks/20A.bin" ; FE/8FE2
      aSoundChunk20B .soundBinary "chunks/20B.bin" ; FE/9000
      aSoundChunk20C .soundBinary "chunks/20C.bin" ; FE/9010
      aSoundChunk20D .soundBinary "chunks/20D.bin" ; FE/902E
      aSoundChunk20E .soundBinary "chunks/20E.bin" ; FE/9042
      aSoundChunk20F .soundBinary "chunks/20F.bin" ; FE/905A
      aSoundChunk210 .soundBinary "chunks/210.bin" ; FE/906A
      aSoundChunk211 .soundBinary "chunks/211.bin" ; FE/9088
      aSoundChunk212 .soundBinary "chunks/212.bin" ; FE/909C
      aSoundChunk213 .soundBinary "chunks/213.bin" ; FE/90BA
      aSoundChunk214 .soundBinary "chunks/214.bin" ; FE/90C6
      aSoundChunk215 .soundBinary "chunks/215.bin" ; FE/90D2
      aSoundChunk216 .soundBinary "chunks/216.bin" ; FE/90DA
      aSoundChunk217 .soundBinary "chunks/217.bin" ; FE/9104
      aSoundChunk218 .soundBinary "chunks/218.bin" ; FE/911C
      aSoundChunk219 .soundBinary "chunks/219.bin" ; FE/9140
      aSoundChunk21A .soundBinary "chunks/21A.bin" ; FE/9154
      aSoundChunk21B .soundBinary "chunks/21B.bin" ; FE/916C
      aSoundChunk21C .soundBinary "chunks/21C.bin" ; FE/917C
      aSoundChunk21D .soundBinary "chunks/21D.bin" ; FE/919A
      aSoundChunk21E .soundBinary "chunks/21E.bin" ; FE/91AE
      aSoundChunk21F .soundBinary "chunks/21F.bin" ; FE/91D8
      aSoundChunk220 .soundBinary "chunks/220.bin" ; FE/91F4
      aSoundChunk221 .soundBinary "chunks/221.bin" ; FE/9212
      aSoundChunk222 .soundBinary "chunks/222.bin" ; FE/9222
      aSoundChunk223 .soundBinary "chunks/223.bin" ; FE/924C
      aSoundChunk224 .soundBinary "chunks/224.bin" ; FE/9260
      aSoundChunk225 .soundBinary "chunks/225.bin" ; FE/9266
      aSoundChunk226 .soundBinary "chunks/226.bin" ; FE/926A
      aSoundChunk227 .soundBinary "chunks/227.bin" ; FE/9270
      aSoundChunk228 .soundBinary "chunks/228.bin" ; FE/9274
      aSoundChunk229 .soundBinary "chunks/229.bin" ; FE/9298
      aSoundChunk22A .soundBinary "chunks/22A.bin" ; FE/92B0
      aSoundChunk22B .soundBinary "chunks/22B.bin" ; FE/92BC
      aSoundChunk22C .soundBinary "chunks/22C.bin" ; FE/92C4
      aSoundChunk22D .soundBinary "chunks/22D.bin" ; FE/92D0
      aSoundChunk22E .soundBinary "chunks/22E.bin" ; FE/92D8
      aSoundChunk22F .soundBinary "chunks/22F.bin" ; FE/99BC
      aSoundChunk230 .soundBinary "chunks/230.bin" ; FE/99C8
      aSoundChunk232 .soundBinary "chunks/232.bin" ; FE/99D0
      aSoundChunk233 .soundBinary "chunks/233.bin" ; FE/99D6
      aSoundChunk234 .soundBinary "chunks/234.bin" ; FE/99DA
      aSoundChunk235 .soundBinary "chunks/235.bin" ; FE/A4B7
      aSoundChunk236 .soundBinary "chunks/236.bin" ; FE/A4BD
      aSoundChunk238 .soundBinary "chunks/238.bin" ; FE/A4C1
      aSoundChunk239 .soundBinary "chunks/239.bin" ; FE/A4C7
      aSoundChunk23A .soundBinary "chunks/23A.bin" ; FE/A4CB
      aSoundChunk23B .soundBinary "chunks/23B.bin" ; FE/A9F6
      aSoundChunk23C .soundBinary "chunks/23C.bin" ; FE/A9FC
      aSoundChunk23E .soundBinary "chunks/23E.bin" ; FE/AA00
      aSoundChunk23F .soundBinary "chunks/23F.bin" ; FE/AA0C
      aSoundChunk240 .soundBinary "chunks/240.bin" ; FE/AA14
      aSoundChunk241 .soundBinary "chunks/241.bin" ; FE/B779
      aSoundChunk242 .soundBinary "chunks/242.bin" ; FE/B785
      aSoundChunk244 .soundBinary "chunks/244.bin" ; FE/B78D
      aSoundChunk245 .soundBinary "chunks/245.bin" ; FE/B793
      aSoundChunk246 .soundBinary "chunks/246.bin" ; FE/B797
      aSoundChunk247 .soundBinary "chunks/247.bin" ; FE/C379
      aSoundChunk248 .soundBinary "chunks/248.bin" ; FE/C37F
      aSoundChunk24A .soundBinary "chunks/24A.bin" ; FE/C383
      aSoundChunk24B .soundBinary "chunks/24B.bin" ; FE/C389
      aSoundChunk24C .soundBinary "chunks/24C.bin" ; FE/C38D
      aSoundChunk24D .soundBinary "chunks/24D.bin" ; FE/CE46
      aSoundChunk24E .soundBinary "chunks/24E.bin" ; FE/CE4C
      aSoundChunk250 .soundBinary "chunks/250.bin" ; FE/CE50
      aSoundChunk251 .soundBinary "chunks/251.bin" ; FE/CE56
      aSoundChunk252 .soundBinary "chunks/252.bin" ; FE/CE5A
      aSoundChunk253 .soundBinary "chunks/253.bin" ; FE/D5AA
      aSoundChunk254 .soundBinary "chunks/254.bin" ; FE/D5B0
      aSoundChunk256 .soundBinary "chunks/256.bin" ; FE/D5B4
      aSoundChunk257 .soundBinary "chunks/257.bin" ; FE/D5BA
      aSoundChunk258 .soundBinary "chunks/258.bin" ; FE/D5BE
      aSoundChunk259 .soundBinary "chunks/259.bin" ; FE/E0FE
      aSoundChunk25A .soundBinary "chunks/25A.bin" ; FE/E104
      aSoundChunk25C .soundBinary "chunks/25C.bin" ; FE/E108
      aSoundChunk25D .soundBinary "chunks/25D.bin" ; FE/E10E
      aSoundChunk25E .soundBinary "chunks/25E.bin" ; FE/E112
      aSoundChunk25F .soundBinary "chunks/25F.bin" ; FE/E7AE
      aSoundChunk260 .soundBinary "chunks/260.bin" ; FE/E7B4
      aSoundChunk262 .soundBinary "chunks/262.bin" ; FE/E7B8
      aSoundChunk263 .soundBinary "chunks/263.bin" ; FE/E7BE
      aSoundChunk264 .soundBinary "chunks/264.bin" ; FE/E7C2
      aSoundChunk265 .soundBinary "chunks/265.bin" ; FE/F2F0
      aSoundChunk266 .soundBinary "chunks/266.bin" ; FE/F2F6
      aSoundChunk268 .soundBinary "chunks/268.bin" ; FE/F2FA
      aSoundChunk269 .soundBinary "chunks/269.bin" ; FE/F300
      aSoundChunk26A .soundBinary "chunks/26A.bin" ; FE/F304
      aSoundChunk26B .soundBinary "chunks/26B.bin" ; FE/FCAF
      aSoundChunk26C .soundBinary "chunks/26C.bin" ; FE/FCB5
      aSoundUnknownFEFCB9 ; FE/FCB9, nothing points here
        .byte $00
      aSoundChunk26E .soundBinary "chunks/26E.bin" ; FE/FCBA
      aSoundChunk26F .soundBinary "chunks/26F.bin" ; FE/FCC0
      aSoundChunk270 .soundBinary "chunks/270.bin" ; FE/FCC4
      aSoundChunk271 .soundBinary "chunks/271.bin" ; FF/07D7
      aSoundChunk272 .soundBinary "chunks/272.bin" ; FF/07DD
      aSoundChunk274 .soundBinary "chunks/274.bin" ; FF/07E1
      aSoundChunk275 .soundBinary "chunks/275.bin" ; FF/07E7
      aSoundChunk276 .soundBinary "chunks/276.bin" ; FF/07EB
      aSoundChunk277 .soundBinary "chunks/277.bin" ; FF/1373
      aSoundChunk278 .soundBinary "chunks/278.bin" ; FF/1379
      aSoundChunk27A .soundBinary "chunks/27A.bin" ; FF/137D
      aSoundChunk27B .soundBinary "chunks/27B.bin" ; FF/1383
      aSoundChunk27C .soundBinary "chunks/27C.bin" ; FF/1387
      aSoundChunk27D .soundBinary "chunks/27D.bin" ; FF/2119
      aSoundChunk27E .soundBinary "chunks/27E.bin" ; FF/211F
      aSoundChunk280 .soundBinary "chunks/280.bin" ; FF/2123
      aSoundChunk281 .soundBinary "chunks/281.bin" ; FF/2129
      aSoundChunk282 .soundBinary "chunks/282.bin" ; FF/212D
      aSoundChunk283 .soundBinary "chunks/283.bin" ; FF/27D2
      aSoundChunk284 .soundBinary "chunks/284.bin" ; FF/27D8
      aSoundChunk286 .soundBinary "chunks/286.bin" ; FF/27DC
      aSoundChunk287 .soundBinary "chunks/287.bin" ; FF/27E2
      aSoundChunk288 .soundBinary "chunks/288.bin" ; FF/27E6
      aSoundChunk289 .soundBinary "chunks/289.bin" ; FF/3326
      aSoundChunk28A .soundBinary "chunks/28A.bin" ; FF/332C
      aSoundChunk28C .soundBinary "chunks/28C.bin" ; FF/3330
      aSoundChunk28D .soundBinary "chunks/28D.bin" ; FF/3336
      aSoundChunk28E .soundBinary "chunks/28E.bin" ; FF/333A
      aSoundChunk28F .soundBinary "chunks/28F.bin" ; FF/3D99
      aSoundChunk290 .soundBinary "chunks/290.bin" ; FF/3D9F
      aSoundChunk292 .soundBinary "chunks/292.bin" ; FF/3DA3
      aSoundChunk293 .soundBinary "chunks/293.bin" ; FF/3DA9
      aSoundChunk294 .soundBinary "chunks/294.bin" ; FF/3DAD
      aSoundChunk295 .soundBinary "chunks/295.bin" ; FF/45DE
      aSoundChunk296 .soundBinary "chunks/296.bin" ; FF/45E4
      aSoundChunk298 .soundBinary "chunks/298.bin" ; FF/45E8
      aSoundChunk299 .soundBinary "chunks/299.bin" ; FF/45EE
      aSoundChunk29A .soundBinary "chunks/29A.bin" ; FF/45F2
      aSoundChunk29B .soundBinary "chunks/29B.bin" ; FF/4BFE
      aSoundChunk29C .soundBinary "chunks/29C.bin" ; FF/4C04
      aSoundChunk29E .soundBinary "chunks/29E.bin" ; FF/4C08
      aSoundChunk29F .soundBinary "chunks/29F.bin" ; FF/4C0E
      aSoundChunk2A0 .soundBinary "chunks/2A0.bin" ; FF/4C12
      aSoundChunk2A1 .soundBinary "chunks/2A1.bin" ; FF/51B2
      aSoundChunk2A2 .soundBinary "chunks/2A2.bin" ; FF/51B8
      aSoundChunk2A4 .soundBinary "chunks/2A4.bin" ; FF/51BC
      aSoundChunk2A5 .soundBinary "chunks/2A5.bin" ; FF/51C2
      aSoundChunk2A6 .soundBinary "chunks/2A6.bin" ; FF/51C6
      aSoundChunk2A7 .soundBinary "chunks/2A7.bin" ; FF/5541
      aSoundChunk2A8 .soundBinary "chunks/2A8.bin" ; FF/5547
      aSoundChunk2AA .soundBinary "chunks/2AA.bin" ; FF/554B
      aSoundChunk2AB .soundBinary "chunks/2AB.bin" ; FF/5551
      aSoundChunk2AC .soundBinary "chunks/2AC.bin" ; FF/5555
      aSoundChunk2AD .soundBinary "chunks/2AD.bin" ; FF/5825
      aSoundChunk2AE .soundBinary "chunks/2AE.bin" ; FF/582B
      aSoundChunk2B0 .soundBinary "chunks/2B0.bin" ; FF/582F
      aSoundChunk2B1 .soundBinary "chunks/2B1.bin" ; FF/5835
      aSoundChunk2B2 .soundBinary "chunks/2B2.bin" ; FF/5839
      aSoundChunk2B3 .soundBinary "chunks/2B3.bin" ; FF/5B99
      aSoundChunk2B4 .soundBinary "chunks/2B4.bin" ; FF/5B9F
      aSoundChunk2B6 .soundBinary "chunks/2B6.bin" ; FF/5BA3
      aSoundChunk2B7 .soundBinary "chunks/2B7.bin" ; FF/5BA9
      aSoundChunk2B8 .soundBinary "chunks/2B8.bin" ; FF/5BAD
      aSoundChunk2B9 .soundBinary "chunks/2B9.bin" ; FF/5F0D
      aSoundChunk2BA .soundBinary "chunks/2BA.bin" ; FF/5F13
      aSoundChunk2BC .soundBinary "chunks/2BC.bin" ; FF/5F17
      aSoundChunk2BD .soundBinary "chunks/2BD.bin" ; FF/5F1D
      aSoundChunk2BE .soundBinary "chunks/2BE.bin" ; FF/5F21
      aSoundChunk2BF .soundBinary "chunks/2BF.bin" ; FF/6266
      aSoundChunk2C0 .soundBinary "chunks/2C0.bin" ; FF/626C
      aSoundChunk2C2 .soundBinary "chunks/2C2.bin" ; FF/6270
      aSoundChunk2C3 .soundBinary "chunks/2C3.bin" ; FF/6276
      aSoundChunk2C4 .soundBinary "chunks/2C4.bin" ; FF/627A
      aSoundChunk2C5 .soundBinary "chunks/2C5.bin" ; FF/6526
      aSoundChunk2C6 .soundBinary "chunks/2C6.bin" ; FF/652C
      aSoundChunk2C8 .soundBinary "chunks/2C8.bin" ; FF/6530
      aSoundChunk2C9 .soundBinary "chunks/2C9.bin" ; FF/6536
      aSoundChunk2CA .soundBinary "chunks/2CA.bin" ; FF/653A
      aSoundChunk2CB .soundBinary "chunks/2CB.bin" ; FF/68B5
      aSoundChunk2CC .soundBinary "chunks/2CC.bin" ; FF/68BB
      aSoundChunk2CE .soundBinary "chunks/2CE.bin" ; FF/68BF
      aSoundChunk2CF .soundBinary "chunks/2CF.bin" ; FF/68C5
      aSoundChunk2D0 .soundBinary "chunks/2D0.bin" ; FF/68C9
      aSoundChunk2D1 .soundBinary "chunks/2D1.bin" ; FF/6C44
      aSoundChunk2D2 .soundBinary "chunks/2D2.bin" ; FF/6C4A
      aSoundChunk2D4 .soundBinary "chunks/2D4.bin" ; FF/6C4E
      aSoundChunk2D5 .soundBinary "chunks/2D5.bin" ; FF/6C54
      aSoundChunk2D6 .soundBinary "chunks/2D6.bin" ; FF/6C58
      aSoundChunk2D7 .soundBinary "chunks/2D7.bin" ; FF/6FD3
      aSoundChunk2D8 .soundBinary "chunks/2D8.bin" ; FF/6FD9
      aSoundChunk2DA .soundBinary "chunks/2DA.bin" ; FF/6FDD
      aSoundChunk2DB .soundBinary "chunks/2DB.bin" ; FF/6FE3
      aSoundChunk2DC .soundBinary "chunks/2DC.bin" ; FF/6FE7
      aSoundChunk2DD .soundBinary "chunks/2DD.bin" ; FF/7362
      aSoundChunk2DE .soundBinary "chunks/2DE.bin" ; FF/7368
      aSoundChunk2E0 .soundBinary "chunks/2E0.bin" ; FF/736C
      aSoundChunk2E1 .soundBinary "chunks/2E1.bin" ; FF/7372
      aSoundChunk2E2 .soundBinary "chunks/2E2.bin" ; FF/7376
      aSoundChunk2E3 .soundBinary "chunks/2E3.bin" ; FF/7646
      aSoundChunk2E4 .soundBinary "chunks/2E4.bin" ; FF/764C
      aSoundChunk2E6 .soundBinary "chunks/2E6.bin" ; FF/7650
      aSoundChunk2E7 .soundBinary "chunks/2E7.bin" ; FF/7656
      aSoundChunk2E8 .soundBinary "chunks/2E8.bin" ; FF/765A
      aSoundChunk2E9 .soundBinary "chunks/2E9.bin" ; FF/79D5
      aSoundChunk2EA .soundBinary "chunks/2EA.bin" ; FF/79DB
      aSoundChunk2EC .soundBinary "chunks/2EC.bin" ; FF/79DF
      aSoundChunk2ED .soundBinary "chunks/2ED.bin" ; FF/79E5
      aSoundChunk2EE .soundBinary "chunks/2EE.bin" ; FF/79E9
      aSoundChunk2EF .soundBinary "chunks/2EF.bin" ; FF/7D49
      aSoundChunk2F0 .soundBinary "chunks/2F0.bin" ; FF/7D4F
      aSoundChunk2F2 .soundBinary "chunks/2F2.bin" ; FF/7D53
      aSoundChunk2F3 .soundBinary "chunks/2F3.bin" ; FF/7D59
      aSoundChunk2F4 .soundBinary "chunks/2F4.bin" ; FF/7D5D
      aSoundChunk2F5 .soundBinary "chunks/2F5.bin" ; FF/80BD
      aSoundChunk2F6 .soundBinary "chunks/2F6.bin" ; FF/80C3
      aSoundChunk2F8 .soundBinary "chunks/2F8.bin" ; FF/80C7
      aSoundChunk2F9 .soundBinary "chunks/2F9.bin" ; FF/80CD
      aSoundChunk2FA .soundBinary "chunks/2FA.bin" ; FF/80D1
      aSoundChunk2FB .soundBinary "chunks/2FB.bin" ; FF/8443
      aSoundChunk2FC .soundBinary "chunks/2FC.bin" ; FF/8449
      aSoundChunk2FE .soundBinary "chunks/2FE.bin" ; FF/844D
      aSoundChunk2FF .soundBinary "chunks/2FF.bin" ; FF/8453
      aSoundChunk300 .soundBinary "chunks/300.bin" ; FF/8457
      aSoundChunk301 .soundBinary "chunks/301.bin" ; FF/87D2
      aSoundChunk302 .soundBinary "chunks/302.bin" ; FF/87D8
      aSoundChunk304 .soundBinary "chunks/304.bin" ; FF/87DC
      aSoundChunk305 .soundBinary "chunks/305.bin" ; FF/87E2
      aSoundChunk306 .soundBinary "chunks/306.bin" ; FF/87E6
      aSoundChunk307 .soundBinary "chunks/307.bin" ; FF/8B61
      aSoundChunk308 .soundBinary "chunks/308.bin" ; FF/8B67
      aSoundChunk30A .soundBinary "chunks/30A.bin" ; FF/8B6B
      aSoundChunk30B .soundBinary "chunks/30B.bin" ; FF/8B71
      aSoundChunk30C .soundBinary "chunks/30C.bin" ; FF/8B75
      aSoundChunk30D .soundBinary "chunks/30D.bin" ; FF/8D25
      aSoundChunk30E .soundBinary "chunks/30E.bin" ; FF/8D2B
      aSoundChunk310 .soundBinary "chunks/310.bin" ; FF/8D2F
      aSoundChunk311 .soundBinary "chunks/311.bin" ; FF/8D35
      aSoundChunk312 .soundBinary "chunks/312.bin" ; FF/8D39
      aSoundChunk313 .soundBinary "chunks/313.bin" ; FF/9099
      aSoundChunk314 .soundBinary "chunks/314.bin" ; FF/909F
      aSoundChunk316 .soundBinary "chunks/316.bin" ; FF/90A3
      aSoundChunk317 .soundBinary "chunks/317.bin" ; FF/90A9
      aSoundChunk318 .soundBinary "chunks/318.bin" ; FF/90AD
      aSoundChunk319 .soundBinary "chunks/319.bin" ; FF/9311
      aSoundChunk31A .soundBinary "chunks/31A.bin" ; FF/9317
      aSoundChunk31C .soundBinary "chunks/31C.bin" ; FF/931B
      aSoundChunk31D .soundBinary "chunks/31D.bin" ; FF/9321
      aSoundChunk31E .soundBinary "chunks/31E.bin" ; FF/9325
      aSoundChunk31F .soundBinary "chunks/31F.bin" ; FF/9685
      aSoundChunk320 .soundBinary "chunks/320.bin" ; FF/968B
      aSoundChunk322 .soundBinary "chunks/322.bin" ; FF/968F
      aSoundChunk323 .soundBinary "chunks/323.bin" ; FF/9695
      aSoundChunk324 .soundBinary "chunks/324.bin" ; FF/9699
      aSoundChunk325 .soundBinary "chunks/325.bin" ; FF/998D
      aSoundChunk326 .soundBinary "chunks/326.bin" ; FF/9993
      aSoundChunk328 .soundBinary "chunks/328.bin" ; FF/9997
      aSoundChunk329 .soundBinary "chunks/329.bin" ; FF/99FD
      aSoundChunk32A .soundBinary "chunks/32A.bin" ; FF/9A41
      aSoundChunk32B .soundBinary "chunks/32B.bin" ; FF/B3E2
      aSoundChunk32C .soundBinary "chunks/32C.bin" ; FF/B43C
      aSoundChunk32D .soundBinary "chunks/32D.bin" ; FF/B478
      aSoundChunk32E .soundBinary "chunks/32E.bin" ; FF/DCCB
      aSoundChunk32F .soundBinary "chunks/32F.bin" ; FF/DCD1
      aSoundChunk330 .soundBinary "chunks/330.bin" ; FF/DCD5
      aSoundChunk331 .soundBinary "chunks/331.bin" ; FF/DD77
      aSoundChunk332 .soundBinary "chunks/332.bin" ; FF/DD89
      aSoundChunk333 .soundBinary "chunks/333.bin" ; FF/DD95
      aSoundChunk334 .soundBinary "chunks/334.bin" ; FF/E3CE
      aSoundChunk335 .soundBinary "chunks/335.bin" ; FF/E3D4
      aSoundChunk336 .soundBinary "chunks/336.bin" ; FF/E3D8

      ; $FFFE63 to the end of the ROM: free

    .endsection SoundDataSection
