; Code from bank $8C not yet assigned to a game system.

    .section Unsorted8CED00Section

      .al
      .xl

      rlUnknown8CED00 ; 8C/ED00

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        tsb $08AD,b
        lda #$0002
        tsb $08AD,b
        lda #$0004
        tsb $08AD,b
        lda #$0008
        tsb $08AD,b
        lda #$0000
        sta $08B6,b
        jsl rlUnknown88B3AF
        lda #$0002
        sta $088B,b
        lda #$0003
        sta $08B8,b
        lda #$0001
        sta $089D,b
        lda #$0002
        sta wScreenFadingProcInput,b
        lda #$B6B6
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8C/ED4F

    .endsection Unsorted8CED00Section


    .section Unsorted8CEDD0Section

      .al
      .xl

      rlUnknown8CEDD0 ; 8C/EDD0

        .al
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        sta $078C,b
        jsl rlGetSelectedUnitLoverGenerationID
        ora #0
        beq _CLC

          jsl rlFindCharacterByGenerationID
          bcs _CLC

            jsl rlGetSelectedUnitCharacterID
            jsl rlUnknown87A040
            bcc _CLC
            bra +

        _CLC
        lda $078C,b
        sta wSelectedUnitDataRAMPointer,b
        clc
        rtl

        +
        sta $08B4,b
        lda $078C,b
        sta wSelectedUnitDataRAMPointer,b

        ; Get lover target CharacterID
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda $08B4,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta $08B4,b

        ; Get own CharacterID
        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta $08B2,b

        lda $08B2,b
        sec
        sbc #1
        asl a
        tax
        lda $8CEE6A,x
        cmp #$FFFF
        beq +

          sta $078E,b
          jsl rlCheckPermanentEventFlagSet
          bcs _CLC

            lda $078E,b
            jsl rlSetPermanentEventFlag
            bra _EE64

        +
        lda $08B4,b
        sec
        sbc #1
        asl a
        tax
        lda $8CEE6A,x
        cmp #$FFFF
        beq _EE64

          sta $078E,b
          jsl rlCheckPermanentEventFlagSet
          bcs _CLC

            lda $078E,b
            jsl rlSetPermanentEventFlag

        _EE64
        jsl rlUnknown8CED00
        sec
        rtl

        .databank 0

      aUnknown8CEE6A ; 8C/EE6A

        ; Holds permanent event flags

        .word $FFFF ; 1 Sigurd
        .word $FFFF ; 2 Naoise
        .word $FFFF ; 3 Alec
        .word $FFFF ; 4 Arden
        .word $FFFF ; 5 Finn
        .word $FFFF ; 6 Quan
        .word $FFFF ; 7 Midir
        .word $FFFF ; 8 Lewyn
        .word $FFFF ; 9 Chulainn
        .word $FFFF ; a Azelle
        .word $FFFF ; b Jamke
        .word $FFFF ; c Claud
        .word $FFFF ; d Beowulf
        .word $FFFF ; e Lex
        .word $FFFF ; F Dew
        .word $0004 ; 10 - Deirdre
        .word $0005 ; 11 - ethlyn
        .word $0006 ; 12 Lachesis
        .word $0007 ; 13 Ayra
        .word $0008 ; 14 Erinys
        .word $0009 ; 15 Tailtiu
        .word $000A ; 16 Silvia
        .word $000B ; 17 Edain
        .word $000C ; 18 Brigid
        .word $FFFF ; Seliph
        .word $FFFF ; Shannan
        .word $FFFF ; Dalvin
        .word $FFFF ; Asaello
        .word $FFFF ; Leif
        .word $FFFF ; Iuchar
        .word $FFFF ; Charlot
        .word $FFFF ; Hawk
        .word $FFFF ; Tristan
        .word $FFFF ; AdultFinn
        .word $FFFF ; Deimne
        .word $FFFF ; Hannibal
        .word $FFFF ; Ares
        .word $FFFF ; Amid
        .word $FFFF ; Oifey
        .word $000D ; Daisy
        .word $000E ; Creidne
        .word $000F ; Muirne
        .word $0010 ; Julia
        .word $0011 ; Altena
        .word $0012 ; Hermina
        .word $0013 ; Linda
        .word $0014 ; Laylea
        .word $0015 ; Jeanne
        .word $FFFF ; Iucharba
        .word $FFFF ; Scathach
        .word $FFFF ; Febail
        .word $FFFF ; Coirpre
        .word $FFFF ; Ced
        .word $FFFF ; Diarmuid
        .word $FFFF ; Lester
        .word $FFFF ; Arthur
        .word $000D ; Patty
        .word $000E ; Larcei
        .word $000F ; Lana
        .word $0012 ; Fee
        .word $0013 ; Tine
        .word $0014 ; Lene
        .word $0015 ; Nanna



; F1 F0 8C 02 F1 8C 1A F1 8C 31 F1 8C 4D F1 8C 68 F1 8C 86 F1 8C A2 F1 8C

    .endsection Unsorted8CEDD0Section
