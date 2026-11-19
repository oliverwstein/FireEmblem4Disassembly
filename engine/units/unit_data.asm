; Getters and setters for a unit's RAM data: unit type, states, lover, deployment,
; arena level, castle, faction, AI, status, canto movement, ring and weapon stat
; bonuses, and current HP.

    .section UnitDataSection

      .al
      .xl

      rlGetUnitType ; 84/9461

        .al
        .autsiz
        .databank ?

        ; 0 = static
        ; 1 = dynamic
        ; 2 = holy
        ; 3 = enemy

        phb
        php
        phk
        plb

        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlSaveUnitType ; 84/9474

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        phx
        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        sta $7E0000+structCharacterDataRAM.Type,x
        rep #$20
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitPersonalDataPointer ; 84/9488

        .al
        .autsiz
        .databank ?

        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda $7E0000+structCharacterDataRAM.PersonalData+2,x
        pha
        rep #$20
        plb
        lda $7E0000+structCharacterDataRAM.PersonalData,x
        tax
        rtl

        .databank 0

      rlSavePersonalCharacterDataToBuffer ; 84/949B

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

        jsl rlGetSelectedUnitPersonalDataPointer

        lda lRAMBufferPointer+1,b
        sta lR18+1
        lda lRAMBufferPointer,b
        sta lR18

        ldy #structPersonalCharacterDataBuffer.UnitStates
        lda structPersonalCharacterDataRAM.UnitStates,b,x
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.LoverGenerationID
        lda structPersonalCharacterDataRAM.LoverGenerationID,b,x
        and #$00FF
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.DeploymentOffset
        lda structPersonalCharacterDataRAM.DeploymentOffset,b,x
        and #$00FF
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.ResidingCastle
        lda structPersonalCharacterDataRAM.ResidingCastle,b,x
        and #$00FF
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.FactionSlot
        lda structPersonalCharacterDataRAM.FactionSlot,b,x
        and #$00FF
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.AI
        lda structPersonalCharacterDataRAM.AI,b,x
        and #$00FF
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.Status
        lda structPersonalCharacterDataRAM.Status,b,x
        and #$00FF
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.CantoMovement
        lda structPersonalCharacterDataRAM.CantoMovement,b,x
        and #$00FF
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.RingStatBonusBitfield
        lda structPersonalCharacterDataRAM.RingStatBonusBitfield,b,x
        and #$00FF
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.WeaponStatBonus
        lda structPersonalCharacterDataRAM.WeaponStatBonus,b,x
        and #$00FF
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.StatusDuration
        lda structPersonalCharacterDataRAM.StatusDuration,b,x
        and #$00FF
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.CurrentHP
        lda structPersonalCharacterDataRAM.CurrentHP,b,x
        and #$00FF
        sta [lR18],y

        ldy #structPersonalCharacterDataBuffer.ClassMoney
        lda structPersonalCharacterDataRAM.ClassMoney,b,x
        and #$00FF
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

      rlLoadPersonalCharacterDataFromBuffer ; 84/954C

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

        jsl rlGetSelectedUnitPersonalDataPointer

        lda lRAMBufferPointer+1,b
        sta lR18+1
        lda lRAMBufferPointer,b
        sta lR18

        ldy #structPersonalCharacterDataBuffer.UnitStates
        lda [lR18],y
        sta structPersonalCharacterDataRAM.UnitStates,b,x

        sep #$20
        ldy #structPersonalCharacterDataBuffer.LoveDataID
        lda [lR18],y
        sta structPersonalCharacterDataRAM.LoveDataID,b,x

        ldy #structPersonalCharacterDataBuffer.LoverGenerationID
        lda [lR18],y
        sta structPersonalCharacterDataRAM.LoverGenerationID,b,x

        ldy #structPersonalCharacterDataBuffer.ResidingCastle
        lda [lR18],y
        sta structPersonalCharacterDataRAM.ResidingCastle,b,x

        ldy #structPersonalCharacterDataBuffer.FactionSlot
        lda [lR18],y
        sta structPersonalCharacterDataRAM.FactionSlot,b,x

        ldy #structPersonalCharacterDataBuffer.AI
        lda [lR18],y
        sta structPersonalCharacterDataRAM.AI,b,x

        ldy #structPersonalCharacterDataBuffer.CantoMovement
        lda [lR18],y
        sta structPersonalCharacterDataRAM.CantoMovement,b,x

        ldy #structPersonalCharacterDataBuffer.RingStatBonusBitfield
        lda [lR18],y
        sta structPersonalCharacterDataRAM.RingStatBonusBitfield,b,x

        ldy #structPersonalCharacterDataBuffer.WeaponStatBonus
        lda [lR18],y
        sta structPersonalCharacterDataRAM.WeaponStatBonus,b,x

        ldy #structPersonalCharacterDataBuffer.StatusDuration
        lda [lR18],y
        sta structPersonalCharacterDataRAM.StatusDuration,b,x

        ldy #structPersonalCharacterDataBuffer.Status
        lda [lR18],y
        sta structPersonalCharacterDataRAM.Status,b,x

        ldy #structPersonalCharacterDataBuffer.DeploymentOffset
        lda [lR18],y
        sta structPersonalCharacterDataRAM.DeploymentOffset,b,x

        ldy #structPersonalCharacterDataBuffer.CurrentHP
        lda [lR18],y
        sta structPersonalCharacterDataRAM.CurrentHP,b,x

        ldy #structPersonalCharacterDataBuffer.ClassMoney
        lda [lR18],y
        sta structPersonalCharacterDataRAM.ClassMoney,b,x
        rep #$20

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
  
      rlGetSelectedUnitStates ; 84/95E5

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        phx
        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.UnitStates,b,x
        plx

        plp
        plb
        rtl

        .databank 0

      rlSetSelectedUnitStates ; 84/95F5

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        ora structPersonalCharacterDataRAM.UnitStates,b,x
        sta structPersonalCharacterDataRAM.UnitStates,b,x

        plx
        plp
        plb
        rtl

        .databank 0

      rlUnsetSelectedUnitStates ; 84/960A

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        eor #$FFFF

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        and structPersonalCharacterDataRAM.UnitStates,b,x
        sta structPersonalCharacterDataRAM.UnitStates,b,x

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitLoveDataID ; 84/9622

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.LoveDataID,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitLoverGenerationID ; 84/9635

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.LoverGenerationID,b,x
        and #$00FF
        plx

        plp
        plb

        -
        rtl

        lda #0
        plx
        plp
        plb
        bra -

        .databank 0

      rlSetSelectedUnitLoverGenerationID ; 84/9650

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        sep #$20
        cmp #$18 + 1
        bcs +

        sta structPersonalCharacterDataRAM.LoverGenerationID,b,x
        rep #$20

        plx
        plp
        plb
        rtl

        +
        .byte 0

        .databank 0

      rlGetSelectedUnitDeploymentOffset ; 84/966B

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wSelectedUnitDataRAMPointer

        ; Output:
        ; A = deployment offset
        ; sec if not deployed

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.DeploymentOffset,b,x
        and #$00FF
        cmp #NoDeploymentOffset
        beq +

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

      rlSetSelectedUnitDeploymentOffset ; 84/968A

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        sep #$20
        sta structPersonalCharacterDataRAM.DeploymentOffset,b,x
        rep #$20

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitArenaLevel ; 84/96A0

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.UnitStates,b,x
        and #UnitStateArenaLevelMask

        plx
        plp
        plb
        rtl

        .databank 0

      rlSetSelectedUnitArenaLevel ; 84/96B3

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx wRoutineVariable1,b
        phx

        and #UnitStateArenaLevelMask
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitPersonalDataPointer

        lda structPersonalCharacterDataRAM.UnitStates,b,x
        and #~UnitStateArenaLevelMask
        ora wRoutineVariable1,b
        sta structPersonalCharacterDataRAM.UnitStates,b,x

        pla
        sta wRoutineVariable1,b
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitHomeCastle ; 84/96DA

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.UnitStates,b,x
        bit #UnitStateFielded
        bne +

        lda structPersonalCharacterDataRAM.ResidingCastle,b,x
        and #$00FF

        plx
        plp
        plb
        clc
        
        -
        rtl

        +
        lda structPersonalCharacterDataRAM.ResidingCastle,b,x
        and #$00FF

        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlSetSelectedUnitResidingCastle ; 84/9702

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        sep #$20
        sta structPersonalCharacterDataRAM.ResidingCastle,b,x

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitFactionSlot ; 84/9716

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wSelectedUnitDataRAMPointer

        ; Output:
        ; A = FactionSlot

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.FactionSlot,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlSetSelectedUnitFaction ; 84/9729

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        sep #$20
        sta structPersonalCharacterDataRAM.FactionSlot,b,x
        rep #$20

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitAI ; 84/973F

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.AI,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlSetSelectedUnitAI ; 84/9752

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        sep #$20
        sta structPersonalCharacterDataRAM.AI,b,x
        rep #$20

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitStatus ; 84/9768

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.Status,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlSetSelectedUnitStatus ; 84/977B

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        sep #$20
        sta structPersonalCharacterDataRAM.Status,b,x
        rep #$20

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitCantoMovement ; 84/9791

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.CantoMovement,b,x
        and #$00FF
        plx
        plp
        plb
        rtl

        .databank 0

      rlSetSelectedUnitCantoMovement ; 84/97A4

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla
        sep #$20
        sta structPersonalCharacterDataRAM.CantoMovement,b,x
        rep #$20
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetActiveRingStatBonusBitfield ; 84/97BA

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.RingStatBonusBitfield,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlAddRingStatBonusToSelectedUnit ; 84/97CD

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        and #$00FF
        pha

        jsl rlGetSelectedUnitPersonalDataPointer
        pla
        ora structPersonalCharacterDataRAM.RingStatBonusBitfield,b,x
        sta structPersonalCharacterDataRAM.RingStatBonusBitfield,b,x

        plx
        plp
        plb
        rtl

        .databank 0

      rlRemoveRingStatBonusFromSelectedUnit ; 84/97E5

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        and #$00FF
        eor #$FFFF
        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla
        and structPersonalCharacterDataRAM.RingStatBonusBitfield,b,x
        sta structPersonalCharacterDataRAM.RingStatBonusBitfield,b,x
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetActiveWeaponStatBonus ; 84/9800

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.WeaponStatBonus,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlSetActiveWeaponStatBonus ; 84/9813

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        sep #$20
        sta structPersonalCharacterDataRAM.WeaponStatBonus,b,x
        rep #$20

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitStatusDuration ; 84/9829

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.StatusDuration,b,x
        and #$00FF
        plx
        plp
        plb
        rtl

        .databank 0

      rlSetSelectedUnitStatusDuration ; 84/983C

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        sep #$20
        sta structPersonalCharacterDataRAM.StatusDuration,b,x
        rep #$20

        plx
        plp
        plb
        rtl

        .databank 0

      rlDecreaseStatusDuration ; 84/9852

        .al
        .autsiz
        .databank ?

        ; Output:
        ; CLC if unit doesnt have a duration or its still active
        ; SEC if just recovered from a status

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitPersonalDataPointer

        lda structPersonalCharacterDataRAM.StatusDuration,b,x
        and #$00FF
        beq _CLC

        dec a
        sep #$20
        sta structPersonalCharacterDataRAM.StatusDuration,b,x
        rep #$20
        bne _CLC

        lda structPersonalCharacterDataRAM.Status,b,x
        and #$00FF
        pha

        lda #StatusHealthy
        jsl rlSetSelectedUnitStatus

        pla
        cmp #StatusSleep
        bne +

          lda structPersonalCharacterDataRAM.DeploymentOffset,b,x
          and #$00FF
          tax
          lda aDeploymentTable._StateBuffer,x
          and #~DeploymentStateAsleep
          sta aDeploymentTable._StateBuffer,x

          lda #$0004
          tsb wUnknown000D79,b

        +
        plx
        plp
        plb
        sec
        bra +
        
        _CLC
        plx
        plp
        plb
        clc
        
        +
        rtl

        .databank 0

      rlSetSelectedUnitMapAnimation ; 84/98A4

        .al
        .autsiz
        .databank ?

        ; A not 0 sets UnitStateMapAnimation, 0 clears it. Also sets the battle
        ; animation option to 2.

        pha
        lda #UnitStateMapAnimation
        jsl rlUnsetSelectedUnitStates
        pla

        ora #0
        bne +

        lda #0
        bra ++

        +
        lda #UnitStateMapAnimation
        
        +
        jsl rlSetSelectedUnitStates

        lda #2
        jsl rlSetBattleAnimationOption
        rtl

        .databank 0

      rlGetSelectedUnitCurrentHP ; 84/98C6

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitPersonalDataPointer
        lda structPersonalCharacterDataRAM.CurrentHP,b,x
        and #$00FF
        plx
        plp
        plb
        rtl

        .databank 0

      rlSetSelectedUnitCurrentHP ; 84/98D9

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla
        sep #$20
        sta structPersonalCharacterDataRAM.CurrentHP,b,x
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitExtendedPersonalDataPointer ; 84/98ED

        .al
        .autsiz
        .databank ?

        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda $7E0000+structCharacterDataRAM.ExtendedPersonalData+2,x
        pha
        rep #$20
        plb
        lda $7E0000+structCharacterDataRAM.ExtendedPersonalData,x
        tax
        rtl

        .databank 0

      rlSaveExtendedCharacterDataToBuffer ; 84/9900

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

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetSelectedUnitExtendedPersonalDataPointer

        lda lRAMBufferPointer+1,b
        sta lR18+1
        lda lRAMBufferPointer,b
        sta lR18

        ldy #0
        lda structExtendedCharacterDataRAM.HP,b,x
        and #$00FF
        sta [lR18],y

        ldy #2
        lda structExtendedCharacterDataRAM.Strength,b,x    
        and #$00FF
        sta [lR18],y

        ldy #4
        lda structExtendedCharacterDataRAM.Magic,b,x
        and #$00FF
        sta [lR18],y

        ldy #6
        lda structExtendedCharacterDataRAM.Skill,b,x
        and #$00FF
        sta [lR18],y

        ldy #8
        lda structExtendedCharacterDataRAM.Speed,b,x
        and #$00FF
        sta [lR18],y

        ldy #10
        lda structExtendedCharacterDataRAM.Defense,b,x
        and #$00FF
        sta [lR18],y

        ldy #12
        lda structExtendedCharacterDataRAM.Resistance,b,x
        and #$00FF
        sta [lR18],y

        ldy #$0E
        lda structExtendedCharacterDataRAM.Luck,b,x
        and #$00FF
        sta [lR18],y

        ldy #$10
        lda structExtendedCharacterDataRAM.Class,b,x
        and #$00FF
        sta [lR18],y

        ldy #$12
        lda structExtendedCharacterDataRAM.Level,b,x
        and #$00FF
        sta [lR18],y

        ldy #$16
        lda structExtendedCharacterDataRAM.Money,b,x
        sta [lR18],y

        ldy #$18
        lda structExtendedCharacterDataRAM.Experience,b,x
        and #$00FF
        sta [lR18],y

        ldy #$1A
        lda structExtendedCharacterDataRAM.TalkTarget,b,x
        and #$00FF
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

        ; 84/99B5

    .endsection UnitDataSection
