; Item RAM data and getters for item properties.

    .section ItemsSection

      .al
      .xl

      rlInitiateItemRAMData ; 87/DF12

        .al
        .autsiz
        .databank ?

        ; lRoutineVariable = PlayerItemTable

        phb
        php

        phk
        plb

        ldx #size(aItemRAMData)-1
        sep #$20
        lda #0
        
          -
          sta aItemRAMData,x
          dec x
          bpl -

        rep #$20

        lda #(`aItemRAMData)<<8
        sta lR18+1
        lda #<>aItemRAMData
        sta lR18
        lda #len(aItemRAMData._Entry)
        sta wR0
        lda #size(aItemRAMData._Entry[0])
        sta wR1
        jsl rlBuildRAMStructHeader

        ldx lRoutineVariable,b

        sep #$20
        lda lRoutineVariable+2,b
        pha
        rep #$20
        plb

          _Loop
          lda #7
          sta wR0
          lda #0
          sta wR1
          lda $0000,b,x
          cmp #$FFFF
          beq +

            and #$00FF
            jsl rlAppendNewItemRAMEntry
            inc x
            bra _Loop

        ; Break Tyrfing from the get go
        +
        lda #PI_Tyrfing
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        bcs +

          lda #0
          jsl rlSetItemRAMStructEntryDurability

        +
        plp
        plb
        rtl

        .databank 0

      rlAppendNewItemRAMEntry ; 87/DF79

        .al
        .autsiz
        .databank ?

        ; A = item ID

        phb
        php

        phk
        plb

        sta $7E2000+structItemRAMEntry.ItemID

        lda wR0
        cmp #5
        beq +

          lda $7E2000+structItemRAMEntry.ItemID
          and #$00FF
          jsl rlGetItemDataROMPointer
          jsl rlGetItemMaxDurability2
          sep #$20
          sta $7E2000+structItemRAMEntry.Durability
          bra ++

        +
        sep #$20
        lda #0
        sta $7E2000+structItemRAMEntry.Durability

        +
        lda wR0
        sta $7E2000+structItemRAMEntry.ItemState
        lda #0
        sta $7E2000+structItemRAMEntry.KillCount
        rep #$20

        lda wR1
        sta $7E2000+structItemRAMEntry.OwnerRAMPointer

        ; Dest
        lda #(`aItemRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aItemRAMData
        sta lStructPointer2,b

        ; source
        lda #(`$7E2000)<<8
        sta lStructPointer1+1,b
        lda #<>$7E2000
        sta lStructPointer1,b

        jsl rlAppendNewStructEntry

        plp
        plb
        rtl

        .databank 0

      rlUnknown87DFDA ; 87/DFDA

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        and #$00FF
        sta wStructIndex,b
        lda #(`aItemRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aItemRAMData
        sta lStructPointer2,b
        lda #(`$87E001)<<8
        sta lStructPointer1+1,b
        lda #<>$87E001
        sta lStructPointer1,b
        jsl $82E85D
        plb
        rtl

        .databank 0

      aUnknown87E001 ; 87/E001

        .byte $FF
        .byte $FF
        .byte $00
        .byte $FF
        .byte $FF
        .byte $FF

      rlUnknown87E007 ; 87/E007

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda #(`aItemRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aItemRAMData
        sta lStructPointer2,b
        jsl rlGetRAMStructCurrentStructCount
        plp
        plb
        rtl

        .databank 0

      rlGetItemRAMStructEntryByPlayerItemIndex ; 87/E01E

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        sta wStructIndex,b

        lda #(`aItemRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aItemRAMData
        sta lStructPointer2,b
        jsl rlGetRAMStructEntryPointerByStructIndex
        bcs +

          lda lStructPointer1,b
          sta wCurrentItemDataRAMPointer,b
          plp
          plb
          clc

          -
          rtl

        +
        stz wCurrentItemDataRAMPointer,b
        plp
        plb
        sec
        bra -

        .databank 0

      rlLoadItemRAMDataByIndex ; 87/E049

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        sta wStructIndex,b
        lda #(`aItemRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aItemRAMData
        sta lStructPointer2,b
        jsl rlLoadRAMStructDataByIndex

        plp
        plb
        rtl

        .databank 0

      rlGetEffectiveItemIDByItemRAMStructEntry ; 87/E063

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataRAMPointer,b
        lda structItemRAMEntry.Durability,b,x
        and #$00FF
        bne +

        jsr rsGetBrokenWeaponID
        bra ++
        
        +
        lda structItemRAMEntry.ItemID,b,x
        and #$00FF

        +
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetItemIDByItemRAMStructEntry ; 87/E088

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataRAMPointer,b
        lda structItemRAMEntry.ItemID,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetEffectiveItemROMPointerByItemRAMStructEntry ; 87/E0A0

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        phx

        ldx wCurrentItemDataRAMPointer,b
        lda structItemRAMEntry.Durability,b,x
        and #$00FF
        bne +

          jsr rsGetBrokenWeaponID
          bra ++

        +
        lda structItemRAMEntry.ItemID,b,x
        and #$00FF
        
        +
        jsl rlGetItemDataROMPointer

        plx

        plp
        plb
        rtl

        .databank 0

      rlGetItemROMPointerByItemRAMStructEntry ; 87/E0C9

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataRAMPointer,b
        lda structItemRAMEntry.ItemID,b,x
        and #$00FF
        jsl rlGetItemDataROMPointer
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetItemCurrentDurability ; 87/E0E5

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataRAMPointer,b
        lda structItemRAMEntry.Durability,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlReduceItemCurrentDurability ; 87/E0FD

        .al
        .autsiz
        .databank ?

        ; Return clc if broken, sec if not

        phb
        phx
        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        ldx wCurrentItemDataRAMPointer,b
        sep #$20
        lda structItemRAMEntry.Durability,b,x
        beq _Broken

        dec a
        sta structItemRAMEntry.Durability,b,x
        bne _Broken

        rep #$20
        sec
        bra +
        
        _Broken
        rep #$20
        clc

        +
        plx
        plb
        rtl

        .databank 0

      rlSetItemRAMStructEntryDurability ; 87/E122

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        pha

        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        ldx wCurrentItemDataRAMPointer,b

        pla
        sep #$20
        sta structItemRAMEntry.Durability,b,x

        plx

        plp
        plb
        rtl

        .databank 0

      rlGetItemRAMKillCountAndCritAbility ; 87/E13D

        .al
        .autsiz
        .databank ?

        ; sec if able to crit due to kills
        ; clc if not
        ; kills in A

        phb
        php

        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataRAMPointer,b
        beq +

        lda structItemRAMEntry.KillCount,b,x
        and #$00FF
        cmp #50
        bcs ++

        +
        plx
        plp
        plb
        clc
        
        -
        rtl
        
        +
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlAddToItemRAMKillCount ; 87/E163

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        pha

        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        ldx wCurrentItemDataRAMPointer,b
        pla
        sep #$20
        clc
        adc structItemRAMEntry.KillCount,b,x
        cmp #100
        bcc +

          lda #100
        
        +
        sta structItemRAMEntry.KillCount,b,x
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetItemRAMStateAndOwner ; 87/E188

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataRAMPointer,b
        lda structItemRAMEntry.ItemState,b,x
        and #$00FF
        sta wR0
        lda structItemRAMEntry.OwnerRAMPointer,b,x
        sta wR1
        plx

        plp
        plb
        rtl

        .databank 0

      rlSetItemRAMStateAndOwner ; 87/E1A7

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataRAMPointer,b
        sep #$20
        lda wR0
        sta structItemRAMEntry.ItemState,b,x
        rep #$20

        lda wR1
        sta structItemRAMEntry.OwnerRAMPointer,b,x

        plx
        plp
        plb
        rtl

        .databank 0

      rlRevertItemAquirement ; 87/E1C7

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemRAMData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataRAMPointer,b
        sep #$20
        lda #ItemStateUnobtained
        sta structItemRAMEntry.ItemState,b,x

        rep #$20
        lda #0
        sta structItemRAMEntry.OwnerRAMPointer,b,x

        lda structItemRAMEntry.ItemID,b,x
        and #$00FF
        jsl rlGetItemDataROMPointer
        jsl rlGetItemMaxDurability2
        sep #$20
        sta structItemRAMEntry.Durability,b,x
        rep #$20
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown87E1FD ; 87/E1FD

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        jsl $87E0C9
        jsl $87E3BE
        sta $14
        cmp #$00FF
        beq _E229

        jsl $87E0E5
        cmp #0
        beq +

        cmp $14
        beq _E229

        jsl $87E230
        asl a
        bra _End
        
        +
        lda #$03E8
        bra _End
        
        _E229
        jsl $87E3D6
        
        _End
        plp
        plb
        rtl

        .databank 0

      rlUnknown87E230 ; 87/E230

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        jsl $87E0C9
        jsl $87E3D6
        lsr a
        sta $14
        jsl $87E0E5
        and #$00FF
        sta $16
        jsl rlUnsignedMultiply16By16
        jsl $87E3BE
        sta $1C
        stz $1E
        jsl $80A1D8
        lda $18
        plp
        plb
        rtl

        .databank 0

      rlUnknown87E25D ; 87/E25D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        jsl $87E0C9
        jsl $87E0E5
        and #$00FF
        sta $0585,b
        jsl $87E3D6
        sta $14
        jsl $87E3BE
        sec
        sbc $0585,b
        sta $16
        jsl rlUnsignedMultiply16By16
        jsl $87E3BE
        sta $1C
        stz $1E
        jsl $80A1D8
        lda $18
        plp
        plb
        rtl

        .databank 0

      rlUnknown87E294 ; 87/E294

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        jsl $87E0C9
        jsl $87E3D6
        sta $1A
        jsl $87E3BE
        sta $1C
        jsl $80A1AB
        lda $1A
        plp
        plb
        rtl

        .databank 0

      rsGetBrokenWeaponID ; 87/E2B1

        .al
        .autsiz
        .databank ?

        phx
        lda structItemRAMEntry.ItemID,b,x
        and #$00FF
        jsl rlGetItemDataROMPointer

        jsl rlGetItemWeaponRank
        inc a
        sta $0585,b

        jsl rlGetItemWeaponType
        asl a
        tax

        lda aBrokenWeaponOffsets,x
        clc
        adc $0585,b
        tax

        lda aBrokenWeaponOffsets,x
        and #$00FF

        plx
        rts

        .databank 0

      aBrokenWeaponOffsets .include "../../data/item/BrokenWeaponOffsets.csv.asm" ; 87/E2DC
      aBrokenWeaponData .binclude "../../data/item/BrokenWeaponData.csv.asm"      ; 87/E2F0

      rlGetItemNamePointerByItemID ; 87/E314

        .al
        .autsiz
        .databank ?

        jsl rlGetItemDataROMPointer
        jsl rlGetItemNamePointer
        rtl

        .databank 0

      rlGetItemDataROMPointer ; 87/E31D

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        cmp #0
        bmi +

          asl a
          clc
          adc aMainDataOffsets.ItemDataOffsets
          tax
          lda aMainDataOffsets,x
          clc
          adc aMainDataOffsets.ItemDataOffsets
          adc #<>aMainDataOffsets
          sta wCurrentItemDataROMPointer,b

          -
          plx
          plp
          plb
          rtl

        +
        stz wCurrentItemDataROMPointer,b
        bra -

        .databank 0

      rlGetItemNamePointer ; 87/E346

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aMainDataOffsets.ItemNameOffsets
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        beq +

          lda structItemROMEntry.Name,b,x
          and #$00FF
          asl a
          clc
          adc aMainDataOffsets.ItemNameOffsets
          tax
          lda #(`aMainDataOffsets)<<8
          sta lRoutineVariable+1,b
          lda aMainDataOffsets,x
          clc
          adc aMainDataOffsets.ItemNameOffsets
          adc #<>aMainDataOffsets
          sta lRoutineVariable,b

          -
          plx
          plp
          plb
          rtl
        
        +
        lda #(`aDummyItemName)<<8
        sta lRoutineVariable+1,b
        lda #<>aDummyItemName
        sta lRoutineVariable,b
        bra -

        .databank 0

      aDummyItemName ; 87/E38A

        .text "　\n"

      rlGetItemEquipmentType ; 87/E38E

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        lda structWeaponStaffROMEntry.EquipmentType,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetItemMaxDurability1 ; 87/E3A6

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        lda structItemROMEntry.Durability,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetItemMaxDurability2 ; 87/E3BE

        .al
        .autsiz
        .databank ?

        ; Identical to the previous one

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        lda structItemROMEntry.Durability,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlUnknown87E3D6 ; 87/E3D6

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #$83
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        lda structWeaponStaffROMEntry.Cost,b,x
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetItemStatBonus ; 87/E3EB

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        beq +

        lda structItemROMEntry.StatBonuses,b,x
        and #$00FF
        
        -
        plx
        plp
        plb
        rtl
        
        +
        lda #0
        bra -

        .databank 0

      rlGetItemStaffEffect ; 87/E40A

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        lda structItemROMEntry.StaffEffect,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetItemWeaponRank ; 87/E422

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        lda structWeaponStaffROMEntry.WeaponRank,b,x
        bit #$0080
        bne +

        and #$007F
        bra ++

        +
        ora #$FF80
        
        +
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetItemSkills ; 87/E444

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        lda structWeaponStaffROMEntry.Skills,b,x
        plx

        plp
        plb
        rtl

        .databank 0

      rlUnknown87E459 ; 87/E459

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #$83
        pha
        rep #$20
        plb

        phx
        ldx $0583,b
        lda $0000,b,x
        and #$00FF
        asl a
        clc
        adc $83800E
        tax
        lda #$8300
        sta lRoutineVariable+1,b
        lda $838000,x
        clc
        adc $83800E
        adc #$8000
        sta lRoutineVariable,b
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetItemWeaponType ; 87/E48D

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        beq +

          lda structItemROMEntry.EquipmentType,b,x
          and #$00FF
          cmp #EquipTypeRing
          bcs +

            lda structWeaponStaffROMEntry.WeaponType,b,x
            and #$00FF

            plx

            plp
            plb
            rtl

        +
        lda #0

        plx

        plp
        plb
        rtl

        .databank 0

      rlGetItemMight ; 87/E4B9

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        beq +

          lda structItemROMEntry.EquipmentType,b,x
          and #$00FF
          cmp #EquipTypeRing
          bcs +

            lda structWeaponStaffROMEntry.Might,b,x
            and #$00FF
            plx
            plp
            plb

            -
            rtl

        +
        lda #0
        plx
        plp
        plb
        bra -

        .databank 0

      rlGetItemAccuracy ; 87/E4E6

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        beq +

        lda structItemROMEntry.EquipmentType,b,x
        and #$00FF
        cmp #EquipTypeRing
        bcs +

        lda structWeaponStaffROMEntry.Accuracy,b,x
        and #$00FF
        plx
        plp
        plb
        
        -
        rtl
        
        +
        lda #0
        plx
        plp
        plb
        bra -

        .databank 0

      rlUnknown87E513 ; 87/E513

        .al
        .autsiz
        .databank ?

        lda #0
        rtl

        .databank 0

      rlGetItemWeight ; 87/E517

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        beq +

        lda structItemROMEntry.EquipmentType,b,x
        and #$00FF
        cmp #2
        bcs +

        lda structWeaponStaffROMEntry.Weight,b,x
        and #$00FF
        plx
        plp
        plb
        rtl

        +
        lda #0
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetItemMinimumRange ; 87/E543

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        beq +

        lda structItemROMEntry.EquipmentType,b,x
        and #$00FF
        cmp #EquipTypeRing
        bcs +

        lda structWeaponStaffROMEntry.MinRange,b,x
        and #$00FF
        plx
        plp
        plb
        rtl
        
        +
        lda #0
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetItemMaximumRange ; 87/E56F

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        beq +

        lda structItemROMEntry.EquipmentType,b,x
        and #$00FF
        cmp #EquipTypeRing
        bcs +

        lda structWeaponStaffROMEntry.MaxRange,b,x
        and #$00FF
        plx
        plp
        plb
        rtl
        
        +
        lda #0
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetItemEffectiveness ; 87/E59B

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        lda structItemROMEntry.EquipmentType,b,x
        and #$00FF
        cmp #EquipTypeRing
        bcs +

        lda structWeaponStaffROMEntry.Effectiveness,b,x
        and #$00FF
        plx
        plp
        plb
        rtl

        +
        lda #0
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown87E5C5 ; 87/E5C5

        .al
        .autsiz
        .databank ?

        ; This routine tries its hardest to be recursive...

        phb
        php
        phk
        plb
        phx
        jsl rlUnknown87E5C5
        ora #0
        beq +

        lda #1

        -
        lsr $0585,b
        bcs +

        inc a
        bra -

        +
        asl a
        tax
        lda #>`aWeaponEffectivenessTextPointers
        sta lRoutineVariable+1,b
        lda aWeaponEffectivenessTextPointers,x
        sta lRoutineVariable,b
        plx
        plp
        plb
        rtl

        .databank 0

      aWeaponEffectivenessTextPointers ; 87/E5F1

        .addr aWeaponEffectivenessNoneText
        .addr aWeaponEffectivenessCavalierText
        .addr aWeaponEffectivenessFlierText
        .addr aWeaponEffectivenessDragonText
        .addr aWeaponEffectivenessKnightText
        .addr aWeaponEffectivenessMageText

      aWeaponEffectivenessNoneText      .text "\n"        ; 87/E5FD
      aWeaponEffectivenessCavalierText  .text "ナイト系\n"  ; 87/E5FF
      aWeaponEffectivenessFlierText     .text "ひこう系\n"  ; 87/E609
      aWeaponEffectivenessDragonText    .text "ドラゴン系\n" ; 87/E613
      aWeaponEffectivenessKnightText    .text "アーマー系\n" ; 87/E61F
      aWeaponEffectivenessMageText      .text "マージ系\n"  ; 87/E62B

      rlGetItemWeaponTraits ; 87/E635

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        lda structItemROMEntry.EquipmentType,b,x
        and #$00FF
        cmp #EquipTypeRing
        bcs +

        lda structWeaponStaffROMEntry.Traits,b,x
        and #$00FF
        plx
        plp
        plb
        rtl
        
        +
        lda #0
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetItemAdditionalInfo ; 87/E65F

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentItemDataROMPointer,b
        lda structItemROMEntry.EquipmentType,b,x
        and #$00FF
        cmp #EquipTypeRing
        bcs +

        lda structWeaponStaffROMEntry.AdditionalInfo,b,x
        and #$00FF
        plx
        plp
        plb
        rtl

        +
        lda #0
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown87E689 ; 87/E689

        .al
        .autsiz
        .databank ?

        pha
        jsl rlGetItemMinimumRange
        sta wR10
        jsl rlGetItemMaximumRange
        sta wR11
        pla

        jsl $848924
        ora #0
        beq +

        sec

        -
        rtl
        
        +
        clc
        bra -

        .databank 0

      rlUnknown87E6A5 ; 87/E6A5

        .al
        .autsiz
        .databank ?

        phx
        jsl rlGetItemStaffEffect
        asl a
        tax
        jsr (aUnknown87E6B1,x)
        plx
        rtl

        .databank 0

      aUnknown87E6B1 ; 87/E6B1

        .word <>$87E6D3
        .word <>$87E6D7
        .word <>$87E6D7
        .word <>$87E6D7
        .word <>$87E6DF
        .word <>$87E6DF
        .word <>$87E6E9
        .word <>$87E6E9
        .word <>$87E6F1
        .word <>$87E6E9
        .word <>$87E6E4
        .word <>$87E705
        .word <>$87E6F6
        .word <>$87E6FB
        .word <>$87E6FB
        .word <>$87E6FB
        .word <>$87E707

        ; 87/E6D3

    .endsection ItemsSection
