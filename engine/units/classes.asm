; Class data: promotions, base stats, growths, weapon ranks, movement, terrain bonus,
; money and skills.

    .section ClassDataSection

      .al
      .xl

      rlGetPromotedClassIfAvailable ; 87/A438

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        lda #0
        sta $7E2000

        jsl rlGetSelectedUnitStates
        bit #UnitState1000
        bne _SEC

        jsl rlGetSelectedUnitClassID
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitCharacterID
        dec a
        tax
        lda aPromotionTable,x
        and #$00FF
        cmp #$00FF
        beq _SEC

        cmp wRoutineVariable1,b
        beq _SEC

        jsl rlGetClassDataROMPointer
        jsl rlGetSelectedUnitLevel
        sta wRoutineVariable1,b

        jsl rlGetClassPromotionLevel
        dec a
        cmp wRoutineVariable1,b
        bpl +

          lda aPromotionTable,x
          sta $7E2000+2
          lda #1
          sta $7E2000

        +
        ply
        plx
        plp
        plb
        clc
        
        -
        rtl
        
        _SEC
        ply
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlGetClassDataROMPointer ; 87/A49D

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        asl a
        clc
        adc aMainDataOffsets.ClassDataOffsets
        tax
        lda aMainDataOffsets,x
        clc
        adc aMainDataOffsets.ClassDataOffsets
        adc #<>aMainDataOffsets
        sta wCurrentClassDataROMPointer,b
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassNamePointer ; 87/A4BC

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        asl a
        clc
        adc aMainDataOffsets.ClassNameOffsets
        tax
        lda #(`aMainDataOffsets)<<8
        sta lRoutineVariable+1,b
        lda aMainDataOffsets,x
        clc
        adc aMainDataOffsets.ClassNameOffsets
        adc #<>aMainDataOffsets
        sta lRoutineVariable,b
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetClassPromotionLevel ; 87/A4E1

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.PromotionLevel,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassBaseHP ; 87/A4F9

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.HP,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassStrength ; 87/A511

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Strength,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassMagic ; 87/A529

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Magic,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassSkill ; 87/A541

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Skill,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassSpeed ; 87/A559

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Speed,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassDefense ; 87/A571

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Defense,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassResistance ; 87/A589

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Resistance,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassWeaponRank ; 87/A5A1

        .al
        .autsiz
        .databank ?

        ; A = weapon type

        phb
        php

        phk
        plb

        phx

        pha

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        pla
        clc
        adc wCurrentClassDataROMPointer,b
        tax
        lda structClassROMEntry.WeaponRanks,b,x
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

      rlGetClassHPGrowth ; 87/A5C9

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.HPGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassStrGrowth ; 87/A5E1

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.StrengthGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassMagGrowth ; 87/A5F9

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.MagicGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassSklGrowth ; 87/A611

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.SkillGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassSpdGrowth ; 87/A629

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.SpeedGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassDefGrowth ; 87/A641

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.DefenseGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassResGrowth ; 87/A659

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.ResistanceGrowth,b,x 
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassMovement ; 87/A671

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Movement,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassMovementType ; 87/A689

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.MovementType,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassTerrainBonusType ; 87/A6A1

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.TerrainBonusType,b,x 
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassMoney ; 87/A6B9

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Money,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassSkills ; 87/A6D1

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Skills,b,x
        plx

        plp
        plb
        rtl

        .databank 0

    .endsection ClassDataSection
