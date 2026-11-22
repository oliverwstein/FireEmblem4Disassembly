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
        tsb wBaseSceneFlags,b
        lda #$0002
        tsb wBaseSceneFlags,b
        lda #$0004
        tsb wBaseSceneFlags,b
        lda #$0008
        tsb wBaseSceneFlags,b
        lda #$0000
        sta wBaseSceneArgument,b
        jsl rlUnknown88B3AF
        lda #$0002
        sta wCastleScreenHandler,b
        lda #$0003
        sta wBaseSceneMode,b
        lda #$0001
        sta wCastleReturnEventFlag,b
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


    .section Unsorted8CED4FSection

      .al
      .xl

      rlUnknown8CED4F ; 8C/ED4F

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8C
        lda wBaseSceneLeftUnitRAMPointer,b
        sta aDialogue.wUnit1,b
        sec
        sbc #$0001
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l aUnknown8CEEE8+1,x
        sta lR18+1
        lda @l aUnknown8CEEE8,x
        sta lR18
        inc x
        inc x
        inc x
        lda @l aUnknown8CEEE8,x
        sec
        sbc lR18
        sta wR0
        lda #$7F00
        sta lR19+1
        lda #$8183
        sta lR19
        jsl rlUnknown8CF06A
        lda #$7F00
        sta lR18+1
        lda #$8183
        sta lR18
        lda wBaseSceneRightUnitRAMPointer,b
        sta aDialogue.wUnit2,b
        sec
        sbc #$0001
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l aUnknown8CEFA8+1,x
        sta lR19+1
        lda @l aUnknown8CEFA8,x
        sta lR19
        inc x
        inc x
        inc x
        lda @l aUnknown8CEFA8,x
        sec
        sbc lR19
        sta wR0
        jsl rlUnknown8CF07F
        lda #$7F00
        sta lBaseSceneDialoguePointer+1,b
        lda #$8183
        sta lBaseSceneDialoguePointer,b
        rtl

        .databank 0

        ; 8C/EDD0

    .endsection Unsorted8CED4FSection


    .section Unsorted8CEDD0Section

      .al
      .xl

      rlUnknown8CEDD0 ; 8C/EDD0

        .al
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        sta wTempVariable1,b
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
        lda wTempVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        clc
        rtl

        +
        sta wBaseSceneRightUnitRAMPointer,b
        lda wTempVariable1,b
        sta wSelectedUnitDataRAMPointer,b

        ; Get lover target CharacterID
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wBaseSceneRightUnitRAMPointer,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wBaseSceneRightUnitRAMPointer,b

        ; Get own CharacterID
        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wBaseSceneLeftUnitRAMPointer,b

        lda wBaseSceneLeftUnitRAMPointer,b
        sec
        sbc #1
        asl a
        tax
        lda aUnknown8CEE6A,x
        cmp #$FFFF
        beq +

          sta wTempVariable2,b
          jsl rlCheckPermanentEventFlagSet
          bcs _CLC

            lda wTempVariable2,b
            jsl rlSetPermanentEventFlag
            bra _EE64

        +
        lda wBaseSceneRightUnitRAMPointer,b
        sec
        sbc #1
        asl a
        tax
        lda aUnknown8CEE6A,x
        cmp #$FFFF
        beq _EE64

          sta wTempVariable2,b
          jsl rlCheckPermanentEventFlagSet
          bcs _CLC

            lda wTempVariable2,b
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


    .section Data8CEEE8Section

      .al
      .xl

      aUnknown8CEEE8 ; 8C/EEE8

        ; Read by rlUnknown8CED4F.

        .word $F0F1, $028C, $8CF1, $F11A, $318C, $8CF1, $F14D, $688C
        .word $8CF1, $F186, $A28C, $8CF1, $F1BB, $CC8C, $8CF1, $F1EA
        .word $018C, $8CF2, $F21F, $388C, $8CF2, $F253, $848C, $8CF2
        .word $F29E, $BB8C, $8CF2, $F2D2, $ED8C, $8CF2, $F30E, $3D8C
        .word $8CF3, $F361, $7B8C, $8CF3, $F391, $AD8C, $8CF3, $F3BE
        .word $DC8C, $8CF3, $F3F6, $1A8C, $8CF4, $F438, $568C, $8CF4
        .word $F469, $878C, $8CF4, $F49C, $BB8C, $8CF4, $F4CF, $E48C
        .word $8CF4, $F4FB, $108C, $8CF5, $F545, $6E8C, $8CF5, $F595
        .word $AF8C, $8CF5, $F5CE, $FD8C, $8CF5, $F626, $518C, $8CF6
        .word $F671, $948C, $8CF6, $F6B2, $CC8C, $8CF6, $F6EA, $FD8C
        .word $8CF6, $F71B, $3A8C, $8CF7, $F750, $868C, $8CF7, $F7AE
        .word $D58C, $8CF7, $F804, $2D8C, $8CF8, $F858, $788C, $8CF8

        ; 8C/EFA8

      aUnknown8CEFA8 ; 8C/EFA8

        ; Read by rlUnknown8CED4F.

        .word $F878, $918C, $8CF8, $F8A9, $BF8C, $8CF8, $F8D5, $EF8C
        .word $8CF8, $F908, $328C, $8CF9, $F954, $6C8C, $8CF9, $F981
        .word $9A8C, $8CF9, $F9CA, $E18C, $8CF9, $F9F8, $1A8C, $8CFA
        .word $FA2D, $428C, $8CFA, $FA5E, $7E8C, $8CFA, $FA98, $BC8C
        .word $8CFA, $FAE1, $008C, $8CFB, $FB18, $358C, $8CFB, $FB4A
        .word $688C, $8CFB, $FB75, $968C, $8CFB, $FBB5, $DC8C, $8CFB
        .word $FBF5, $0B8C, $8CFC, $FC35, $498C, $8CFC, $FC70, $8F8C
        .word $8CFC, $FCAA, $CC8C, $8CFC, $FCF6, $118C, $8CFD, $FD29
        .word $4A8C, $8CFD, $FD66, $8A8C, $8CFD, $FDB5, $D68C, $8CFD
        .word $FDFA, $158C, $8CFE, $FE33, $408C, $8CFE, $FE66, $7F8C
        .word $8CFE, $FE95, $A98C, $8CFE, $FEC4, $EE8C, $8CFE, $FF09
        .word $218C, $8CFF, $FF45, $708C, $8CFF, $FF91, $B58C, $8CFF
        .word $20C2

        ; 8C/F06A

    .endsection Data8CEEE8Section


    .section Unsorted8CF06ASection

      .al
      .xl

      rlUnknown8CF06A ; 8C/F06A

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0000

        _F06D
        lda [lR18],y
        sta [lR19],y
        inc y
        cpy wR0
        bne _F06D
        lda lR19+1
        sta lR18+1
        lda lR19
        sta lR18
        rtl

        .databank 0

        ; 8C/F07F

      rlUnknown8CF07F ; 8C/F07F

        .al
        .xl
        .autsiz
        .databank ?

        tya
        dec a
        dec a
        clc
        adc lR18
        sta lR20
        lda lR18+1
        adc #$0000
        sta lR20+1
        ldy #$0000

        _F091
        lda [lR19],y
        sta [lR20],y
        inc y
        cpy wR0
        bne _F091
        rtl

        .databank 0

        ; 8C/F09B

    .endsection Unsorted8CF06ASection
