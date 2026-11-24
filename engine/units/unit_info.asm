; Getters for a unit's fixed information: class, weapon ranks, terrain costs,
; character, gender, parents, growths, skills, holy blood, enemy data and map sprite.

    .section UnitClassInfoSection

      .al
      .xl

      rlGetSelectedUnitCommanderCharacterID ; 84/9FC4

        .al
        .autsiz
        .databank ?

        ; Returns commander character ID of selected unit, or 0

        phb
        php
        phk
        plb
        phx
        lda wR0
        pha

        jsl rlGetSelectedUnitStates
        bit #UnitStateGroupLeader
        bne _A00E

        jsl rlGetSelectedUnitAI
        sta wR0

        jsl rlGetSelectedUnitFactionSlot
        cmp #0
        beq +

          jsl rlGetFactionGroupLeaderCharacterID
          bra _End

        +
        jsl rlGetSelectedUnitGenerationID
        cmp #1
        beq _A00E

        ldx wSelectedUnitDataRAMPointer,b
        phx

        lda #1
        sta wRoutineVariable1,b

        lda #0
        jsl rlFindGenerationIDInFactionSlotData
        jsl rlGetSelectedUnitCharacterID

        plx
        stx wSelectedUnitDataRAMPointer,b
        bra _End
        
        _A00E
        lda #0

        _End
        plx
        stx wR0
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitPortraitOrCommanderID ; 84/A018

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitCommanderCharacterID
        ora #0
        beq +

        asl a
        ora #1
        bra ++  
        
        +
        jsl rlGetSelectedUnitCharacterID
        asl a
        
        +
        rtl

        .databank 0

      rlGetSelectedUnitClassID ; 84/A02D

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitExtendedPersonalDataPointer

        lda structExtendedCharacterDataRAM.Class,b,x
        and #$00FF

        -
        plx

        plp 
        plb
        rtl
        
        +
        jsl rlGetEnemyUnitClassID
        bra -

        .databank 0

      rlGetClassWeakness ; 84/A055

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitClassID
        tax
        lda aClassWeaknessTable,x
        and #$00FF
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitFactionNamePointer ; 84/A06A

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotNamePointer
        rtl

        .databank 0

      rlGetSelectedUnitClassNamePointer ; 84/A073

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitClassID
        jsl rlGetClassNamePointer
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitClassDataPointer ; 84/A084

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        jsl rlGetSelectedUnitClassID
        jsl rlGetClassDataROMPointer
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitWeaponRank ; 84/A095

        .al
        .autsiz
        .databank ?

        ; A = weapon type

        phb
        php
        phk
        plb
        phx
        phy

        ldx wR34
        phx
        ldx wR35
        phx

        sta wRoutineVariable1,b
        jsl rlGetSelectedUnitClassDataPointer

        lda wRoutineVariable1,b
        jsl rlGetClassWeaponRank
        cmp #WeaponRankNone
        bcs _End

        sta wR35

        ldy #(size(aHolyBloodGrowthBoostsOffsets)/2)-1

        -
        tya
        jsl rlCheckForSpecifiedHolyBlood
        ora #0
        beq _NextBlood

        sta wR34

        tya
        asl a
        tax
        lda aHolyBloodGrowthBoostsOffsets,x
        tax
        lda aHolyBloodGrowthBoostsOffsets,x
        and #$00FF
        cmp wRoutineVariable1,b
        bne _NextBlood

        lda wR34
        cmp #MajorHolyBlood
        bcs _StarRank

        lda wR35
        sec
        sbc wR34
        beq _End
        bpl +

          lda #WeaponRankA
          bra _End
        
        +
        sta wR35
        
        _NextBlood
        dec y
        bpl -

        lda wR35
        
        _End
        plx
        stx wR35
        plx
        stx wR34

        ply
        plx
        plp
        plb
        clc
        
        -
        rtl
        
        _StarRank
        lda #0

        plx
        stx wR35
        plx
        stx wR34
        ply
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlGetSelectedUnitMovementCostPointer ; 84/A111

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassMovementType
        asl a
        clc
        adc aMainDataOffsets.MovementCostOffsets
        tax
        lda aMainDataOffsets,x
        clc
        adc aMainDataOffsets.MovementCostOffsets
        adc #<>aMainDataOffsets
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitTerrainAvoidPointer ; 84/A135

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassTerrainBonusType
        asl a
        clc
        adc aMainDataOffsets.TerrainAvoidOffsets
        tax
        lda aMainDataOffsets,x
        clc
        adc aMainDataOffsets.TerrainAvoidOffsets
        adc #<>aMainDataOffsets
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetTileTerrainAvoid ; 84/A159

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        sta wRoutineVariable1,b

        lda #0
        asl a
        clc
        adc aMainDataOffsets.TerrainAvoidOffsets
        tax
        lda aMainDataOffsets,x
        clc
        adc aMainDataOffsets.TerrainAvoidOffsets
        adc #<>aMainDataOffsets
        clc
        adc wRoutineVariable1,b
        tax
        lda aMainDataOffsets & $FF0000,x
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

      rlSetSelectedUnitClass ; 84/A191

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        pha
        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        pla

        sep #$20
        sta structExtendedCharacterDataRAM.Class,b,x
        rep #$20

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitConstantDataPointer ; 84/A1A7

        .al
        .autsiz
        .databank ?

        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda $7E0000+structCharacterDataRAM.ConstantData+2,x
        pha
        rep #$20
        plb
        lda $7E0000+structCharacterDataRAM.ConstantData,x
        tax
        rtl

        .databank 0

      rlSaveCharacterROMDataToBuffer ; 84/A1BA

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        lda lR18
        pha
        lda lR18+1
        pha

        jsl rlGetSelectedUnitConstantDataPointer

        lda lRAMBufferPointer+1,b
        sta lR18+1
        lda lRAMBufferPointer,b
        sta lR18

        ldy #structCharacterROMDataBuffer.CharacterID
        jsl rlGetSelectedUnitCharacterID
        sta [lR18],y

        ldy #structCharacterROMDataBuffer.CharacterName
        jsl rlGetSelectedUnitNamePointer
        sta [lR18],y

        ldy #structCharacterROMDataBuffer.Gender
        lda structStaticCharacterROMEntry.Gender - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.FatherID
        lda structStaticCharacterROMEntry.FatherID - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.HPGrowth
        lda structStaticCharacterROMEntry.HPGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.StrengthGrowth
        lda structStaticCharacterROMEntry.StrengthGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.MagicGrowth
        lda structStaticCharacterROMEntry.MagicGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.SkillGrowth
        lda structStaticCharacterROMEntry.SkillGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.SpeedGrowth
        lda structStaticCharacterROMEntry.SpeedGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.DefenseGrowth
        lda structStaticCharacterROMEntry.DefenseGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.ResistanceGrowth
        lda structStaticCharacterROMEntry.ResistanceGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.LuckGrowth
        lda structStaticCharacterROMEntry.LuckGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.Skills1
        lda structStaticCharacterROMEntry.Skills1 - structStaticCharacterROMEntry.CharacterID,b,x
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.Skills3
        lda structStaticCharacterROMEntry.Skills3 - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.HolyBlood1
        lda structStaticCharacterROMEntry.HolyBlood1 - structStaticCharacterROMEntry.CharacterID,b,x
        sta [lR18],y
        ldy #structCharacterROMDataBuffer.HolyBlood2
        lda structStaticCharacterROMEntry.HolyBlood2 - structStaticCharacterROMEntry.CharacterID,b,x
        sta [lR18],y

        pla
        sta lR18+1
        pla
        sta lR18
        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/A282

    .endsection UnitClassInfoSection


    .section LoadCharacterROMDataFromBufferSection

      .al
      .xl

      rlLoadCharacterROMDataFromBuffer ; 84/A282

        ; The inverse of rlSaveCharacterROMDataToBuffer: copies the buffer at
        ; lRAMBufferPointer back into the selected unit's constant data. The
        ; buffer word at $04 is its generation ID. Skills are copied as two
        ; overlapping words ($0F and $10).

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        phy
        lda lR18
        pha
        lda lR18+1
        pha
        jsl rlGetSelectedUnitConstantDataPointer
        lda lRAMBufferPointer+1,b
        sta lR18+1
        lda lRAMBufferPointer,b
        sta lR18
        ldy #structCharacterROMDataBuffer.CharacterID
        lda [lR18],y
        sta structCharacterConstantData.CharacterID,b,x
        ldy #structCharacterROMDataBuffer.CharacterName
        lda [lR18],y
        sta structCharacterConstantData.CharacterName,b,x
        sep #$20
        ldy #$0004
        lda [lR18],y
        sta structCharacterConstantData.GenerationID,b,x
        ldy #structCharacterROMDataBuffer.Gender
        lda [lR18],y
        sta structCharacterConstantData.Gender,b,x
        ldy #structCharacterROMDataBuffer.FatherID
        lda [lR18],y
        sta structCharacterConstantData.FatherID,b,x
        ldy #structCharacterROMDataBuffer.HPGrowth
        lda [lR18],y
        sta structCharacterConstantData.HPGrowth,b,x
        ldy #structCharacterROMDataBuffer.StrengthGrowth
        lda [lR18],y
        sta structCharacterConstantData.StrengthGrowth,b,x
        ldy #structCharacterROMDataBuffer.MagicGrowth
        lda [lR18],y
        sta structCharacterConstantData.MagicGrowth,b,x
        ldy #structCharacterROMDataBuffer.SkillGrowth
        lda [lR18],y
        sta structCharacterConstantData.SkillGrowth,b,x
        ldy #structCharacterROMDataBuffer.SpeedGrowth
        lda [lR18],y
        sta structCharacterConstantData.SpeedGrowth,b,x
        ldy #structCharacterROMDataBuffer.DefenseGrowth
        lda [lR18],y
        sta structCharacterConstantData.DefenseGrowth,b,x
        ldy #structCharacterROMDataBuffer.ResistanceGrowth
        lda [lR18],y
        sta structCharacterConstantData.ResistanceGrowth,b,x
        ldy #structCharacterROMDataBuffer.LuckGrowth
        lda [lR18],y
        sta structCharacterConstantData.LuckGrowth,b,x
        rep #$20
        ldy #structCharacterROMDataBuffer.Skills1
        lda [lR18],y
        sta structCharacterConstantData.Skills1,b,x
        ldy #structCharacterROMDataBuffer.Skills2
        lda [lR18],y
        sta structCharacterConstantData.Skills2,b,x
        ldy #structCharacterROMDataBuffer.HolyBlood1
        lda [lR18],y
        sta structCharacterConstantData.HolyBlood1,b,x
        ldy #structCharacterROMDataBuffer.HolyBlood2
        lda [lR18],y
        sta structCharacterConstantData.HolyBlood2,b,x
        pla
        sta lR18+1
        pla
        sta lR18
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/A333

    .endsection LoadCharacterROMDataFromBufferSection


    .section UnitCharacterInfoSection

      .al
      .xl

      rlGetSelectedUnitCharacterID ; 84/A333

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wSelectedUnitDataRAMPointer

        ; Output:
        ; A = CharacterID

        phb
        php

        phk
        plb

        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitConstantDataPointer
        lda structStaticCharacterROMEntry.CharacterID - structStaticCharacterROMEntry.CharacterID,b,x 

        -
        plx

        plp
        plb
        rtl
        
        +
        jsl rlGetEnemyUnitCharacterID
        bra -

        .databank 0

      rlGetSelectedUnitGenerationID ; 84/A358

        .al
        .autsiz
        .databank ?

        ; Regular enemies: get number as is, and set carry
        ; Others: if flag $80 set, and #$7F and like above
        ; no flag $80, get unit dead =sec, if not clc

        phb
        php

        phk
        plb

        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq _Enemy

        jsl rlGetSelectedUnitConstantDataPointer
        lda structStaticCharacterROMEntry.GenerationID - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        bit #$0080
        bne ++

        and #$007F
        tax

        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne +

        txa
        plx
        plp
        plb
        clc

        _End
        rtl

        _Enemy
        jsl rlGetEnemyUnitGenerationID
        plx
        plp
        plb
        sec
        bra _End

        +
        txa

        +
        and #$007F
        plx
        plp
        plb
        sec
        bra _End

        .databank 0

      rlGetSelectedUnitNamePointer ; 84/A3A2

        .al
        .autsiz
        .databank ?

        ; Input:  
        ; filled wSelectedUnitDataRAMPointer

        ; Output: 
        ; lRoutineVariable = name pointer

        phb
        php

        phk
        plb

        phx

        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

          jsl rlGetSelectedUnitConstantDataPointer
          lda structStaticCharacterROMEntry.CharacterName - structStaticCharacterROMEntry.CharacterID,b,x 

          -
          pha

          asl a
          clc
          adc aMainDataOffsets.CharacterNameOffsets
          tax
          lda #(`aMainDataOffsets)<<8
          sta lRoutineVariable+1,b
          lda aMainDataOffsets,x
          clc
          adc aMainDataOffsets.CharacterNameOffsets
          adc #<>aMainDataOffsets
          sta lRoutineVariable,b

          pla
          plx

          plp
          plb
          rtl

        +
        jsl rlGetEnemyUnitNameID
        bra -

        .databank 0

      rlGetSelectedUnitGender ; 84/A3E5

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitConstantDataPointer
        lda structStaticCharacterROMEntry.Gender - structStaticCharacterROMEntry.CharacterID,b,x 
        and #$00FF

        -
        plx

        plp
        plb

        rtl

        +
        jsl rlGetEnemyUnitGender
        bra -

        .databank 0

      rlGetSelectedUnitMotherID ; 84/A40D

        .al
        .autsiz
        .databank ?

        phx
        phy
        jsl rlGetSelectedUnitCharacterID
        sta wRoutineVariable1,b

        lda aChildrenDataOffsets
        tax

        ldy #0
        
        -
        lda aChildrenDataOffsets,x
        cmp wRoutineVariable1,b
        beq _Child

        inc x
        inc x
        inc y
        cpy #size(aChildrenDataOffsets)
        bcc -

        lda #0

        -
        ply
        plx
        rtl

        _Child
        tya
        lsr a
        clc
        adc #Deirdre
        bra -

        .databank 0

      rlGetSelectedUnitFatherID ; 84/A43D

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitConstantDataPointer
        lda structCharacterConstantData.FatherID,b,x
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

      rlGetSelectedUnitTotalHPGrowth ; 84/A464

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        lda #0
        jsl rlGetCharacterHolyBloodGrowthBoost
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitConstantDataPointer

        lda structStaticCharacterROMEntry.HPGrowth - structStaticCharacterROMEntry.CharacterID,b,x 
        and #$00FF
        clc
        adc wRoutineVariable1,b
        jsr rsFloorGrowthAtZero
        plx

        plp
        plb
        rtl

        .databank 0

      rsFloorGrowthAtZero ; 84/A488

        .al
        .autsiz
        .databank ?

        bpl +

          lda #0

        +
        rts

        .databank 0

      rlGetSelectedUnitTotalStrGrowth ; 84/A48E

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        lda #1
        jsl rlGetCharacterHolyBloodGrowthBoost
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitConstantDataPointer

        lda structStaticCharacterROMEntry.StrengthGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        clc
        adc wRoutineVariable1,b
        jsr rsFloorGrowthAtZero
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitTotalMagGrowth ; 84/A4B2

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        lda #2
        jsl rlGetCharacterHolyBloodGrowthBoost
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitConstantDataPointer

        lda structStaticCharacterROMEntry.MagicGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        clc
        adc wRoutineVariable1,b
        jsr rsFloorGrowthAtZero
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitTotalSklGrowth ; 84/A4D6

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        lda #3
        jsl rlGetCharacterHolyBloodGrowthBoost
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitConstantDataPointer

        lda structStaticCharacterROMEntry.SkillGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        clc
        adc wRoutineVariable1,b
        jsr rsFloorGrowthAtZero
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitTotalSpdGrowth ; 84/A4FA

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        lda #4
        jsl rlGetCharacterHolyBloodGrowthBoost
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitConstantDataPointer

        lda structStaticCharacterROMEntry.SpeedGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        clc
        adc wRoutineVariable1,b
        jsr rsFloorGrowthAtZero
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitTotalDefGrowth ; 84/A51E

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        lda #5
        jsl rlGetCharacterHolyBloodGrowthBoost
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitConstantDataPointer

        lda structStaticCharacterROMEntry.DefenseGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        clc
        adc wRoutineVariable1,b
        jsr rsFloorGrowthAtZero
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitTotalResGrowth ; 84/A542

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        lda #6
        jsl rlGetCharacterHolyBloodGrowthBoost
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitConstantDataPointer

        lda structStaticCharacterROMEntry.ResistanceGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        clc
        adc wRoutineVariable1,b
        jsr rsFloorGrowthAtZero
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitTotalLuckGrowth ; 84/A566

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        lda #7
        jsl rlGetCharacterHolyBloodGrowthBoost
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitConstantDataPointer

        lda structStaticCharacterROMEntry.LuckGrowth - structStaticCharacterROMEntry.CharacterID,b,x
        and #$00FF
        clc
        adc wRoutineVariable1,b
        jsr rsFloorGrowthAtZero
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitSkills ; 84/A58A

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitConstantDataPointer
        lda structStaticCharacterROMEntry.Skills1 - structStaticCharacterROMEntry.CharacterID,b,x 
        sta lRoutineVariable,b
        lda structStaticCharacterROMEntry.Skills2 - structStaticCharacterROMEntry.CharacterID,b,x
        sta lRoutineVariable+1,b

        -
        plx
        plp
        plb
        rtl

        +
        lda #0
        sta lRoutineVariable+1,b
        lda #0
        sta lRoutineVariable,b
        bra -

        .databank 0

      rlCheckForSpecifiedHolyBlood ; 84/A5C0

        .al
        .autsiz
        .databank ?

        ; In:
        ; A     = holy blood index
        ; wSelectedUnitDataRAMPointer = unit pointer

        ; Out:
        ; A =
        ;     0 if no blood
        ;     1 if minor
        ;     2 if major

        phb
        php

        phk
        plb

        phx
        phy

        ldx wR0
        phx

        sta wR0
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq _NotPlayable

        jsl rlGetSelectedUnitConstantDataPointer
        txy

        lda wR0
        asl a
        tax

        tya
        clc
        adc aCharacterStructHolyBloodOffsets,x
        tay

        lda aHolyBloodBitfieldTable,x
        lsr a
        ora aHolyBloodBitfieldTable,x
        and $0000,b,y
        beq _End

        cmp aHolyBloodBitfieldTable,x
        bcc +

          lda #2
          bra _End

        +
        lda #1
        bra _End
        
        _End
        plx
        stx wR0

        ply
        plx

        plp
        plb
        rtl

        _NotPlayable
        lda #0
        bra _End

        .databank 0

      aCharacterStructHolyBloodOffsets ; 84/A615

        .word $0012
        .word $0012
        .word $0012
        .word $0012
        .word $0012
        .word $0012
        .word $0012
        .word $0012
        .word $0014
        .word $0014
        .word $0014
        .word $0014
        .word $0014

      aHolyBloodBitfieldTable ; 84/A62F

        .word $0002
        .word $0008
        .word $0020
        .word $0080
        .word $0200
        .word $0800
        .word $2000
        .word $8000
        .word $0002
        .word $0008
        .word $0020
        .word $0080
        .word $0200

      rlGetCharacterHolyBloodGrowthBoost ; 84/A649

        .al
        .autsiz
        .databank ?

        ; In:
        ; A = stat offset, HP = 0, Str = 1, ...

        ; Out:
        ; A = total bonus granted by holy blood

        phb
        php

        phk
        plb

        phx
        phy

        ldx wR0
        phx
        ldx wR1
        phx

        sta wRoutineVariable1,b
        stz wR1
        ldy #(size(aHolyBloodGrowthBoostsOffsets)/2)-1
        
        -
        tya
        jsl rlCheckForSpecifiedHolyBlood
        ora #0
        beq _HolyBloodContinue

        sta wR0

        tya
        asl a
        tax
        lda aHolyBloodGrowthBoostsOffsets,x
        adc wRoutineVariable1,b
        tax
        lda aHolyBloodGrowthBoostsOffsets+2,x
        bit #$0080
        bne +

        and #$007F
        bra ++

        +
        ora #$FF80

        +
        dec wR0
        beq +

          ; Double bonus if major
          asl a
        
        +
        clc
        adc wR1
        sta wR1
        
        _HolyBloodContinue
        dec y
        bpl -

        lda wR1

        plx
        stx wR1
        plx 
        stx wR0

        ply
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetHolyBloodHolyWeaponID ; 84/A69F

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        asl a
        tax
        lda aHolyBloodGrowthBoostsOffsets,x
        tax
        lda aHolyBloodGrowthBoostsOffsets+1,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetWeaponStatBoostForSpecifiedStat ; 84/A6B6

        .al
        .autsiz
        .databank ?

        ; A = stat ID

        phb
        php
        phk
        plb
        phx
        ldx wRoutineVariable1,b
        phx

        dec a
        sta wRoutineVariable1,b

        jsl rlGetActiveWeaponStatBonus
        ora #0
        beq _End

        ; only boost IDs below $0E belong to holy weapons
        cmp #$000E
        bcs +

        dec a
        asl a
        tax
        lda aHolyBloodGrowthBoostsOffsets,x
        clc
        adc wRoutineVariable1,b
        tax
        lda aHolyBloodGrowthBoostsOffsets+structHolyBloodDataEntry.StrBoost,x
        and #$00FF

        _End
        plx
        stx wRoutineVariable1,b
        plx
        plp
        plb
        rtl
        
        +
        lda #0
        bra _End

        .databank 0

      rlGetEnemyUnitConstantDataPointer ; 84/A6F1

        .al
        .autsiz
        .databank ?

        ; Gets the rom pointer + structEnemyCharacterROMEntry.CharacterID

        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda $7E0000+10+2,x
        pha
        rep #$20
        plb
        lda $7E0000+10,x
        tax
        rtl

        .databank 0

      rlGetEnemyUnitCharacterID ; 84/A704

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        jsl rlGetEnemyUnitConstantDataPointer
        lda structEnemyCharacterROMEntry.CharacterID - structEnemyCharacterROMEntry.CharacterID,b,x 
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetEnemyUnitNameID ; 84/A714

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        jsl rlGetEnemyUnitConstantDataPointer
        lda structEnemyCharacterROMEntry.CharacterName - structEnemyCharacterROMEntry.CharacterID,b,x
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetEnemyUnitClassID ; 84/A724

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        jsl rlGetEnemyUnitConstantDataPointer
        lda structEnemyCharacterROMEntry.Class - structEnemyCharacterROMEntry.CharacterID,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetEnemyUnitGender ; 84/A737

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx

        jsl rlGetEnemyUnitConstantDataPointer
        lda structEnemyCharacterROMEntry.Gender - structEnemyCharacterROMEntry.CharacterID,b,x
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

      rlGetEnemyUnitLevel ; 84/A754

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetEnemyUnitConstantDataPointer
        lda structEnemyCharacterROMEntry.Level - structEnemyCharacterROMEntry.CharacterID,b,x
        and #$00FF
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEnemyUnitLeadershipStars ; 84/A767

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetEnemyUnitConstantDataPointer
        lda structEnemyCharacterROMEntry.LeadershipStars - structEnemyCharacterROMEntry.CharacterID,b,x
        and #$00FF
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEnemyUnitGenerationID ; 84/A77A

        .al
        .autsiz
        .databank ?

        ; An enemy's stand-in for a GenerationID: its FactionMemberID,
        ; the unit's number within its faction (1 = leader, $FF = none).
        ; rlFindGenerationIDInFactionSlotData searches by it.

        phb
        php

        phk
        plb

        phx
        jsl rlGetEnemyUnitConstantDataPointer
        lda structEnemyCharacterROMEntry.FactionMemberID - structEnemyCharacterROMEntry.CharacterID,b,x 
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetEnemyClassHPGrowth ; 84/A78D

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassHPGrowth
        rtl

        .databank 0

      rlGetEnemyClassStrGrowth ; 84/A796

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassStrGrowth
        rtl

        .databank 0

      rlGetEnemyClassMagGrowth ; 84/A79F

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassMagGrowth
        rtl

        .databank 0

      rlGetEnemyClassSklGrowth ; 84/A7A8

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassSklGrowth
        rtl

        .databank 0

      rlGetEnemyClassSpdGrowth ; 84/A7B1

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassSpdGrowth
        rtl

        .databank 0

      rlGetEnemyClassDefGrowth ; 84/A7BA

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassDefGrowth
        rtl

        .databank 0

      rlGetEnemyClassResGrowth ; 84/A7C3

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassResGrowth
        rtl

        .databank 0

      rlGetEnemyClassMoney ; 84/A7CC

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.ClassMoney,b,x
        and #$00FF
        phk
        plb
        sep #$20
        sta WRMPYA,b
        lda #100
        sta WRMPYB,b
        nop
        nop
        nop
        rep #$20
        lda RDMPY,b
        plx
        plp
        plb
        rtl

        .databank 0

      rlSetEnemyClassMoney ; 84/A7F3

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        sta WRDIVA,b
        sep #$20
        lda #100
        sta WRDIVB,b
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        rep #$20
        lda RDDIV,b

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        and #$003F
        sep #$20
        sta structPersonalCharacterDataRAM.ClassMoney,b,x
        rep #$20
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitMapSprite ; 84/A822

        .al
        .autsiz
        .databank ?

        ; Input:
        ; Filled wSelectedUnitDataRAMPointer

        ; Output:
        ; A = MapSpriteID

        phb
        php
        phk
        plb
        phx

        lda wR0
        pha
        lda wR1
        pha

        jsl rlGetSelectedUnitGender
        sta wR0
        jsl rlGetSelectedUnitCharacterID
        sta wR1
        jsl rlGetSelectedUnitClassID
        jsr rsGetClassMapSprite

        plx
        stx wR1
        plx
        stx wR0

        plx
        plp
        plb
        rtl

        .databank 0

      rsGetClassMapSprite ; 84/A84A

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = ClassID
        ; wR0 = gender
        ; wR1 = CharacterID

        ; Output:
        ; A = MapSpriteID

        phx
        asl a
        tax
        lda aClassMapSpriteAssignmentOffsets,x
        clc
        adc #<>aClassMapSpriteAssignmentOffsets
        tax
        
        -
        lda $830000 + structClassMapSpriteAssignment.Gender,x
        and #$00FF
        cmp #$00FF
        beq _End

          cmp wR0
          bne +

            lda $830000 + structClassMapSpriteAssignment.CharacterID,x
            beq _End

              cmp wR1
              beq _End

          +
          txa
          clc
          adc #size(structClassMapSpriteAssignment)
          tax
          bra -

        _End
        lda $830000 + structClassMapSpriteAssignment.SpriteID,x
        plx
        rts

        .databank 0

      rlUseInventorySlotItem ; 84/A87E

        .al
        .autsiz

        ; wRoutineVariable1 = inv slot

        phb
        phk
        plb
        phx
        jsl rlGetSelectedUnitFactionSlot
        ora #0
        bne _CLC

          jsl rlGetUnitType
          cmp #UnitTypeHoly
          bcs _CLC

            lda wRoutineVariable1,b
            beq _End

              jsl rlGetItemRAMStructEntryByInventorySlot
              bcs _CLC

                jsl rlReduceItemCurrentDurability
                bcc _End

                  jsl rlGetItemROMPointerByItemRAMStructEntry
                  jsl rlGetItemWeaponType
                  cmp #WeaponTypeFire
                  bcc +

                    lda #0
                    sta wRoutineVariable1,b
                    jsl rlSetSelectedUnitEquippedWeaponBitfield

                  +
                  jsl rlSaveEquippedWeaponStatBonus
                  sec

            _End
            plx
            plb
            rtl
        
        _CLC
        clc
        bra _End

        .databank 0

    .endsection UnitCharacterInfoSection


    .section CheckIfCharacterHasFemaleGenerationIDSection

      .al
      .xl

      rlCheckIfCharacterHasFemaleGenerationID ; 87/F4CF

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = CharacterID

        phb
        phy
        jsl rlSwapToMainDataBank
        jsl rlGetCharacterDataROMPointer
        tay
        lda structCharacterROMEntry.Type,b,y
        and #$00FF
        cmp #UnitTypeStatic
        beq _Static

          cmp #UnitTypeDynamic
          beq _Dynamic

            _CLC
            clc
            bra _End

        _Static
        lda structStaticCharacterROMEntry.GenerationID,b,y
        bra +

        _Dynamic
        lda structDynamicCharacterROMEntry.GenerationID,b,y

        +
        and #$00FF
        cmp #16
        bcc _CLC

        sec

        _End
        ply
        plb
        rtl

        .databank 0

        ; 87/F501

    .endsection CheckIfCharacterHasFemaleGenerationIDSection


    .section CheckIsTalkTargetOfSection

      .al
      .xl

      rlCheckIsTalkTargetOf ; 87/9EE7

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the selected unit's living talk target is the character of the unit in wRoutineVariable1 (a unit RAM pointer).

        phb
        php
        phk
        plb
        .databank $87
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wRoutineVariable1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitLivingTalkTarget
        cmp wRoutineVariable1,b
        bne _9F0D
        plp
        plb
        .databank ?
        sec

        _9F0C
        rtl


        _9F0D
        plp
        plb
        .databank ?
        clc
        bra _9F0C

        .databank 0

        ; 87/9F12

    .endsection CheckIsTalkTargetOfSection


