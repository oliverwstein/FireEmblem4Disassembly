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
        BattleUploads      .word <>aSoundBattleUploads
        TerrainUploads .word <>aSoundTerrainUploads
      .endblock

      aSoundChunks ; F7/7C16

        ; label, size, SPC address (0: after the previous chunk), flags; chunk ID in the comment
        .soundChunk aSoundSequence064, len(binary("sequences/064.bin")), $D400, SOUND_CHUNK_COMPRESSED ; $064
        .soundChunk aSoundSequence065, len(binary("sequences/065.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $065
        .soundChunk aSoundSequence066, len(binary("sequences/066.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $066
        .soundChunk aSoundSequence067, len(binary("sequences/067.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $067
        .soundChunk aSoundSequence068, len(binary("sequences/068.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $068
        .soundChunk aSoundSequence069, len(binary("sequences/069.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $069
        .soundChunk aSoundSequence06A, len(binary("sequences/06A.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $06A
        .soundChunk aSoundSequence06B, len(binary("sequences/06B.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $06B
        .soundChunk aSoundSequence06C, len(binary("sequences/06C.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $06C
        .soundChunk aSoundSequence06D, len(binary("sequences/06D.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $06D
        .soundChunk aSoundSequence06E, len(binary("sequences/06E.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $06E
        .soundChunk aSoundSequence06F, len(binary("sequences/06F.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $06F
        .soundChunk aSoundSequence070, len(binary("sequences/070.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $070
        .soundChunk aSoundSequence071, len(binary("sequences/071.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $071
        .soundChunk aSoundSequence072, len(binary("sequences/072.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $072
        .soundChunk aSoundSequence073, len(binary("sequences/073.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $073
        .soundChunk aSoundSequence074, len(binary("sequences/074.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $074
        .soundChunk aSoundSequence075, len(binary("sequences/075.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $075
        .soundChunk aSoundSequence076, len(binary("sequences/076.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $076
        .soundChunk aSoundSequence077, len(binary("sequences/077.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $077
        .soundChunk aSoundSequence078, len(binary("sequences/078.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $078
        .soundChunk aSoundSequence079, len(binary("sequences/079.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $079
        .soundChunk aSoundSequence07A, len(binary("sequences/07A.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $07A
        .soundChunk aSoundSequence07B, len(binary("sequences/07B.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $07B
        .soundChunk aSoundSequence07C, len(binary("sequences/07C.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $07C
        .soundChunk aSoundSequence07D, len(binary("sequences/07D.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $07D
        .soundChunk aSoundSequence07E, len(binary("sequences/07E.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $07E
        .soundChunk aSoundSequence07F, len(binary("sequences/07F.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $07F
        .soundChunk aSoundSequence080, len(binary("sequences/080.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $080
        .soundChunk aSoundSequence081, len(binary("sequences/081.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $081
        .soundChunk aSoundSequence082, len(binary("sequences/082.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $082
        .soundChunk aSoundSequence083, len(binary("sequences/083.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $083
        .soundChunk aSoundSequence084, len(binary("sequences/084.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $084
        .soundChunk aSoundSequence085, len(binary("sequences/085.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $085
        .soundChunk aSoundSequence086, len(binary("sequences/086.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $086
        .soundChunk aSoundSequence087, len(binary("sequences/087.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $087
        .soundChunk aSoundSequence088, len(binary("sequences/088.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $088
        .soundChunk aSoundSequence089, len(binary("sequences/089.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $089
        .soundChunk aSoundSequence08A, len(binary("sequences/08A.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08A
        .soundChunk aSoundSequence08B, len(binary("sequences/08B.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08B
        .soundChunk aSoundSequence08C, len(binary("sequences/08C.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08C
        .soundChunk aSoundSequence08D, len(binary("sequences/08D.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08D
        .soundChunk aSoundSequence08E, len(binary("sequences/08E.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08E
        .soundChunk aSoundSequence08F, len(binary("sequences/08F.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $08F
        .soundChunk aSoundSequence090, len(binary("sequences/090.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $090
        .soundChunk aSoundSequence091, len(binary("sequences/091.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $091
        .soundChunk aSoundSequence092, len(binary("sequences/092.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $092
        .soundChunk aSoundSequence093, len(binary("sequences/093.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $093
        .soundChunk aSoundSequence094, len(binary("sequences/094.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $094
        .soundChunk aSoundSequence095, len(binary("sequences/095.bin")), $BC00, SOUND_CHUNK_COMPRESSED ; $095
        .soundChunk aSoundSequence096, len(binary("sequences/096.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $096
        .soundChunk aSoundSequence097, len(binary("sequences/097.bin")), $B500, SOUND_CHUNK_COMPRESSED ; $097
        .soundChunk aSoundSequence098, len(binary("sequences/098.bin")), $B500, SOUND_CHUNK_COMPRESSED ; $098
        .soundChunk aSoundSequence099, len(binary("sequences/099.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $099
        .soundChunk aSoundSequence09A, len(binary("sequences/09A.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09A
        .soundChunk aSoundSequence09B, len(binary("sequences/09B.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09B
        .soundChunk aSoundSequence09C, len(binary("sequences/09C.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09C
        .soundChunk aSoundSequence09D, len(binary("sequences/09D.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09D
        .soundChunk aSoundSequence09E, len(binary("sequences/09E.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09E
        .soundChunk aSoundSequence09F, len(binary("sequences/09F.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $09F
        .soundChunk aSoundSequence0A0, len(binary("sequences/0A0.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A0
        .soundChunk aSoundSequence0A1, len(binary("sequences/0A1.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A1
        .soundChunk aSoundSequence0A2, len(binary("sequences/0A2.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A2
        .soundChunk aSoundSequence0A3, len(binary("sequences/0A3.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A3
        .soundChunk aSoundSequence0A4, len(binary("sequences/0A4.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A4
        .soundChunk aSoundSequence0A5, len(binary("sequences/0A5.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A5
        .soundChunk aSoundSequence0A6, len(binary("sequences/0A6.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A6
        .soundChunk aSoundSequence0A7, len(binary("sequences/0A7.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A7
        .soundChunk aSoundSequence0A8, len(binary("sequences/0A8.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A8
        .soundChunk aSoundSequence0A9, len(binary("sequences/0A9.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0A9
        .soundChunk aSoundSequence0AA, len(binary("sequences/0AA.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AA
        .soundChunk aSoundSequence0AB, len(binary("sequences/0AB.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AB
        .soundChunk aSoundSequence0AC, len(binary("sequences/0AC.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AC
        .soundChunk aSoundSequence0AD, len(binary("sequences/0AD.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AD
        .soundChunk aSoundSequence0AE, len(binary("sequences/0AE.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AE
        .soundChunk aSoundSequence0AF, len(binary("sequences/0AF.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0AF
        .soundChunk aSoundSequence0B0, len(binary("sequences/0B0.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B0
        .soundChunk aSoundSequence0B1, len(binary("sequences/0B1.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B1
        .soundChunk aSoundSequence0B2, len(binary("sequences/0B2.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B2
        .soundChunk aSoundSequence0B3, len(binary("sequences/0B3.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B3
        .soundChunk aSoundSequence0B4, len(binary("sequences/0B4.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B4
        .soundChunk aSoundSequence0B5, len(binary("sequences/0B5.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B5
        .soundChunk aSoundSequence0B6, len(binary("sequences/0B6.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B6
        .soundChunk aSoundSequence0B7, len(binary("sequences/0B7.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B7
        .soundChunk aSoundSequence0B8, len(binary("sequences/0B8.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B8
        .soundChunk aSoundSequence0B9, len(binary("sequences/0B9.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0B9
        .soundChunk aSoundSequence0BA, len(binary("sequences/0BA.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BA
        .soundChunk aSoundSequence0BB, len(binary("sequences/0BB.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BB
        .soundChunk aSoundSequence0BC, len(binary("sequences/0BC.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BC
        .soundChunk aSoundSequence0BD, len(binary("sequences/0BD.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BD
        .soundChunk aSoundSequence0BE, len(binary("sequences/0BE.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BE
        .soundChunk aSoundSequence0BF, len(binary("sequences/0BF.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0BF
        .soundChunk aSoundSequence0C0, len(binary("sequences/0C0.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C0
        .soundChunk aSoundSequence0C1, len(binary("sequences/0C1.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C1
        .soundChunk aSoundSequence0C2, len(binary("sequences/0C2.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C2
        .soundChunk aSoundSequence0C3, len(binary("sequences/0C3.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C3
        .soundChunk aSoundSequence0C4, len(binary("sequences/0C4.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C4
        .soundChunk aSoundSequence0C5, len(binary("sequences/0C5.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C5
        .soundChunk aSoundSequence0C6, len(binary("sequences/0C6.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C6
        .soundChunk aSoundSequence0C7, len(binary("sequences/0C7.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C7
        .soundChunk aSoundSequence0C8, len(binary("sequences/0C8.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C8
        .soundChunk aSoundSequence0C9, len(binary("sequences/0C9.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0C9
        .soundChunk aSoundSequence0CA, len(binary("sequences/0CA.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CA
        .soundChunk aSoundSequence0CB, len(binary("sequences/0CB.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CB
        .soundChunk aSoundSequence0CC, len(binary("sequences/0CC.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CC
        .soundChunk aSoundSequence0CD, len(binary("sequences/0CD.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CD
        .soundChunk aSoundSequence0CE, len(binary("sequences/0CE.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CE
        .soundChunk aSoundSequence0CF, len(binary("sequences/0CF.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0CF
        .soundChunk aSoundSequence0D0, len(binary("sequences/0D0.bin")), $C500, SOUND_CHUNK_COMPRESSED | SOUND_CHUNK_BUFFER2 ; $0D0
        .soundChunk aSoundSequence0D1, len(binary("sequences/0D1.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $0D1
        .soundChunk aSoundSequence0D2, len(binary("sequences/0D2.bin")), $C500, SOUND_CHUNK_COMPRESSED ; $0D2
        .soundChunk aSoundSequence0D3, len(binary("sequences/0D3.bin")), $B500, SOUND_CHUNK_COMPRESSED ; $0D3
        .soundChunk aSoundChunk0D4, len(binary("chunks/0D4.bin")), $2380, 0 ; $0D4
        .soundChunk aSoundChunk0D5, len(binary("chunks/0D5.bin")), $2380, 0 ; $0D5
        .soundChunk aSoundChunk0D6, len(binary("chunks/0D6.bin")), $2380, 0 ; $0D6
        .soundChunk aSoundSample0D7, len(binary("samples/0D7.brr")), $0000, 0 ; $0D7
        .soundChunk aSoundSample0D8, len(binary("samples/0D8.brr")), $0000, 0 ; $0D8
        .soundChunk aSoundSample0D9, len(binary("samples/0D9.brr")), $0000, 0 ; $0D9
        .soundChunk aSoundSample0DA, len(binary("samples/0DA.brr")), $0000, 0 ; $0DA
        .soundChunk aSoundSample0DB, len(binary("samples/0DB.brr")), $0000, 0 ; $0DB
        .soundChunk aSoundSample0DC, len(binary("samples/0DC.brr")), $0000, 0 ; $0DC
        .soundChunk aSoundSample0DD, len(binary("samples/0DD.brr")), $0000, 0 ; $0DD
        .soundChunk aSoundSample0DE, len(binary("samples/0DE.brr")), $0000, 0 ; $0DE
        .soundChunk aSoundSample0DF, len(binary("samples/0DF.brr")), $0000, 0 ; $0DF
        .soundChunk aSoundSample0E0, len(binary("samples/0E0.brr")), $0000, 0 ; $0E0
        .soundChunk aSoundSample0E1, len(binary("samples/0E1.brr")), $0000, 0 ; $0E1
        .soundChunk aSoundSample0E2, len(binary("samples/0E2.brr")), $0000, 0 ; $0E2
        .soundChunk aSoundSample0E3, len(binary("samples/0E3.brr")), $0000, 0 ; $0E3
        .soundChunk aSoundSample0E4, len(binary("samples/0E4.brr")), $0000, 0 ; $0E4
        .soundChunk aSoundSample0E5, len(binary("samples/0E5.brr")), $0000, 0 ; $0E5
        .soundChunk aSoundSample0E6, len(binary("samples/0E6.brr")), $0000, 0 ; $0E6
        .soundChunk aSoundSample0E7, len(binary("samples/0E7.brr")), $0000, 0 ; $0E7
        .soundChunk aSoundSample0E8, len(binary("samples/0E8.brr")), $0000, 0 ; $0E8
        .soundChunk aSoundSample0E9, len(binary("samples/0E9.brr")), $0000, 0 ; $0E9
        .soundChunk aSoundSample0EA, len(binary("samples/0EA.brr")), $0000, 0 ; $0EA
        .soundChunk aSoundSample0EB, len(binary("samples/0EB.brr")), $0000, 0 ; $0EB
        .soundChunk aSoundSample0EC, len(binary("samples/0EC.brr")), $0000, 0 ; $0EC
        .soundChunk aSoundSample0ED, len(binary("samples/0ED.brr")), $0000, 0 ; $0ED
        .soundChunk aSoundSample0EE, len(binary("samples/0EE.brr")), $0000, 0 ; $0EE
        .soundChunk aSoundSample0EF, len(binary("samples/0EF.brr")), $0000, 0 ; $0EF
        .soundChunk aSoundSample0F0, len(binary("samples/0F0.brr")), $0000, 0 ; $0F0
        .soundChunk aSoundSample0F1, len(binary("samples/0F1.brr")), $0000, 0 ; $0F1
        .soundChunk aSoundSample0F2, len(binary("samples/0F2.brr")), $0000, 0 ; $0F2
        .soundChunk aSoundSample0F3, len(binary("samples/0F3.brr")), $0000, 0 ; $0F3
        .soundChunk aSoundSample0F4, len(binary("samples/0F4.brr")), $0000, 0 ; $0F4
        .soundChunk aSoundSample0F5, len(binary("samples/0F5.brr")), $0000, 0 ; $0F5
        .soundChunk aSoundSample0F6, len(binary("samples/0F6.brr")), $0000, 0 ; $0F6
        .soundChunk aSoundSample0F7, len(binary("samples/0F7.brr")), $0000, 0 ; $0F7
        .soundChunk aSoundSample0F8, len(binary("samples/0F8.brr")), $0000, 0 ; $0F8
        .soundChunk aSoundSample0F9, len(binary("samples/0F9.brr")), $0000, 0 ; $0F9
        .soundChunk aSoundSample0FA, len(binary("samples/0FA.brr")), $0000, 0 ; $0FA
        .soundChunk aSoundSample0FB, len(binary("samples/0FB.brr")), $0000, 0 ; $0FB
        .soundChunk aSoundSample0FC, len(binary("samples/0FC.brr")), $0000, 0 ; $0FC
        .soundChunk aSoundSample0FD, len(binary("samples/0FD.brr")), $0000, 0 ; $0FD
        .soundChunk aSoundSample0FE, len(binary("samples/0FE.brr")), $0000, 0 ; $0FE
        .soundChunk aSoundSample0FF, len(binary("samples/0FF.brr")), $0000, 0 ; $0FF
        .soundChunk aSoundSample100, len(binary("samples/100.brr")), $0000, 0 ; $100
        .soundChunk aSoundSample101, len(binary("samples/101.brr")), $0000, 0 ; $101
        .soundChunk aSoundSample102, len(binary("samples/102.brr")), $0000, 0 ; $102
        .soundChunk aSoundSample103, len(binary("samples/103.brr")), $0000, 0 ; $103
        .soundChunk aSoundSample104, len(binary("samples/104.brr")), $0000, 0 ; $104
        .soundChunk aSoundSample105, len(binary("samples/105.brr")), $0000, 0 ; $105
        .soundChunk aSoundSample106, len(binary("samples/106.brr")), $0000, 0 ; $106
        .soundChunk aSoundSample107, len(binary("samples/107.brr")), $0000, 0 ; $107
        .soundChunk aSoundSample108, len(binary("samples/108.brr")), $0000, 0 ; $108
        .soundChunk aSoundSample109, len(binary("samples/109.brr")), $0000, 0 ; $109
        .soundChunk aSoundSample10A, len(binary("samples/10A.brr")), $0000, 0 ; $10A
        .soundChunk aSoundSample10B, len(binary("samples/10B.brr")), $0000, 0 ; $10B
        .soundChunk aSoundSample10C, len(binary("samples/10C.brr")), $0000, 0 ; $10C
        .soundChunk aSoundSample10D, len(binary("samples/10D.brr")), $0000, 0 ; $10D
        .soundChunk aSoundSample10E, len(binary("samples/10E.brr")), $0000, 0 ; $10E
        .soundChunk aSoundSample10F, len(binary("samples/10F.brr")), $0000, 0 ; $10F
        .soundChunk aSoundSample110, len(binary("samples/110.brr")), $0000, 0 ; $110
        .soundChunk aSoundSample111, len(binary("samples/111.brr")), $0000, 0 ; $111
        .soundChunk aSoundSample112, len(binary("samples/112.brr")), $0000, 0 ; $112
        .soundChunk aSoundSample113, len(binary("samples/113.brr")), $0000, 0 ; $113
        .soundChunk aSoundSample114, len(binary("samples/114.brr")), $0000, 0 ; $114
        .soundChunk aSoundSample115, len(binary("samples/115.brr")), $0000, 0 ; $115
        .soundChunk aSoundSample116, len(binary("samples/116.brr")), $0000, 0 ; $116
        .soundChunk aSoundSample117, len(binary("samples/117.brr")), $0000, 0 ; $117
        .soundChunk aSoundSample118, len(binary("samples/118.brr")), $0000, 0 ; $118
        .soundChunk aSoundSample119, len(binary("samples/119.brr")), $0000, 0 ; $119
        .soundChunk aSoundSample11A, len(binary("samples/11A.brr")), $0000, 0 ; $11A
        .soundChunk aSoundSample11B, len(binary("samples/11B.brr")), $0000, 0 ; $11B
        .soundChunk aSoundSample11C, len(binary("samples/11C.brr")), $0000, 0 ; $11C
        .soundChunk aSoundSample11D, len(binary("samples/11D.brr")), $0000, 0 ; $11D
        .soundChunk aSoundSample11E, len(binary("samples/11E.brr")), $0000, 0 ; $11E
        .soundChunk aSoundSample11F, len(binary("samples/11F.brr")), $0000, 0 ; $11F
        .soundChunk aSoundSample120, len(binary("samples/120.brr")), $0000, 0 ; $120
        .soundChunk aSoundSample121, len(binary("samples/121.brr")), $0000, 0 ; $121
        .soundChunk aSoundSample122, len(binary("samples/122.brr")), $0000, 0 ; $122
        .soundChunk aSoundSample123, len(binary("samples/123.brr")), $0000, 0 ; $123
        .soundChunk aSoundSample124, len(binary("samples/124.brr")), $0000, 0 ; $124
        .soundChunk aSoundSample125, len(binary("samples/125.brr")), $0000, 0 ; $125
        .soundChunk aSoundSample126, len(binary("samples/126.brr")), $0000, 0 ; $126
        .soundChunk aSoundSample127, len(binary("samples/127.brr")), $0000, 0 ; $127
        .soundChunk aSoundSample128, len(binary("samples/128.brr")), $0000, 0 ; $128
        .soundChunk aSoundSample129, len(binary("samples/129.brr")), $0000, 0 ; $129
        .soundChunk aSoundSample12A, len(binary("samples/12A.brr")), $0000, 0 ; $12A
        .soundChunk aSoundSample12B, len(binary("samples/12B.brr")), $0000, 0 ; $12B
        .soundChunk aSoundSample12C, len(binary("samples/12C.brr")), $0000, 0 ; $12C
        .soundChunk aSoundSample12D, len(binary("samples/12D.brr")), $0000, 0 ; $12D
        .soundChunk aSoundSample12E, len(binary("samples/12E.brr")), $0000, 0 ; $12E
        .soundChunk aSoundSample12F, len(binary("samples/12F.brr")), $0000, 0 ; $12F
        .soundChunk aSoundSample130, len(binary("samples/130.brr")), $0000, 0 ; $130
        .soundChunk aSoundSample131, len(binary("samples/131.brr")), $0000, 0 ; $131
        .soundChunk aSoundSample132, len(binary("samples/132.brr")), $0000, 0 ; $132
        .soundChunk aSoundSample133, len(binary("samples/133.brr")), $0000, 0 ; $133
        .soundChunk aSoundSample134, len(binary("samples/134.brr")), $0000, 0 ; $134
        .soundChunk aSoundSample135, len(binary("samples/135.brr")), $0000, 0 ; $135
        .soundChunk aSoundSample136, len(binary("samples/136.brr")), $0000, 0 ; $136
        .soundChunk aSoundSample137, len(binary("samples/137.brr")), $0000, 0 ; $137
        .soundChunk aSoundSample138, len(binary("samples/138.brr")), $0000, 0 ; $138
        .soundChunk aSoundSample139, len(binary("samples/139.brr")), $0000, 0 ; $139
        .soundChunk aSoundSample13A, len(binary("samples/13A.brr")), $0000, 0 ; $13A
        .soundChunk aSoundSample13B, len(binary("samples/13B.brr")), $0000, 0 ; $13B
        .soundChunk aSoundSample13C, len(binary("samples/13C.brr")), $0000, 0 ; $13C
        .soundChunk aSoundSample13D, len(binary("samples/13D.brr")), $0000, 0 ; $13D
        .soundChunk aSoundSample13E, len(binary("samples/13E.brr")), $0000, 0 ; $13E
        .soundChunk aSoundSample13F, len(binary("samples/13F.brr")), $0000, 0 ; $13F
        .soundChunk aSoundSample140, len(binary("samples/140.brr")), $0000, 0 ; $140
        .soundChunk aSoundSample141, len(binary("samples/141.brr")), $0000, 0 ; $141
        .soundChunk aSoundSample142, len(binary("samples/142.brr")), $0000, 0 ; $142
        .soundChunk aSoundSample143, len(binary("samples/143.brr")), $0000, 0 ; $143
        .soundChunk aSoundSample144, len(binary("samples/144.brr")), $0000, 0 ; $144
        .soundChunk aSoundSample145, len(binary("samples/145.brr")), $0000, 0 ; $145
        .soundChunk aSoundInstruments146, len(binary("instruments/146.bin")), $FE00, 0 ; $146
        .soundChunk aSoundDirectory147, len(binary("directories/147.bin")), $FD00, 0 ; $147
        .soundChunk aSoundInstruments148, len(binary("instruments/148.bin")), $FE00, 0 ; $148
        .soundChunk aSoundDirectory149, len(binary("directories/149.bin")), $FD00, 0 ; $149
        .soundChunk aSoundInstruments14A, len(binary("instruments/14A.bin")), $FE00, 0 ; $14A
        .soundChunk aSoundDirectory14B, len(binary("directories/14B.bin")), $FD00, 0 ; $14B
        .soundChunk aSoundInstruments14C, len(binary("instruments/14C.bin")), $FE00, 0 ; $14C
        .soundChunk aSoundDirectory14D, len(binary("directories/14D.bin")), $FD00, 0 ; $14D
        .soundChunk aSoundInstruments14E, len(binary("instruments/14E.bin")), $FE00, 0 ; $14E
        .soundChunk aSoundDirectory14F, len(binary("directories/14F.bin")), $FD00, 0 ; $14F
        .soundChunk aSoundInstruments150, len(binary("instruments/150.bin")), $FE00, 0 ; $150
        .soundChunk aSoundDirectory151, len(binary("directories/151.bin")), $FD00, 0 ; $151
        .soundChunk aSoundInstruments152, len(binary("instruments/152.bin")), $FE00, 0 ; $152
        .soundChunk aSoundDirectory153, len(binary("directories/153.bin")), $FD00, 0 ; $153
        .soundChunk aSoundInstruments154, len(binary("instruments/154.bin")), $FE00, 0 ; $154
        .soundChunk aSoundDirectory155, len(binary("directories/155.bin")), $FD00, 0 ; $155
        .soundChunk aSoundInstruments156, len(binary("instruments/156.bin")), $FE00, 0 ; $156
        .soundChunk aSoundDirectory157, len(binary("directories/157.bin")), $FD00, 0 ; $157
        .soundChunk aSoundInstruments158, len(binary("instruments/158.bin")), $FE00, 0 ; $158
        .soundChunk aSoundDirectory159, len(binary("directories/159.bin")), $FD00, 0 ; $159
        .soundChunk aSoundInstruments15A, len(binary("instruments/15A.bin")), $FE00, 0 ; $15A
        .soundChunk aSoundDirectory15B, len(binary("directories/15B.bin")), $FD00, 0 ; $15B
        .soundChunk aSoundInstruments15C, len(binary("instruments/15C.bin")), $FE00, 0 ; $15C
        .soundChunk aSoundDirectory15D, len(binary("directories/15D.bin")), $FD00, 0 ; $15D
        .soundChunk aSoundInstruments15E, len(binary("instruments/15E.bin")), $FE00, 0 ; $15E
        .soundChunk aSoundDirectory15F, len(binary("directories/15F.bin")), $FD00, 0 ; $15F
        .soundChunk aSoundInstruments160, len(binary("instruments/160.bin")), $FE00, 0 ; $160
        .soundChunk aSoundDirectory161, len(binary("directories/161.bin")), $FD00, 0 ; $161
        .soundChunk aSoundInstruments162, len(binary("instruments/162.bin")), $FE00, 0 ; $162
        .soundChunk aSoundDirectory163, len(binary("directories/163.bin")), $FD00, 0 ; $163
        .soundChunk aSoundInstruments164, len(binary("instruments/164.bin")), $FE00, 0 ; $164
        .soundChunk aSoundDirectory165, len(binary("directories/165.bin")), $FD00, 0 ; $165
        .soundChunk aSoundInstruments166, len(binary("instruments/166.bin")), $FE00, 0 ; $166
        .soundChunk aSoundDirectory167, len(binary("directories/167.bin")), $FD00, 0 ; $167
        .soundChunk aSoundInstruments168, len(binary("instruments/168.bin")), $FE00, 0 ; $168
        .soundChunk aSoundDirectory169, len(binary("directories/169.bin")), $FD00, 0 ; $169
        .soundChunk aSoundInstruments16A, len(binary("instruments/16A.bin")), $FE00, 0 ; $16A
        .soundChunk aSoundDirectory16B, len(binary("directories/16B.bin")), $FD00, 0 ; $16B
        .soundChunk aSoundInstruments16C, len(binary("instruments/16C.bin")), $FE00, 0 ; $16C
        .soundChunk aSoundDirectory16D, len(binary("directories/16D.bin")), $FD00, 0 ; $16D
        .soundChunk aSoundInstruments16E, len(binary("instruments/16E.bin")), $FE00, 0 ; $16E
        .soundChunk aSoundDirectory16F, len(binary("directories/16F.bin")), $FD00, 0 ; $16F
        .soundChunk aSoundInstruments170, len(binary("instruments/170.bin")), $FE00, 0 ; $170
        .soundChunk aSoundDirectory171, len(binary("directories/171.bin")), $FD00, 0 ; $171
        .soundChunk aSoundInstruments172, len(binary("instruments/172.bin")), $FE00, 0 ; $172
        .soundChunk aSoundDirectory173, len(binary("directories/173.bin")), $FD00, 0 ; $173
        .soundChunk aSoundInstruments174, len(binary("instruments/174.bin")), $FE00, 0 ; $174
        .soundChunk aSoundDirectory175, len(binary("directories/175.bin")), $FD00, 0 ; $175
        .soundChunk aSoundInstruments176, len(binary("instruments/176.bin")), $FE00, 0 ; $176
        .soundChunk aSoundDirectory177, len(binary("directories/177.bin")), $FD00, 0 ; $177
        .soundChunk aSoundInstruments178, len(binary("instruments/178.bin")), $FE00, 0 ; $178
        .soundChunk aSoundDirectory179, len(binary("directories/179.bin")), $FD00, 0 ; $179
        .soundChunk aSoundInstruments17A, len(binary("instruments/17A.bin")), $FE00, 0 ; $17A
        .soundChunk aSoundDirectory17B, len(binary("directories/17B.bin")), $FD00, 0 ; $17B
        .soundChunk aSoundInstruments17C, len(binary("instruments/17C.bin")), $FE00, 0 ; $17C
        .soundChunk aSoundDirectory17D, len(binary("directories/17D.bin")), $FD00, 0 ; $17D
        .soundChunk aSoundInstruments17E, len(binary("instruments/17E.bin")), $FE00, 0 ; $17E
        .soundChunk aSoundDirectory17F, len(binary("directories/17F.bin")), $FD00, 0 ; $17F
        .soundChunk aSoundInstruments180, len(binary("instruments/180.bin")), $FE00, 0 ; $180
        .soundChunk aSoundDirectory181, len(binary("directories/181.bin")), $FD00, 0 ; $181
        .soundChunk aSoundInstruments182, len(binary("instruments/182.bin")), $FE00, 0 ; $182
        .soundChunk aSoundDirectory183, len(binary("directories/183.bin")), $FD00, 0 ; $183
        .soundChunk aSoundInstruments184, len(binary("instruments/184.bin")), $FE00, 0 ; $184
        .soundChunk aSoundDirectory185, len(binary("directories/185.bin")), $FD00, 0 ; $185
        .soundChunk aSoundInstruments186, len(binary("instruments/186.bin")), $FE00, 0 ; $186
        .soundChunk aSoundDirectory187, len(binary("directories/187.bin")), $FD00, 0 ; $187
        .soundChunk aSoundInstruments188, len(binary("instruments/188.bin")), $FE00, 0 ; $188
        .soundChunk aSoundDirectory189, len(binary("directories/189.bin")), $FD00, 0 ; $189
        .soundChunk aSoundInstruments18A, len(binary("instruments/18A.bin")), $FE00, 0 ; $18A
        .soundChunk aSoundDirectory18B, len(binary("directories/18B.bin")), $FD00, 0 ; $18B
        .soundChunk aSoundInstruments18C, len(binary("instruments/18C.bin")), $FE00, 0 ; $18C
        .soundChunk aSoundDirectory18D, len(binary("directories/18D.bin")), $FD00, 0 ; $18D
        .soundChunk aSoundInstruments18E, len(binary("instruments/18E.bin")), $FE00, 0 ; $18E
        .soundChunk aSoundDirectory18F, len(binary("directories/18F.bin")), $FD00, 0 ; $18F
        .soundChunk aSoundInstruments190, len(binary("instruments/190.bin")), $FE00, 0 ; $190
        .soundChunk aSoundDirectory191, len(binary("directories/191.bin")), $FD00, 0 ; $191
        .soundChunk aSoundInstruments192, len(binary("instruments/192.bin")), $FE00, 0 ; $192
        .soundChunk aSoundDirectory193, len(binary("directories/193.bin")), $FD00, 0 ; $193
        .soundChunk aSoundInstruments194, len(binary("instruments/194.bin")), $FE00, 0 ; $194
        .soundChunk aSoundDirectory195, len(binary("directories/195.bin")), $FD00, 0 ; $195
        .soundChunk aSoundInstruments196, len(binary("instruments/196.bin")), $FE00, 0 ; $196
        .soundChunk aSoundDirectory197, len(binary("directories/197.bin")), $FD00, 0 ; $197
        .soundChunk aSoundInstruments198, len(binary("instruments/198.bin")), $FE00, 0 ; $198
        .soundChunk aSoundDirectory199, len(binary("directories/199.bin")), $FD00, 0 ; $199
        .soundChunk aSoundInstruments19A, len(binary("instruments/19A.bin")), $FE00, 0 ; $19A
        .soundChunk aSoundDirectory19B, len(binary("directories/19B.bin")), $FD00, 0 ; $19B
        .soundChunk aSoundInstruments19C, len(binary("instruments/19C.bin")), $FE00, 0 ; $19C
        .soundChunk aSoundDirectory19D, len(binary("directories/19D.bin")), $FD00, 0 ; $19D
        .soundChunk aSoundInstruments19E, len(binary("instruments/19E.bin")), $FE00, 0 ; $19E
        .soundChunk aSoundDirectory19F, len(binary("directories/19F.bin")), $FD00, 0 ; $19F
        .soundChunk aSoundInstruments1A0, len(binary("instruments/1A0.bin")), $FE00, 0 ; $1A0
        .soundChunk aSoundDirectory1A1, len(binary("directories/1A1.bin")), $FD00, 0 ; $1A1
        .soundChunk aSoundInstruments1A2, len(binary("instruments/1A2.bin")), $FE00, 0 ; $1A2
        .soundChunk aSoundDirectory1A3, len(binary("directories/1A3.bin")), $FD00, 0 ; $1A3
        .soundChunk aSoundInstruments1A4, len(binary("instruments/1A4.bin")), $FE00, 0 ; $1A4
        .soundChunk aSoundDirectory1A5, len(binary("directories/1A5.bin")), $FD00, 0 ; $1A5
        .soundChunk aSoundInstruments1A6, len(binary("instruments/1A6.bin")), $FE00, 0 ; $1A6
        .soundChunk aSoundDirectory1A7, len(binary("directories/1A7.bin")), $FD00, 0 ; $1A7
        .soundChunk aSoundInstruments1A8, len(binary("instruments/1A8.bin")), $FE00, 0 ; $1A8
        .soundChunk aSoundDirectory1A9, len(binary("directories/1A9.bin")), $FD00, 0 ; $1A9
        .soundChunk aSoundInstruments1AA, len(binary("instruments/1AA.bin")), $FE00, 0 ; $1AA
        .soundChunk aSoundDirectory1AB, len(binary("directories/1AB.bin")), $FD00, 0 ; $1AB
        .soundChunk aSoundInstruments1AC, len(binary("instruments/1AC.bin")), $FE00, 0 ; $1AC
        .soundChunk aSoundDirectory1AD, len(binary("directories/1AD.bin")), $FD00, 0 ; $1AD
        .soundChunk aSoundInstruments1AE, len(binary("instruments/1AE.bin")), $FE00, 0 ; $1AE
        .soundChunk aSoundDirectory1AF, len(binary("directories/1AF.bin")), $FD00, 0 ; $1AF
        .soundChunk aSoundInstruments1B0, len(binary("instruments/1B0.bin")), $FE00, 0 ; $1B0
        .soundChunk aSoundDirectory1B1, len(binary("directories/1B1.bin")), $FD00, 0 ; $1B1
        .soundChunk aSoundInstruments1B2, len(binary("instruments/1B2.bin")), $FE00, 0 ; $1B2
        .soundChunk aSoundDirectory1B3, len(binary("directories/1B3.bin")), $FD00, 0 ; $1B3
        .soundChunk aSoundInstruments1B4, len(binary("instruments/1B4.bin")), $FE00, 0 ; $1B4
        .soundChunk aSoundDirectory1B5, len(binary("directories/1B5.bin")), $FD00, 0 ; $1B5
        .soundChunk aSoundInstruments1B6, len(binary("instruments/1B6.bin")), $FE00, 0 ; $1B6
        .soundChunk aSoundDirectory1B7, len(binary("directories/1B7.bin")), $FD00, 0 ; $1B7
        .soundChunk aSoundInstruments1B8, len(binary("instruments/1B8.bin")), $FE00, 0 ; $1B8
        .soundChunk aSoundDirectory1B9, len(binary("directories/1B9.bin")), $FD00, 0 ; $1B9
        .soundChunk aSoundInstruments1BA, len(binary("instruments/1BA.bin")), $FE00, 0 ; $1BA
        .soundChunk aSoundDirectory1BB, len(binary("directories/1BB.bin")), $FD00, 0 ; $1BB
        .soundChunk aSoundInstruments1BC, len(binary("instruments/1BC.bin")), $FE00, 0 ; $1BC
        .soundChunk aSoundDirectory1BD, len(binary("directories/1BD.bin")), $FD00, 0 ; $1BD
        .soundChunk aSoundInstruments1BE, len(binary("instruments/1BE.bin")), $FE00, 0 ; $1BE
        .soundChunk aSoundDirectory1BF, len(binary("directories/1BF.bin")), $FD00, 0 ; $1BF
        .soundChunk aSoundInstruments1C0, len(binary("instruments/1C0.bin")), $FE00, 0 ; $1C0
        .soundChunk aSoundDirectory1C1, len(binary("directories/1C1.bin")), $FD00, 0 ; $1C1
        .soundChunk aSoundInstruments1C2, len(binary("instruments/1C2.bin")), $FE00, 0 ; $1C2
        .soundChunk aSoundDirectory1C3, len(binary("directories/1C3.bin")), $FD00, 0 ; $1C3
        .soundChunk aSoundInstruments1C4, len(binary("instruments/1C4.bin")), $FE00, 0 ; $1C4
        .soundChunk aSoundDirectory1C5, len(binary("directories/1C5.bin")), $FD00, 0 ; $1C5
        .soundChunk aSoundInstruments1C6, len(binary("instruments/1C6.bin")), $FE00, 0 ; $1C6
        .soundChunk aSoundDirectory1C7, len(binary("directories/1C7.bin")), $FD00, 0 ; $1C7
        .soundChunk aSoundInstruments1C8, len(binary("instruments/1C8.bin")), $FE00, 0 ; $1C8
        .soundChunk aSoundDirectory1C9, len(binary("directories/1C9.bin")), $FD00, 0 ; $1C9
        .soundChunk aSoundInstruments1CA, len(binary("instruments/1CA.bin")), $FE00, 0 ; $1CA
        .soundChunk aSoundDirectory1CB, len(binary("directories/1CB.bin")), $FD00, 0 ; $1CB
        .soundChunk aSoundInstruments1CC, len(binary("instruments/1CC.bin")), $FE00, 0 ; $1CC
        .soundChunk aSoundDirectory1CD, len(binary("directories/1CD.bin")), $FD00, 0 ; $1CD
        .soundChunk aSoundInstruments1CE, len(binary("instruments/1CE.bin")), $FE00, 0 ; $1CE
        .soundChunk aSoundDirectory1CF, len(binary("directories/1CF.bin")), $FD00, 0 ; $1CF
        .soundChunk aSoundInstruments1D0, len(binary("instruments/1D0.bin")), $FE00, 0 ; $1D0
        .soundChunk aSoundDirectory1D1, len(binary("directories/1D1.bin")), $FD00, 0 ; $1D1
        .soundChunk aSoundInstruments1D2, len(binary("instruments/1D2.bin")), $FE00, 0 ; $1D2
        .soundChunk aSoundDirectory1D3, len(binary("directories/1D3.bin")), $FD00, 0 ; $1D3
        .soundChunk aSoundInstruments1D4, len(binary("instruments/1D4.bin")), $FE00, 0 ; $1D4
        .soundChunk aSoundDirectory1D5, len(binary("directories/1D5.bin")), $FD00, 0 ; $1D5
        .soundChunk aSoundInstruments1D6, len(binary("instruments/1D6.bin")), $FE00, 0 ; $1D6
        .soundChunk aSoundDirectory1D7, len(binary("directories/1D7.bin")), $FD00, 0 ; $1D7
        .soundChunk aSoundInstruments1D8, len(binary("instruments/1D8.bin")), $FE00, 0 ; $1D8
        .soundChunk aSoundDirectory1D9, len(binary("directories/1D9.bin")), $FD00, 0 ; $1D9
        .soundChunk aSoundInstruments1DA, len(binary("instruments/1DA.bin")), $FE00, 0 ; $1DA
        .soundChunk aSoundDirectory1DB, len(binary("directories/1DB.bin")), $FD00, 0 ; $1DB
        .soundChunk aSoundInstruments1DC, len(binary("instruments/1DC.bin")), $FE00, 0 ; $1DC
        .soundChunk aSoundDirectory1DD, len(binary("directories/1DD.bin")), $FD00, 0 ; $1DD
        .soundChunk aSoundInstruments1DE, len(binary("instruments/1DE.bin")), $FE00, 0 ; $1DE
        .soundChunk aSoundDirectory1DF, len(binary("directories/1DF.bin")), $FD00, 0 ; $1DF
        .soundChunk aSoundInstruments1E0, len(binary("instruments/1E0.bin")), $FE00, 0 ; $1E0
        .soundChunk aSoundDirectory1E1, len(binary("directories/1E1.bin")), $FD00, 0 ; $1E1
        .soundChunk aSoundInstruments1E2, len(binary("instruments/1E2.bin")), $FE00, 0 ; $1E2
        .soundChunk aSoundDirectory1E3, len(binary("directories/1E3.bin")), $FD00, 0 ; $1E3
        .soundChunk aSoundInstruments1E4, len(binary("instruments/1E4.bin")), $FE00, 0 ; $1E4
        .soundChunk aSoundDirectory1E5, len(binary("directories/1E5.bin")), $FD00, 0 ; $1E5
        .soundChunk aSoundInstruments1E6, len(binary("instruments/1E6.bin")), $FE00, 0 ; $1E6
        .soundChunk aSoundDirectory1E7, len(binary("directories/1E7.bin")), $FD00, 0 ; $1E7
        .soundChunk aSoundInstruments1E8, len(binary("instruments/1E8.bin")), $FE00, 0 ; $1E8
        .soundChunk aSoundDirectory1E9, len(binary("directories/1E9.bin")), $FD00, 0 ; $1E9
        .soundChunk aSoundInstruments1EA, len(binary("instruments/1EA.bin")), $FE00, 0 ; $1EA
        .soundChunk aSoundDirectory1EB, len(binary("directories/1EB.bin")), $FD00, 0 ; $1EB
        .soundChunk aSoundInstruments1EC, len(binary("instruments/1EC.bin")), $FE00, 0 ; $1EC
        .soundChunk aSoundDirectory1ED, len(binary("directories/1ED.bin")), $FD00, 0 ; $1ED
        .soundChunk aSoundInstruments1EE, len(binary("instruments/1EE.bin")), $FE00, 0 ; $1EE
        .soundChunk aSoundDirectory1EF, len(binary("directories/1EF.bin")), $FD00, 0 ; $1EF
        .soundChunk aSoundInstruments1F0, len(binary("instruments/1F0.bin")), $FE00, 0 ; $1F0
        .soundChunk aSoundDirectory1F1, len(binary("directories/1F1.bin")), $FD00, 0 ; $1F1
        .soundChunk aSoundInstruments1F2, len(binary("instruments/1F2.bin")), $FE00, 0 ; $1F2
        .soundChunk aSoundDirectory1F3, len(binary("directories/1F3.bin")), $FD00, 0 ; $1F3
        .soundChunk aSoundInstruments1F4, len(binary("instruments/1F4.bin")), $FE00, 0 ; $1F4
        .soundChunk aSoundDirectory1F5, len(binary("directories/1F5.bin")), $FD00, 0 ; $1F5
        .soundChunk aSoundInstruments1F6, len(binary("instruments/1F6.bin")), $FE00, 0 ; $1F6
        .soundChunk aSoundDirectory1F7, len(binary("directories/1F7.bin")), $FD00, 0 ; $1F7
        .soundChunk aSoundInstruments1F8, len(binary("instruments/1F8.bin")), $FE00, 0 ; $1F8
        .soundChunk aSoundDirectory1F9, len(binary("directories/1F9.bin")), $FD00, 0 ; $1F9
        .soundChunk aSoundInstruments1FA, len(binary("instruments/1FA.bin")), $FE00, 0 ; $1FA
        .soundChunk aSoundDirectory1FB, len(binary("directories/1FB.bin")), $FD00, 0 ; $1FB
        .soundChunk aSoundInstruments1FC, len(binary("instruments/1FC.bin")), $FE00, 0 ; $1FC
        .soundChunk aSoundDirectory1FD, len(binary("directories/1FD.bin")), $FD00, 0 ; $1FD
        .soundChunk aSoundInstruments1FE, len(binary("instruments/1FE.bin")), $FE00, 0 ; $1FE
        .soundChunk aSoundDirectory1FF, len(binary("directories/1FF.bin")), $FD00, 0 ; $1FF
        .soundChunk aSoundInstruments200, len(binary("instruments/200.bin")), $FE00, 0 ; $200
        .soundChunk aSoundDirectory201, len(binary("directories/201.bin")), $FD00, 0 ; $201
        .soundChunk aSoundInstruments202, len(binary("instruments/202.bin")), $FE00, 0 ; $202
        .soundChunk aSoundDirectory203, len(binary("directories/203.bin")), $FD00, 0 ; $203
        .soundChunk aSoundInstruments204, len(binary("instruments/204.bin")), $FE00, 0 ; $204
        .soundChunk aSoundDirectory205, len(binary("directories/205.bin")), $FD00, 0 ; $205
        .soundChunk aSoundInstruments206, len(binary("instruments/206.bin")), $FE00, 0 ; $206
        .soundChunk aSoundDirectory207, len(binary("directories/207.bin")), $FD00, 0 ; $207
        .soundChunk aSoundInstruments208, len(binary("instruments/208.bin")), $FE00, 0 ; $208
        .soundChunk aSoundDirectory209, len(binary("directories/209.bin")), $FD00, 0 ; $209
        .soundChunk aSoundInstruments20A, len(binary("instruments/20A.bin")), $FE00, 0 ; $20A
        .soundChunk aSoundDirectory20B, len(binary("directories/20B.bin")), $FD00, 0 ; $20B
        .soundChunk aSoundInstruments20C, len(binary("instruments/20C.bin")), $FE00, 0 ; $20C
        .soundChunk aSoundDirectory20D, len(binary("directories/20D.bin")), $FD00, 0 ; $20D
        .soundChunk aSoundInstruments20E, len(binary("instruments/20E.bin")), $FE00, 0 ; $20E
        .soundChunk aSoundDirectory20F, len(binary("directories/20F.bin")), $FD00, 0 ; $20F
        .soundChunk aSoundInstruments210, len(binary("instruments/210.bin")), $FE00, 0 ; $210
        .soundChunk aSoundDirectory211, len(binary("directories/211.bin")), $FD00, 0 ; $211
        .soundChunk aSoundInstruments212, len(binary("instruments/212.bin")), $FE00, 0 ; $212
        .soundChunk aSoundDirectory213, len(binary("directories/213.bin")), $FD00, 0 ; $213
        .soundChunk aSoundInstruments214, len(binary("instruments/214.bin")), $FE00, 0 ; $214
        .soundChunk aSoundDirectory215, len(binary("directories/215.bin")), $FD00, 0 ; $215
        .soundChunk aSoundInstruments216, len(binary("instruments/216.bin")), $FE00, 0 ; $216
        .soundChunk aSoundDirectory217, len(binary("directories/217.bin")), $FD00, 0 ; $217
        .soundChunk aSoundInstruments218, len(binary("instruments/218.bin")), $FE00, 0 ; $218
        .soundChunk aSoundDirectory219, len(binary("directories/219.bin")), $FD00, 0 ; $219
        .soundChunk aSoundInstruments21A, len(binary("instruments/21A.bin")), $FE00, 0 ; $21A
        .soundChunk aSoundDirectory21B, len(binary("directories/21B.bin")), $FD00, 0 ; $21B
        .soundChunk aSoundInstruments21C, len(binary("instruments/21C.bin")), $FE00, 0 ; $21C
        .soundChunk aSoundDirectory21D, len(binary("directories/21D.bin")), $FD00, 0 ; $21D
        .soundChunk aSoundInstruments21E, len(binary("instruments/21E.bin")), $FE00, 0 ; $21E
        .soundChunk aSoundDirectory21F, len(binary("directories/21F.bin")), $FD00, 0 ; $21F
        .soundChunk aSoundInstruments220, len(binary("instruments/220.bin")), $FE00, 0 ; $220
        .soundChunk aSoundDirectory221, len(binary("directories/221.bin")), $FD00, 0 ; $221
        .soundChunk aSoundInstruments222, len(binary("instruments/222.bin")), $FE00, 0 ; $222
        .soundChunk aSoundDirectory223, len(binary("directories/223.bin")), $FD00, 0 ; $223
        .soundChunk aSoundInstruments224, len(binary("instruments/224.bin")), $FE00, 0 ; $224
        .soundChunk aSoundDirectory225, len(binary("directories/225.bin")), $FD00, 0 ; $225
        .soundChunk aSoundInstruments226, len(binary("instruments/226.bin")), $FE00, 0 ; $226
        .soundChunk aSoundDirectory227, len(binary("directories/227.bin")), $FD00, 0 ; $227
        .soundChunk aSoundInstruments228, len(binary("instruments/228.bin")), $FE00, 0 ; $228
        .soundChunk aSoundDirectory229, len(binary("directories/229.bin")), $FD00, 0 ; $229
        .soundChunk aSoundInstruments22A, len(binary("instruments/22A.bin")), $FE00, 0 ; $22A
        .soundChunk aSoundDirectory22B, len(binary("directories/22B.bin")), $FD00, 0 ; $22B
        .soundChunk aSoundChunk22C, len(binary("chunks/22C.bin")), $FF50, 0 ; $22C
        .soundChunk aSoundDirectory22D, len(binary("directories/22D.bin")), $FDE0, 0 ; $22D
        .soundChunk aSoundSample22E, len(binary("samples/22E.brr")), $51E0, 0 ; $22E
        .soundChunk aSoundChunk22F, len(binary("chunks/22F.bin")), $FF68, 0 ; $22F
        .soundChunk aSoundDirectory230, len(binary("directories/230.bin")), $FDF0, 0 ; $230
        .soundChunk aSoundSample22E, len(binary("samples/22E.brr")), $62F0, 0 ; $231
        .soundChunk aSoundChunk232, len(binary("chunks/232.bin")), $FF50, 0 ; $232
        .soundChunk aSoundDirectory233, len(binary("directories/233.bin")), $FDE0, 0 ; $233
        .soundChunk aSoundSample234, len(binary("samples/234.brr")), $51E0, 0 ; $234
        .soundChunk aSoundChunk235, len(binary("chunks/235.bin")), $FF68, 0 ; $235
        .soundChunk aSoundDirectory236, len(binary("directories/236.bin")), $FDF0, 0 ; $236
        .soundChunk aSoundSample234, len(binary("samples/234.brr")), $62F0, 0 ; $237
        .soundChunk aSoundChunk238, len(binary("chunks/238.bin")), $FF50, 0 ; $238
        .soundChunk aSoundDirectory239, len(binary("directories/239.bin")), $FDE0, 0 ; $239
        .soundChunk aSoundSample23A, len(binary("samples/23A.brr")), $51E0, 0 ; $23A
        .soundChunk aSoundChunk23B, len(binary("chunks/23B.bin")), $FF68, 0 ; $23B
        .soundChunk aSoundDirectory23C, len(binary("directories/23C.bin")), $FDF0, 0 ; $23C
        .soundChunk aSoundSample23A, len(binary("samples/23A.brr")), $62F0, 0 ; $23D
        .soundChunk aSoundChunk23E, len(binary("chunks/23E.bin")), $FF50, 0 ; $23E
        .soundChunk aSoundDirectory23F, len(binary("directories/23F.bin")), $FDE0, 0 ; $23F
        .soundChunk aSoundSample240, len(binary("samples/240.brr")), $51E0, 0 ; $240
        .soundChunk aSoundChunk241, len(binary("chunks/241.bin")), $FF68, 0 ; $241
        .soundChunk aSoundDirectory242, len(binary("directories/242.bin")), $FDF0, 0 ; $242
        .soundChunk aSoundSample240, len(binary("samples/240.brr")), $62F0, 0 ; $243
        .soundChunk aSoundChunk244, len(binary("chunks/244.bin")), $FF50, 0 ; $244
        .soundChunk aSoundDirectory245, len(binary("directories/245.bin")), $FDE0, 0 ; $245
        .soundChunk aSoundSample246, len(binary("samples/246.brr")), $51E0, 0 ; $246
        .soundChunk aSoundChunk247, len(binary("chunks/247.bin")), $FF68, 0 ; $247
        .soundChunk aSoundDirectory248, len(binary("directories/248.bin")), $FDF0, 0 ; $248
        .soundChunk aSoundSample246, len(binary("samples/246.brr")), $62F0, 0 ; $249
        .soundChunk aSoundChunk24A, len(binary("chunks/24A.bin")), $FF50, 0 ; $24A
        .soundChunk aSoundDirectory24B, len(binary("directories/24B.bin")), $FDE0, 0 ; $24B
        .soundChunk aSoundSample24C, len(binary("samples/24C.brr")), $51E0, 0 ; $24C
        .soundChunk aSoundChunk24D, len(binary("chunks/24D.bin")), $FF68, 0 ; $24D
        .soundChunk aSoundDirectory24E, len(binary("directories/24E.bin")), $FDF0, 0 ; $24E
        .soundChunk aSoundSample24C, len(binary("samples/24C.brr")), $62F0, 0 ; $24F
        .soundChunk aSoundChunk250, len(binary("chunks/250.bin")), $FF50, 0 ; $250
        .soundChunk aSoundDirectory251, len(binary("directories/251.bin")), $FDE0, 0 ; $251
        .soundChunk aSoundSample252, len(binary("samples/252.brr")), $51E0, 0 ; $252
        .soundChunk aSoundChunk253, len(binary("chunks/253.bin")), $FF68, 0 ; $253
        .soundChunk aSoundDirectory254, len(binary("directories/254.bin")), $FDF0, 0 ; $254
        .soundChunk aSoundSample252, len(binary("samples/252.brr")), $62F0, 0 ; $255
        .soundChunk aSoundChunk256, len(binary("chunks/256.bin")), $FF50, 0 ; $256
        .soundChunk aSoundDirectory257, len(binary("directories/257.bin")), $FDE0, 0 ; $257
        .soundChunk aSoundSample258, len(binary("samples/258.brr")), $51E0, 0 ; $258
        .soundChunk aSoundChunk259, len(binary("chunks/259.bin")), $FF68, 0 ; $259
        .soundChunk aSoundDirectory25A, len(binary("directories/25A.bin")), $FDF0, 0 ; $25A
        .soundChunk aSoundSample258, len(binary("samples/258.brr")), $62F0, 0 ; $25B
        .soundChunk aSoundChunk25C, len(binary("chunks/25C.bin")), $FF50, 0 ; $25C
        .soundChunk aSoundDirectory25D, len(binary("directories/25D.bin")), $FDE0, 0 ; $25D
        .soundChunk aSoundSample25E, len(binary("samples/25E.brr")), $51E0, 0 ; $25E
        .soundChunk aSoundChunk25F, len(binary("chunks/25F.bin")), $FF68, 0 ; $25F
        .soundChunk aSoundDirectory260, len(binary("directories/260.bin")), $FDF0, 0 ; $260
        .soundChunk aSoundSample25E, len(binary("samples/25E.brr")), $62F0, 0 ; $261
        .soundChunk aSoundChunk262, len(binary("chunks/262.bin")), $FF50, 0 ; $262
        .soundChunk aSoundDirectory263, len(binary("directories/263.bin")), $FDE0, 0 ; $263
        .soundChunk aSoundSample264, len(binary("samples/264.brr")), $51E0, 0 ; $264
        .soundChunk aSoundChunk265, len(binary("chunks/265.bin")), $FF68, 0 ; $265
        .soundChunk aSoundDirectory266, len(binary("directories/266.bin")), $FDF0, 0 ; $266
        .soundChunk aSoundSample264, len(binary("samples/264.brr")), $62F0, 0 ; $267
        .soundChunk aSoundChunk268, len(binary("chunks/268.bin")), $FF50, 0 ; $268
        .soundChunk aSoundDirectory269, len(binary("directories/269.bin")), $FDE0, 0 ; $269
        .soundChunk aSoundSample26A, len(binary("samples/26A.brr")), $51E0, 0 ; $26A
        .soundChunk aSoundChunk26B, len(binary("chunks/26B.bin")), $FF68, 0 ; $26B
        .soundChunk aSoundDirectory26C, len(binary("directories/26C.bin")), $FDF0, 0 ; $26C
        .soundChunk aSoundSample26A, len(binary("samples/26A.brr")), $62F0, 0 ; $26D
        .soundChunk aSoundChunk26E, len(binary("chunks/26E.bin")), $FF50, 0 ; $26E
        .soundChunk aSoundDirectory26F, len(binary("directories/26F.bin")), $FDE0, 0 ; $26F
        .soundChunk aSoundSample270, len(binary("samples/270.brr")), $51E0, 0 ; $270
        .soundChunk aSoundChunk271, len(binary("chunks/271.bin")), $FF68, 0 ; $271
        .soundChunk aSoundDirectory272, len(binary("directories/272.bin")), $FDF0, 0 ; $272
        .soundChunk aSoundSample270, len(binary("samples/270.brr")), $62F0, 0 ; $273
        .soundChunk aSoundChunk274, len(binary("chunks/274.bin")), $FF50, 0 ; $274
        .soundChunk aSoundDirectory275, len(binary("directories/275.bin")), $FDE0, 0 ; $275
        .soundChunk aSoundSample276, len(binary("samples/276.brr")), $51E0, 0 ; $276
        .soundChunk aSoundChunk277, len(binary("chunks/277.bin")), $FF68, 0 ; $277
        .soundChunk aSoundDirectory278, len(binary("directories/278.bin")), $FDF0, 0 ; $278
        .soundChunk aSoundSample276, len(binary("samples/276.brr")), $62F0, 0 ; $279
        .soundChunk aSoundChunk27A, len(binary("chunks/27A.bin")), $FF50, 0 ; $27A
        .soundChunk aSoundDirectory27B, len(binary("directories/27B.bin")), $FDE0, 0 ; $27B
        .soundChunk aSoundSample27C, len(binary("samples/27C.brr")), $51E0, 0 ; $27C
        .soundChunk aSoundChunk27D, len(binary("chunks/27D.bin")), $FF68, 0 ; $27D
        .soundChunk aSoundDirectory27E, len(binary("directories/27E.bin")), $FDF0, 0 ; $27E
        .soundChunk aSoundSample27C, len(binary("samples/27C.brr")), $62F0, 0 ; $27F
        .soundChunk aSoundChunk280, len(binary("chunks/280.bin")), $FF50, 0 ; $280
        .soundChunk aSoundDirectory281, len(binary("directories/281.bin")), $FDE0, 0 ; $281
        .soundChunk aSoundSample282, len(binary("samples/282.brr")), $51E0, 0 ; $282
        .soundChunk aSoundChunk283, len(binary("chunks/283.bin")), $FF68, 0 ; $283
        .soundChunk aSoundDirectory284, len(binary("directories/284.bin")), $FDF0, 0 ; $284
        .soundChunk aSoundSample282, len(binary("samples/282.brr")), $62F0, 0 ; $285
        .soundChunk aSoundChunk286, len(binary("chunks/286.bin")), $FF50, 0 ; $286
        .soundChunk aSoundDirectory287, len(binary("directories/287.bin")), $FDE0, 0 ; $287
        .soundChunk aSoundSample288, len(binary("samples/288.brr")), $51E0, 0 ; $288
        .soundChunk aSoundChunk289, len(binary("chunks/289.bin")), $FF68, 0 ; $289
        .soundChunk aSoundDirectory28A, len(binary("directories/28A.bin")), $FDF0, 0 ; $28A
        .soundChunk aSoundSample288, len(binary("samples/288.brr")), $62F0, 0 ; $28B
        .soundChunk aSoundChunk28C, len(binary("chunks/28C.bin")), $FF50, 0 ; $28C
        .soundChunk aSoundDirectory28D, len(binary("directories/28D.bin")), $FDE0, 0 ; $28D
        .soundChunk aSoundSample28E, len(binary("samples/28E.brr")), $51E0, 0 ; $28E
        .soundChunk aSoundChunk28F, len(binary("chunks/28F.bin")), $FF68, 0 ; $28F
        .soundChunk aSoundDirectory290, len(binary("directories/290.bin")), $FDF0, 0 ; $290
        .soundChunk aSoundSample28E, len(binary("samples/28E.brr")), $62F0, 0 ; $291
        .soundChunk aSoundChunk292, len(binary("chunks/292.bin")), $FF50, 0 ; $292
        .soundChunk aSoundDirectory293, len(binary("directories/293.bin")), $FDE0, 0 ; $293
        .soundChunk aSoundSample294, len(binary("samples/294.brr")), $51E0, 0 ; $294
        .soundChunk aSoundChunk295, len(binary("chunks/295.bin")), $FF68, 0 ; $295
        .soundChunk aSoundDirectory296, len(binary("directories/296.bin")), $FDF0, 0 ; $296
        .soundChunk aSoundSample294, len(binary("samples/294.brr")), $62F0, 0 ; $297
        .soundChunk aSoundChunk298, len(binary("chunks/298.bin")), $FF50, 0 ; $298
        .soundChunk aSoundDirectory299, len(binary("directories/299.bin")), $FDE0, 0 ; $299
        .soundChunk aSoundSample29A, len(binary("samples/29A.brr")), $51E0, 0 ; $29A
        .soundChunk aSoundChunk29B, len(binary("chunks/29B.bin")), $FF68, 0 ; $29B
        .soundChunk aSoundDirectory29C, len(binary("directories/29C.bin")), $FDF0, 0 ; $29C
        .soundChunk aSoundSample29A, len(binary("samples/29A.brr")), $62F0, 0 ; $29D
        .soundChunk aSoundChunk29E, len(binary("chunks/29E.bin")), $FF50, 0 ; $29E
        .soundChunk aSoundDirectory29F, len(binary("directories/29F.bin")), $FDE0, 0 ; $29F
        .soundChunk aSoundSample2A0, len(binary("samples/2A0.brr")), $51E0, 0 ; $2A0
        .soundChunk aSoundChunk2A1, len(binary("chunks/2A1.bin")), $FF68, 0 ; $2A1
        .soundChunk aSoundDirectory2A2, len(binary("directories/2A2.bin")), $FDF0, 0 ; $2A2
        .soundChunk aSoundSample2A0, len(binary("samples/2A0.brr")), $62F0, 0 ; $2A3
        .soundChunk aSoundChunk2A4, len(binary("chunks/2A4.bin")), $FF62, 0 ; $2A4
        .soundChunk aSoundDirectory2A5, len(binary("directories/2A5.bin")), $FDEC, 0 ; $2A5
        .soundChunk aSoundSample2A6, len(binary("samples/2A6.brr")), $5F74, 0 ; $2A6
        .soundChunk aSoundChunk2A7, len(binary("chunks/2A7.bin")), $FF7A, 0 ; $2A7
        .soundChunk aSoundDirectory2A8, len(binary("directories/2A8.bin")), $FDFC, 0 ; $2A8
        .soundChunk aSoundSample2A6, len(binary("samples/2A6.brr")), $7084, 0 ; $2A9
        .soundChunk aSoundChunk2AA, len(binary("chunks/2AA.bin")), $FF62, 0 ; $2AA
        .soundChunk aSoundDirectory2AB, len(binary("directories/2AB.bin")), $FDEC, 0 ; $2AB
        .soundChunk aSoundSample2AC, len(binary("samples/2AC.brr")), $5F74, 0 ; $2AC
        .soundChunk aSoundChunk2AD, len(binary("chunks/2AD.bin")), $FF7A, 0 ; $2AD
        .soundChunk aSoundDirectory2AE, len(binary("directories/2AE.bin")), $FDFC, 0 ; $2AE
        .soundChunk aSoundSample2AC, len(binary("samples/2AC.brr")), $7084, 0 ; $2AF
        .soundChunk aSoundChunk2B0, len(binary("chunks/2B0.bin")), $FF62, 0 ; $2B0
        .soundChunk aSoundDirectory2B1, len(binary("directories/2B1.bin")), $FDEC, 0 ; $2B1
        .soundChunk aSoundSample2B2, len(binary("samples/2B2.brr")), $5F74, 0 ; $2B2
        .soundChunk aSoundChunk2B3, len(binary("chunks/2B3.bin")), $FF7A, 0 ; $2B3
        .soundChunk aSoundDirectory2B4, len(binary("directories/2B4.bin")), $FDFC, 0 ; $2B4
        .soundChunk aSoundSample2B2, len(binary("samples/2B2.brr")), $7084, 0 ; $2B5
        .soundChunk aSoundChunk2B6, len(binary("chunks/2B6.bin")), $FF62, 0 ; $2B6
        .soundChunk aSoundDirectory2B7, len(binary("directories/2B7.bin")), $FDEC, 0 ; $2B7
        .soundChunk aSoundSample2B8, len(binary("samples/2B8.brr")), $5F74, 0 ; $2B8
        .soundChunk aSoundChunk2B9, len(binary("chunks/2B9.bin")), $FF7A, 0 ; $2B9
        .soundChunk aSoundDirectory2BA, len(binary("directories/2BA.bin")), $FDFC, 0 ; $2BA
        .soundChunk aSoundSample2B8, len(binary("samples/2B8.brr")), $7084, 0 ; $2BB
        .soundChunk aSoundChunk2BC, len(binary("chunks/2BC.bin")), $FF62, 0 ; $2BC
        .soundChunk aSoundDirectory2BD, len(binary("directories/2BD.bin")), $FDEC, 0 ; $2BD
        .soundChunk aSoundSample2BE, len(binary("samples/2BE.brr")), $5F74, 0 ; $2BE
        .soundChunk aSoundChunk2BF, len(binary("chunks/2BF.bin")), $FF7A, 0 ; $2BF
        .soundChunk aSoundDirectory2C0, len(binary("directories/2C0.bin")), $FDFC, 0 ; $2C0
        .soundChunk aSoundSample2BE, len(binary("samples/2BE.brr")), $7084, 0 ; $2C1
        .soundChunk aSoundChunk2C2, len(binary("chunks/2C2.bin")), $FF62, 0 ; $2C2
        .soundChunk aSoundDirectory2C3, len(binary("directories/2C3.bin")), $FDEC, 0 ; $2C3
        .soundChunk aSoundSample2C4, len(binary("samples/2C4.brr")), $5F74, 0 ; $2C4
        .soundChunk aSoundChunk2C5, len(binary("chunks/2C5.bin")), $FF7A, 0 ; $2C5
        .soundChunk aSoundDirectory2C6, len(binary("directories/2C6.bin")), $FDFC, 0 ; $2C6
        .soundChunk aSoundSample2C4, len(binary("samples/2C4.brr")), $7084, 0 ; $2C7
        .soundChunk aSoundChunk2C8, len(binary("chunks/2C8.bin")), $FF62, 0 ; $2C8
        .soundChunk aSoundDirectory2C9, len(binary("directories/2C9.bin")), $FDEC, 0 ; $2C9
        .soundChunk aSoundSample2CA, len(binary("samples/2CA.brr")), $5F74, 0 ; $2CA
        .soundChunk aSoundChunk2CB, len(binary("chunks/2CB.bin")), $FF7A, 0 ; $2CB
        .soundChunk aSoundDirectory2CC, len(binary("directories/2CC.bin")), $FDFC, 0 ; $2CC
        .soundChunk aSoundSample2CA, len(binary("samples/2CA.brr")), $7084, 0 ; $2CD
        .soundChunk aSoundChunk2CE, len(binary("chunks/2CE.bin")), $FF62, 0 ; $2CE
        .soundChunk aSoundDirectory2CF, len(binary("directories/2CF.bin")), $FDEC, 0 ; $2CF
        .soundChunk aSoundSample2D0, len(binary("samples/2D0.brr")), $5F74, 0 ; $2D0
        .soundChunk aSoundChunk2D1, len(binary("chunks/2D1.bin")), $FF7A, 0 ; $2D1
        .soundChunk aSoundDirectory2D2, len(binary("directories/2D2.bin")), $FDFC, 0 ; $2D2
        .soundChunk aSoundSample2D0, len(binary("samples/2D0.brr")), $7084, 0 ; $2D3
        .soundChunk aSoundChunk2D4, len(binary("chunks/2D4.bin")), $FF62, 0 ; $2D4
        .soundChunk aSoundDirectory2D5, len(binary("directories/2D5.bin")), $FDEC, 0 ; $2D5
        .soundChunk aSoundSample2D6, len(binary("samples/2D6.brr")), $5F74, 0 ; $2D6
        .soundChunk aSoundChunk2D7, len(binary("chunks/2D7.bin")), $FF7A, 0 ; $2D7
        .soundChunk aSoundDirectory2D8, len(binary("directories/2D8.bin")), $FDFC, 0 ; $2D8
        .soundChunk aSoundSample2D6, len(binary("samples/2D6.brr")), $7084, 0 ; $2D9
        .soundChunk aSoundChunk2DA, len(binary("chunks/2DA.bin")), $FF62, 0 ; $2DA
        .soundChunk aSoundDirectory2DB, len(binary("directories/2DB.bin")), $FDEC, 0 ; $2DB
        .soundChunk aSoundSample2DC, len(binary("samples/2DC.brr")), $5F74, 0 ; $2DC
        .soundChunk aSoundChunk2DD, len(binary("chunks/2DD.bin")), $FF7A, 0 ; $2DD
        .soundChunk aSoundDirectory2DE, len(binary("directories/2DE.bin")), $FDFC, 0 ; $2DE
        .soundChunk aSoundSample2DC, len(binary("samples/2DC.brr")), $7084, 0 ; $2DF
        .soundChunk aSoundChunk2E0, len(binary("chunks/2E0.bin")), $FF62, 0 ; $2E0
        .soundChunk aSoundDirectory2E1, len(binary("directories/2E1.bin")), $FDEC, 0 ; $2E1
        .soundChunk aSoundSample2E2, len(binary("samples/2E2.brr")), $5F74, 0 ; $2E2
        .soundChunk aSoundChunk2E3, len(binary("chunks/2E3.bin")), $FF7A, 0 ; $2E3
        .soundChunk aSoundDirectory2E4, len(binary("directories/2E4.bin")), $FDFC, 0 ; $2E4
        .soundChunk aSoundSample2E2, len(binary("samples/2E2.brr")), $7084, 0 ; $2E5
        .soundChunk aSoundChunk2E6, len(binary("chunks/2E6.bin")), $FF62, 0 ; $2E6
        .soundChunk aSoundDirectory2E7, len(binary("directories/2E7.bin")), $FDEC, 0 ; $2E7
        .soundChunk aSoundSample2E8, len(binary("samples/2E8.brr")), $5F74, 0 ; $2E8
        .soundChunk aSoundChunk2E9, len(binary("chunks/2E9.bin")), $FF7A, 0 ; $2E9
        .soundChunk aSoundDirectory2EA, len(binary("directories/2EA.bin")), $FDFC, 0 ; $2EA
        .soundChunk aSoundSample2E8, len(binary("samples/2E8.brr")), $7084, 0 ; $2EB
        .soundChunk aSoundChunk2EC, len(binary("chunks/2EC.bin")), $FF62, 0 ; $2EC
        .soundChunk aSoundDirectory2ED, len(binary("directories/2ED.bin")), $FDEC, 0 ; $2ED
        .soundChunk aSoundSample2EE, len(binary("samples/2EE.brr")), $5F74, 0 ; $2EE
        .soundChunk aSoundChunk2EF, len(binary("chunks/2EF.bin")), $FF7A, 0 ; $2EF
        .soundChunk aSoundDirectory2F0, len(binary("directories/2F0.bin")), $FDFC, 0 ; $2F0
        .soundChunk aSoundSample2EE, len(binary("samples/2EE.brr")), $7084, 0 ; $2F1
        .soundChunk aSoundChunk2F2, len(binary("chunks/2F2.bin")), $FF62, 0 ; $2F2
        .soundChunk aSoundDirectory2F3, len(binary("directories/2F3.bin")), $FDEC, 0 ; $2F3
        .soundChunk aSoundSample2F4, len(binary("samples/2F4.brr")), $5F74, 0 ; $2F4
        .soundChunk aSoundChunk2F5, len(binary("chunks/2F5.bin")), $FF7A, 0 ; $2F5
        .soundChunk aSoundDirectory2F6, len(binary("directories/2F6.bin")), $FDFC, 0 ; $2F6
        .soundChunk aSoundSample2F4, len(binary("samples/2F4.brr")), $7084, 0 ; $2F7
        .soundChunk aSoundChunk2F8, len(binary("chunks/2F8.bin")), $FF62, 0 ; $2F8
        .soundChunk aSoundDirectory2F9, len(binary("directories/2F9.bin")), $FDEC, 0 ; $2F9
        .soundChunk aSoundSample2FA, len(binary("samples/2FA.brr")), $5F74, 0 ; $2FA
        .soundChunk aSoundChunk2FB, len(binary("chunks/2FB.bin")), $FF7A, 0 ; $2FB
        .soundChunk aSoundDirectory2FC, len(binary("directories/2FC.bin")), $FDFC, 0 ; $2FC
        .soundChunk aSoundSample2FA, len(binary("samples/2FA.brr")), $7084, 0 ; $2FD
        .soundChunk aSoundChunk2FE, len(binary("chunks/2FE.bin")), $FF62, 0 ; $2FE
        .soundChunk aSoundDirectory2FF, len(binary("directories/2FF.bin")), $FDEC, 0 ; $2FF
        .soundChunk aSoundSample300, len(binary("samples/300.brr")), $5F74, 0 ; $300
        .soundChunk aSoundChunk301, len(binary("chunks/301.bin")), $FF7A, 0 ; $301
        .soundChunk aSoundDirectory302, len(binary("directories/302.bin")), $FDFC, 0 ; $302
        .soundChunk aSoundSample300, len(binary("samples/300.brr")), $7084, 0 ; $303
        .soundChunk aSoundChunk304, len(binary("chunks/304.bin")), $FF62, 0 ; $304
        .soundChunk aSoundDirectory305, len(binary("directories/305.bin")), $FDEC, 0 ; $305
        .soundChunk aSoundSample306, len(binary("samples/306.brr")), $5F74, 0 ; $306
        .soundChunk aSoundChunk307, len(binary("chunks/307.bin")), $FF7A, 0 ; $307
        .soundChunk aSoundDirectory308, len(binary("directories/308.bin")), $FDFC, 0 ; $308
        .soundChunk aSoundSample306, len(binary("samples/306.brr")), $7084, 0 ; $309
        .soundChunk aSoundChunk30A, len(binary("chunks/30A.bin")), $FF62, 0 ; $30A
        .soundChunk aSoundDirectory30B, len(binary("directories/30B.bin")), $FDEC, 0 ; $30B
        .soundChunk aSoundSample30C, len(binary("samples/30C.brr")), $5F74, 0 ; $30C
        .soundChunk aSoundChunk30D, len(binary("chunks/30D.bin")), $FF7A, 0 ; $30D
        .soundChunk aSoundDirectory30E, len(binary("directories/30E.bin")), $FDFC, 0 ; $30E
        .soundChunk aSoundSample30C, len(binary("samples/30C.brr")), $7084, 0 ; $30F
        .soundChunk aSoundChunk310, len(binary("chunks/310.bin")), $FF62, 0 ; $310
        .soundChunk aSoundDirectory311, len(binary("directories/311.bin")), $FDEC, 0 ; $311
        .soundChunk aSoundSample312, len(binary("samples/312.brr")), $5F74, 0 ; $312
        .soundChunk aSoundChunk313, len(binary("chunks/313.bin")), $FF7A, 0 ; $313
        .soundChunk aSoundDirectory314, len(binary("directories/314.bin")), $FDFC, 0 ; $314
        .soundChunk aSoundSample312, len(binary("samples/312.brr")), $7084, 0 ; $315
        .soundChunk aSoundChunk316, len(binary("chunks/316.bin")), $FF62, 0 ; $316
        .soundChunk aSoundDirectory317, len(binary("directories/317.bin")), $FDEC, 0 ; $317
        .soundChunk aSoundSample318, len(binary("samples/318.brr")), $5F74, 0 ; $318
        .soundChunk aSoundChunk319, len(binary("chunks/319.bin")), $FF7A, 0 ; $319
        .soundChunk aSoundDirectory31A, len(binary("directories/31A.bin")), $FDFC, 0 ; $31A
        .soundChunk aSoundSample318, len(binary("samples/318.brr")), $7084, 0 ; $31B
        .soundChunk aSoundChunk31C, len(binary("chunks/31C.bin")), $FF62, 0 ; $31C
        .soundChunk aSoundDirectory31D, len(binary("directories/31D.bin")), $FDEC, 0 ; $31D
        .soundChunk aSoundSample31E, len(binary("samples/31E.brr")), $5F74, 0 ; $31E
        .soundChunk aSoundChunk31F, len(binary("chunks/31F.bin")), $FF7A, 0 ; $31F
        .soundChunk aSoundDirectory320, len(binary("directories/320.bin")), $FDFC, 0 ; $320
        .soundChunk aSoundSample31E, len(binary("samples/31E.brr")), $7084, 0 ; $321
        .soundChunk aSoundChunk322, len(binary("chunks/322.bin")), $FF62, 0 ; $322
        .soundChunk aSoundDirectory323, len(binary("directories/323.bin")), $FDEC, 0 ; $323
        .soundChunk aSoundSample324, len(binary("samples/324.brr")), $5F74, 0 ; $324
        .soundChunk aSoundChunk325, len(binary("chunks/325.bin")), $FF7A, 0 ; $325
        .soundChunk aSoundDirectory326, len(binary("directories/326.bin")), $FDFC, 0 ; $326
        .soundChunk aSoundSample324, len(binary("samples/324.brr")), $7084, 0 ; $327
        .soundChunk aSoundInstruments328, len(binary("instruments/328.bin")), $FE6C, 0 ; $328
        .soundChunk aSoundDirectory329, len(binary("directories/329.bin")), $FD48, 0 ; $329
        .soundChunk aSoundSample32A, len(binary("samples/32A.brr")), $3204, 0 ; $32A
        .soundChunk aSoundInstruments32B, len(binary("instruments/32B.bin")), $FEE4, 0 ; $32B
        .soundChunk aSoundDirectory32C, len(binary("directories/32C.bin")), $FD98, 0 ; $32C
        .soundChunk aSoundSample32D, len(binary("samples/32D.brr")), $4BA7, 0 ; $32D
        .soundChunk aSoundInstruments32E, len(binary("instruments/32E.bin")), $FEE4, 0 ; $32E
        .soundChunk aSoundDirectory32F, len(binary("directories/32F.bin")), $FD98, 0 ; $32F
        .soundChunk aSoundSample330, len(binary("samples/330.brr")), $4BA7, 0 ; $330
        .soundChunk aSoundInstruments331, len(binary("instruments/331.bin")), $FEE4, 0 ; $331
        .soundChunk aSoundDirectory332, len(binary("directories/332.bin")), $FD98, 0 ; $332
        .soundChunk aSoundSample333, len(binary("samples/333.brr")), $4BA7, 0 ; $333
        .soundChunk aSoundInstruments334, len(binary("instruments/334.bin")), $FE66, 0 ; $334
        .soundChunk aSoundDirectory335, len(binary("directories/335.bin")), $FD44, 0 ; $335
        .soundChunk aSoundSample336, len(binary("samples/336.brr")), $AA70, 0 ; $336
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
        .soundChunk aSoundDirectory344, len(binary("directories/344.bin")), $FDE0, 0 ; $344
        .soundChunk aSoundSample12D, len(binary("samples/12D.brr")), $51E0, 0 ; $345
        .soundChunk aSoundChunk346, len(binary("chunks/346.bin")), $FF68, 0 ; $346
        .soundChunk aSoundDirectory347, len(binary("directories/347.bin")), $FDF0, 0 ; $347
        .soundChunk aSoundSample12D, len(binary("samples/12D.brr")), $62F0, 0 ; $348
        .soundChunk aSoundChunk349, len(binary("chunks/349.bin")), $FF50, 0 ; $349
        .soundChunk aSoundDirectory34A, len(binary("directories/34A.bin")), $FDE0, 0 ; $34A
        .soundChunk aSoundSample11F, len(binary("samples/11F.brr")), $51E0, 0 ; $34B
        .soundChunk aSoundChunk34C, len(binary("chunks/34C.bin")), $FF68, 0 ; $34C
        .soundChunk aSoundDirectory34D, len(binary("directories/34D.bin")), $FDF0, 0 ; $34D
        .soundChunk aSoundSample11F, len(binary("samples/11F.brr")), $62F0, 0 ; $34E
        .soundChunk aSoundInstruments34F, len(binary("instruments/34F.bin")), $FE66, 0 ; $34F
        .soundChunk aSoundDirectory350, len(binary("directories/350.bin")), $FD44, 0 ; $350
        .soundChunk aSoundSample276, len(binary("samples/276.brr")), $A000, 0 ; $351
        .soundChunk aSoundInstruments352, len(binary("instruments/352.bin")), $FE00, 0 ; $352
        .soundChunk aSoundDirectory353, len(binary("directories/353.bin")), $FD00, 0 ; $353
        .soundChunk aSoundSample126, len(binary("samples/126.brr")), $2800, 0 ; $354
        .soundChunk aSoundSample27C, len(binary("samples/27C.brr")), $0000, 0 ; $355
        .soundChunk aSoundSample23A, len(binary("samples/23A.brr")), $0000, 0 ; $356
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

      aSoundBattleUploads ; F7/AD9C

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
      aSoundPadF7AF2F ; F7/AF2F, no chunk starts here
        ; Sent to the APU as the high byte of aSoundChunk337's last word: uploads go by words.
        .byte $00
      aSoundChunk338 .soundBinary "chunks/338.bin" ; F7/AF30
      aSoundPadF7AF31 ; F7/AF31, no chunk starts here
        ; Sent to the APU as the high byte of aSoundChunk338's last word: uploads go by words.
        .byte $00
      aSoundChunk339 .soundBinary "chunks/339.bin" ; F7/AF32
      aSoundPadF7AF33 ; F7/AF33, no chunk starts here
        ; Sent to the APU as the high byte of aSoundChunk339's last word: uploads go by words.
        .byte $00
      aSoundChunk33A .soundBinary "chunks/33A.bin" ; F7/AF34
      aSoundPadF7AF35 ; F7/AF35, no chunk starts here
        ; Sent to the APU as the high byte of aSoundChunk33A's last word: uploads go by words.
        .byte $00
      aSoundChunk33D .soundBinary "chunks/33D.bin" ; F7/AF36
      aSoundChunk33E .soundBinary "chunks/33E.bin" ; F7/AF38
      aSoundChunk33F .soundBinary "chunks/33F.bin" ; F7/AF3A
      aSoundChunk33B .soundBinary "chunks/33B.bin" ; F7/AF3C
      aSoundChunk33C .soundBinary "chunks/33C.bin" ; F7/AF3E
      aSoundChunk340 .soundBinary "chunks/340.bin" ; F7/AF40
      aSoundPadF7AF41 ; F7/AF41, no chunk starts here
        ; Sent to the APU as the high byte of aSoundChunk340's last word: uploads go by words.
        .byte $00
      aSoundChunk341 .soundBinary "chunks/341.bin" ; F7/AF42
      aSoundPadF7AF43 ; F7/AF43, no chunk starts here
        ; Sent to the APU as the high byte of aSoundChunk341's last word: uploads go by words.
        .byte $00
      aSoundChunk342 .soundBinary "chunks/342.bin" ; F7/AF44
      aSoundPadF7AF45 ; F7/AF45, no chunk starts here
        ; Sent to the APU as the high byte of aSoundChunk342's last word: uploads go by words.
        .byte $00
      aSoundChunk343 .soundBinary "chunks/343.bin" ; F7/AF46
      aSoundDirectory344 .soundBinary "directories/344.bin" ; F7/AF4C
      aSoundChunk346 .soundBinary "chunks/346.bin" ; F7/AF50
      aSoundDirectory347 .soundBinary "directories/347.bin" ; F7/AF56
      aSoundChunk349 .soundBinary "chunks/349.bin" ; F7/AF5A
      aSoundDirectory34A .soundBinary "directories/34A.bin" ; F7/AF60
      aSoundChunk34C .soundBinary "chunks/34C.bin" ; F7/AF64
      aSoundDirectory34D .soundBinary "directories/34D.bin" ; F7/AF6A
      aSoundInstruments34F .soundBinary "instruments/34F.bin" ; F7/AF6E
      aSoundDirectory350 .soundBinary "directories/350.bin" ; F7/AF74
      aSoundInstruments352 .soundBinary "instruments/352.bin" ; F7/AF78
      aSoundDirectory353 .soundBinary "directories/353.bin" ; F7/AF7E
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
      aSoundPadF7AFEE ; F7/AFEE, nothing points here
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

      aSoundSequence064 .soundBinary "sequences/064.bin.lz" ; F7/CDBC
      aSoundSequence065 .soundBinary "sequences/065.bin.lz" ; F7/CE59
      aSoundSequence066 .soundBinary "sequences/066.bin.lz" ; F7/D7A2
      aSoundSequence067 .soundBinary "sequences/067.bin.lz" ; F7/E275
      aSoundSequence068 .soundBinary "sequences/068.bin.lz" ; F7/ECE4
      aSoundSequence069 .soundBinary "sequences/069.bin.lz" ; F7/F474
      aSoundSequence06A .soundBinary "sequences/06A.bin.lz" ; F7/FAC4
      aSoundSequence06B .soundBinary "sequences/06B.bin.lz" ; F8/03FE
      aSoundSequence06C .soundBinary "sequences/06C.bin.lz" ; F8/0C44
      aSoundSequence06D .soundBinary "sequences/06D.bin.lz" ; F8/1144
      aSoundSequence06E .soundBinary "sequences/06E.bin.lz" ; F8/19F2
      aSoundSequence06F .soundBinary "sequences/06F.bin.lz" ; F8/1F4C
      aSoundSequence070 .soundBinary "sequences/070.bin.lz" ; F8/26C9
      aSoundSequence071 .soundBinary "sequences/071.bin.lz" ; F8/33A6
      aSoundSequence072 .soundBinary "sequences/072.bin.lz" ; F8/3924
      aSoundSequence073 .soundBinary "sequences/073.bin.lz" ; F8/4022
      aSoundSequence074 .soundBinary "sequences/074.bin.lz" ; F8/47F0
      aSoundSequence075 .soundBinary "sequences/075.bin.lz" ; F8/4DDB
      aSoundSequence076 .soundBinary "sequences/076.bin.lz" ; F8/5565
      aSoundSequence077 .soundBinary "sequences/077.bin.lz" ; F8/5B19
      aSoundSequence078 .soundBinary "sequences/078.bin.lz" ; F8/6162
      aSoundSequence079 .soundBinary "sequences/079.bin.lz" ; F8/6878
      aSoundSequence07A .soundBinary "sequences/07A.bin.lz" ; F8/726A
      aSoundSequence07B .soundBinary "sequences/07B.bin.lz" ; F8/7913
      aSoundSequence07C .soundBinary "sequences/07C.bin.lz" ; F8/820F
      aSoundSequence07D .soundBinary "sequences/07D.bin.lz" ; F8/88C4
      aSoundSequence07E .soundBinary "sequences/07E.bin.lz" ; F8/8D57
      aSoundSequence07F .soundBinary "sequences/07F.bin.lz" ; F8/91D5
      aSoundSequence080 .soundBinary "sequences/080.bin.lz" ; F8/96F8
      aSoundSequence081 .soundBinary "sequences/081.bin.lz" ; F8/98C1
      aSoundSequence082 .soundBinary "sequences/082.bin.lz" ; F8/9BCC
      aSoundSequence083 .soundBinary "sequences/083.bin.lz" ; F8/9E49
      aSoundSequence084 .soundBinary "sequences/084.bin.lz" ; F8/A0AC
      aSoundSequence085 .soundBinary "sequences/085.bin.lz" ; F8/A7CB
      aSoundSequence086 .soundBinary "sequences/086.bin.lz" ; F8/A978
      aSoundSequence087 .soundBinary "sequences/087.bin.lz" ; F8/AB36
      aSoundSequence088 .soundBinary "sequences/088.bin.lz" ; F8/AE78
      aSoundSequence089 .soundBinary "sequences/089.bin.lz" ; F8/B65E
      aSoundSequence08A .soundBinary "sequences/08A.bin.lz" ; F8/B850
      aSoundSequence08B .soundBinary "sequences/08B.bin.lz" ; F8/B9C5
      aSoundSequence08C .soundBinary "sequences/08C.bin.lz" ; F8/BBE0
      aSoundSequence08D .soundBinary "sequences/08D.bin.lz" ; F8/C39A
      aSoundSequence08E .soundBinary "sequences/08E.bin.lz" ; F8/C562
      aSoundSequence08F .soundBinary "sequences/08F.bin.lz" ; F8/C743
      aSoundSequence090 .soundBinary "sequences/090.bin.lz" ; F8/C92A
      aSoundSequence091 .soundBinary "sequences/091.bin.lz" ; F8/CBEB
      aSoundSequence092 .soundBinary "sequences/092.bin.lz" ; F8/CEA9
      aSoundSequence093 .soundBinary "sequences/093.bin.lz" ; F8/D0B7
      aSoundSequence094 .soundBinary "sequences/094.bin.lz" ; F8/D2BB
      aSoundSequence095 .soundBinary "sequences/095.bin.lz" ; F8/D837
      aSoundSequence096 .soundBinary "sequences/096.bin.lz" ; F8/E658
      aSoundSequence097 .soundBinary "sequences/097.bin.lz" ; F8/EDAB
      aSoundSequence098 .soundBinary "sequences/098.bin.lz" ; F9/01BA
      aSoundSequence099 .soundBinary "sequences/099.bin.lz" ; F9/1011
      aSoundSequence09A .soundBinary "sequences/09A.bin.lz" ; F9/16F3
      aSoundSequence09B .soundBinary "sequences/09B.bin.lz" ; F9/1B80
      aSoundSequence09C .soundBinary "sequences/09C.bin.lz" ; F9/1EDA
      aSoundSequence09D .soundBinary "sequences/09D.bin.lz" ; F9/240C
      aSoundSequence09E .soundBinary "sequences/09E.bin.lz" ; F9/290A
      aSoundSequence09F .soundBinary "sequences/09F.bin.lz" ; F9/2BC5
      aSoundSequence0A0 .soundBinary "sequences/0A0.bin.lz" ; F9/3159
      aSoundSequence0A1 .soundBinary "sequences/0A1.bin.lz" ; F9/345C
      aSoundSequence0A2 .soundBinary "sequences/0A2.bin.lz" ; F9/3696
      aSoundSequence0A3 .soundBinary "sequences/0A3.bin.lz" ; F9/37EC
      aSoundSequence0A4 .soundBinary "sequences/0A4.bin.lz" ; F9/3D55
      aSoundSequence0A5 .soundBinary "sequences/0A5.bin.lz" ; F9/45DF
      aSoundSequence0A6 .soundBinary "sequences/0A6.bin.lz" ; F9/47B2
      aSoundSequence0A7 .soundBinary "sequences/0A7.bin.lz" ; F9/48BB
      aSoundSequence0A8 .soundBinary "sequences/0A8.bin.lz" ; F9/5093
      aSoundSequence0A9 .soundBinary "sequences/0A9.bin.lz" ; F9/5436
      aSoundSequence0AA .soundBinary "sequences/0AA.bin.lz" ; F9/578C
      aSoundSequence0AB .soundBinary "sequences/0AB.bin.lz" ; F9/5A16
      aSoundSequence0AC .soundBinary "sequences/0AC.bin.lz" ; F9/5B99
      aSoundSequence0AD .soundBinary "sequences/0AD.bin.lz" ; F9/5D1E
      aSoundSequence0AE .soundBinary "sequences/0AE.bin.lz" ; F9/5DF2
      aSoundSequence0AF .soundBinary "sequences/0AF.bin.lz" ; F9/5FA3
      aSoundSequence0B0 .soundBinary "sequences/0B0.bin.lz" ; F9/631F
      aSoundSequence0B1 .soundBinary "sequences/0B1.bin.lz" ; F9/681A
      aSoundSequence0B2 .soundBinary "sequences/0B2.bin.lz" ; F9/6EED
      aSoundSequence0B3 .soundBinary "sequences/0B3.bin.lz" ; F9/710E
      aSoundSequence0B4 .soundBinary "sequences/0B4.bin.lz" ; F9/73E9
      aSoundSequence0B5 .soundBinary "sequences/0B5.bin.lz" ; F9/7B61
      aSoundSequence0B6 .soundBinary "sequences/0B6.bin.lz" ; F9/7EA5
      aSoundSequence0B7 .soundBinary "sequences/0B7.bin.lz" ; F9/811C
      aSoundSequence0B8 .soundBinary "sequences/0B8.bin.lz" ; F9/8571
      aSoundSequence0B9 .soundBinary "sequences/0B9.bin.lz" ; F9/8783
      aSoundSequence0BA .soundBinary "sequences/0BA.bin.lz" ; F9/8AAD
      aSoundSequence0BB .soundBinary "sequences/0BB.bin.lz" ; F9/8D65
      aSoundSequence0BC .soundBinary "sequences/0BC.bin.lz" ; F9/911F
      aSoundSequence0BD .soundBinary "sequences/0BD.bin.lz" ; F9/92C2
      aSoundSequence0BE .soundBinary "sequences/0BE.bin.lz" ; F9/9600
      aSoundSequence0BF .soundBinary "sequences/0BF.bin.lz" ; F9/992C
      aSoundSequence0C0 .soundBinary "sequences/0C0.bin.lz" ; F9/9D47
      aSoundSequence0C1 .soundBinary "sequences/0C1.bin.lz" ; F9/9FF1
      aSoundSequence0C2 .soundBinary "sequences/0C2.bin.lz" ; F9/A1D4
      aSoundSequence0C3 .soundBinary "sequences/0C3.bin.lz" ; F9/A554
      aSoundSequence0C4 .soundBinary "sequences/0C4.bin.lz" ; F9/A859
      aSoundSequence0C5 .soundBinary "sequences/0C5.bin.lz" ; F9/AB62
      aSoundSequence0C6 .soundBinary "sequences/0C6.bin.lz" ; F9/AE26
      aSoundSequence0C7 .soundBinary "sequences/0C7.bin.lz" ; F9/B07D
      aSoundSequence0C8 .soundBinary "sequences/0C8.bin.lz" ; F9/B355
      aSoundSequence0C9 .soundBinary "sequences/0C9.bin.lz" ; F9/B86D
      aSoundSequence0CA .soundBinary "sequences/0CA.bin.lz" ; F9/BD16
      aSoundSequence0CB .soundBinary "sequences/0CB.bin.lz" ; F9/C017
      aSoundSequence0CC .soundBinary "sequences/0CC.bin.lz" ; F9/C225
      aSoundSequence0CD .soundBinary "sequences/0CD.bin.lz" ; F9/C4F4
      aSoundSequence0CE .soundBinary "sequences/0CE.bin.lz" ; F9/C801
      aSoundSequence0CF .soundBinary "sequences/0CF.bin.lz" ; F9/CE1F
      aSoundSequence0D0 .soundBinary "sequences/0D0.bin.lz" ; F9/D295
      aSoundSequence0D1 .soundBinary "sequences/0D1.bin.lz" ; F9/D911
      aSoundSequence0D2 .soundBinary "sequences/0D2.bin.lz" ; F9/DB9E
      aSoundSequence0D3 .soundBinary "sequences/0D3.bin.lz" ; F9/DD83
      aSoundChunk0D4 .soundBinary "chunks/0D4.bin" ; F9/F063
      aSoundChunk0D5 .soundBinary "chunks/0D5.bin" ; F9/FE48
      aSoundChunk0D6 .soundBinary "chunks/0D6.bin" ; FA/0C8C
      aSoundSample0D7 .soundBinary "samples/0D7.brr" ; FA/1099
      aSoundSample0D8 .soundBinary "samples/0D8.brr" ; FA/280C
      aSoundSample0D9 .soundBinary "samples/0D9.brr" ; FA/2A94
      aSoundSample0DA .soundBinary "samples/0DA.brr" ; FA/2FEC
      aSoundSample0DB .soundBinary "samples/0DB.brr" ; FA/3A0C
      aSoundSample0DC .soundBinary "samples/0DC.brr" ; FA/562C
      aSoundSample0DD .soundBinary "samples/0DD.brr" ; FA/6E02
      aSoundSample0DE .soundBinary "samples/0DE.brr" ; FA/7027
      aSoundSample0DF .soundBinary "samples/0DF.brr" ; FA/76F9
      aSoundSample0E0 .soundBinary "samples/0E0.brr" ; FA/7819
      aSoundSample0E1 .soundBinary "samples/0E1.brr" ; FA/79F6
      aSoundSample0E2 .soundBinary "samples/0E2.brr" ; FA/7E9A
      aSoundSample0E3 .soundBinary "samples/0E3.brr" ; FA/89DA
      aSoundSample0E4 .soundBinary "samples/0E4.brr" ; FA/8F7A
      aSoundSample0E5 .soundBinary "samples/0E5.brr" ; FA/951A
      aSoundSample0E6 .soundBinary "samples/0E6.brr" ; FA/9E1A
      aSoundSample0E7 .soundBinary "samples/0E7.brr" ; FA/A10E
      aSoundSample0E8 .soundBinary "samples/0E8.brr" ; FA/A7CE
      aSoundSample0E9 .soundBinary "samples/0E9.brr" ; FA/AC4E
      aSoundSample0EA .soundBinary "samples/0EA.brr" ; FA/B236
      aSoundSample0EB .soundBinary "samples/0EB.brr" ; FA/BB36
      aSoundSample0EC .soundBinary "samples/0EC.brr" ; FA/C436
      aSoundSample0ED .soundBinary "samples/0ED.brr" ; FA/DB8E
      aSoundSample0EE .soundBinary "samples/0EE.brr" ; FA/F32E
      aSoundSample0EF .soundBinary "samples/0EF.brr" ; FA/F95E
      aSoundSample0F0 .soundBinary "samples/0F0.brr" ; FB/05C7
      aSoundSample0F1 .soundBinary "samples/0F1.brr" ; FB/15BD
      aSoundSample0F2 .soundBinary "samples/0F2.brr" ; FB/1B5D
      aSoundSample0F3 .soundBinary "samples/0F3.brr" ; FB/245D
      aSoundSample0F4 .soundBinary "samples/0F4.brr" ; FB/41E5
      aSoundSample0F5 .soundBinary "samples/0F5.brr" ; FB/485D
      aSoundSample0F6 .soundBinary "samples/0F6.brr" ; FB/5A5D
      aSoundSample0F7 .soundBinary "samples/0F7.brr" ; FB/67DD
      aSoundSample0F8 .soundBinary "samples/0F8.brr" ; FB/6DC5
      aSoundSample0F9 .soundBinary "samples/0F9.brr" ; FB/7B45
      aSoundSample0FA .soundBinary "samples/0FA.brr" ; FB/9468
      aSoundSample0FB .soundBinary "samples/0FB.brr" ; FB/99AE
      aSoundSample0FC .soundBinary "samples/0FC.brr" ; FB/9D4D
      aSoundSample0FD .soundBinary "samples/0FD.brr" ; FB/A33E
      aSoundSample0FE .soundBinary "samples/0FE.brr" ; FB/B0BE
      aSoundSample0FF .soundBinary "samples/0FF.brr" ; FB/B4C9
      aSoundSample100 .soundBinary "samples/100.brr" ; FB/BCF1
      aSoundSample101 .soundBinary "samples/101.brr" ; FB/BF70
      aSoundSample102 .soundBinary "samples/102.brr" ; FB/C27F
      aSoundSample103 .soundBinary "samples/103.brr" ; FB/C7D7
      aSoundSample104 .soundBinary "samples/104.brr" ; FB/D506
      aSoundSample105 .soundBinary "samples/105.brr" ; FB/DE06
      aSoundSample106 .soundBinary "samples/106.brr" ; FB/E45A
      aSoundSample107 .soundBinary "samples/107.brr" ; FC/004D
      aSoundSample108 .soundBinary "samples/108.brr" ; FC/0125
      aSoundSample109 .soundBinary "samples/109.brr" ; FC/1472
      aSoundSample10A .soundBinary "samples/10A.brr" ; FC/21C5
      aSoundSample10B .soundBinary "samples/10B.brr" ; FC/243B
      aSoundSample10C .soundBinary "samples/10C.brr" ; FC/2F7B
      aSoundSample10D .soundBinary "samples/10D.brr" ; FC/375B
      aSoundSample10E .soundBinary "samples/10E.brr" ; FC/405B
      aSoundSample10F .soundBinary "samples/10F.brr" ; FC/472D
      aSoundSample110 .soundBinary "samples/110.brr" ; FC/4F0D
      aSoundSample111 .soundBinary "samples/111.brr" ; FC/56ED
      aSoundSample112 .soundBinary "samples/112.brr" ; FC/82DF
      aSoundSample113 .soundBinary "samples/113.brr" ; FC/8D8F
      aSoundSample114 .soundBinary "samples/114.brr" ; FC/91C7
      aSoundSample115 .soundBinary "samples/115.brr" ; FC/9353
      aSoundSample116 .soundBinary "samples/116.brr" ; FC/96B3
      aSoundSample117 .soundBinary "samples/117.brr" ; FC/A93A
      aSoundSample118 .soundBinary "samples/118.brr" ; FC/B23A
      aSoundSample119 .soundBinary "samples/119.brr" ; FC/BFBA
      aSoundSample11A .soundBinary "samples/11A.brr" ; FC/C67A
      aSoundSample11B .soundBinary "samples/11B.brr" ; FC/D844
      aSoundSample11C .soundBinary "samples/11C.brr" ; FC/DCC4
      aSoundSample11D .soundBinary "samples/11D.brr" ; FC/E798
      aSoundPadFCE8AF ; FC/E8AF, no chunk starts here
        ; Sent to the APU as the high byte of aSoundSample11D's last word: uploads go by words.
        .byte $00
      aSoundSample11E .soundBinary "samples/11E.brr" ; FC/E8B0
      aSoundSample11F .soundBinary "samples/11F.brr" ; FD/001A
      aSoundSample120 .soundBinary "samples/120.brr" ; FD/01CA
      aSoundSample121 .soundBinary "samples/121.brr" ; FD/088A
      aSoundSample122 .soundBinary "samples/122.brr" ; FD/0ACA
      aSoundSample123 .soundBinary "samples/123.brr" ; FD/36CE
      aSoundSample124 .soundBinary "samples/124.brr" ; FD/3C53
      aSoundSample125 .soundBinary "samples/125.brr" ; FD/400D
      aSoundSample126 .soundBinary "samples/126.brr" ; FD/632C
      aSoundSample127 .soundBinary "samples/127.brr" ; FD/6B0C
      aSoundSample128 .soundBinary "samples/128.brr" ; FD/6F0E
      aSoundSample129 .soundBinary "samples/129.brr" ; FD/7C4F
      aSoundSample12A .soundBinary "samples/12A.brr" ; FD/881F
      aSoundSample12B .soundBinary "samples/12B.brr" ; FD/938C
      aSoundSample12C .soundBinary "samples/12C.brr" ; FD/9DAC
      aSoundSample12D .soundBinary "samples/12D.brr" ; FD/A4FC
      aSoundSample12E .soundBinary "samples/12E.brr" ; FD/B0F0
      aSoundSample12F .soundBinary "samples/12F.brr" ; FD/B43E
      aSoundSample130 .soundBinary "samples/130.brr" ; FD/B9BA
      aSoundSample131 .soundBinary "samples/131.brr" ; FD/BFC6
      aSoundSample132 .soundBinary "samples/132.brr" ; FD/C3DA
      aSoundSample133 .soundBinary "samples/133.brr" ; FD/C85A
      aSoundSample134 .soundBinary "samples/134.brr" ; FD/CEAE
      aSoundSample135 .soundBinary "samples/135.brr" ; FD/D6CD
      aSoundSample136 .soundBinary "samples/136.brr" ; FD/E966
      aSoundSample137 .soundBinary "samples/137.brr" ; FD/F2ED
      aSoundSample138 .soundBinary "samples/138.brr" ; FD/FBC9
      aSoundSample139 .soundBinary "samples/139.brr" ; FD/FE6C
      aSoundSample13A .soundBinary "samples/13A.brr" ; FE/0001
      aSoundSample13B .soundBinary "samples/13B.brr" ; FE/08C2
      aSoundSample13C .soundBinary "samples/13C.brr" ; FE/0CA0
      aSoundSample13D .soundBinary "samples/13D.brr" ; FE/1BAC
      aSoundSample13E .soundBinary "samples/13E.brr" ; FE/2893
      aSoundSample13F .soundBinary "samples/13F.brr" ; FE/3103
      aSoundSample140 .soundBinary "samples/140.brr" ; FE/3802
      aSoundSample141 .soundBinary "samples/141.brr" ; FE/4246
      aSoundSample142 .soundBinary "samples/142.brr" ; FE/4594
      aSoundSample143 .soundBinary "samples/143.brr" ; FE/5650
      aSoundSample144 .soundBinary "samples/144.brr" ; FE/6190
      aSoundSample145 .soundBinary "samples/145.brr" ; FE/6610
      aSoundInstruments146 .soundBinary "instruments/146.bin" ; FE/7810
      aSoundDirectory147 .soundBinary "directories/147.bin" ; FE/7846
      aSoundInstruments148 .soundBinary "instruments/148.bin" ; FE/785A
      aSoundDirectory149 .soundBinary "directories/149.bin" ; FE/78AE
      aSoundInstruments14A .soundBinary "instruments/14A.bin" ; FE/78D6
      aSoundDirectory14B .soundBinary "directories/14B.bin" ; FE/7924
      aSoundInstruments14C .soundBinary "instruments/14C.bin" ; FE/794C
      aSoundDirectory14D .soundBinary "directories/14D.bin" ; FE/798E
      aSoundInstruments14E .soundBinary "instruments/14E.bin" ; FE/79AE
      aSoundDirectory14F .soundBinary "directories/14F.bin" ; FE/79DE
      aSoundInstruments150 .soundBinary "instruments/150.bin" ; FE/79F6
      aSoundDirectory151 .soundBinary "directories/151.bin" ; FE/7A20
      aSoundInstruments152 .soundBinary "instruments/152.bin" ; FE/7A38
      aSoundDirectory153 .soundBinary "directories/153.bin" ; FE/7A7A
      aSoundInstruments154 .soundBinary "instruments/154.bin" ; FE/7AA6
      aSoundDirectory155 .soundBinary "directories/155.bin" ; FE/7AC4
      aSoundInstruments156 .soundBinary "instruments/156.bin" ; FE/7AD8
      aSoundDirectory157 .soundBinary "directories/157.bin" ; FE/7B0E
      aSoundInstruments158 .soundBinary "instruments/158.bin" ; FE/7B2A
      aSoundDirectory159 .soundBinary "directories/159.bin" ; FE/7B54
      aSoundInstruments15A .soundBinary "instruments/15A.bin" ; FE/7B70
      aSoundDirectory15B .soundBinary "directories/15B.bin" ; FE/7BB8
      aSoundInstruments15C .soundBinary "instruments/15C.bin" ; FE/7BD8
      aSoundDirectory15D .soundBinary "directories/15D.bin" ; FE/7C38
      aSoundInstruments15E .soundBinary "instruments/15E.bin" ; FE/7C60
      aSoundDirectory15F .soundBinary "directories/15F.bin" ; FE/7C9C
      aSoundInstruments160 .soundBinary "instruments/160.bin" ; FE/7CB8
      aSoundDirectory161 .soundBinary "directories/161.bin" ; FE/7CDC
      aSoundInstruments162 .soundBinary "instruments/162.bin" ; FE/7CF0
      aSoundDirectory163 .soundBinary "directories/163.bin" ; FE/7D1A
      aSoundInstruments164 .soundBinary "instruments/164.bin" ; FE/7D36
      aSoundDirectory165 .soundBinary "directories/165.bin" ; FE/7D60
      aSoundInstruments166 .soundBinary "instruments/166.bin" ; FE/7D78
      aSoundDirectory167 .soundBinary "directories/167.bin" ; FE/7DA8
      aSoundInstruments168 .soundBinary "instruments/168.bin" ; FE/7DBC
      aSoundDirectory169 .soundBinary "directories/169.bin" ; FE/7DE6
      aSoundInstruments16A .soundBinary "instruments/16A.bin" ; FE/7DFE
      aSoundDirectory16B .soundBinary "directories/16B.bin" ; FE/7E28
      aSoundInstruments16C .soundBinary "instruments/16C.bin" ; FE/7E40
      aSoundDirectory16D .soundBinary "directories/16D.bin" ; FE/7E64
      aSoundInstruments16E .soundBinary "instruments/16E.bin" ; FE/7E78
      aSoundDirectory16F .soundBinary "directories/16F.bin" ; FE/7EAE
      aSoundInstruments170 .soundBinary "instruments/170.bin" ; FE/7ECE
      aSoundDirectory171 .soundBinary "directories/171.bin" ; FE/7EEC
      aSoundInstruments172 .soundBinary "instruments/172.bin" ; FE/7F00
      aSoundDirectory173 .soundBinary "directories/173.bin" ; FE/7F36
      aSoundInstruments174 .soundBinary "instruments/174.bin" ; FE/7F4E
      aSoundDirectory175 .soundBinary "directories/175.bin" ; FE/7F72
      aSoundInstruments176 .soundBinary "instruments/176.bin" ; FE/7F86
      aSoundDirectory177 .soundBinary "directories/177.bin" ; FE/7FB6
      aSoundInstruments178 .soundBinary "instruments/178.bin" ; FE/7FCE
      aSoundDirectory179 .soundBinary "directories/179.bin" ; FE/7FF2
      aSoundInstruments17A .soundBinary "instruments/17A.bin" ; FE/800A
      aSoundDirectory17B .soundBinary "directories/17B.bin" ; FE/8040
      aSoundInstruments17C .soundBinary "instruments/17C.bin" ; FE/8060
      aSoundDirectory17D .soundBinary "directories/17D.bin" ; FE/8078
      aSoundInstruments17E .soundBinary "instruments/17E.bin" ; FE/8088
      aSoundDirectory17F .soundBinary "directories/17F.bin" ; FE/80B8
      aSoundInstruments180 .soundBinary "instruments/180.bin" ; FE/80D4
      aSoundDirectory181 .soundBinary "directories/181.bin" ; FE/810A
      aSoundInstruments182 .soundBinary "instruments/182.bin" ; FE/8112
      aSoundDirectory183 .soundBinary "directories/183.bin" ; FE/8160
      aSoundInstruments184 .soundBinary "instruments/184.bin" ; FE/8178
      aSoundDirectory185 .soundBinary "directories/185.bin" ; FE/81A8
      aSoundInstruments186 .soundBinary "instruments/186.bin" ; FE/81C4
      aSoundDirectory187 .soundBinary "directories/187.bin" ; FE/81D0
      aSoundInstruments188 .soundBinary "instruments/188.bin" ; FE/81D8
      aSoundDirectory189 .soundBinary "directories/189.bin" ; FE/81F0
      aSoundInstruments18A .soundBinary "instruments/18A.bin" ; FE/8200
      aSoundDirectory18B .soundBinary "directories/18B.bin" ; FE/8230
      aSoundInstruments18C .soundBinary "instruments/18C.bin" ; FE/8250
      aSoundDirectory18D .soundBinary "directories/18D.bin" ; FE/8292
      aSoundInstruments18E .soundBinary "instruments/18E.bin" ; FE/82B6
      aSoundDirectory18F .soundBinary "directories/18F.bin" ; FE/82C8
      aSoundInstruments190 .soundBinary "instruments/190.bin" ; FE/82D4
      aSoundDirectory191 .soundBinary "directories/191.bin" ; FE/82DA
      aSoundInstruments192 .soundBinary "instruments/192.bin" ; FE/82DE
      aSoundDirectory193 .soundBinary "directories/193.bin" ; FE/82F0
      aSoundInstruments194 .soundBinary "instruments/194.bin" ; FE/82FC
      aSoundDirectory195 .soundBinary "directories/195.bin" ; FE/8338
      aSoundInstruments196 .soundBinary "instruments/196.bin" ; FE/835C
      aSoundDirectory197 .soundBinary "directories/197.bin" ; FE/836E
      aSoundInstruments198 .soundBinary "instruments/198.bin" ; FE/8376
      aSoundDirectory199 .soundBinary "directories/199.bin" ; FE/839A
      aSoundInstruments19A .soundBinary "instruments/19A.bin" ; FE/83B2
      aSoundDirectory19B .soundBinary "directories/19B.bin" ; FE/83D0
      aSoundInstruments19C .soundBinary "instruments/19C.bin" ; FE/83E4
      aSoundDirectory19D .soundBinary "directories/19D.bin" ; FE/83FC
      aSoundInstruments19E .soundBinary "instruments/19E.bin" ; FE/8408
      aSoundDirectory19F .soundBinary "directories/19F.bin" ; FE/842C
      aSoundInstruments1A0 .soundBinary "instruments/1A0.bin" ; FE/8444
      aSoundDirectory1A1 .soundBinary "directories/1A1.bin" ; FE/8468
      aSoundInstruments1A2 .soundBinary "instruments/1A2.bin" ; FE/847C
      aSoundDirectory1A3 .soundBinary "directories/1A3.bin" ; FE/84A0
      aSoundInstruments1A4 .soundBinary "instruments/1A4.bin" ; FE/84B4
      aSoundDirectory1A5 .soundBinary "directories/1A5.bin" ; FE/84D2
      aSoundInstruments1A6 .soundBinary "instruments/1A6.bin" ; FE/84E2
      aSoundDirectory1A7 .soundBinary "directories/1A7.bin" ; FE/8500
      aSoundInstruments1A8 .soundBinary "instruments/1A8.bin" ; FE/8514
      aSoundDirectory1A9 .soundBinary "directories/1A9.bin" ; FE/8532
      aSoundInstruments1AA .soundBinary "instruments/1AA.bin" ; FE/8542
      aSoundDirectory1AB .soundBinary "directories/1AB.bin" ; FE/854E
      aSoundInstruments1AC .soundBinary "instruments/1AC.bin" ; FE/8556
      aSoundDirectory1AD .soundBinary "directories/1AD.bin" ; FE/85AA
      aSoundInstruments1AE .soundBinary "instruments/1AE.bin" ; FE/85C2
      aSoundDirectory1AF .soundBinary "directories/1AF.bin" ; FE/8610
      aSoundInstruments1B0 .soundBinary "instruments/1B0.bin" ; FE/862C
      aSoundDirectory1B1 .soundBinary "directories/1B1.bin" ; FE/8686
      aSoundInstruments1B2 .soundBinary "instruments/1B2.bin" ; FE/86A6
      aSoundDirectory1B3 .soundBinary "directories/1B3.bin" ; FE/8712
      aSoundInstruments1B4 .soundBinary "instruments/1B4.bin" ; FE/8736
      aSoundDirectory1B5 .soundBinary "directories/1B5.bin" ; FE/87A2
      aSoundInstruments1B6 .soundBinary "instruments/1B6.bin" ; FE/87CE
      aSoundDirectory1B7 .soundBinary "directories/1B7.bin" ; FE/8816
      aSoundInstruments1B8 .soundBinary "instruments/1B8.bin" ; FE/8822
      aSoundDirectory1B9 .soundBinary "directories/1B9.bin" ; FE/8852
      aSoundInstruments1BA .soundBinary "instruments/1BA.bin" ; FE/886E
      aSoundDirectory1BB .soundBinary "directories/1BB.bin" ; FE/889E
      aSoundInstruments1BC .soundBinary "instruments/1BC.bin" ; FE/88BA
      aSoundDirectory1BD .soundBinary "directories/1BD.bin" ; FE/88DE
      aSoundInstruments1BE .soundBinary "instruments/1BE.bin" ; FE/88F2
      aSoundDirectory1BF .soundBinary "directories/1BF.bin" ; FE/891C
      aSoundInstruments1C0 .soundBinary "instruments/1C0.bin" ; FE/8934
      aSoundDirectory1C1 .soundBinary "directories/1C1.bin" ; FE/8958
      aSoundInstruments1C2 .soundBinary "instruments/1C2.bin" ; FE/896C
      aSoundDirectory1C3 .soundBinary "directories/1C3.bin" ; FE/8984
      aSoundInstruments1C4 .soundBinary "instruments/1C4.bin" ; FE/8994
      aSoundDirectory1C5 .soundBinary "directories/1C5.bin" ; FE/89B2
      aSoundInstruments1C6 .soundBinary "instruments/1C6.bin" ; FE/89C6
      aSoundDirectory1C7 .soundBinary "directories/1C7.bin" ; FE/89DE
      aSoundInstruments1C8 .soundBinary "instruments/1C8.bin" ; FE/89EA
      aSoundDirectory1C9 .soundBinary "directories/1C9.bin" ; FE/89FC
      aSoundInstruments1CA .soundBinary "instruments/1CA.bin" ; FE/8A08
      aSoundDirectory1CB .soundBinary "directories/1CB.bin" ; FE/8A2C
      aSoundInstruments1CC .soundBinary "instruments/1CC.bin" ; FE/8A40
      aSoundDirectory1CD .soundBinary "directories/1CD.bin" ; FE/8A70
      aSoundInstruments1CE .soundBinary "instruments/1CE.bin" ; FE/8A8C
      aSoundDirectory1CF .soundBinary "directories/1CF.bin" ; FE/8AB6
      aSoundInstruments1D0 .soundBinary "instruments/1D0.bin" ; FE/8AC6
      aSoundDirectory1D1 .soundBinary "directories/1D1.bin" ; FE/8ADE
      aSoundInstruments1D2 .soundBinary "instruments/1D2.bin" ; FE/8AEE
      aSoundDirectory1D3 .soundBinary "directories/1D3.bin" ; FE/8B24
      aSoundInstruments1D4 .soundBinary "instruments/1D4.bin" ; FE/8B48
      aSoundDirectory1D5 .soundBinary "directories/1D5.bin" ; FE/8B60
      aSoundInstruments1D6 .soundBinary "instruments/1D6.bin" ; FE/8B70
      aSoundDirectory1D7 .soundBinary "directories/1D7.bin" ; FE/8B8E
      aSoundInstruments1D8 .soundBinary "instruments/1D8.bin" ; FE/8B96
      aSoundDirectory1D9 .soundBinary "directories/1D9.bin" ; FE/8BB4
      aSoundInstruments1DA .soundBinary "instruments/1DA.bin" ; FE/8BC8
      aSoundDirectory1DB .soundBinary "directories/1DB.bin" ; FE/8BDA
      aSoundInstruments1DC .soundBinary "instruments/1DC.bin" ; FE/8BE6
      aSoundDirectory1DD .soundBinary "directories/1DD.bin" ; FE/8BFE
      aSoundInstruments1DE .soundBinary "instruments/1DE.bin" ; FE/8C0E
      aSoundDirectory1DF .soundBinary "directories/1DF.bin" ; FE/8C2C
      aSoundInstruments1E0 .soundBinary "instruments/1E0.bin" ; FE/8C40
      aSoundDirectory1E1 .soundBinary "directories/1E1.bin" ; FE/8C58
      aSoundInstruments1E2 .soundBinary "instruments/1E2.bin" ; FE/8C64
      aSoundDirectory1E3 .soundBinary "directories/1E3.bin" ; FE/8C70
      aSoundInstruments1E4 .soundBinary "instruments/1E4.bin" ; FE/8C78
      aSoundDirectory1E5 .soundBinary "directories/1E5.bin" ; FE/8C8A
      aSoundInstruments1E6 .soundBinary "instruments/1E6.bin" ; FE/8C96
      aSoundDirectory1E7 .soundBinary "directories/1E7.bin" ; FE/8CB4
      aSoundInstruments1E8 .soundBinary "instruments/1E8.bin" ; FE/8CC8
      aSoundDirectory1E9 .soundBinary "directories/1E9.bin" ; FE/8CF2
      aSoundInstruments1EA .soundBinary "instruments/1EA.bin" ; FE/8D0A
      aSoundDirectory1EB .soundBinary "directories/1EB.bin" ; FE/8D2E
      aSoundInstruments1EC .soundBinary "instruments/1EC.bin" ; FE/8D42
      aSoundDirectory1ED .soundBinary "directories/1ED.bin" ; FE/8D5A
      aSoundInstruments1EE .soundBinary "instruments/1EE.bin" ; FE/8D6A
      aSoundDirectory1EF .soundBinary "directories/1EF.bin" ; FE/8D7C
      aSoundInstruments1F0 .soundBinary "instruments/1F0.bin" ; FE/8D88
      aSoundDirectory1F1 .soundBinary "directories/1F1.bin" ; FE/8DB8
      aSoundInstruments1F2 .soundBinary "instruments/1F2.bin" ; FE/8DCC
      aSoundDirectory1F3 .soundBinary "directories/1F3.bin" ; FE/8DEA
      aSoundInstruments1F4 .soundBinary "instruments/1F4.bin" ; FE/8DFA
      aSoundDirectory1F5 .soundBinary "directories/1F5.bin" ; FE/8E0C
      aSoundInstruments1F6 .soundBinary "instruments/1F6.bin" ; FE/8E18
      aSoundDirectory1F7 .soundBinary "directories/1F7.bin" ; FE/8E2A
      aSoundInstruments1F8 .soundBinary "instruments/1F8.bin" ; FE/8E36
      aSoundDirectory1F9 .soundBinary "directories/1F9.bin" ; FE/8E4E
      aSoundInstruments1FA .soundBinary "instruments/1FA.bin" ; FE/8E5E
      aSoundDirectory1FB .soundBinary "directories/1FB.bin" ; FE/8E76
      aSoundInstruments1FC .soundBinary "instruments/1FC.bin" ; FE/8E86
      aSoundDirectory1FD .soundBinary "directories/1FD.bin" ; FE/8E9E
      aSoundInstruments1FE .soundBinary "instruments/1FE.bin" ; FE/8EAE
      aSoundDirectory1FF .soundBinary "directories/1FF.bin" ; FE/8ED2
      aSoundInstruments200 .soundBinary "instruments/200.bin" ; FE/8EE6
      aSoundDirectory201 .soundBinary "directories/201.bin" ; FE/8EF8
      aSoundInstruments202 .soundBinary "instruments/202.bin" ; FE/8F04
      aSoundDirectory203 .soundBinary "directories/203.bin" ; FE/8F28
      aSoundInstruments204 .soundBinary "instruments/204.bin" ; FE/8F3C
      aSoundDirectory205 .soundBinary "directories/205.bin" ; FE/8F5A
      aSoundInstruments206 .soundBinary "instruments/206.bin" ; FE/8F6E
      aSoundDirectory207 .soundBinary "directories/207.bin" ; FE/8F86
      aSoundInstruments208 .soundBinary "instruments/208.bin" ; FE/8F96
      aSoundDirectory209 .soundBinary "directories/209.bin" ; FE/8FC6
      aSoundInstruments20A .soundBinary "instruments/20A.bin" ; FE/8FE2
      aSoundDirectory20B .soundBinary "directories/20B.bin" ; FE/9000
      aSoundInstruments20C .soundBinary "instruments/20C.bin" ; FE/9010
      aSoundDirectory20D .soundBinary "directories/20D.bin" ; FE/902E
      aSoundInstruments20E .soundBinary "instruments/20E.bin" ; FE/9042
      aSoundDirectory20F .soundBinary "directories/20F.bin" ; FE/905A
      aSoundInstruments210 .soundBinary "instruments/210.bin" ; FE/906A
      aSoundDirectory211 .soundBinary "directories/211.bin" ; FE/9088
      aSoundInstruments212 .soundBinary "instruments/212.bin" ; FE/909C
      aSoundDirectory213 .soundBinary "directories/213.bin" ; FE/90BA
      aSoundInstruments214 .soundBinary "instruments/214.bin" ; FE/90C6
      aSoundDirectory215 .soundBinary "directories/215.bin" ; FE/90D2
      aSoundInstruments216 .soundBinary "instruments/216.bin" ; FE/90DA
      aSoundDirectory217 .soundBinary "directories/217.bin" ; FE/9104
      aSoundInstruments218 .soundBinary "instruments/218.bin" ; FE/911C
      aSoundDirectory219 .soundBinary "directories/219.bin" ; FE/9140
      aSoundInstruments21A .soundBinary "instruments/21A.bin" ; FE/9154
      aSoundDirectory21B .soundBinary "directories/21B.bin" ; FE/916C
      aSoundInstruments21C .soundBinary "instruments/21C.bin" ; FE/917C
      aSoundDirectory21D .soundBinary "directories/21D.bin" ; FE/919A
      aSoundInstruments21E .soundBinary "instruments/21E.bin" ; FE/91AE
      aSoundDirectory21F .soundBinary "directories/21F.bin" ; FE/91D8
      aSoundInstruments220 .soundBinary "instruments/220.bin" ; FE/91F4
      aSoundDirectory221 .soundBinary "directories/221.bin" ; FE/9212
      aSoundInstruments222 .soundBinary "instruments/222.bin" ; FE/9222
      aSoundDirectory223 .soundBinary "directories/223.bin" ; FE/924C
      aSoundInstruments224 .soundBinary "instruments/224.bin" ; FE/9260
      aSoundDirectory225 .soundBinary "directories/225.bin" ; FE/9266
      aSoundInstruments226 .soundBinary "instruments/226.bin" ; FE/926A
      aSoundDirectory227 .soundBinary "directories/227.bin" ; FE/9270
      aSoundInstruments228 .soundBinary "instruments/228.bin" ; FE/9274
      aSoundDirectory229 .soundBinary "directories/229.bin" ; FE/9298
      aSoundInstruments22A .soundBinary "instruments/22A.bin" ; FE/92B0
      aSoundDirectory22B .soundBinary "directories/22B.bin" ; FE/92BC
      aSoundChunk22C .soundBinary "chunks/22C.bin" ; FE/92C4
      aSoundDirectory22D .soundBinary "directories/22D.bin" ; FE/92D0
      aSoundSample22E .soundBinary "samples/22E.brr" ; FE/92D8
      aSoundChunk22F .soundBinary "chunks/22F.bin" ; FE/99BC
      aSoundDirectory230 .soundBinary "directories/230.bin" ; FE/99C8
      aSoundChunk232 .soundBinary "chunks/232.bin" ; FE/99D0
      aSoundDirectory233 .soundBinary "directories/233.bin" ; FE/99D6
      aSoundSample234 .soundBinary "samples/234.brr" ; FE/99DA
      aSoundChunk235 .soundBinary "chunks/235.bin" ; FE/A4B7
      aSoundDirectory236 .soundBinary "directories/236.bin" ; FE/A4BD
      aSoundChunk238 .soundBinary "chunks/238.bin" ; FE/A4C1
      aSoundDirectory239 .soundBinary "directories/239.bin" ; FE/A4C7
      aSoundSample23A .soundBinary "samples/23A.brr" ; FE/A4CB
      aSoundChunk23B .soundBinary "chunks/23B.bin" ; FE/A9F6
      aSoundDirectory23C .soundBinary "directories/23C.bin" ; FE/A9FC
      aSoundChunk23E .soundBinary "chunks/23E.bin" ; FE/AA00
      aSoundDirectory23F .soundBinary "directories/23F.bin" ; FE/AA0C
      aSoundSample240 .soundBinary "samples/240.brr" ; FE/AA14
      aSoundChunk241 .soundBinary "chunks/241.bin" ; FE/B779
      aSoundDirectory242 .soundBinary "directories/242.bin" ; FE/B785
      aSoundChunk244 .soundBinary "chunks/244.bin" ; FE/B78D
      aSoundDirectory245 .soundBinary "directories/245.bin" ; FE/B793
      aSoundSample246 .soundBinary "samples/246.brr" ; FE/B797
      aSoundChunk247 .soundBinary "chunks/247.bin" ; FE/C379
      aSoundDirectory248 .soundBinary "directories/248.bin" ; FE/C37F
      aSoundChunk24A .soundBinary "chunks/24A.bin" ; FE/C383
      aSoundDirectory24B .soundBinary "directories/24B.bin" ; FE/C389
      aSoundSample24C .soundBinary "samples/24C.brr" ; FE/C38D
      aSoundChunk24D .soundBinary "chunks/24D.bin" ; FE/CE46
      aSoundDirectory24E .soundBinary "directories/24E.bin" ; FE/CE4C
      aSoundChunk250 .soundBinary "chunks/250.bin" ; FE/CE50
      aSoundDirectory251 .soundBinary "directories/251.bin" ; FE/CE56
      aSoundSample252 .soundBinary "samples/252.brr" ; FE/CE5A
      aSoundChunk253 .soundBinary "chunks/253.bin" ; FE/D5AA
      aSoundDirectory254 .soundBinary "directories/254.bin" ; FE/D5B0
      aSoundChunk256 .soundBinary "chunks/256.bin" ; FE/D5B4
      aSoundDirectory257 .soundBinary "directories/257.bin" ; FE/D5BA
      aSoundSample258 .soundBinary "samples/258.brr" ; FE/D5BE
      aSoundChunk259 .soundBinary "chunks/259.bin" ; FE/E0FE
      aSoundDirectory25A .soundBinary "directories/25A.bin" ; FE/E104
      aSoundChunk25C .soundBinary "chunks/25C.bin" ; FE/E108
      aSoundDirectory25D .soundBinary "directories/25D.bin" ; FE/E10E
      aSoundSample25E .soundBinary "samples/25E.brr" ; FE/E112
      aSoundChunk25F .soundBinary "chunks/25F.bin" ; FE/E7AE
      aSoundDirectory260 .soundBinary "directories/260.bin" ; FE/E7B4
      aSoundChunk262 .soundBinary "chunks/262.bin" ; FE/E7B8
      aSoundDirectory263 .soundBinary "directories/263.bin" ; FE/E7BE
      aSoundSample264 .soundBinary "samples/264.brr" ; FE/E7C2
      aSoundChunk265 .soundBinary "chunks/265.bin" ; FE/F2F0
      aSoundDirectory266 .soundBinary "directories/266.bin" ; FE/F2F6
      aSoundChunk268 .soundBinary "chunks/268.bin" ; FE/F2FA
      aSoundDirectory269 .soundBinary "directories/269.bin" ; FE/F300
      aSoundSample26A .soundBinary "samples/26A.brr" ; FE/F304
      aSoundChunk26B .soundBinary "chunks/26B.bin" ; FE/FCAF
      aSoundDirectory26C .soundBinary "directories/26C.bin" ; FE/FCB5
      aSoundPadFEFCB9 ; FE/FCB9, nothing points here
        .byte $00
      aSoundChunk26E .soundBinary "chunks/26E.bin" ; FE/FCBA
      aSoundDirectory26F .soundBinary "directories/26F.bin" ; FE/FCC0
      aSoundSample270 .soundBinary "samples/270.brr" ; FE/FCC4
      aSoundChunk271 .soundBinary "chunks/271.bin" ; FF/07D7
      aSoundDirectory272 .soundBinary "directories/272.bin" ; FF/07DD
      aSoundChunk274 .soundBinary "chunks/274.bin" ; FF/07E1
      aSoundDirectory275 .soundBinary "directories/275.bin" ; FF/07E7
      aSoundSample276 .soundBinary "samples/276.brr" ; FF/07EB
      aSoundChunk277 .soundBinary "chunks/277.bin" ; FF/1373
      aSoundDirectory278 .soundBinary "directories/278.bin" ; FF/1379
      aSoundChunk27A .soundBinary "chunks/27A.bin" ; FF/137D
      aSoundDirectory27B .soundBinary "directories/27B.bin" ; FF/1383
      aSoundSample27C .soundBinary "samples/27C.brr" ; FF/1387
      aSoundChunk27D .soundBinary "chunks/27D.bin" ; FF/2119
      aSoundDirectory27E .soundBinary "directories/27E.bin" ; FF/211F
      aSoundChunk280 .soundBinary "chunks/280.bin" ; FF/2123
      aSoundDirectory281 .soundBinary "directories/281.bin" ; FF/2129
      aSoundSample282 .soundBinary "samples/282.brr" ; FF/212D
      aSoundChunk283 .soundBinary "chunks/283.bin" ; FF/27D2
      aSoundDirectory284 .soundBinary "directories/284.bin" ; FF/27D8
      aSoundChunk286 .soundBinary "chunks/286.bin" ; FF/27DC
      aSoundDirectory287 .soundBinary "directories/287.bin" ; FF/27E2
      aSoundSample288 .soundBinary "samples/288.brr" ; FF/27E6
      aSoundChunk289 .soundBinary "chunks/289.bin" ; FF/3326
      aSoundDirectory28A .soundBinary "directories/28A.bin" ; FF/332C
      aSoundChunk28C .soundBinary "chunks/28C.bin" ; FF/3330
      aSoundDirectory28D .soundBinary "directories/28D.bin" ; FF/3336
      aSoundSample28E .soundBinary "samples/28E.brr" ; FF/333A
      aSoundChunk28F .soundBinary "chunks/28F.bin" ; FF/3D99
      aSoundDirectory290 .soundBinary "directories/290.bin" ; FF/3D9F
      aSoundChunk292 .soundBinary "chunks/292.bin" ; FF/3DA3
      aSoundDirectory293 .soundBinary "directories/293.bin" ; FF/3DA9
      aSoundSample294 .soundBinary "samples/294.brr" ; FF/3DAD
      aSoundChunk295 .soundBinary "chunks/295.bin" ; FF/45DE
      aSoundDirectory296 .soundBinary "directories/296.bin" ; FF/45E4
      aSoundChunk298 .soundBinary "chunks/298.bin" ; FF/45E8
      aSoundDirectory299 .soundBinary "directories/299.bin" ; FF/45EE
      aSoundSample29A .soundBinary "samples/29A.brr" ; FF/45F2
      aSoundChunk29B .soundBinary "chunks/29B.bin" ; FF/4BFE
      aSoundDirectory29C .soundBinary "directories/29C.bin" ; FF/4C04
      aSoundChunk29E .soundBinary "chunks/29E.bin" ; FF/4C08
      aSoundDirectory29F .soundBinary "directories/29F.bin" ; FF/4C0E
      aSoundSample2A0 .soundBinary "samples/2A0.brr" ; FF/4C12
      aSoundChunk2A1 .soundBinary "chunks/2A1.bin" ; FF/51B2
      aSoundDirectory2A2 .soundBinary "directories/2A2.bin" ; FF/51B8
      aSoundChunk2A4 .soundBinary "chunks/2A4.bin" ; FF/51BC
      aSoundDirectory2A5 .soundBinary "directories/2A5.bin" ; FF/51C2
      aSoundSample2A6 .soundBinary "samples/2A6.brr" ; FF/51C6
      aSoundChunk2A7 .soundBinary "chunks/2A7.bin" ; FF/5541
      aSoundDirectory2A8 .soundBinary "directories/2A8.bin" ; FF/5547
      aSoundChunk2AA .soundBinary "chunks/2AA.bin" ; FF/554B
      aSoundDirectory2AB .soundBinary "directories/2AB.bin" ; FF/5551
      aSoundSample2AC .soundBinary "samples/2AC.brr" ; FF/5555
      aSoundChunk2AD .soundBinary "chunks/2AD.bin" ; FF/5825
      aSoundDirectory2AE .soundBinary "directories/2AE.bin" ; FF/582B
      aSoundChunk2B0 .soundBinary "chunks/2B0.bin" ; FF/582F
      aSoundDirectory2B1 .soundBinary "directories/2B1.bin" ; FF/5835
      aSoundSample2B2 .soundBinary "samples/2B2.brr" ; FF/5839
      aSoundChunk2B3 .soundBinary "chunks/2B3.bin" ; FF/5B99
      aSoundDirectory2B4 .soundBinary "directories/2B4.bin" ; FF/5B9F
      aSoundChunk2B6 .soundBinary "chunks/2B6.bin" ; FF/5BA3
      aSoundDirectory2B7 .soundBinary "directories/2B7.bin" ; FF/5BA9
      aSoundSample2B8 .soundBinary "samples/2B8.brr" ; FF/5BAD
      aSoundChunk2B9 .soundBinary "chunks/2B9.bin" ; FF/5F0D
      aSoundDirectory2BA .soundBinary "directories/2BA.bin" ; FF/5F13
      aSoundChunk2BC .soundBinary "chunks/2BC.bin" ; FF/5F17
      aSoundDirectory2BD .soundBinary "directories/2BD.bin" ; FF/5F1D
      aSoundSample2BE .soundBinary "samples/2BE.brr" ; FF/5F21
      aSoundChunk2BF .soundBinary "chunks/2BF.bin" ; FF/6266
      aSoundDirectory2C0 .soundBinary "directories/2C0.bin" ; FF/626C
      aSoundChunk2C2 .soundBinary "chunks/2C2.bin" ; FF/6270
      aSoundDirectory2C3 .soundBinary "directories/2C3.bin" ; FF/6276
      aSoundSample2C4 .soundBinary "samples/2C4.brr" ; FF/627A
      aSoundChunk2C5 .soundBinary "chunks/2C5.bin" ; FF/6526
      aSoundDirectory2C6 .soundBinary "directories/2C6.bin" ; FF/652C
      aSoundChunk2C8 .soundBinary "chunks/2C8.bin" ; FF/6530
      aSoundDirectory2C9 .soundBinary "directories/2C9.bin" ; FF/6536
      aSoundSample2CA .soundBinary "samples/2CA.brr" ; FF/653A
      aSoundChunk2CB .soundBinary "chunks/2CB.bin" ; FF/68B5
      aSoundDirectory2CC .soundBinary "directories/2CC.bin" ; FF/68BB
      aSoundChunk2CE .soundBinary "chunks/2CE.bin" ; FF/68BF
      aSoundDirectory2CF .soundBinary "directories/2CF.bin" ; FF/68C5
      aSoundSample2D0 .soundBinary "samples/2D0.brr" ; FF/68C9
      aSoundChunk2D1 .soundBinary "chunks/2D1.bin" ; FF/6C44
      aSoundDirectory2D2 .soundBinary "directories/2D2.bin" ; FF/6C4A
      aSoundChunk2D4 .soundBinary "chunks/2D4.bin" ; FF/6C4E
      aSoundDirectory2D5 .soundBinary "directories/2D5.bin" ; FF/6C54
      aSoundSample2D6 .soundBinary "samples/2D6.brr" ; FF/6C58
      aSoundChunk2D7 .soundBinary "chunks/2D7.bin" ; FF/6FD3
      aSoundDirectory2D8 .soundBinary "directories/2D8.bin" ; FF/6FD9
      aSoundChunk2DA .soundBinary "chunks/2DA.bin" ; FF/6FDD
      aSoundDirectory2DB .soundBinary "directories/2DB.bin" ; FF/6FE3
      aSoundSample2DC .soundBinary "samples/2DC.brr" ; FF/6FE7
      aSoundChunk2DD .soundBinary "chunks/2DD.bin" ; FF/7362
      aSoundDirectory2DE .soundBinary "directories/2DE.bin" ; FF/7368
      aSoundChunk2E0 .soundBinary "chunks/2E0.bin" ; FF/736C
      aSoundDirectory2E1 .soundBinary "directories/2E1.bin" ; FF/7372
      aSoundSample2E2 .soundBinary "samples/2E2.brr" ; FF/7376
      aSoundChunk2E3 .soundBinary "chunks/2E3.bin" ; FF/7646
      aSoundDirectory2E4 .soundBinary "directories/2E4.bin" ; FF/764C
      aSoundChunk2E6 .soundBinary "chunks/2E6.bin" ; FF/7650
      aSoundDirectory2E7 .soundBinary "directories/2E7.bin" ; FF/7656
      aSoundSample2E8 .soundBinary "samples/2E8.brr" ; FF/765A
      aSoundChunk2E9 .soundBinary "chunks/2E9.bin" ; FF/79D5
      aSoundDirectory2EA .soundBinary "directories/2EA.bin" ; FF/79DB
      aSoundChunk2EC .soundBinary "chunks/2EC.bin" ; FF/79DF
      aSoundDirectory2ED .soundBinary "directories/2ED.bin" ; FF/79E5
      aSoundSample2EE .soundBinary "samples/2EE.brr" ; FF/79E9
      aSoundChunk2EF .soundBinary "chunks/2EF.bin" ; FF/7D49
      aSoundDirectory2F0 .soundBinary "directories/2F0.bin" ; FF/7D4F
      aSoundChunk2F2 .soundBinary "chunks/2F2.bin" ; FF/7D53
      aSoundDirectory2F3 .soundBinary "directories/2F3.bin" ; FF/7D59
      aSoundSample2F4 .soundBinary "samples/2F4.brr" ; FF/7D5D
      aSoundChunk2F5 .soundBinary "chunks/2F5.bin" ; FF/80BD
      aSoundDirectory2F6 .soundBinary "directories/2F6.bin" ; FF/80C3
      aSoundChunk2F8 .soundBinary "chunks/2F8.bin" ; FF/80C7
      aSoundDirectory2F9 .soundBinary "directories/2F9.bin" ; FF/80CD
      aSoundSample2FA .soundBinary "samples/2FA.brr" ; FF/80D1
      aSoundChunk2FB .soundBinary "chunks/2FB.bin" ; FF/8443
      aSoundDirectory2FC .soundBinary "directories/2FC.bin" ; FF/8449
      aSoundChunk2FE .soundBinary "chunks/2FE.bin" ; FF/844D
      aSoundDirectory2FF .soundBinary "directories/2FF.bin" ; FF/8453
      aSoundSample300 .soundBinary "samples/300.brr" ; FF/8457
      aSoundChunk301 .soundBinary "chunks/301.bin" ; FF/87D2
      aSoundDirectory302 .soundBinary "directories/302.bin" ; FF/87D8
      aSoundChunk304 .soundBinary "chunks/304.bin" ; FF/87DC
      aSoundDirectory305 .soundBinary "directories/305.bin" ; FF/87E2
      aSoundSample306 .soundBinary "samples/306.brr" ; FF/87E6
      aSoundChunk307 .soundBinary "chunks/307.bin" ; FF/8B61
      aSoundDirectory308 .soundBinary "directories/308.bin" ; FF/8B67
      aSoundChunk30A .soundBinary "chunks/30A.bin" ; FF/8B6B
      aSoundDirectory30B .soundBinary "directories/30B.bin" ; FF/8B71
      aSoundSample30C .soundBinary "samples/30C.brr" ; FF/8B75
      aSoundChunk30D .soundBinary "chunks/30D.bin" ; FF/8D25
      aSoundDirectory30E .soundBinary "directories/30E.bin" ; FF/8D2B
      aSoundChunk310 .soundBinary "chunks/310.bin" ; FF/8D2F
      aSoundDirectory311 .soundBinary "directories/311.bin" ; FF/8D35
      aSoundSample312 .soundBinary "samples/312.brr" ; FF/8D39
      aSoundChunk313 .soundBinary "chunks/313.bin" ; FF/9099
      aSoundDirectory314 .soundBinary "directories/314.bin" ; FF/909F
      aSoundChunk316 .soundBinary "chunks/316.bin" ; FF/90A3
      aSoundDirectory317 .soundBinary "directories/317.bin" ; FF/90A9
      aSoundSample318 .soundBinary "samples/318.brr" ; FF/90AD
      aSoundChunk319 .soundBinary "chunks/319.bin" ; FF/9311
      aSoundDirectory31A .soundBinary "directories/31A.bin" ; FF/9317
      aSoundChunk31C .soundBinary "chunks/31C.bin" ; FF/931B
      aSoundDirectory31D .soundBinary "directories/31D.bin" ; FF/9321
      aSoundSample31E .soundBinary "samples/31E.brr" ; FF/9325
      aSoundChunk31F .soundBinary "chunks/31F.bin" ; FF/9685
      aSoundDirectory320 .soundBinary "directories/320.bin" ; FF/968B
      aSoundChunk322 .soundBinary "chunks/322.bin" ; FF/968F
      aSoundDirectory323 .soundBinary "directories/323.bin" ; FF/9695
      aSoundSample324 .soundBinary "samples/324.brr" ; FF/9699
      aSoundChunk325 .soundBinary "chunks/325.bin" ; FF/998D
      aSoundDirectory326 .soundBinary "directories/326.bin" ; FF/9993
      aSoundInstruments328 .soundBinary "instruments/328.bin" ; FF/9997
      aSoundDirectory329 .soundBinary "directories/329.bin" ; FF/99FD
      aSoundSample32A .soundBinary "samples/32A.brr" ; FF/9A41
      aSoundInstruments32B .soundBinary "instruments/32B.bin" ; FF/B3E2
      aSoundDirectory32C .soundBinary "directories/32C.bin" ; FF/B43C
      aSoundSample32D .soundBinary "samples/32D.brr" ; FF/B478
      aSoundInstruments32E .soundBinary "instruments/32E.bin" ; FF/DCCB
      aSoundDirectory32F .soundBinary "directories/32F.bin" ; FF/DCD1
      aSoundSample330 .soundBinary "samples/330.brr" ; FF/DCD5
      aSoundInstruments331 .soundBinary "instruments/331.bin" ; FF/DD77
      aSoundDirectory332 .soundBinary "directories/332.bin" ; FF/DD89
      aSoundSample333 .soundBinary "samples/333.brr" ; FF/DD95
      aSoundInstruments334 .soundBinary "instruments/334.bin" ; FF/E3CE
      aSoundDirectory335 .soundBinary "directories/335.bin" ; FF/E3D4
      aSoundSample336 .soundBinary "samples/336.brr" ; FF/E3D8

      ; $FFFE63 to the end of the ROM: free

    .endsection SoundDataSection
