; SNES HiROM cartridge header, extended header, and native/emulation interrupt vectors.


    .section SNESHeaderSection

      .al
      .xl

      .enc "proc"

      aSNESExtendedHeader ; 80/FFB0
        .text "01A32J"
        .fill 10, 0

      aSNESHeader ; 80/FFC0
        .text "FIREEMBLEM4          "
        .byte $31                 ; HiROM, FastROM
        .byte $02                 ; ROM + SRAM + Battery
        .byte $0C                 ; 4MB ROM
        .byte $03                 ; 8KB SRAM
        .byte $00                 ; Japan
        .byte $33                 ; Extended header
        .byte $00                 ; Version 0
        .word $7B6A               ; Checksum complement
        .word $8495               ; Checksum

      aSNESNativeVectors ; 80/FFE0
        .word $8000, $8000, $8000, $8000
        .word $8000, <>rlVBlank, $8000, <>rlIRQ

      aSNESEmulationVectors ; 80/FFF0
        .word $8000, $8000, $8000, $8000
        .word $8000, $8000, <>rlReset, $8000

      .enc "none"

    .endsection SNESHeaderSection


