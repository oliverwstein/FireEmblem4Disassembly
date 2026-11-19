; Checking whether a unit has a skill from their character, class or items, and the
; debug skill list.

    .section SkillsSection

      .al
      .xl

      rlCheckIfUnitHasSpecifiedPersonalOrClassSkill ; 87/A19D

        .al
        .autsiz
        .databank `aValidPersonalSkillTable

        ; A = skill ID

        phb
        php
        phk
        plb
        phx
        ldx wRoutineVariable1,b
        phx

        sta wRoutineVariable1,b

        lda wRoutineVariable1,b
        asl a
        clc
        adc wRoutineVariable1,b
        tax
        jsl rlGetSelectedUnitSkills

        lda lRoutineVariable,b
        bit aValidPersonalSkillTable,x
        bne +

        lda lRoutineVariable+1,b
        bit aValidPersonalSkillTable+1,x
        bne +

        lda wRoutineVariable1,b
        asl a
        tax
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassSkills
        bit aValidClassSkillTable,x
        bne +

        plx
        stx wRoutineVariable1,b
        plx
        plp
        plb
        clc
        rtl

        +
        plx
        stx wRoutineVariable1,b
        plx
        plp
        plb
        sec
        rtl

        .databank 0

      aValidPersonalSkillTable .block ; 87/A1EA

        .long 0                               ; SkillIDDummy
        .long 0                               ; SkillIDCanto
        .long 0                               ; SkillIDPavise
        .long UnitSkill1Wrath
        .long UnitSkill1Pursuit
        .long UnitSkill1Adept
        .long 0                               ; SkillIDSteal
        .long 0                               ; SkillIDUnknown2
        .long 0                               ; SkillIDDance
        .long 0                               ; SkillIDUnknown3
        .long 0                               ; SkillIDUnknown4
        .long UnitSkill1Dismount
        .long UnitSkill1Charm
        .long UnitSkill1PoW
        .long UnitSkill1Nihil
        .long UnitSkill1Miracle
        .long UnitSkill2Critical << 8
        .long UnitSkill2Vantage  << 8
        .long UnitSkill2Accost   << 8
        .long UnitSkill2Astra    << 8
        .long UnitSkill2Luna     << 8
        .long UnitSkill2Sol      << 8
        .long UnitSkill2Holy     << 8
        .long UnitSkill2Darkness << 8
        .long UnitSkill3Renewal  << 16
        .long UnitSkill3Paragon  << 16
        .long UnitSkill3Escape   << 16
        .long UnitSkill3Recover  << 16
        .long UnitSkill3Bargain  << 16
        .long UnitSkill3Return   << 16

      .bend

      aValidClassSkillTable .block ; 87/A244

        .word 0                       ; SkillIDDummy
        .word ClassSkillCanto
        .word ClassSkillPavise
        .word ClassSkillWrath
        .word ClassSkillPursuit
        .word ClassSkillAdept
        .word ClassSkillSteal
        .word ClassSkillUnknown1      ; SkillIDUnknown2
        .word ClassSkillDance
        .word ClassSkillUnknown2      ; SkillIDUnknown3
        .word ClassSkillUnknown3      ; SkillIDUnknown4
        .word ClassSkillDismount
        .word ClassSkillCharm
        .word 0                       ; SkillIDPoW
        .word 0                       ; SkillIDNihil
        .word 0                       ; SkillIDMiracle
        .word ClassSkillCritical
        .word 0                       ; SkillIDVantage
        .word 0                       ; SkillIDAccost
        .word 0                       ; SkillIDAstra
        .word 0                       ; SkillIDLuna
        .word 0                       ; SkillIDSol
        .word 0                       ; SkillIDHoly
        .word 0                       ; SkillIDDarkness
        .word 0                       ; SkillIDRenewal
        .word 0                       ; SkillIDParagon
        .word 0                       ; SkillIDEscape
        .word 0                       ; SkillIDRecover
        .word 0                       ; SkillIDBargain
        .word 0                       ; SkillIDReturn

      .bend

      aValidItemSkillTable .block; 87/A280

        .word 0                 ; SkillIDDummy
        .word ItemSkillCanto
        .word 0                 ; SkillIDPavise
        .word 0                 ; SkillIDWrath
        .word ItemSkillPursuit
        .word 0                 ; SkillIDAdept
        .word ItemSkillSteal
        .word 0                 ; SkillIDUnknown2
        .word 0                 ; SkillIDDance
        .word 0                 ; SkillIDUnknown3
        .word ItemSkillUnknown1 ; SkillIDUnknown4
        .word 0                 ; SkillIDDismount
        .word 0                 ; SkillIDCharm
        .word 0                 ; SkillIDPoW
        .word 0                 ; SkillIDNihil
        .word ItemSkillMiracle
        .word ItemSkillCritical
        .word 0                 ; SkillIDVantage
        .word 0                 ; SkillIDAccost
        .word 0                 ; SkillIDAstra
        .word 0                 ; SkillIDLuna
        .word 0                 ; SkillIDSol
        .word 0                 ; SkillIDHoly
        .word 0                 ; SkillIDDarkness
        .word ItemSkillRenewal
        .word ItemSkillParagon
        .word ItemSkillEscape
        .word ItemSkillRecover
        .word ItemSkillBargain
        .word ItemSkillReturn

      .bend

      rlCheckIfUnitHasSpecifiedPersonalSkill ; 87/A2BC

        .al
        .autsiz
        .databank `aValidPersonalSkillTable

        ; A = skill ID

        phb
        phk
        plb
        phx
        ldx wRoutineVariable1,b
        phx

        sta wRoutineVariable1,b
        lda wRoutineVariable1,b
        asl a
        clc
        adc wRoutineVariable1,b
        tax
        jsl rlGetSelectedUnitSkills

        lda lRoutineVariable,b
        bit aValidPersonalSkillTable,x
        bne +

        lda lRoutineVariable+1,b
        bit aValidPersonalSkillTable+1,x
        bne +

        clc

        -
        plx
        stx wRoutineVariable1,b
        plx
        plb
        rtl
        
        +
        sec
        bra -

        .databank 0

      rlCheckIfInventoryItemsHaveSpecifiedSkill ; 87/A2EF

        .al
        .autsiz
        .databank `aValidItemSkillTable

        phb
        php
        phk
        plb
        phx
        phy

        asl a
        tax
        ldy #1

        -
        tya
        jsl rlGetItemROMDataByInventorySlot

        lda wCurrentItemDataROMPointer,b
        beq _CLC

        jsl rlGetItemEquipmentType
        cmp #EquipTypeWeapon
        bne +

          tya
          jsl rlCheckIfWeaponEquipped
          bcc ++

        +
        jsl rlGetItemSkills
        bit aValidItemSkillTable,x
        bne _SEC

        +
        inc y
        bra -

        _CLC
        ply
        plx
        plp
        plb
        clc
        rtl

        _SEC
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0

      rlDebugGetSkillList ; 87/A32C

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        lda #0
        sta wDebugMenuSkillCounter

        ldx #size(aDebugMenuSkillFlags)-1
        lda #0

        -
        sta aDebugMenuSkillFlags,x
        dec x
        bpl -

        jsr rsDebugGetClassSkills
        jsr rsDebugGetPersonalSkills
        jsr rsDebugGetItemSkills
        plx

        plp
        plb
        rtl

        .databank 0

      rsDebugFlagSkillPossesstion ; 87/A352

        .al
        .autsiz
        .databank ?

        ; wR0 = skill ID

        phx
        ldx wR0
        lda aDebugMenuSkillFlags,x
        and #$00FF
        bne +

          sep #$20
          lda #1
          sta aDebugMenuSkillFlags,x
          rep #$20

          lda wDebugMenuSkillCounter
          inc a
          sta wDebugMenuSkillCounter

        +
        plx
        rts

        .databank 0

      rsDebugGetClassSkills ; 87/A373

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassSkills
        ora #0
        beq _End

          sta wR1

          lda #size(aDebugMenuSkillFlags)-1
          sta wR0

          ldx #size(aValidClassSkillTable)-2

          -
          lda aValidClassSkillTable,x
          bit wR1
          beq +

            jsr rsDebugFlagSkillPossesstion

          +
          dec wR0
          dec x
          dec x
          bpl -

        _End
        rts

        .databank 0

      rsDebugGetPersonalSkills ; 87/A39C

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitSkills

        ; ora all skills together to see if we have minimum 1

        lda lRoutineVariable,b
        ora lRoutineVariable+1,b
        beq _End

          lda #size(aDebugMenuSkillFlags)-1
          sta wR0

          ldx #size(aValidPersonalSkillTable)-3

          -
          lda aValidPersonalSkillTable,x
          bit lRoutineVariable,b
          bne +

          lda aValidPersonalSkillTable+1,x
          bit lRoutineVariable+1,b
          beq ++

            +
            jsr rsDebugFlagSkillPossesstion
          
          +
          dec wR0
          dec x
          dec x
          dec x
          bpl -
        
        _End
        rts

        .databank 0

      rsDebugGetItemSkills ; 87/A3CD

        .al
        .autsiz
        .databank ?

        ldx #1
        
        _Loop
        txa
        jsl rlGetItemROMDataByInventorySlot

        lda wCurrentItemDataROMPointer
        beq _End

          jsl rlGetItemEquipmentType
          cmp #EquipTypeWeapon
          bne +

            tya
            jsl rlCheckIfWeaponEquipped
            bcc _A411
          
          +
          jsl rlGetItemSkills
          ora #0
          beq _A411

          sta wR1

          lda #size(aDebugMenuSkillFlags)-1
          sta wR0

          phx
          ldx #size(aValidItemSkillTable)-2
          
          -
          lda aValidItemSkillTable,x
          bit wR1
          beq +

            jsr rsDebugFlagSkillPossesstion

          +
          dec wR0
          dec x
          dec x
          bpl -

          plx

          _A411
          inc x
          bra _Loop
        
        _End
        rts

        .databank 0

      rlUnknown87A415 ; 87/A415

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        lda #0
        sta $7E2000
        ldx #$001D
        lda #0
        
        -
        sta $7E2002,x
        dec x
        bpl -

        jsr $87A373
        jsr $87A39C

        plx
        plp
        plb
        rtl

        .databank 0

    .endsection SkillsSection
