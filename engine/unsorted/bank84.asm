; Code from bank $84 not yet assigned to a game system.

    .section Unsorted84CFBFSection

      .al
      .xl

      rlUnknown84CFBF ; 84/CFBF

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wR0
        pha
        lda wR1
        pha

        lda aDeploymentTable._XTilePosition,x
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        sta wR1
        jsl $87EA09
        bcs +

          jsl rlCheckIfCastleGuarded
          bcs +

            jsl rlGetLocationFactionSlotOwner
            sta wR0

            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b

            phx
            ldx wR0
            jsl rlGetSelectedUnitFactionSlot
            jsl rlGetFactionRelation
            plx

            cmp #AllegianceEnemy
            beq +

              cmp #AllegianceOther
              beq +

                jsr rsUnknown84D010

        +
        pla
        sta wR1
        pla
        sta wR0
        plp
        plb
        rtl

        .databank 0

      rsUnknown84D010 ; 84/D010

        .al
        .autsiz
        .databank ?

        lda aDeploymentTable._StateBuffer,x
        ora #DeploymentStateGuardingCastle
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._State,x

        lda #UnitStateGuardingCastle
        jsl rlSetSelectedUnitStates
        jsl rlGetEventLocationEntryID
        jsl rlSetSelectedUnitResidingCastle
        jsl rlSetCastleGuarded
        jsl rlGetEventLocationEntryCoordinates
        sta wRoutineVariable1,b
        jsl rlUnknown84C996
        rts

        .databank 0

        ; 84/D03E

    .endsection Unsorted84CFBFSection
