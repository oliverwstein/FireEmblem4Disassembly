
  .virtual $000000

    wR0  .word ? ; $000000
    wR1  .word ? ; $000002
    wR2  .word ? ; $000004
    wR3  .word ? ; $000006
    wR4  .word ? ; $000008
    wR5  .word ? ; $00000A
    wR6  .word ? ; $00000C
    wR7  .word ? ; $00000E
    wR8  .word ? ; $000010
    wR9  .word ? ; $000012
    wR10 .word ? ; $000014
    wR11 .word ? ; $000016
    wR12 .word ? ; $000018
    wR13 .word ? ; $00001A
    wR14 .word ? ; $00001C
    wR15 .word ? ; $00001E
    wR16 .word ? ; $000020
    wR17 .word ? ; $000022

    lR18 .long ? ; $000024
    lR19 .long ? ; $000027
    lR20 .long ? ; $00002A
    lR21 .long ? ; $00002D
    lR22 .long ? ; $000030
    lR23 .long ? ; $000033
    lR24 .long ? ; $000036
    lR25 .long ? ; $000039

    wR26 .word ? ; $00003C
    wR27 .word ? ; $00003E
    wR28 .word ? ; $000040
    wR29 .word ? ; $000042
    wR30 .word ? ; $000044
    wR31 .word ? ; $000046
    wR32 .word ? ; $000048
    wR33 .word ? ; $00004A
    wR34 .word ? ; $00004C
    wR35 .word ? ; $00004E
    wR36 .word ? ; $000050
    wR37 .word ? ; $000052

    lR38 .long ? ; $000054
    lR39 .long ? ; $000057

    wR40 .word ? ; $00005A
    wR41 .word ? ; $00005C
    wR42 .word ? ; $00005E
    wR43 .word ? ; $000060

    lR44 .long ? ; $000062
    lR45 .long ? ; $000065

    wR46 .word ? ; $000068

    lR47 .long ? ; $00006A
    lR48 .long ? ; $00006D

    bBufferINIDISP    .byte ? ; $000070
    bBufferOBSEL      .byte ? ; $000071
    wBufferOAMADD     .word ? ; $000072
    bBufferBGMODE     .byte ? ; $000074
    bBufferMOSAIC     .byte ? ; $000075
    bBufferBG1SC      .byte ? ; $000076
    bBufferBG2SC      .byte ? ; $000077
    bBufferBG3SC      .byte ? ; $000078
    bBufferBG4SC      .byte ? ; $000079
    bBufferBG12NBA    .byte ? ; $00007A
    bBufferBG34NBA    .byte ? ; $00007B
    bBufferM7SEL      .byte ? ; $00007C
    bBufferW12SEL     .byte ? ; $00007D
    bBufferW34SEL     .byte ? ; $00007E
    wBufferBG1HOFS    .word ? ; $00007F
    wBufferBG1VOFS    .word ? ; $000081
    wBufferBG2HOFS    .word ? ; $000083
    wBufferBG2VOFS    .word ? ; $000085
    wBufferBG3HOFS    .word ? ; $000087
    wBufferBG3VOFS    .word ? ; $000089
    wBufferBG4HOFS    .word ? ; $00008B
    wBufferBG4VOFS    .word ? ; $00008D
    bBufferWOBJSEL    .byte ? ; $00008F
    bBufferWH0        .byte ? ; $000090
    bBufferWH1        .byte ? ; $000091
    bBufferWH2        .byte ? ; $000092
    bBufferWH3        .byte ? ; $000093
    bBufferWBGLOG     .byte ? ; $000094
    bBufferWOBJLOG    .byte ? ; $000095
    bBufferTM         .byte ? ; $000096
    bBufferTS         .byte ? ; $000097
    bBufferTMW        .byte ? ; $000098
    bBufferTSW        .byte ? ; $000099
    bBufferCGWSEL     .byte ? ; $00009A
    bBufferCGADSUB    .byte ? ; $00009B
    bBufferCOLDATA_0  .byte ? ; $00009C
    bBufferCOLDATA_1  .byte ? ; $00009D
    bBufferCOLDATA_2  .byte ? ; $00009E
    bBufferCOLDATA_3  .byte ? ; $00009F
    bBufferSETINI     .byte ? ; $0000A0

  .endvirtual

  .virtual $0000B1

    bBufferNMITIMEN   .byte ? ; $0000B1
    bBufferVTIMEL     .byte ? ; $0000B2
    bBufferVTIMEH     .byte ? ; $0000B3
    bBufferHTIMEL     .byte ? ; $0000B4
    bBufferHTIMEH     .byte ? ; $0000B5
    bBufferHDMAEN     .byte ? ; $0000B6
    bBufferMEMSEL     .byte ? ; $0000B7

  .endvirtual


  .virtual $0000C8

    DecompressionVariables .block ; $0000C8
      lSource .long ?             ; $0000C8
      .union
        lDest .long ?             ; $0000CB
        .struct
          bVar0 .byte ?           ; $0000CB
          bVar1 .byte ?           ; $0000CC
          bMethodCount .byte ?    ; $0000CD
        .endstruct
      .endunion
      lTemp .long ?               ; $0000CE
      bCount .byte ?              ; $0000D1
      bFlag .byte ?               ; $0000D2
    .endblock

    wVBlankPointer            .word ? ; $0000D3
    wIRQPointer               .word ? ; $0000D5
    wMainLoopPointer          .word ? ; $0000D7
    wVBlankFlag               .word ? ; $0000D9
    wVBlankEnabledFramecount  .word ? ; $0000DB
    wVBlankDisabledFramecount .word ? ; $0000DD

  .endvirtual

  .virtual $0000E0

    wJoyRepeatDelay    .word ? ; $0000E0
      ; This is the time before
      ; an input is set to automatically
      ; repeat.
    wJoyRepeatInterval .word ? ; $0000E2
      ; This is the time between
      ; automatically-repeated inputs.
    wJoy1Input         .word ? ; $0000E4
    wJoy2Input         .word ? ; $0000E6
      ; These are the inputs
      ; being read from the joypads.
    wJoy1New           .word ? ; $0000E8
    wJoy2New           .word ? ; $0000EA
      ; These are the strictly-new
      ; button presses this frame.
    wJoy1Repeated      .word ? ; $0000EC
    wJoy2Repeated      .word ? ; $0000EE
      ; These are the buttons that
      ; are being automatically
      ; repeated.
    wJoy1Old           .word ? ; $0000F0
      ; This is the previous frame's
      ; inputs for joypad 1.
                       .fill 4 ; $0000F2
    wJoy1RepeatTimer   .word ? ; $0000F6
      ; This timer is decremented
      ; every frame while a button
      ; combination is held. Starts
      ; at wJoyRepeatDelay and is
      ; reset to wJoyRepeatInterval
      ; when it reaches 0.
    wJoy2Old           .word ? ; $0000F8
      ; This is the previous frame's
      ; inputs for joypad 2.
                       .fill 4 ; $0000FA
    wJoy2RepeatTimer   .word ? ; $0000FE
      ; This timer is decremented
      ; every frame while a button
      ; combination is held. Starts
      ; at wJoyRepeatDelay and is
      ; reset to wJoyRepeatInterval
      ; when it reaches 0.

    aBGPaletteBuffer .block      ; $000100 0.01
      aPalette0 .dstruct Palette ; $000100 0.01
      aPalette1 .dstruct Palette ; $000120 0.01
      aPalette2 .dstruct Palette ; $000140 0.01
      aPalette3 .dstruct Palette ; $000160 0.01
      aPalette4 .dstruct Palette ; $000180 0.01
      aPalette5 .dstruct Palette ; $0001A0 0.01
      aPalette6 .dstruct Palette ; $0001C0 0.01
      aPalette7 .dstruct Palette ; $0001E0 0.01
    .endblock

    aOAMPaletteBuffer .block     ; $000200 0.01
      aPalette0 .dstruct Palette ; $000200 0.01
      aPalette1 .dstruct Palette ; $000220 0.01
      aPalette2 .dstruct Palette ; $000240 0.01
      aPalette3 .dstruct Palette ; $000260 0.01
      aPalette4 .dstruct Palette ; $000280 0.01
      aPalette5 .dstruct Palette ; $0002A0 0.01
      aPalette6 .dstruct Palette ; $0002C0 0.01
      aPalette7 .dstruct Palette ; $0002E0 0.01
    .endblock

  .endvirtual



  .virtual $000339

    wScreenFadingTimeIncrement .word ?  ; $000339
    wScreenFadingTimer         .word ?  ; $00033B
    wScreenFadingFlag          .word ?  ; $00033D
    wScreenFadingProcInput     .word ?  ; $00033F
    bDMAPendingChannels        .byte ?  ; $000341
    bHDMAPendingChannels       .byte ?  ; $000342
    wDMAArrayPosition .word ?           ; $000343
    bDMAArrayFlag .byte ?               ; $000345
    aDMAArray .fill $100                ; $000346
    wDecompressionArrayPosition .word ? ; $000446
    bDecompressionArrayFlag .byte ?     ; $000448
    aDecompressionArray .fill $20       ; $000449
    bFrameCounterByOnes .byte ?         ; $000469
    bFrameCounterByThrees .byte ?       ; $00046A
    aRNArray .fill 55                   ; $00046B
    wRNIndex .word ?                    ; $0004A2
    bRNGUnknown1 .byte ?                ; $0004A4
    bRNGUnknown2 .byte ?                ; $0004A5

  .endvirtual


  .virtual $0004A6

    lBlockCopySource .long ?      ; $0004A6
    lBlockCopyDestination .long ? ; $0004A9
    wBlockCopySize .word ?        ; $0004AC
    rsBlockCopyMVNRAM .block      ; $0004AE
      mvn #$00,#$00
      rts
    .endblock
    rsBlockCopyMVPRAM .block      ; $0004B2
      mvp #$00,#$00
      rts
    .endblock

  .endvirtual


  .virtual $0004B6

    ; The sound loader's variables (rlInitSound clears $04B6-$0515). A script
    ; channel's values are at +0 for channel 0 and +2 for channel 1.
    wSoundHeaderAddress .word ?   ; $0004B6
      ; <>aSoundHeader.
    .union
      wSoundDataBankHigh .word ?  ; $0004B8
        ; (`aSoundHeader) << 8. Added to a pointer's high byte, it gives the
        ; high byte and bank of an address in the sound data.
      .struct
        .byte ?
        bSoundDataBank .byte ?    ; $0004B9
      .endstruct
    .endunion
    wMusicID .word ?              ; $0004BA
      ; The song script channel 0 plays (1-160, aSoundScripts; 0 none), set by
      ; the code that changes the music (the debug menu's sound test too).
      ; Bit 15: upload with VBlank off.
    wSoundScript1ID .word ?       ; $0004BC
      ; The same for channel 1; nothing in the build sets it.
    aSoundScriptPositions .fill 4 ; $0004BE
      ; Per channel: offset of the next word of the script.
    aSoundScriptWaits .fill 4     ; $0004C2
      ; Per channel: frames left before the next command.
    aSoundScriptRunning .fill 4   ; $0004C6
      ; Per channel: the script ID being run; a different wMusicID restarts.
    aSoundChannelFadeState .block ; $0004CA: Ch0 fade state; +3 ($0004CD) Ch1
      bMode  .byte ?              ; $0004CA
      bLevel .byte ?              ; $0004CB
      bFlags .byte ?              ; $0004CC
    .endblock
    aSoundChannelFadeState2  .fill 3 ; $0004CD
    aSoundChannelFadeTarget  .fill 3 ; $0004D0: Ch0 target; +3 ($0004D3) Ch1
    aSoundChannelFadeTarget2 .fill 3 ; $0004D3

  .endvirtual

  .virtual $0004D6

    ; Values for the APU's ports 0 and 2, sent by rlSendSoundQueuesToAPU: the
    ; one being sent, then up to four waiting (0 = empty).
    wSoundEffectCurrent .word ?   ; $0004D6
    aSoundEffectQueue .fill 8     ; $0004D8
      ; Filled by rlPlaySoundEffect and rlSendSoundCommand.
    wSoundEffect2Current .word ?  ; $0004E0
    aSoundEffect2Queue .fill 8    ; $0004E2
      ; Filled by rlPlaySoundEffect2.
    bSoundFlags .byte ?           ; $0004EA
      ; Bit 0: rlPlaySoundEffect does nothing. Bit 2: rlPlaySoundEffect2 does
      ; nothing. Bit 4: rlQueueSoundCommand drops values $C8-$DF. rlUpdateSound
      ; acts when bits 4 and 6 change.
    bSoundResendCommand .byte ?   ; $0004EB
      ; The last command $CB-$CD rlQueueSoundCommand queued;
      ; rlSoundOnFlag10Cleared queues it again.
    bSoundFlagsApplied .byte ?    ; $0004EC
      ; Bits 4 and 6 of bSoundFlags as rlUpdateSound last acted on them.
    .byte ?                       ; $0004ED
    wSoundScriptChannel .word ?   ; $0004EE
      ; The channel rsStepSoundScript is stepping (0 or 2).
    wSoundTemp .word ?            ; $0004F0
      ; Scratch for the upload code: the word being run, a count of words.
    wSoundUploadDestination .word ? ; $0004F2
      ; The SPC address the next chunk goes to.
    bAPUUploading .byte ?         ; $0004F4
      ; Nonzero while data is being uploaded to the APU; the sound queues wait.
      ; The value is sent on port 0 as the kind of upload ($FE the driver, $FA-$FD
      ; uploads from scripts).
    bSoundUploadNoVBlank .byte ?  ; $0004F5
      ; Nonzero: rlRunSoundUploadList turns VBlank off while it uploads.
    bAPUStatus .byte ?            ; $0004F6
      ; Read from APU port 3 every frame.
    bSoundUpdateSlot .byte ?      ; $0004F7
      ; Cycles 0, 3, 6 (+3 mod 9) each frame in rlUpdateSound.
    wSoundScriptCommand .word ?   ; $0004F8
      ; The script word being run; its low 10 bits are the frames to wait.
    wSoundDeferredUpload .word ?  ; $0004FA
      ; An upload list script commands 11-14 left for rlRunDeferredSoundUpload
      ; (0 none), sent with bSoundDeferredUploadMode as bAPUUploading.
    bSoundDeferredUploadMode .byte ? ; $0004FC
    bSoundIndirectStep .byte ?    ; $0004FD
      ; Which entry of an indirect upload list rsGetIndirectSoundUpload returns
      ; next (0 starts again).
    aSoundIndirectLast .fill 2    ; $0004FE
      ; The last indirect upload ID from $3C up (+0) and below $3C (+1): asked
      ; for again at the start of its list, it uploads nothing.
    wSoundIndirectPending .word ? ; $000500
      ; Nonzero forces script command 17 to resend the sound upload command.

  .endvirtual

  .virtual $000502

    wSoundBuffer1Chunk .word ?    ; $000502
      ; The chunk table entry decompressed into the buffer at $7E5358, so it is
      ; not decompressed again.
    wSoundBuffer2Chunk .word ?    ; $000504
      ; The same for the buffer at $7E6358 (SOUND_CHUNK_BUFFER2).
    bAPUPort1 .byte ?             ; $000506
      ; Read from APU port 1 by rlSendSoundQueuesToAPU.
    bSoundBufferFirstByte .byte ? ; $000507
      ; The first byte of the chunk last decompressed; script command 17
      ; compares it with bAPUPort1.
    wSoundUploadBusyFlag .word ?  ; $000508
      ; Nonzero pauses script command 17.
    wSoundQueueFlags .word ?      ; $00050A
      ; ORed into commands queued by rsSoundScriptQueueCommand and cleared.

  .endvirtual

  .virtual $00050C

    aSoundTerrain .fill 4         ; $00050C
      ; Two offsets into aSoundTerrainUploads, from the terrain of the battle's
      ; units (rsSoundUploadCommandReadTerrain).
    aSoundScriptPrevious .fill 4  ; $000510
      ; Per channel: the script ID that ran last, saved when its script ends.

  .endvirtual

  ; Map menus: the windows drawn on BG3 over the map (engine/menus/map_menu.asm).
  ; rlInitMapMenus clears $000516-$00053F.

  .virtual $000516

    wMapMenuVRAMTilemap .word ?   ; $000516 ; VRAM word address of BG3's tilemap
    lMapMenuBGBuffer .long ?      ; $000518 ; the BG3 tilemap buffer the menus are drawn into (aBG3TilemapBuffer)
    .fill 6                       ; $00051B
    bMapMenuFlags .byte ?         ; $000521
      ; Bitfield
      ; $02, $04, $08, $10 = something changed: upload the dirty rows in VBlank
      ; $20 = hold the uploads
      ; $40 = rlDrawMapMenuBG3 also draws the menus in front of the current one
      ; $80 = uploads on (rlEnableMapMenuUploads)
    lMapMenuListHead .long ?      ; $000522 ; the first open map menu; each links the next (structMapMenu.Next), back to front
    ; $000525

  .endvirtual


  .virtual $00052A

    wMapMenuDirtyTop .word ?                ; $00052A ; first BG3 row to upload (32 = none)
    wMapMenuDirtyBottom .word ?             ; $00052C ; last BG3 row to upload
    lMapMenuRAMEntryPointer .long ?         ; $00052E
    lMapMenuTilemapRAMEntryPointer .long ?  ; $000531
    wMapMenuNewPosition .word ?             ; $000534 ; argument of rlMoveMapMenu: column, row; bit 15 hides the menu
    bUnknown0536 .byte ?                    ; $000536
      ; Bitfield
      ; $0001 = busy decompressing
      ; $0002 = busy dma-ing
    lUnknown0537 .long ?                    ; $000537

    aCurrentTilemapInfo .block 
      wBaseTile .word ?                     ; $00053A
    .bend
    wMapMenuClearTile .word ?               ; $00053C ; what rlClearMapMenuTiles fills a menu with
    wMapMenuTransparentTile .word ?         ; $00053E ; not copied to BG3; cleared BG3 rows are filled with it
    lMenuOptionPointer .long ?                    ; $000540 ; the menu option list template (rlPushMenuOptionList), option definition (rlAddMenuOption) or selected option (rlSelectMenuOptionByIndex)
    wMenuOptionX .word ?                  ; $000543 ; X of the option rlAddMenuOption adds
    wMenuOptionY .word ?                  ; $000545 ; Y of the option rlAddMenuOption adds
    lMenuOptionListTop .long ?         ; $000547 ; the current (top) menu option list; each list block keeps the previous top at +2, so the lists form a stack

  .endvirtual




  .virtual $00054A

    lStructPointer1 .long ?       ; $00054A
    ; For saving, this is the data source.
    ; For loading, this is the destination.
    lPendingStructEntryPointer .long ? ; $00054D ; staged 24-bit entry pointer copied to lStructPointer1

  .endvirtual

  .virtual $000550

    wStructIndex .word ?          ; $000550
    ; Is 1 indexed instead of 0 indexed.
    wStructCurrentCount .word ?   ; $000552 ; current struct count
    wStructSize .word ?           ; $000554
    wStructIndexAlternate .word ? ; $000556
    wStructMultiplyTemp1 .word ?  ; $000558 ; multiplicand shifted left in rsGetRAMStructOffset
    wStructMultiplyTemp2 .word ?  ; $00055A ; struct size added per bit in rsGetRAMStructOffset
    lStructPointer2 .long ?       ; $00055C
    ; For saving, this is the destination.
    ; For loading, this is the data source.

  .endvirtual


  .virtual $000565

    lRAMAreaPointer .long ?             ; $000565
    lRAMAreaPointerBuffer .long ?       ; $000568
    wUnknown00056B .word ?              ; $00056B
    wLoadedUnitCount .word ?            ; $00056D
    wSelectedUnitDataRAMPointer .word ? ; $00056F
    lRoutineVariable .long ?            ; $000571
    wRoutineVariable1 .word ?           ; $000574
      ; Used for basically everything
    wRoutineVariable2 .word ?           ; $000576
    wRoutineVariable3 .word ?           ; $000578
    wCurrentClassDataROMPointer .word ? ; $00057A
    wMapActionTargetType .word ?        ; $00057C ; jump table index into aMapActionRoutines
    wSelectedInventorySlot .word ?      ; $00057E
    wTargetEventLocationEntry .word ?   ; $000580 ; castle/location event entry passed between map, AI, and return
    .word ? ; $000582

  .endvirtual

  .virtual $000583

    wCurrentItemDataROMPointer .word ?  ; $000583
    wTempItemDataROMPointer .word ?     ; $000585 ; scratch item ROM pointer / stat sum
    wCurrentItemDataRAMPointer .word ?  ; $000587
    wLoadedFactionCount .word ?         ; $000589
    wDeployedUnitsCount .word ?         ; $00058B
    lRAMBufferPointer .long ?           ; $00058D
    wEventLocationEntry .word ?         ; $000590
    wMenuState .word ?                  ; $000592 ; active arena/shop/castle menu substate jump index
    wNextMenuState .word ?              ; $000594 ; pending wMenuState or wGameStateStep applied after fade/wait

  .endvirtual

  .virtual $000596

    wMapTileIDMask .word ?    ; $000596
      ; ANDed with each aMapData word to get the tile ID ($03FF on the chapter map).
    wMapScrollXPixels .word ? ; $000598
    wMapScrollYPixels .word ? ; $00059A

  .endvirtual






  .virtual $00071C

    wMovementMapWindowLeft .word ?          ; $00071C
    wMovementMapWindowTop .word ?           ; $00071E
    wMovementMapWindowRight .word ?         ; $000720
    wMovementMapWindowBottom .word ?        ; $000722
      ; The map tiles aMovementMap covers: 64x64 around the selected unit
      ; (rsSetMovementMapWindowAndRedraw). Right and bottom are left + 64 and
      ; top + 64 before clamping and are also the origin for the index.
    wTilemapRedrawOffset .word ?            ; $000724
      ; Where the next row goes in aBG2TilemapBuffer/aBG3TilemapBuffer while the
      ; whole map or range overlay is redrawn.
    wMapScrollSpeed .word ?                 ; $000726
    wMapPixelScrollDistance .word ?         ; $000728
    wMapTileBufferWrapped .word ?           ; $00072A ; set when a row or column being built wraps to the start of its buffer
    wMapColumnUploadFlag .word ?            ; $00072C ; rlUploadMapRowAndColumn copies the column buffer when set
    wMapRowUploadFlag .word ?               ; $00072E ; rlUploadMapRowAndColumn copies the row buffer when set
    wMapColumnUploadVRAMOffset .word ?      ; $000730
    wMapRowUploadVRAMOffset .word ?         ; $000732
    wMapSavedScrollXPixels .word ?          ; $000734
    wMapSavedScrollYPixels .word ?          ; $000736
    wMapScrollCurrentPixelDistance .word ?  ; $000738
    wMapScrollingFlag .word ?               ; $00073A ; set while the camera scrolls (rlContinueMapScroll)
    wMapEnableXScrollFlag .word ?           ; $00073C
    wMapEnableYScrollFlag .word ?           ; $00073E
    wMapMinXScroll .word ?                  ; $000740
    wMapMaxXScroll .word ?                  ; $000742
    wMapMinYScroll .word ?                  ; $000744
    wMapMaxYScroll .word ?                  ; $000746
    ; $000748

  .endvirtual


  .virtual $000300

    wGameStateRoutine2 .word ? ; $000300
    wGameStateRoutine1 .word ? ; $000302
      ; Every frame, rlRunGameStateRoutines runs the routine at index
      ; wGameStateRoutine1 in aGameStateRoutines and then the one at index
      ; wGameStateRoutine2. An entry with bank $7D instead sets wGameStateRoutine1.
    wGameStateStep .word ?     ; $000304
      ; A step counter for the current game state. The routines that set up a
      ; state clear it, and state routines advance it as they go.
    lTaskJumpPointer .long ?   ; $000306
      ; Indirect target jumped to by rlRunVBlankHookInit / rlRunVBlankHookCycle.
    aTaskTable .block          ; $000309 ($30 bytes: 16 x 3-byte long pointers)
      lEntry0 .long ?          ; $000309
      .fill 45                 ; $00030C-$000338
    .endblock

  .endvirtual

  .virtual $000750

    wMapScrollDirectionIdentifier .word ? ; $000750
    .word ? ; $000752
    .word ? ; $000754
    .word ? ; $000756
    wMapCursorResting .word ? ; $000758 ; set for a frame when the cursor comes to rest on a tile
    wUnknown00075A .word ?    ; $00075A
    wMapWidthMode .word ?     ; $00075C
      ; 4: aMapData rows are 64 tiles; anything else (8): 128 tiles.
    .word ? ; $00075E
    wMapXOffset .word ?       ; $000760
    wMapYOffset .word ?       ; $000762
    wMapCursorMoved .word ?   ; $000764 ; bit 0: the cursor moved this step (rlMoveMapCursorInDirection)
    wMapCursorStepping .word ? ; $000766 ; set while the cursor or a walking unit is partway through a 16-pixel step
    wCursorXOffset .word ?    ; $000768
    wCursorYOffset .word ?    ; $00076A
    wMovingUnitXPixel .word ? ; $00076C ; where the moving unit sprite is drawn in state 1 (map pixels)
    wMovingUnitYPixel .word ? ; $00076E
    wUnitSelectedFlag .word ? ; $000770 ; nonzero while a unit is picked up and its range overlay shown

  .endvirtual





  .virtual $000772

    wActiveUnitDeploymentOffset .word ? ; $000772
      ; The deployment offset of the unit the map code is acting with: set when a
      ; unit is chosen for an action, and read wherever that unit is needed.
    wMapTargetDeploymentOffset .word ? ; $000774 ; selected target unit deployment offset
    wMapTargetSearchIndex .word ?      ; $000776 ; $0000-$03FF index into aTargetDistanceMap
    wMapCursorXTile .word ?            ; $000778 ; selected destination X tile / camera pan X tile delta
    wMapCursorYTile .word ?            ; $00077A ; selected destination Y tile / camera pan Y tile delta
    wMapCursorOriginXTile .word ?      ; $00077C ; saved unit origin X tile for move cancel
    wMapCursorOriginYTile .word ?      ; $00077E ; saved unit origin Y tile for move cancel
    wMapSavedCursorXPixel .word ?      ; $000780 ; cursor absolute X pixel saved across move
    wMapSavedCursorYPixel .word ?      ; $000782 ; cursor absolute Y pixel saved across move
    wMapPanTargetDeploymentOffset .word ? ; $000784 ; unit deployment offset targeted by camera pan
    wMapReturnFlags .word ?            ; $000786
      ; What the map does on return from a menu or the castle (MAP_RETURN_* in
      ; include/Map.h): send the cursor to the active unit, start a castle staff's
      ; target selection, and whether that selection is running or came from the
      ; castle grid.
    wMapSystemFlags .word ?            ; $000788 ; bitfield:
      ; $0001 = JOY_Y held (recomputed per frame by rsUpdateMapSystemFlags)
      ; $0002 = a unit is selected, or wMapReturnFlags or wMapActionMode is nonzero
      ; $0004 = wMapCursorState is not 0
      ; $0008 = map cursor / unit action HUD update
      ; $0010 = an event is running (wEventEngineFlags nonzero)
      ; $0020 = the minimap is open
      ; $0040 = faction phase setup active
      ; $0080 = unit window / map menu open (rlHideMapWindows/D5)
      ; $4000 = a warp castle was chosen on the minimap
      ; $8000 = sets wMapCursorResting for a frame
    wDeployedUnitScanCounter .word ?   ; $00078A ; deployed unit iteration count vs wDeployedUnitsCount

  .endvirtual

  .virtual $00078C

    wTempVariable1 .word ? ; $00078C
    wTempVariable2 .word ? ; $00078E
      ; Temporary values used by many unrelated routines: prices, portrait IDs,
      ; weapons and their ranges, map coordinates and more.
    wUnknown000790 .word ? ; $000790 ; tilemap / path helper scratch
    ; Skip $000792 (multi-purposed in the map code).

  .endvirtual

  .virtual $000794

    aMovementPath .fill $40 ; $000794
      ; The walking path rsBuildMovementPath writes, one word per step from the
      ; destination back to the unit: 1 down, 2 up, 3 right, 4 left.
      ; wMapScrollScriptOffset indexes it as the unit walks.

  .endvirtual


  .virtual $0007D4

    wMapScrollScriptOffset .word ?      ; $0007D4
    wSavedMapScrollScriptOffset .word ? ; $0007D6 ; saves wMapScrollScriptOffset around movement-arrow calc
    wMapCursorState .word ?             ; $0007D8
      ; What the map cursor is doing (MAP_CURSOR_* in include/Map.h); see
      ; engine/map/map_cursor.asm.
    wMovingUnitSpriteState .word ?      ; $0007DA ; 0 idle, 1 selected, 2 moving/acting
    wMovingUnitSpriteFrame .word ?      ; $0007DC ; moving map sprite frame index
    wMovingUnitSpriteTimer .word ?      ; $0007DE ; countdown timer reloaded from aMapSpriteWalkFrameDelays
    wMapActionMode .word ?              ; $0007E0 ; active map action / menu selection mode

  .endvirtual




  .virtual $0007E2

    wMovingUnitSpriteFacing .word ? ; $0007E2 ; 0 left, 8 right, $10 up, $18 down
    wMapSpriteFrameCounter .word ?        ; $0007E4 ; incremented after map sprite VRAM DMA cycles
    wMapSpriteFrameByteOffset .word ?     ; $0007E6 ; animation frame byte offset added to lMapSpriteGraphicsPointer
    wMapSpriteAnimationPauseFlags .word ? ; $0007E8 ; $8000 disables map sprite DMA, $0001 disables tile anim/mouth
    lMapSpriteGraphicsPointer .long ?     ; $0007EA ; 24-bit base pointer to map sprite GFX

    aDynamicMapSpriteDMASources .block ; $0007ED ($30 bytes: 8 x 6-byte top/bottom .long pairs)
      lTopHalf    .long ?              ; $0007ED
      lBottomHalf .long ?              ; $0007F0
      .fill 42                         ; $0007F3-$00081C
    .endblock

    aDynamicMapSpriteVRAMDestinations .block ; $00081D ($30 bytes: 8 x 6-byte stride matching DMASources)
      wTopHalf    .word ?              ; $00081D
      .byte ?                          ; $00081F
      wBottomHalf .word ?              ; $000820
      .fill 43                         ; $000822-$00084C
    .endblock

  .endvirtual












  .virtual $000867

    aMovingMapSpritesMapSprites .fill (size(word) * 4) ; $000867
      ; If bit $8000 is set, its a tall sprite.
    wMapActionActiveFlag .word ?               ; $00086F ; 0 idle, 1 active, $FFFF AI/scripted map move
    wActiveActionUnit1DeploymentOffset .word ? ; $000871 ; acting unit deployment offset
    wActiveActionUnit2DeploymentOffset .word ? ; $000873 ; target unit deployment offset ($FFFF none)
    wActiveActionDestinationX .word ?          ; $000875 ; destination X in pixels (tile << 4)
    wActiveActionDestinationY .word ?          ; $000877 ; destination Y in pixels (tile << 4)
    wActiveActionID .word ?                    ; $000879 ; action type (e.g. 4 seize, 11+ scripted)

    wCastleSubMenuStep .word ?                 ; $00087B ; castle/map sub-action step
    wCastleCursorX .word ?                     ; $00087D ; castle menu cursor X
    wCastleCursorY .word ?                     ; $00087F ; castle menu cursor Y
    .fill 4                                    ; $000881
    wUnknown000885 .word ?                     ; $000885
    .fill 2                                    ; $000887

    wCastleListSubCount .word ?                ; $000889 ; items in the unit's inventory (0-7)
    wCastleScreenHandler .word ?               ; $00088B ; CASTLE_SCREEN_* (include/Castle.h)
    wCastleGridCursorXPixel .word ?            ; $00088D ; courtyard cursor X
    wCastleGridCursorYPixel .word ?            ; $00088F ; courtyard cursor Y
    wCastleCursorState .word ?                 ; $000891 ; CASTLE_CURSOR_* (include/Castle.h)
    wCastleUnitCommand .word ?                 ; $000893 ; CASTLE_COMMAND_* (include/Castle.h)
    wCastleTownFacility .word ?                ; $000895 ; CASTLE_TOWN_* (include/Castle.h)
    wCastleGridSlot .word ?                    ; $000897 ; 0-23, slot on the 4x6 courtyard grid
    wCastleGridSavedSlot .word ?               ; $000899 ; wCastleGridSlot kept while choosing a target
    wCastleSavedUnitRAMPointer .word ?         ; $00089B ; the unit that entered the castle ($FFFF none)
    wCastleReturnEventFlag .word ?             ; $00089D ; nonzero: rlUnknown8CED4F runs before the next conversation
    wEnteredCastleLocationID .word ?           ; $00089F ; location ID of the castle entered
    wCastleMenuOptionIndex .word ?             ; $0008A1 ; the keeper option under the cursor
    wCastleConfirmCursorIndex .word ?          ; $0008A3 ; yes/no cursor (0 yes, 1 no)
    wCastleListWindowRow .word ?               ; $0008A5 ; cursor row 0-7 in a scrolling list
    wCastleListSelectedIndex .word ?           ; $0008A7 ; the list entry under the cursor
    wCastleListItemState .word ?               ; $0008A9 ; ItemState a stock list collects
    wCastleListItemCount .word ?               ; $0008AB ; entries in the stock list

    wConversationFlags .word ?                 ; $0008AD ; the conversation scene's portraits:
      ; $0001 = left portrait shown (cleared when it has faded out)
      ; $0002 = right portrait shown
      ; $0004 = draw the left window frame sprite (rsPushConversationLeftFrame)
      ; $0008 = draw the right window frame sprite
      ; $0010 = load the left portrait and fade it in (rsConversationLoadPortraits)
      ; $0020 = load the right portrait and fade it in
      ; $0040 = send the left window's tiles (rsConversationDrawWindows)
      ; $0080 = send the right window's tiles
    lConversationDialoguePointer .long ?       ; $0008AF ; the dialogue the scene shows
    wConversationLeftUnit .word ?              ; $0008B2 ; left portrait: unit pointer, character or portrait ID, by step
    wConversationRightUnit .word ?             ; $0008B4 ; right portrait: likewise
    wConversationBackground .word ?            ; $0008B6 ; dialogue background (aDialogueBackgroundPointers)
    wConversationExitMode .word ?              ; $0008B8 ; CONVERSATION_EXIT_* (include/Castle.h)
    wCastleEventUnit .word ?                   ; $0008BA ; the unit whose castle entry event is running

  .endvirtual

  .virtual $0008DA

    wEpiloguePart .word ?       ; $0008DA ; EPILOGUE_PART_*: where rsOpenEpilogueScreen starts
    wEpilogueCharacter .word ?  ; $0008DC ; the character whose ending scene plays (25-63)

  .endvirtual

  .virtual $000AD3

    wEpilogueRecordCharacter .word ? ; $000AD3 ; the play record's current character (rlASMCRecordNextGeneration1Unit)

  .endvirtual

  .virtual $0008DE

    aOAMYBandCounters .block ; $0008DE (12 x .byte counters under sep #$20 in rlScanSpriteLineOverflow)
      bBand0  .byte ? ; $0008DE
      bBand1  .byte ? ; $0008DF
      bBand2  .byte ? ; $0008E0
      bBand3  .byte ? ; $0008E1
      bBand4  .byte ? ; $0008E2
      bBand5  .byte ? ; $0008E3
      bBand6  .byte ? ; $0008E4
      bBand7  .byte ? ; $0008E5
      bBand8  .byte ? ; $0008E6
      bBand9  .byte ? ; $0008E7
      bBand10 .byte ? ; $0008E8
      bBand11 .byte ? ; $0008E9
    .endblock
    .fill 6                                    ; $0008EA-$0008EF
    bOAMRenderedSpriteCount .byte ?            ; $0008F0 ; active OAM entry count >> 2

  .endvirtual



  .virtual $0008F1

    wUnknown0008F1 .fill (size(word) * 4) ; $0008F1
    .fill (size(word) * 4)                ; $0008F9
    wUnknown000901 .fill (size(word) * 4) ; $000901
    .fill (size(word) * 4)                ; $000909
    wUnknown000911 .fill (size(word) * 4) ; $000911
      ; Holds movement direction of a map sprite
    .fill (size(word) * 4)                ; $000919
    wUnknown000921 .word ?                ; $000921
      ; Is a bitfield

  .endvirtual





  .virtual $000D6A

    wCurrentChapter .word ?             ; $000D6A
    lChapterEventDataPointer .long ?    ; $000D6C
    wOptionSettings .word ?             ; $000D6F
      ; 0001 = autocursor off
      ; 0002 = terrain window off
      ; 0004 = unit window off
      ; 0008 / 0010 / 0020 = text speed
      ; 0040 = enemies fast
      ; 0080 = mono audio
      ; 0100 = audio off
      ; 0200 = autosave enabled
      ; 0400 / 0800 = autosave slot ID
      ; 1000 = clever mode enabled
      ; 2000 = animations off
      ; 4000 = animations by unit
      ; 8000 = not used?
    wAreaRestrictionBitfield .word ?  ; $000D71
    wDestroyedLocationsCount .word ?  ; $000D73
    bSavedPlayerCursorXTile .byte ?   ; $000D75 ; cursor X tile saved when entering castle / checked on turn 2+
    bSavedPlayerCursorYTile .byte ?   ; $000D76 ; cursor Y tile saved alongside bSavedPlayerCursorXTile
    wMainGameMode .word ?             ; $000D77 ; 2 = chapter map

  .endvirtual



  .virtual $000ADD

    ; The battle scene (include/BattleScene.h). Names scoped to the battle
    ; scene files in tools/name_ram.py.

    bBattleSceneLetterboxINIDISP .byte ? ; $000ADD ; INIDISP for the top 15 lines ($8F: blank)
    .byte ?                              ; $000ADE
    .byte ?                              ; $000ADF
    bBattleSceneRoundState    .byte ? ; $000AE0 ; BattleSceneRoundMayRun ...
    lBattleSceneRoundPointer  .long ? ; $000AE1 ; the next entry of aBattleRoundsData
    bBattleSceneStrikeFlags   .byte ? ; $000AE4 ; $08 miss, $10 struck, $40 critical, $80 waiting
    .byte ?                           ; $000AE5
    bBattleSceneRanged        .byte ? ; $000AE6 ; bit 0 is meant to be the round's ranged bit, but the set is never stored
    bBattleSceneRoundHighByte .byte ? ; $000AE7 ; the high byte of the current round entry
    bBattleSceneAttackerSide  .byte ? ; $000AE8 ; $80: combatant 2 attacks

  .endvirtual

  .virtual $000D44

    wBattleSceneAttackerTerrain .word ? ; $000D44 ; the initiator's terrain
    wBattleSceneDefenderTerrain .word ? ; $000D46
    bBattleSceneDistance        .byte ? ; $000D48
    wBattleSceneExperience      .word ? ; $000D49 ; aActionStructUnit1's, before the battle
    wBattleSceneExperienceGained .word ? ; $000D4B
    bBattleSceneLevel           .byte ? ; $000D4D ; level plus levels gained
    aBattleSceneCombatant1 .dstruct structBattleSceneCombatant ; $000D4E
    aBattleSceneCombatant2 .dstruct structBattleSceneCombatant ; $000D5C

  .endvirtual

  .virtual $7FE197

    bBattleSceneCameraXFraction .byte ? ; $7FE197
    wBattleSceneCameraX         .word ? ; $7FE198 ; BG scroll: a combatant's screen X is its X minus this

  .endvirtual

  .virtual $7FE1A4

    wBattleSceneCheckX   .word ? ; $7FE1A4 ; X tested by rlBattleSceneCheckOnScreen
    bBattleSceneCameraPan .byte ? ; $7FE1A6 ; signed pixels left to pan

  .endvirtual

  .virtual $7FE33A

    aBattleSceneBrightnessTableBuffer .fill $30 ; $7FE33A ; built by rsBattleSceneBuildBrightnessTable
    aBattleSceneBrightnessTable       .fill $30 ; $7FE36A ; the INIDISP HDMA table

  .endvirtual

  .virtual $7FE441

    ; Copies within bank $7F done in VBlank (rlBattleSceneQueueCopy): length - 1
    ; ($FFFF free), source, destination.
    aBattleSceneCopyQueue .brept 8 ; $7FE441
      .word ?, ?, ?
    .endrept

  .endvirtual

  .virtual $7FFC56

    bBattleSceneFade      .byte ? ; $7FFC56 ; low nibble brightness, $40 fading out, $80 fading
    bBattleSceneFadeDelay .byte ? ; $7FFC57 ; frames per brightness step
    bBattleSceneFadeTimer .byte ? ; $7FFC58
    wBattleSceneFlags     .word ? ; $7FFC59 ; BattleSceneFlagMelee ...

  .endvirtual

  .virtual $000AE9
    wBattleAnimationAttackerOffset .word ? ; $000AE9 ; $0000 or $0043
    wBattleAnimationDefenderOffset .word ? ; $000AEB ; $0043 or $0000
  .endvirtual

  .virtual $000AF3

    ; Battle animation combatants: two records of $43 bytes, the first from
    ; $0AF3 and the second from $0B36; code indexes them with X = 0 or $43.
    ; Positions are 8.8 pixels (engine/battle_scene/animation_moves.asm).
    ; Names scoped to the battle scene files in tools/name_ram.py.

    bBattleAnimationStateFlags      .byte ? ; $000AF3 ; $01 active, $02 paused, $04 busy, $08 airborne, $20 cleared by leap, $80 slot enabled
    bBattleAnimationFacingFlags     .byte ? ; $000AF4 ; $06 variant mask, $08 flip/dir, $60 cleared on sequence start
    bBattleAnimationCombatantFlags  .byte ? ; $000AF5 ; $40 flip/palette flag, $80 set by leap
    bBattleAnimationMotionFlags     .byte ? ; $000AF6 ; $01 free X motion
    bBattleAnimationRole            .byte ? ; $000AF7 ; 1 cast, 2/3 attacker/defender

    wBattleAnimationXFixed          .byte ? ; $000AF8: X in 8.8 (with wBattleAnimationX)
    wBattleAnimationX               .word ? ; $000AF9: whole pixels, 9 bits
    wBattleAnimationYAnchor         .word ? ; $000AFB: baseline Y subtracted by wBattleAnimationYFixed
    wBattleAnimationYFixed          .byte ? ; $000AFD: Y in 8.8 (with bBattleAnimationY)
    bBattleAnimationY               .byte ? ; $000AFE: whole pixels; the ground is $58
    wBattleAnimationTargetXFixed    .byte ? ; $000AFF: target X in 8.8
    wBattleAnimationTargetX         .word ? ; $000B00
                                    .fill 2
    wBattleAnimationTargetY         .word ? ; $000B04
                                    .fill 2
    wBattleAnimationXSpeed          .word ? ; $000B08: 8.8 pixels a frame, bit 15 leftward
    wBattleAnimationXDeceleration   .word ? ; $000B0A: $FFFF halves the speed each frame
    wBattleAnimationXStartSpeed     .word ? ; $000B0C
    wBattleAnimationYVelocity       .word ? ; $000B0E
    wBattleAnimationGravity         .word ? ; $000B10
                                    .fill 1
    wBattleAnimationYStep           .word ? ; $000B13

    bBattleAnimationDelayMultiplier1 .byte ? ; $000B15 ; 8.8 frame delay multiplier low/high
    bBattleAnimationDelayMultiplier2 .byte ? ; $000B16
    bBattleAnimationDrawOffsetX      .byte ? ; $000B17 ; signed X sprite draw offset
    bBattleAnimationDrawOffsetY      .byte ? ; $000B18 ; unsigned Y sprite draw offset
    lBattleAnimationFrameDataPointer .long ? ; $000B19 ; 24-bit animation/frame bank+table ptr
    bBattleAnimationSequenceID       .byte ? ; $000B1C ; current sequence ID
    bBattleAnimationPoseID           .byte ? ; $000B1D ; current frame/pose ID ($FE = hidden)
    bBattleAnimationPoseOffset       .byte ? ; $000B1E ; added to sequence/pose lookup
    wBattleAnimationScriptLoopOffset .word ? ; $000B1F ; start offset of animation sequence
    wBattleAnimationScriptOffset     .word ? ; $000B21 ; current animation script offset (+2 per command)
    bBattleAnimationFrameTimer       .byte ? ; $000B23 ; countdown frames for current pose
    wBattleAnimationBaseTile         .word ? ; $000B24 ; OAM base tile + bit 15 H-flip
    bBattleAnimationAttributes       .byte ? ; $000B26 ; OAM attributes (bit 3 $08 palette swap)
    lBattleAnimationSecondaryPointer1 .long ? ; $000B27 ; $0B27-$0B29
    lBattleAnimationSecondaryPointer2 .long ? ; $000B2A ; $0B2A-$0B2C
    wBattleAnimationSecondaryOffset  .word ? ; $000B2D ; $0B2D-$0B2E
    lBattleAnimationMoveListPointer  .long ? ; $000B2F ; $0B2F-$0B31 (move program pointer)
    wBattleAnimationMoveListLoopOffset .word ? ; $000B32 ; $0B32-$0B33
    wBattleAnimationMoveListOffset   .word ? ; $000B34 ; $0B34-$0B35

    ; Combatant 2 ($0B36-$0B78, mirror at +$43 accessed directly without X index)
    bBattleAnimation2StateFlags      .byte ? ; $000B36
    bBattleAnimation2FacingFlags     .byte ? ; $000B37
    bBattleAnimation2CombatantFlags  .byte ? ; $000B38
                                     .fill 1 ; $000B39
    bBattleAnimation2Role            .byte ? ; $000B3A
    wBattleAnimation2XFixed          .byte ? ; $000B3B
    wBattleAnimation2X               .word ? ; $000B3C
    wBattleAnimation2YAnchor         .word ? ; $000B3E
    wBattleAnimation2YFixed          .byte ? ; $000B40
    bBattleAnimation2Y               .byte ? ; $000B41
                                     .fill 7 ; $000B42-$000B48
                                     .fill 2 ; $000B49-$000B4A
    wBattleAnimation2XSpeed          .word ? ; $000B4B
                                     .fill 4 ; $000B4D-$000B50
    wBattleAnimation2YVelocity       .word ? ; $000B51
                                     .fill 3 ; $000B53-$000B55
    wBattleAnimation2YStep           .word ? ; $000B56
                                     .fill 4 ; $000B58-$000B5B
    lBattleAnimation2FrameDataPointer .long ? ; $000B5C
                                     .fill 10 ; $000B5F-$000B68
    bBattleAnimation2Attributes      .byte ? ; $000B69
                                     .fill 15 ; $000B6A-$000B78

  .endvirtual



  .virtual $000D79

    wChapterFlags .word ?        ; $000D79
      ; Flags of the chapter in progress, cleared by rlResetChapterProgress and
      ; rlAdvanceToNextChapter (rlMapSetup keeps only $4005). Bits:
      ; $0001 = the dialogue boxes' tilemaps have been drawn (rlRedrawDialogueBoxTilemaps)
      ; $0002 = a dialogue box changed: redraw their tilemaps next frame
      ; $0004 = deployment states changed: copy the state buffers next frame (rlApplyBufferedDeploymentStates)
      ; $0010 = set while a battle's rounds are built (engine/battle/battle.asm)
      ; $0020 = the castle screen is open: relocations refresh its units, battles are type 3
      ; $0040 = open the castle screen after the unit goes into the castle (rsRelocateIntoCastle)
      ; $0080 = the AI queued an event for the unit about to act (rsRunQueuedAIUnitEvent)
      ; $0100 = set by the map menu and bank $91; meaning unknown
      ; $0200 = the map step does not move the cursor (rsMapStepPhase)
      ; $0400 = the chapter has ended (rlSaveChapterTurncount); no seize popup
      ; $0800 = the minimap is choosing a Warp destination
      ; $1000 = a unit of the army acted this phase; disables the map save command
      ; $2000 = the active unit has a canto move to make (rsResumeCantoMove)
      ; $4000 = this chapter's first phase song has played (rlStartPhaseMusic)
      ; $8000 = set with $2000 by rlCheckActiveUnitCanto and by bank $9E; cleared by rsRunActionEndedEvents
    wSavedMapStep .word ?      ; $000D7B ; saved event/turn cycle state
    wUnknown000D7D .word ?        ; $000D7D ; set by rlRunEvents

  .endvirtual



    ; - $0004 update deployment status?
    ; - $0400 turncount saved?

  .virtual $000D7F

    wUnitRelocationDeploymentOffset .word ? ; $000D7F
    wUnitRelocationType             .word ? ; $000D81
    wUnitRelocationLocationID       .word ? ; $000D83
      ; What the map step does next for a unit after an action (UNIT_RELOCATION_*
      ; in include/Map.h): rlRunQueuedUnitRelocation runs it and sets the
      ; deployment offset back to $FFFF. Rescue stores type 9 and the player's
      ; castle, capture type 2 and the location where it happened.

  .endvirtual

  .virtual $000D85

    wDefeatedUnitDeploymentOffset .word ? ; $000D85
    wMapStateFlags .word ?                ; $000D87 ; bitfield:
      ; $0003 = post-action dispatch index into aQueuedUnitMenuOpeners
      ; $0004 = cursor hovering selectable unit/tile in rlGetMapMenuPosition
      ; $0008 = unit/action map menu open
      ; $0010 = secondary sub-menu open
      ; $0020 = AI/busy action lock blocking normal map menus
      ; $8000 = pending post-action handler dispatch
    wInventoryFullDeploymentOffset .word ?           ; $000D89 ; inventory-full & turn setup scratch
    wActionEndedDeploymentOffset .word ?           ; $000D8B ; faction/castle deployment helper
    wVillageGoldPopUpAmount .word ?           ; $000D8D ; phase state word

  .endvirtual

  .virtual $000D8F

    wCurrentTurn .word ?    ; $000D8F
    wActiveFactionSlot .word ?  ; $000D91
    aChapterTurncounts .fill 12 * size(word) ; $000D93

  .endvirtual

  .virtual $000DAB

    wPhaseSongID .word ?          ; $000DAB ; the active army's phase song (rlStartPhaseMusic)
    wPhaseMusicFadeTimer .word ?  ; $000DAD ; rsMapStepFadeOutMusic: $FFFF start the fade, then frames left

  .endvirtual

  ; The map battle HP windows' requests (engine/battle/map_battle_hud.asm): $4000 + n
  ; lose n HP, $0800 + n gain n HP, $1000 close, $0100 experience; the window sets
  ; $2000 while it works on one and 0 when done.

  .virtual $000DAF

    wMapBattleHPWindowLeftRequest .word ?  ; $000DAF
    wMapBattleHPWindowRightRequest .word ? ; $000DB1

  .endvirtual

  ; procMapExperienceWindow's counters, in the same place.

  .virtual $000DB1

    bMapExperienceWindowStepTimer .byte ?  ; $000DB1 ; frames to the next point
    bMapExperienceWindowSoundTimer .byte ? ; $000DB2 ; frames to the next tick sound

  .endvirtual

  ; procMapItemList's messages to procMapItemWeaponStats.

  .virtual $7E8BEC

    wMapItemListHoveredSlot .word ? ; $7E8BEC ; the slot under the cursor
    wMapItemListRequest .word ?     ; $7E8BEE ; bit 15: close; bit 14: show wMapItemListHoveredSlot
  .endvirtual

  .virtual $000DB3

    aOAMStripTailOffsets      .fill 32 ; $000DB3 ; 16 words: sprite buffer write/head offsets per Y-band
    aOAMStripReadOffsets      .fill 32 ; $000DD3 ; 16 words: cyclic read offsets per Y-band
    aOAMStripActiveCapacities .fill 32 ; $000DF3 ; 16 words: active per-band OAM quotas
    aOAMStripOverflowOffsets  .fill 32 ; $000E13 ; 16 words: overflow/secondary offsets
    aOAMStripTargetCapacities .fill 32 ; $000E33 ; 16 words: target per-band OAM quotas
    aOAMStripCooldownTimers   .fill 32 ; $000E53 ; 16 words: hysteresis countdowns
    wOAMStripFrameCounter     .word ?  ; $000E73 ; toggled lsr a each frame to alternate sprite priority
    wOAMStripCooldownReload   .word ?  ; $000E75 ; cooldown reload value (1 or $30)
    wOAMStripOverflowMode     .word ?  ; $000E77 ; 0 or 1

  .endvirtual 






  .virtual $000E7B

    bUnknown000E7B .byte ?            ; $000E7B
      ; $01 ?
      ; $02 ?
      ; $10 set at the beginning of AI cycles?
      ; $20 set before evaluating if an AI cycle should happen?
      ; $40 required for AI cycle?
      ; $80 skips AI cycle?
    wAIEngineCycleType .word ?        ; $000E7C
    wAIActiveFaction .word ?          ; $000E7E
    wAICurrentAISetting .word ?         ; $000E80
    wAISelectedAIUnitOffset .word ?   ; $000E82
    wAISelectedAITargetOffset .word ? ; $000E84
    wAICurrentAIUnitCounter .word ?   ; $000E86
    wAITargetXPosition .word ?        ; $000E88
    wAITargetYPosition .word ?        ; $000E8A
    wAIUnknown000E8C .word ?          ; $000E8C
    wAIUnknown000E8E .word ?          ; $000E8E
    lAITemp000E90 .long ?             ; $000E90
    lAITemp000E93 .long ?             ; $000E93
    wAITemp000E96 .word ?             ; $000E96
      ; Sometimes target x coord, sometimes a counter
    wAITemp000E98 .word ?             ; $000E98
      ; Sometimes target y coord, sometimes a counter
    wAITemp000E9A .word ?             ; $000E9A
      ; infliced damage
    wAITemp000E9C .word ?             ; $000E9C
      ; battle defense
    wAITemp000E9E .word ?             ; $000E9E
      ; battle hit
    wAITemp000EA0 .word ?             ; $000EA0
      ; weapon triangle bonus
    wAITemp000EA2 .word ?             ; $000EA2
      ; field movement / item effectiveness
    wAITemp000EA4 .word ?             ; $000EA4
      ; Item min+max range

    bEventStatus .byte ?                          ; $000EA6
      ; $0001 = runs opening events?
      ; $0002 = runs other events?
    wEventUnit1Pointer .word ?                    ; $000EA7
    wEventUnit2Pointer .word ?                    ; $000EA9
    lEventPointer .long ?                         ; $000EAB
    wEventEngineParameter1 .word ?                ; $000EAE
    wEventEngineParameter2 .word ?                ; $000EB0
    wEventEngineParameter3 .word ?                ; $000EB2
    wEventEngineParameter4 .word ?                ; $000EB4
    wEventCommandLength .word ?                   ; $000EB6
    wEventEngineGen2CharacterID1 .word ?          ; $000EB8
    wEventEngineGen2CharacterID2 .word ?          ; $000EBA
    bEventActionIdentifier .byte ?                ; $000EBC
      ; Known values (from the original author's notes; "?" marks guesses):
      ; $03 = after action
      ; $04 = enter home castle?
      ; $09 = visit village
      ; $0A = talk
      ; $11 = ?
      ; $14 = attack
      ; $17 = someone got killed?
      ; $18 = ?
      ; $20 = start player phase?
      ; $21 = before enemy action?
    wEventEngineArgument1 .word ?                 ; $000EBD
    wEventEngineArgument2 .word ?                 ; $000EBF
    wEventEngineArgument3 .word ?                 ; $000EC1
    wEventEngineArgument4 .word ?                 ; $000EC3
    lChapterEventRAMDataEntryPointer .long ?      ; $000EC5

    aProcSystem .block                            ; $000EC8
      wFlag .word ?                               ; $000EC8
      wOffset .word ?                             ; $000ECA
      lPointer .long ?                            ; $000ECC
      wInput0 .word ?                             ; $000ECF
      wInput1 .word ?                             ; $000ED1
      wInput2 .word ?                             ; $000ED3
      wInput3 .word ?                             ; $000ED5
      aHeaderTypeOffset .fill (size(word) * 16)   ; $000ED7
      aHeaderTypeBank .fill (size(word) * 16)     ; $000EF7
      aHeaderName .fill (size(word) * 16)         ; $000F17
      aHeaderBitfield .fill (size(word) * 16)     ; $000F37
      aHeaderOnCycle .fill (size(word) * 16)      ; $000F57
      aHeaderCodeOffset .fill (size(word) * 16)   ; $000F77
      aHeaderSleepTimer .fill (size(word) * 16)   ; $000F97
      aHeaderUnknownTimer .fill (size(word) * 16) ; $000FB7
      aBody0 .fill (size(word) * 16)              ; $000FD7
      aBody1 .fill (size(word) * 16)              ; $000FF7
      aBody2 .fill (size(word) * 16)              ; $001017
      aBody3 .fill (size(word) * 16)              ; $001037
      aBody4 .fill (size(word) * 16)              ; $001057
      aBody5 .fill (size(word) * 16)              ; $001077
      aBody6 .fill (size(word) * 16)              ; $001097
      aBody7 .fill (size(word) * 16)              ; $0010B7
      aUnknownBitfield .fill (size(word) * 16)    ; $0010D7
    .endblock

    aActiveSpriteSystem .block
      wFlag .word ?                           ; $0010F7
      wOffset .word ?                         ; $0010F9
      .word ?                                 ; $0010FB
      lPointer .long ?                        ; $0010FD
      aTypeOffset     .fill (size(word) * 16) ; $001100
      aBanks          .fill (size(word) * 16) ; $001120
      aUpdater        .fill (size(word) * 16) ; $001140
      aOnCycle        .fill (size(word) * 16) ; $001160
      aFrameTimer     .fill (size(word) * 16) ; $001180
      aCodeOffset     .fill (size(word) * 16) ; $0011A0
      aFrameOffset    .fill (size(word) * 16) ; $0011C0
      aUnknown0011E0  .fill (size(word) * 16) ; $0011E0
      aUnknown001200  .fill (size(word) * 16) ; $001200
      aUnknown001220  .fill (size(word) * 16) ; $001220
      aUnknown001240  .fill (size(word) * 16) ; $001240
      aUnknown001260  .fill (size(word) * 16) ; $001260
      aUnknown001280  .fill (size(word) * 16) ; $001280
      aUnknown0012A0  .fill (size(word) * 16) ; $0012A0
      aUnknown0012C0  .fill (size(word) * 16) ; $0012C0 ; holds mover index
      aUnknown0012E0  .fill (size(word) * 16) ; $0012E0
      aUnknown001300  .fill (size(word) * 16) ; $001300 ; holds movement direction
      aUnknown001320  .fill (size(word) * 16) ; $001320
      aUnknown001340  .fill (size(word) * 16) ; $001340
      aUnknown001360  .fill (size(word) * 16) ; $001360
      aUnknown001380  .fill (size(word) * 16) ; $001380
      aUnknown0013A0  .fill (size(word) * 16) ; $0013A0
      aUnknown0013C0  .fill (size(word) * 16) ; $0013C0
      aUnknown0013E0  .fill (size(word) * 16) ; $0013E0

    .bend

    ; $001400

  .endvirtual






  .virtual $0015E7

    aHDMASystem .block                   ; $0015E7
      wFlag .word ?                      ; $0015E7
      wOffset .word ?                    ; $0015E9
      lPointer .long ?                   ; $0015EB
      bPendingChannels .byte ?           ; $0015EE
      aTypeOffset .fill (size(word) * 8) ; $0015EF
      aTypeBank .fill (size(word) * 8)   ; $0015FF
      aBitfield .fill (size(word) * 8)   ; $00160F
      aOnCycle .fill (size(word) * 8)    ; $00161F
      aCodeOffset .fill (size(word) * 8) ; $00162F
      aSleepTimer .fill (size(word) * 8) ; $00163F
      aTimer .fill (size(word) * 8)      ; $00164F
      aOffset .fill (size(word) * 8)     ; $00165F
      aBankAndBBADx .brept 8             ; $00166F
        bBank .byte ?                    ; $00166F
        bBBADx .byte ?                   ; $001670
      .endrept
      aDMAPxAndIndirectBank .brept 8     ; $00167F
        bDMAPx .byte ?                   ; $00167F
        bIndirectBank .byte ?            ; $001680
      .endrept
    .bend

  .endvirtual































  .virtual $00171A

    wEventEngineFlags .word ? ; $00171A
      ; Nonzero while an event script runs (rlStartEventScript sets 9). $0002 the
      ; event waits for its procs, $0004 the event has procs (rlEventEngineCreateProc),
      ; $0008 cleared when a script starts, $8000 the event is fading out. The map
      ; step and many map routines do nothing while it is nonzero.
    wEventEngineState .word ? ; $00171C
      ; 0 begin the script, 1 run its commands, 2 end it (aEventEngineStateRoutines).
    wUnknown00171E .word ? ; $00171E
    wMapCurrentlyScrollingFlag .word ? ; $001720
    wEventUnitSlot1ID .word ? ; $001722
    wEventUnitSlot2ID .word ? ; $001724
    wEventUnitSlot1XCoordinate .word ? ; $001726
    wEventUnitSlot1YCoordinate .word ? ; $001728
    wEventUnitSlot2XCoordinate .word ? ; $00172A
    wEventUnitSlot2YCoordinate .word ? ; $00172C
    wEventEngineTruthFlag      .word ? ; $00172E
    wUnknown001730 .word ? ; $001730
    wUnknown001732 .word ? ; $001732

  .endvirtual


  .virtual $001736

    wActiveEventOffset  .word ?       ; $001736
    lActiveEventPointer .long ?       ; $001738
    wActiveEventLength  .word ?       ; $00173B
    .byte ?                           ; $00173D
    wEventMapScrollScript .long ?     ; $00173E
    wEventMapScrollSpeed .word ?      ; $001741

  .endvirtual

  .virtual $001745

    aEpilogue .block
      wCurrentEpilogueID .word ?        ; $001745
      wNextEpilogueID .word ?           ; $001747
        ; When current epilogue ID = this value, end dialogue
        ; and let the event code call the next epilogue dialogue.
      .union
        wRegionID .word ?               ; $001749
        wRegionEpilogueCounter .word ?  ; $001749
        ; Lower byte region ID, high byte counter for how many
        ; units of that region displayed their epilogue.
      .endunion
      wUnknown00174B .word ?            ; $00174B
      wUnknown00174D .word ?            ; $00174D
      wUnknown00174F .word ?            ; $00174F
      wChosenDialogueID .word ?         ; $001751
    .bend

  .endvirtual

  .virtual $00176D

    wEventProcOffsets .fill (size(word) * 16) ; $00176D
    wEventProcBanks   .fill (size(word) * 16) ; $00178D
    ; $0017AD

  .endvirtual

  .virtual $0017BE

    aMovingMapSprites .block  ; $0017BE

      wOffset .word ?  ; $0017BE
      wUnknown0017C0 .word ?      ; $0017C0 ; map sprite ID, if 0 use characters map sprite
      wUnknown0017C2 .word ?      ; $0017C2 ; $10 = DisappearOffscreenFlag
      wActiveSpriteOffset .fill (size(word) * 4)    ; $0017C4
      wUnknown0017CC .fill (size(word) * 4)         ; $0017CC
      wXPixelPosition .fill (size(word) * 4)        ; $0017D4
      wYPixelPosition .fill (size(word) * 4)        ; $0017DC
      wPathScriptAddress .fill (size(word) * 4)     ; $0017E4
      wPathScriptBank .fill (size(word) * 4)        ; $0017EC
      wPathScriptOffset .fill (size(word) * 4)      ; $0017F4
      wSpeed .fill (size(word) * 4)                 ; $0017FC
      wUnknown001804 .fill (size(word) * 4)         ; $001804
        ; Sprite color
      wMovingSound .fill (size(word) * 4)           ; $00180C
        ; Low byte is sound ID, high byte is volume?
      wUnknown001814 .fill (size(word) * 4)         ; $001814
      wUnknown00181C .word ?                        ; $00181C
      wState .word ?                                ; $00181E
        ; 0 = nothing to do
        ; 1 = movement queued
        ; 2 = movement script done
      wEntryIndex    .word ?                        ; $001820
      wUnknown001822 .word ?                        ; $001822
      wUnknown001824 .word ?                        ; $001824
      wCharacterID   .word ?                        ; $001826
      wSpawnXCoordinate .word ?                     ; $001828
      wSpawnYCoordinate .word ?                     ; $00182A
      wDestinationXCoordinate .word ?               ; $00182C
      wDestinationYCoordinate .word ?               ; $00182E
      wUnknown001830 .word ?                        ; $001830 
        ; 0 or 1?

    .bend

      .word ?                                       ; $001832
    aEventScriptBuffer .fill $22                    ; $001834
      ; May be bigger

  .endvirtual


  .virtual $001854

    ; The save menu screen's variables (engine/save/save_menu.asm). The menu is a
    ; list of rows: on the title file menu the commands, on a slot list a heading
    ; row and the four slots. The Jugdral history scroll reuses two of them.

    wSaveMenuNextStep .word ?       ; $001854
      ; The step to go to once the rows are drawn (rsSaveMenuDrawRows).
    wSaveMenuRowsDrawn .word ?      ; $001856
      ; Rows drawn so far; also the row type whose text is being rendered.
    wSaveMenuRowCount .word ?       ; $001858
    wSaveMenuCommandRow .word ?     ; $00185A
      ; The file menu's cursor row. The history scroll: the entry being drawn.
    aSaveMenuRowTypes .fill 6       ; $00185C
      ; One byte per row: 1-9 a command or heading (aSaveMenuRowTexts), 10 an
      ; empty slot, 11-14 a used slot 1-4.
    wSaveMenuWindowPosition .word ? ; $001862
      ; Low byte the column, high byte the row (tiles).
    wSaveMenuSlotRow .word ?        ; $001864
      ; The slot list's cursor row (1-4), $FFFF while the command rows show.
      ; The history scroll: lines scrolled.
    wSaveMenuConfirm .word ?        ; $001866
      ; The yes/no window: 0 closed, 1 yes, 2 no.

  .endvirtual





  .virtual $001868

    aDialogue .block ; $001868

      wSlotOffset               .word ? ; $001868
      lActivePointer            .long ? ; $00186A
      lActivePointerStack1      .long ? ; $00186D
      lActivePointerStack2      .long ? ; $001870
      lActivePointerStack3      .long ? ; $001873
      lActivePointerStack4      .long ? ; $001876
      lActivePointerStack5      .long ? ; $001879
      lActivePointerStack6      .long ? ; $00187C
        ; Some commands can change the active pointer temporarily
        ; and the original one is then pushed into the next slot.
        ; This can be done up to 6 times before the dialogue system
        ; skips commands that change the pointer further.
      lUnknown00187F            .long ? ; $00187F
      wStatus                   .word ? ; $001882
      wCommandCycle             .word ? ; $001884
      wUnknown001886            .word ? ; $001886
      wTextSpeed                .word ? ; $001888
      wPauseTimer               .word ? ; $00188A
      wUnknown00188C            .word ? ; $00188C
      wUnknown00188E            .word ? ; $00188E
      wUnknown001890            .word ? ; $001890
      wUnknown001892            .word ? ; $001892
      bFontPage                 .byte ? ; $001894
      wCurrentCharacter         .word ? ; $001895
      wGraphicBufferPixelOffset .word ? ; $001897
        ; Gets adjusted to 0-7 pixel range
      wStringPixelLength        .word ? ; $001899
      wTextSound                .word ? ; $00189B
      wClearTile                .word ? ; $00189D
      wBaseTile                 .word ? ; $00189F ; X indexed?
      wFreeHDMATable            .word ? ; $0018A1
      wUnknown0018A3            .word ? ; $0018A3
      wUnknown0018A5            .word ? ; $0018A5
      wUnknown0018A7            .word ? ; $0018A7
      wUnit1                    .word ? ; $0018A9
      wUnit2                    .word ? ; $0018AB
      wNumber1                  .word ? ; $0018AD
      wNumber2                  .word ? ; $0018AF
      wItemID                   .word ? ; $0018B1
      wClassID                  .word ? ; $0018B3

      .fill $0018C3 - *

      lFontGraphics             .long ? ; $0018C3
      lFontWidthTable           .long ? ; $0018C6
      wUnknown0018C9            .word ? ; $0018C9 ; current size to copy to VRAM
      wUnknown0018CB            .word ? ; $0018CB ; current VRAM destination
      lHDMARoutine              .long ? ; $0018CD
      wUnknown0018D0            .word ? ; $0018D0 ; dialogue type? 1 = BG, 2 = no BG?

      _Slot .brept 2

        wUnknown0018D2        .word ? ; $0018D2 ; handled a character flag?
        lBGBufferPosition     .long ? ; $0018D4
        wVRAMAddress          .word ? ; $0018D7
        wUnknown0018D9        .word ? ; $0018D9
        .union
          wDisplayArea        .word ? ; $0018DB
          .struct
            bDisplayWidth     .byte ? ; $0018DB
            bDisplayHeight    .byte ? ; $0018DC
          .endstruct
        .endunion
        wBGBufferOffset       .word ? ; $0018DD
        wVRAMTileOffset       .word ? ; $0018DF
        wUnknown0018E1        .word ? ; $0018E1
        wUnknown0018E3        .word ? ; $0018E3
        wPortraitID           .word ? ; $0018E5 ; can also be portrait RAM address?
        wUnknown0018E7        .word ? ; $0018E7
        wUnknown0018E9        .word ? ; $0018E9

      .endrept

      .fill $001907 - * ; $001904

      aCharacterGraphicsBuffer .fill $200 ; $001907
      ; $001B07

    .bend

  .endvirtual


  .virtual $001B09

    aSave .block
      wUnknown001B09 .word ?            ; $001B09
      wMenuOperation .word ?            ; $001B0B
        ; 1 indexed
        ; $8000 flag set = load, else save
      wActiveSlot .word ?               ; $001B0D
      wActiveSaveData .word ?           ; $001B0F
        ; $00000111 = save ID
        ; $01111000 = completion count
      aSlotDataBuffer .brept 4          ; $001B11
        .word ?
      .endrept
      wGameTimerLow .word ?             ; $001B19
      wGameTimerHigh .word ?            ; $001B1B
      wCharacterID .word ?              ; $001B1D
      wCharacterDeploymentState .word ? ; $001B1F
      wCharacterXPosition .word ?       ; $001B21
      wCharacterYPosition .word ?       ; $001B23
      wStructIndex .word ?              ; $001B25
      wStructCount .word ?              ; $001B27
      wSlotDataToMatch .word ?          ; $001B29
        ; rlRecordUnitLoss: this save's slot data word (chapter and save ID).
      aFactionEntryOffsets .brept 7     ; $001B2B
        .word ?
      .endrept
      wCreatedUnitType .word ?          ; $001B39
        ; The unit type (0 static, 1 dynamic, 2 holy, 3 enemy) of the unit
        ; rlCreateUnitFromBuffers is building.
      wCurrentBitOffset .word ?         ; $001B3B
      wAvtiveSaveSlotOffset .word ?     ; $001B3D
      wDataBitLength .word ?            ; $001B3F
    .bend

    aPaletteFading .block
      wMaxSteps .word ?                   ; $001B41
      wDesiredColor .word ?               ; $001B43
      wCurrentStep .word ?                ; $001B45
      wCurrentPaletteBufferOffset .word ? ; $001B47
    .bend

    wDemoIndex .word ?        ; $001B49 ; the attract demo to show (rlSetDemoIndexFromRanking)
    wDemoRestartIndex .word ? ; $001B4B ; where wDemoIndex starts again

  .endvirtual


  .virtual $000CC2

    wDemoBattlePair .word ? ; $000CC2
      ; Which pair of battle scenes the opening plays (aDemoBattlesPointerTable
      ; holds two per entry): counts down after each opening, and from 0
      ; starts again at the highest completion count, at most 15
      ; (rlASMCLoadNextDemoBattle).

  .endvirtual


  .virtual $001C00

    aSpriteBuffer .fill (128 * size(structPPUOAMEntry)) ; $001C00
    aSpriteExtBuffer .fill ((128 * 2) / 8)              ; $001E00
    wNextFreeSpriteOffset .word ?                       ; $001E20

  .endvirtual






  .virtual $7E2000

    wSonUnitRAMPointer .word ?       ; $7E2000
    wDaughterUnitRAMPointer .word ?  ; $7E2002

  .endvirtual


  .virtual $7E2000 ; some general use ram

    wDebugMenuSkillCounter .word ? ; $7E2000
    aDebugMenuSkillFlags .block    ; $7E2002
      bUnknown1     .byte ?
      bCanto        .byte ?
      bPavise       .byte ?
      bWrath        .byte ?
      bPursuit      .byte ?
      bAdept        .byte ?
      bSteal        .byte ?
      bUnknown2     .byte ?
      bDance        .byte ?
      bUnknown3     .byte ?
      bUnknown4     .byte ?
      bUnknown5     .byte ?
      bCharm        .byte ?
      bUnknown6     .byte ?
      bNihil        .byte ?
      bMiracle      .byte ?
      bCritical     .byte ?
      bVantage      .byte ?
      bAccost       .byte ?
      bAstra        .byte ?
      bLuna         .byte ?
      bSol          .byte ?
      bHoly         .byte ?
      bDarkness     .byte ?
      bRenewal      .byte ?
      bParagon      .byte ?
      bUnknown7     .byte ?
      bUnknown8     .byte ?
      bBargain      .byte ?
      bUnknown9     .byte ?
    .bend
  .endvirtual




  ; $7E2000 - some table for unit RAM pointers indexed by unit number?




  ; The unit menu's lists of usable inventory slots, built by rlBuildUnitMenuSlotLists at the
  ; unit's tile: each is a count byte, then up to seven slot numbers. The AI uses
  ; this area for other things (below). Scoped in tools/name_ram.py.

  .virtual $7E2000

    aUnitMenuWeaponSlots .fill 8       ; $7E2000 ; weapons with a target in range (attack)
    aUnitMenuStaffSlots .fill 8        ; $7E2008 ; staves with a target on the map
    aUnitMenuAssaultSlots .fill 8      ; $7E2010 ; weapons with an enemy at a castle in range (assault)
    aUnitMenuItemSlots .fill 8         ; $7E2018 ; usable items
    aUnitMenuEquipSlots .fill 8        ; $7E2020 ; equippable weapons
    aUnitMenuCastleStaffSlots .fill 8  ; $7E2028 ; staves with a target in the castle

  .endvirtual

  ; AI:

  .virtual $7E2000

    wAIUnknownBitfield7E2000 .word ?        ; $7E2000
    ; $0001 = finished with targeting cycle?
    ; $0004 = any foe in groups threat range
    ; $0008 = group leader dead
    ; $0010 = group leader is guarding castle
    ; $0020 = group has a target tile?
    ; $0040 = group leader fielded
    ; $0080 = ?
    ; $0100 = ?
    ; $0200 = ?
    wAIUnknown7E2002 .word ?                ; $7E2002
      ; 4 and 5 skip filling targets range map
    wAIFormationType .word ?                ; $7E2004
    wAIFormationDirection .word ?           ; $7E2006
    wAIGroupLeaderFieldMovement .word ?     ; $7E2008
    wAIGroupHighestItemRange .word ?        ; $7E200A
    wAIGroupLeaderXPosition .word ?         ; $7E200C
    wAIGroupLeaderYPosition .word ?         ; $7E200E
    wAIUnknown7E2010 .word ?                ; $7E2010
    wAIUnknown7E2012 .word ?                ; $7E2012
    wAIUnknown7E2014 .word ?                ; $7E2014
    wAIUnknown7E2016 .word ?                ; $7E2016
    wAIUnknown7E2018 .word ?                ; $7E2018 ; Target value?
    wAIGroupObjective .word ?                ; $7E201A ; some ID, action, for aAIGroupObjectiveRoutines
    wAIUnknown7E201C .word ?                ; $7E201C
    wAIIgnoredGenerationID .word ?          ; $7E201E
    wAIGroupLeaderDeploymentOffset .word ?  ; $7E2020
    wAIUnitCounter .word ?                  ; $7E2022
    aAIUnitList .brept 24                   ; $7E2024
      .dstruct structAIUnitEntry
    .endrept
    ; $7E2174
  .endvirtual







  .virtual $7E2180
    aFactionArea .fill 195                  ; $7E2180
      ; Has 7 FactionSlot offsets (+the free space offset), each offset with its own structFactionHeader and then short pointers to unit RAM data
      ; The size is weird

    aUnitRAMPointers .block                 ; $7E2243
      _Header .structRAMStructHeader
      _Entry .brept 72                      ; $7E2247
        .word ?
      .endrept
    .bend

    aUnitRAMArea .block                     ; $7E22D7
      _Header .structRAMAreaHeader
      _Entry .brept 72
        .structRAMAreaEntryHeader
        .structCharacterDataRAM
      .endrept
    .bend

    aStaticUnitRAMArea .block               ; $7E29E7
      _Header .structRAMAreaHeader
      _Entry .brept 24
        .structRAMAreaEntryHeader
        .structPersonalCharacterDataRAM
        .structExtendedCharacterDataRAM
      .endrept
    .bend

    aDynamicUnitRAMArea .block              ; $7E2D4F
      _Header .structRAMAreaHeader
      _Entry .brept 17
        .structRAMAreaEntryHeader
        .structPersonalCharacterDataRAM
        .structExtendedCharacterDataRAM
        .structCharacterConstantData
      .endrept
    .bend

    aHolyAndEnemyRAMArea .block             ; $7E3131
      _Header .structRAMAreaHeader
      _Entry .brept 63
        .structRAMAreaEntryHeader
        .structPersonalCharacterDataRAM
      .endrept
    .bend

    aInventoryRAMArea .block               ; $7E3664
      _Header .structRAMAreaHeader
      _Entry .brept 72+1
        .structRAMAreaEntryHeader
        .structInventoryDataRAM
      .endrept
    .bend

    aLoverRAMArea .block                    ; $7E3BD7
      _Header .structRAMAreaHeader
      _Entry .brept 9
        .structLoverDataRAM
      .endrept
      .fill 9 * 6
    .bend

    aUnitWinCounts .block               ; $7E3D23
      _Gen1 .brept 24
        .word ?
      .endrept
      _Gen2 .brept 24                   ; $7E3D53
        .word ?
      .endrept
    .bend

    wTotalLevelUpCount .word ?          ; $7E3D83
    wTotalAlivePlayerUnitCount .word ?  ; $7E3D85
    aItemRAMData .block
      _Header .structRAMStructHeader    ; $7E3D87
      _Entry .brept 256
        .structItemRAMEntry
      .endrept
    .bend

    aDeploymentTable .block
      _State .fill (size(word) * 72)              ; $7E438B
      _XTilePosition .fill (size(word) * 72)      ; $7E441B
      _YTilePosition .fill (size(word) * 72)      ; $7E44AB
      _XPixelPosition .fill (size(word) * 72)     ; $7E453B
      _YPixelPosition .fill (size(word) * 72)     ; $7E45CB
      _DeploymentOffsets .fill (size(word) * 72)  ; $7E465B
      _UnitRAMPointer .fill (size(word) * 72)     ; $7E46EB
      _FactionSlot .fill (size(word) * 72)        ; $7E477B
      _MapSpriteID .fill (size(word) * 72)        ; $7E480B
      _StateBuffer .fill (size(word) * 72)        ; $7E489B
    .bend

    wSavedDeploymentXTile .word ? ; $7E492B: saved by rlMoveDeploymentToTile and rlSaveDeploymentTile
    wSavedDeploymentYTile .word ? ; $7E492D

    ; 7E492F


  .endvirtual


  .virtual $7E4E45

    aChapterLocationRAMData .fill 16 * size(byte)               ; $7E4E45
    aChapterLocationMoneyRewards .fill 16 * size(word)          ; $7E4E55
    aCastleUnitDeploymentOffsets .fill 24 * size(word)              ; $7E4E75
    aChapterActiveMapChanges .fill 8                            ; $7E4EA5
      ; Unsure about the size

  .endvirtual

  .virtual $7E4EA9

    aScriptedUnitMapAction .fill 26 ; $7E4EA9

    ; $7E4EC3

  .endvirtual

  .virtual $7E4EA9

    wBattleType .byte ? ; $7E4EA9
      ; 0 = normal
      ; 1 = arena
      ; 2 = ? (forced anims on?)
      ; 3 = ?
    wBattleStatus   .byte ? ; $7E4EAA
      ; $40 - battle anim off
      ; $20 - ?
      ; $10 - ?
      ; $08 - siege offense (guard attacks)
      ; $04 - siege defense (guard defends)
      ; $01 - enemy initiator
      ; $00 - player initiator

    wBattleDistance .word ? ; $7E4EAB
    wBattleQuotePointer .long ? ; $7E4EAD
    wDeathQuotePointer  .long ? ; $7E4EB0
    wBattleSong .word ? ; $7E4EB3

    aActionStructUnit1 .structActionStructEntry ; $7E4EB5
    aActionStructUnit2 .structActionStructEntry ; $7E4F15

    wBattleCriticalType .word ? ; $7E4F75
      ; $8000 actually critting
      ; 0 = natural crit
      ; 1 = sibling crit
      ; 2 = lover crit
      ; 3 = triangle attack

    .word ? ; 7E4F77
    .word ? ; 7E4F79
    .word ? ; 7E4F7B
    .word ? ; 7E4F7D
    .word ? ; 7E4F7F

    aBattleRoundsData .block
      _Header .structRAMStructHeader  ; $7E4F81
      _Entry .brept 40 *2
        .word ?
      .endrept
    .bend

    wAITargetCounter .word ?          ; $7E5025
    aAITargetList .brept 48           ; $7E5027
      .dstruct structAITargetEntry
    .endrept

    aPermanentEventFlags .fill len(bytes(%1 x 256)) ; $7E5297

    aChapterEventRAMData .block                     ; $7E52B7
      _Header .structRAMStructHeader
      _Entry .brept 3
        .structChapterEventRAMEntry
      .endrept
    .bend

    ; 7E52EE

  .endvirtual



  .virtual $7E4EC5

    ; This overlaps with aActionStructUnit1

    aChildAverageLevelStats .block
      HP          .word ? ; 7E4EC5
      Strength    .word ? ; 7E4EC7
      Magic       .word ? ; 7E4EC9
      Skill       .word ? ; 7E4ECB
      Speed       .word ? ; 7E4ECD
      Defense     .word ? ; 7E4ECF
      Resistance  .word ? ; 7E4ED1
      Luck        .word ? ; 7E4ED3
    .bend

  .endvirtual

  .virtual $7E5315

    wUnitWindowPage .word ?      ; $7E5315
      ; The unit window's page, sort direction (0 descending, else ascending) and
      ; sort type. They are saved with the game. Names after FE5 (wUnitWindowCurrentPage...).
    wUnitWindowSortDirection .word ?      ; $7E5317
    wUnitWindowSortType .word ?      ; $7E5319
    aUnitJoinOrder .brept 24    ; $7E531B
      .word ?
    .endrept
    ; Is indexed by unit generation ID and stores value of how many player units existed when unit was loaded.
    ; If someone dies, their value gets zero'd, and anyone with a higher value gets decremented.

    .fill 3 ; $7E534B

    wEpilogueOtherUnitsExistFlag .word ? ; $7E534E
    aEpilogueUnitMovement .block
      wCharacterID .word ?              ; $7E5350
      wStartingCoordinates .word ?      ; $7E5352
      wDestinationCoordinates .word ?   ; $7E5354
      wMovementData .byte ?             ; $7E5356
    .bend

    ; $7E5358

  .endvirtual




  .virtual $7E7358

    aUnitLossesCount .brept 48 ; $7E7358
      .byte ?
    .endrept

    ; $7E7388

  .endvirtual





  .virtual $7E6388

    aBG1TilemapBuffer .block             ; $7E6388
      Page0 .fill (32 * 32 * size(word)) ; $7E6388
      Page1 .fill (32 * 32 * size(word)) ; $7E6B88
      .endblock

    aBG2TilemapBuffer .block             ; $7E7388
      Page0 .fill (32 * 32 * size(word)) ; $7E7388
      Page1 .fill (32 * 32 * size(word)) ; $7E7B88
      .endblock

    aBG3TilemapBuffer .block             ; $7E8388
      Page0 .fill (32 * 32 * size(word)) ; $7E8388
      Page1 .fill (32 * 32 * size(word)) ; $7E8B88
      .endblock

  .endvirtual

  .virtual $7E8B88

    aDecompressionBuffer .fill ($7F0000 - *) ; $7E8B88
    ; IDK when this ends

  .endvirtual

  .virtual $7E8B88

    aEventMovement .block

      aMapTraversalList .fill $800 ; $7E8B88
      aMovementCostMap .fill $1000 ; $7E9388
        ; Stores movement cost +1, any tile with a unit gets +8
      .fill 64  ; $7EA388
        ; Clear area to not mess with the aTargetDistanceMap when looking for
        ; tiles upwards
      aTargetDistanceMap .fill $1000 ; $7EA3C8
        ; Holds the distance of each tile from the destination point to the specified units tile.
      .fill 64 ; $7EB3C8
        ; Clear area for aTargetDistanceMap downwards
      .fill 64 ; $7EB408
        ; Clear area for aTargetMap upwards
      aTargetMap .fill $1000 ; $7EB448
        ; The tile index with the target marked with a 0.
      .fill 64 ; $7EB408
        ; Clear area for aTargetMap downwards
      wMovementCostPointer .word ?    ; $7EC488
      wEntryIndex .word ?    ; $7EC48A
      wUnitXCoordinate .word ?    ; $7EC48C
      wUnitYCoordinate .word ?    ; $7EC48E
        ; Coordinates where the unit to me moved is before the movement.
      wDestinationXCoordinate .word ?    ; $7EC490
      wDestinationYCoordinate .word ?    ; $7EC492
        ; Coordinates where the unit is supposed to move to.
      wUnknown7EC494 .word ?    ; $7EC494
        ; 0 or 1?
      wStartingXCoordinate .word ?    ; $7EC496
      wStartingYCoordinate .word ?    ; $7EC498
        ; Starting spot where the routine generates a distance map from.
        ; Equal to the Destination coorinates.
      wTargetXCoordinate .word ?    ; $7EC49A
      wTargetYCoordinate .word ?    ; $7EC49C
        ; First found target in the target map.
        ; Equal to the Units coorinates.
      .union
        .struct
          wRunningMovementCost .word ?            ; $7EC49E
          wAnalyzeTraversalOffset .word ?         ; $7EC4A0
          wMapTraversalListOffset .word ?         ; $7EC4A2
          wFilledMapTraversalListFlag .word ?     ; $7EC4A4
        .endstruct
        .struct
          wMovementScriptBufferAddress .word ?    ; $7EC49E
          wLowestMovementDistance .word ?         ; $7EC4A0
          wMapTileIndex .word ?                   ; $7EC4A2
          wMaxScriptCommandsCount .word ?         ; $7EC4A4
        .endstruct
      .endunion
      aMovementScriptBuffer1 .fill $200           ; $7EC4A6
      aMovementScriptBuffer2 .fill $200           ; $7EC6A6
      aMovementScriptBuffer3 .fill $200           ; $7EC8A6
      aMovementScriptBuffer4 .fill $200           ; $7ECAA6
      aScriptStartXCoordinate .fill size(word)* 4 ; $7ECCA6
      aScriptStartYCoordinate .fill size(word)* 4 ; $7ECCAE
      aScriptEndXCoordinate .fill size(word)* 4   ; $7ECCB6
      aScriptEndYCoordinate .fill size(word)* 4   ; $7ECCBE
    .bend

    wActionStructAttackerDeploymentNumber .word ? ; $7ECCC6
    wActionStructDefenderDeploymentNumber .word ? ; $7ECCC8
    wActionStructUnit1DeploymentNumber    .word ? ; $7ECCCA
    wActionStructUnit2DeploymentNumber    .word ? ; $7ECCCC

  .endvirtual



  .virtual $7ECCD6

    wBattleAttackerIndex    .word ? ; $7ECCD6
      ; 0 = player
      ; 1 = enemy
    wActionStructAttacker   .word ? ; $7ECCD8
    wActionStructDefender   .word ? ; $7ECCDA
    wBattleActivatedSkill   .word ? ; $7ECCDC
    bBattleRoundFlags .byte ? ; $7ECCDE
      ; "ＥＭＴＤＤＣＡＴ"
      ; $00 = player
      ; $01 = enemy
      ; $02 = staff action?
      ; $04 = crit
      ; $08 = miss
      ; $10 = vs julius, arena and not trigger skill 1 set?
      ; $20 = ranged
      ; $40 = magic
  .endvirtual

  .virtual $7ECCE8

    wBattleTempVariable .word ? ; $7ECCE8
      ; A temporary of the battle calculations: a location ID, a class weakness,
      ; a number of strikes or a side, depending on the routine.

  .endvirtual

  .virtual $7ECCE6

    wScriptedCombatFlags .word ? ; $7ECCE6
      ; $01 = If set: attacker attacks first, else defender
      ; $02 = If set: regular fight, else arena?
      ; $04 = If set: Crit
      ; $08 = If set: miss, else hit
      ; $10 = Fixed Crit/Hit/Miss based on $04/$08

  .endvirtual

  ; .word ? ; $7ECCE8 - various things




  .virtual $7ECB88

    aWorldMapMarkerPalette .fill size(word) * 7 ; $7ECB88

  .endvirtual






  .virtual $7EDB88

    aMovingMapSpriteData .brept 4 ; $7EDB88 / $7EDC08 / $7EDC88 / $7EDD08
      wCharacterID        .word ? ; $00
      aSpawnCoordinates   .word ? ; $02
      .union
        bSpeed            .byte ? ; $04 ; lower nybble
        bFlags            .byte ? ; $04 ; upper nybble
        ; if bit $10 set, set bit $10 of wUnknown0017C2, DisappearOffscreenFlag
        ; if $80 set, check if char is dead, skip movement if so
      .endunion
      bAllegianceColor    .byte ? ; $05
      lPathScriptPointer  .long ? ; $06
      .fill $77                   ; $09
    .endrept

  ; $7EDD88

  .endvirtual











  .virtual $7EFF00

    aDialogueHDMATable1 .fill $80 ; $7EFF00
    aDialogueHDMATable2 .fill $80 ; $7EFF80

  .endvirtual


  .virtual $7F2000

    aTerrainTileset .fill $400 ; $7F2000
      ; This is a terrain byte for each tile in the tileset.
    aMapData .fill $1000 * size(word) ; $7F2400
      ; This holds the entire 64x64 map with each tile being a word-sized aTerrainTileset ID.

    .word ? ; $7F4400

    aAIAction .block ; 7F4402
      wUnknown7F4402 .word ?                  ; $7F4402 ; index for 86A035: 0 = silence foe, 1 = attack injured, 2 = regular attack?
      wTargetXPosition .word ?                ; $7F4404
      wTargetYPosition .word ?                ; $7F4406
      wAttackTileMapTileIndex .word ?         ; $7F4408
      wAttackTileXPosition .word ?            ; $7F440A
      wAttackTileYPosition .word ?            ; $7F440C
      wAttackMapTileIndexModifier .word ?     ; $7F440E
      wAttackTileXPositionModifier .word ?    ; $7F4410
      wAttackTileYPositionModifier .word ?    ; $7F4412
      .word ?                                 ; $7F4414
      .word ?                                 ; $7F4416
      wMapWidth .word ?                       ; $7F4418
      wMapHeight .word ?                      ; $7F441A
      wAttackChance .word ?                   ; $7F441C
      .word ?                                 ; $7F441E
      wMinimumAttackRange .word ?             ; $7F4420
      wMaximumAttackRange .word ?             ; $7F4422
      .word ?                                 ; $7F4424
      wAttackDirection .word ?                ; $7F4426
      wAdditionalAttackDirections .word ?     ; $7F4428
      wMapPointer .word ?                     ; $7F442A
      wUnknown7F442C .word ?                  ; $7F442C ; active faction/counter/?
      wUnitFaction .word ?                    ; $7F442E
      wUnitMovementCostPointer .word ?        ; $7F4430
      wUnknown7F4432 .word ?                  ; $7F4432
      wBestAttackChance .word ?               ; $7F4434
      wUnitToChosenTargetDistance .word ?     ; $7F4436
      wLeadershipPower .word ?                ; $7F4438
      wDestinationXPosition .word ?           ; $7F443A
      wDestinationYPosition .word ?           ; $7F443C
      wChosenTargetDeploymentOffset .word ?   ; $7F443E
      wUnknown7F4440 .word ?                  ; $7F4440 ; interaction type id? 0 = attack, 8 = silence?
      wUnitInventorySlot .word ?              ; $7F4442
      wUnitItemMinimumRange .word ?           ; $7F4444
      wUnitItemMaximumRange .word ?           ; $7F4446
      wUnknown7F4448 .word ?                  ; $7F4448 ; value of wAIUnknown7E2002 or 5 if guarding castle, index for aAIAttackTypeRoutines
      wUntDeploymentOffset .word ?            ; $7F444A
      wTargetDeploymentOffset .word ?         ; $7F444C
      wAttackTileTerrainType .word ?          ; $7F444E
      wUnitCurrentHP .word ?                  ; $7F4450
      wExpectedInflictedDamage .word ?        ; $7F4452
      wExpectedTakenDamage .word ?            ; $7F4454
      wTargetHPBonus .word ?                  ; $7F4456
      wUnitHPPenalty .word ?                  ; $7F4458
      wMovementDistanceToTarget .word ?       ; $7F445A ; needs checking
      wUnknown7F445C .word ?                  ; $7F445C ; some value based on attack range around target?
      wUnitToAttackTileDistance .word ?       ; $7F445E
      wTargetToAttackTileDistance .word ?     ; $7F4460
      .word ?                                 ; $7F4462
      wAttackTileThreatValue .word ?          ; $7F4464
      wTurnValue .word ?                      ; $7F4466
        ; Can either be capped at 63 or halved
      wTempValue .word ?                      ; $7F4468
      wTargetsBattleMight .word ?             ; $7F446A

    .bend

  .endvirtual




  .virtual $7F5400

    aWorldMapMarker .block
      wStatus .brept 8              ; $7F5400
        .word ?
      .endrept
      wTimer .brept 8               ; $7F5410
        .word ?
      .endrept
      wXPosition .brept 8           ; $7F5420
        .word ?
      .endrept
      wYPosition .brept 8           ; $7F5430
        .word ?
      .endrept
      wID .brept 8                  ; $7F5440
        .word ?
      .endrept
    .bend

    aWorldMapPortrait .block
      wStatus .brept 7              ; $7F5450
        .word ?
      .endrept
      wXPosition .brept 7           ; $7F545E
        .word ?
      .endrept
      wYPosition .brept 7           ; $7F546C
        .word ?
      .endrept
    .bend

    .word ?                         ; $7F547A

    wEpilogueSavedUnitID1 .word ?   ; $7F547C
    wEpilogueSavedUnitID2 .word ?   ; $7F547E
    wEpilogueSavedUnitID3 .word ?   ; $7F5480
    .word ?                         ; $7F5482
    .word ?                         ; $7F5484
    wEpilogueTimer .word ?          ; $7F5486 ; frames counted by the epilogue's steps (and the secret code's position)
    
  .endvirtual

  .virtual $7F5599

    aPortraitSlotsPaletteBuffer .fill (size(Palette) * 8) ; $7F5599

    ; 7F5699

  .endvirtual

  .virtual $7F454A

    aMapAction .block
      wWeaponType .word ?     ; $7F454A
      wUnknown7F454C .word ?  ; $7F454C
      wBattleClassID .word ?  ; $7F454E
        ; usually class ID, can differ if gendered?
      wUnknown7F4450 .word ?  ; $7F4550
      wXTilePosition .word ?  ; $7F4552
      wYTilePosition .word ?  ; $7F4554
      wUnknown7F4556 .word ?  ; $7F4556
      wUnknown7F4558 .word ?  ; $7F4558
      wUnknown7F455A .word ?  ; $7F455A
      wUnknown7F455C .word ?  ; $7F455C
      wUnknown7F455E .word ?  ; $7F455E
      wUnknown7F4560 .word ?  ; $7F4560
      wUnknown7F4562 .word ?  ; $7F4562
      wDefenderAllegiance            .word ?  ; $7F4564
      wMapBattleTerrainMode          .word ?  ; $7F4566 ; selects terrain/BG config (<4)
                                     .fill 6  ; $7F4568-$7F456D
      wMapBattleClassSpriteID        .word ?  ; $7F456E ; *49 index into aBattleMapSpriteData
      wMapBattleWeaponAnimIndex      .word ?  ; $7F4570 ; *6 offset within class entry in aBattleMapSpriteData
      wMapBattleAttackVariant        .word ?  ; $7F4572 ; loaded from byte+$30 of aBattleMapSpriteData entry
      wUnknown7F4574                 .word ?  ; $7F4574 ; active side allegiance
      wUnknown7F4576                 .word ?  ; $7F4576 ; active sprite parameter
      wMapBattleAttackerXPixel       .word ?  ; $7F4578 ; attacker sprite X
      wMapBattleAttackerYPixel       .word ?  ; $7F457A ; attacker sprite Y
      wUnknown7F457C                 .word ?  ; $7F457C
      wUnknown7F457E                 .word ?  ; $7F457E
      wMapBattleActiveSpriteSyncFlag .word ?  ; $7F4580 ; command 05 waits until 0, command 06 clears when aux sprite matches
      wMapBattleActiveSpriteAckFlag  .word ?  ; $7F4582 ; set to 1 by rsActiveSpriteCommand05 when SyncFlag == 0
      wMapBattlePhaseFlag            .word ?  ; $7F4584 ; 0/1 map-battle active state
      lUnknown7F4586                 .long ?  ; $7F4586
      lUnknown7F4589                 .long ?  ; $7F4589
      lUnknown7F458C                 .long ?  ; $7F458C
      lUnknown7F458F                 .long ?  ; $7F458F
      lMapBattleAttackerSpriteScriptPointer .long ? ; $7F4592 ; $7E00 bank + offset -> $7EFC8C
      lMapBattleAuxSpriteScriptPointer      .long ? ; $7F4595 ; $7E00 bank + offset -> $7EFC92/$7EFC9E
      lUnknown7F4598                 .long ?  ; $7F4598
      lUnknown7F459B                 .long ?  ; $7F459B
      wMapBattleRoundIndex           .word ?  ; $7F459E ; index into aBattleRoundsData
                                     .word ?  ; $7F45A0
      wMapBattleRoundCounter         .word ?  ; $7F45A2
      wMapBattleAttackerSpriteSlot   .word ?  ; $7F45A4 ; attacker active sprite slot offset
      wMapBattleAttackerAuxSpriteSlot .word ? ; $7F45A6 ; attacker overlay/shadow sprite slot
      wMapBattleDefenderSpriteSlot   .word ?  ; $7F45A8 ; defender active sprite slot
      wMapBattleDefenderAuxSpriteSlot .word ? ; $7F45AA ; defender overlay/shadow sprite slot
      aMapBattleSavedPalette         .fill 32 ; $7F45AC ; saved 16-color palette buffer
      wMapBattlePaletteRestoreFlag   .word ?  ; $7F45CC ; nonzero after palette saved/faded
      wMapBattleLevelUpFrameCounter  .word ?  ; $7F45CE ; level-up UI animation frame counter
      lMapBattleLevelUpDataPointer   .long ?  ; $7F45D0 ; 24-bit ptr ($7E4EA9+$4C level-up struct)
      wMapBattleLevelUpStatIndex     .word ?  ; $7F45D3 ; index into aMapBattleStatGainOrder stat order
      wMapBattleLevelUpStatWaitTimer .word ?  ; $7F45D5 ; delay timer per stat row
      wMapBattleLevelUpStatGain      .word ?  ; $7F45D7 ; current stat gain value
    .bend

  .endvirtual


  .virtual $7F4C87

    wMapBattleMode .word ? ; $7F4C87
      ; How procMapBattle was started: 0 a battle (rlStartMapBattleAnimation),
      ; 1 the opening's demo battles (rlASMCStartDemoMapBattle), 2 a scripted
      ; battle from an event (rlStartSoloMapBattleAnimation,
      ; rlStartScriptedMapBattleAnimation). Modes 1 and 2 do not change HP
      ; (rlApplyMapBattleRoundHP).

  .endvirtual


  .virtual $7F5089

    ; The map battle's magic effects (bank $9F, procMapMagicEffect). An effect
    ; number is an item ID minus Fire ($3E), so 0 is Fire and 41 BrokenStaffA;
    ; $FFFF is none.

    wMapMagicEffect .word ? ; $7F5089
      ; The effect playing now: chosen per round from the two below
      ; (rlSelectMapMagicEffectForRound), or set by the caller.
    wMapMagicAttackerEffect .word ? ; $7F508B
    wMapMagicDefenderEffect .word ? ; $7F508D
      ; Each side's effect, filled from its weapon by rlInitMapBattleCombatants.
    wMapMagicFlags .word ? ; $7F508F
      ; 0: no effect this battle. Bit 0 set: effects play. The high byte says
      ; where the units are on screen (rlUnknown9E811F): $01 near the left
      ; edge, $02 near the right, $04 near the bottom. $8000: no effect
      ; (no defender, or a scripted battle).
    wMapMagicStart .word ? ; $7F5091
      ; Set to 1 by active sprite command $10 (ACTIVE_SPRITE_START_MAP_MAGIC)
      ; in the battler's script; rlProcMapMagicEffectCycle then runs the
      ; effect's starter. Negative: end without one.
    wMapMagicDone .word ? ; $7F5093
      ; Set to 1 by the effect when it has finished; command $11
      ; (ACTIVE_SPRITE_WAIT_MAP_MAGIC) waits for it.

  .endvirtual


  .virtual $7F5099

    wMapMagicCasterPixel .word ? ; $7F5099
      ; The acting unit's position on screen: X in the low byte, Y in the high.
    wMapMagicTargetPixel .word ? ; $7F509B
      ; The other unit's position, the same way (rlUnknown9E8C81).

  .endvirtual


  .virtual $7F50A1

    wMapMagicProcListEnd .word ? ; $7F50A1
    wMapMagicHDMAListEnd .word ? ; $7F50A3
      ; Byte offsets of the $FFFF that ends each list below.
    aMapMagicProcList .fill size(word) * 9 ; $7F50A5
      ; Slots of the procs the effect created (rsCreateMapMagicProc), freed by
      ; rlEndMapMagicEffect. Ends with $FFFF.
    aMapMagicHDMAList .fill size(word) * 9 ; $7F50B7
      ; The same for HDMA entries (rsCreateMapMagicHDMA).

  .endvirtual


  .virtual $7F454A

    .union
      .struct
        aMovingMapSpriteBuffers .brept 4 ; $7F454A
          .fill $2000
        .endrept
      .endstruct
      .struct
        aAllyUnitMap .fill $1000        ; $7F454A
          ; Filled with deployment offsets of units of the AI faction and its allies.
        aUnfriendlyUnitMap .fill $1000  ; $7F554A
          ; Filled with deployment offsets of units whose faction is an enemy of,
          ; or neutral to, the AI faction. It cannot fight the neutral ones, but
          ; they block its movement like enemies.
        aRangeMap .fill $1000           ; $7F654A
          ; Filled with flagged tiles that can be attacked.
        aMovementMap .fill $1000        ; $7F754A
          ; Filled with the remaining field movement after movement to a specific tile.
        aTargetDistanceMap .fill $1000  ; $7F854A
          ; Filled with the total movement cost required to reach certain target tiles.
        aTargetMap .fill $1000        ; $7F954A
          ; Filled with either deployment offsets for units, or castle IDs that are the
          ; current AI's targets.
        .union
          .struct
            aMovementCostMap .fill $1000  ; $7FA54A
              ; Filled with the movement cost of all tiles on the map.
          .endstruct
          .struct
            aUnitMap .fill $1000  ; $7FA54A
              ; Filled with deployment offsets of all units.
          .endstruct
        .endunion
        aMapTraversalList .fill $100  ; $7FB54A
          ; Used in different ways, either holds tile indices like up, down, left, right, and
          ; then takes one and overwrites it with its 4 directions and so on,
          ; or gets indexed by remaining field movement and then holds an offset to the next list.
        aNextTraversedTileIndexList .fill $400 ; $7FB64A
          ; The size of this is a guess, IDK how big it is
      .endstruct
    .endunion

  .endvirtual




  .virtual $7F82C7

    ; The unit window's working variables (engine/menus/unit_window.asm). Other
    ; screens reuse this area for their own values (code in bank $89 writes
    ; $7F82C9 and $7F83F5), so the names are only written in the unit window's
    ; code. Names follow the FE5 disassembly, which keeps FE4's unit window and
    ; whose code reads these at the same places; FE4 has a few extra words.

    wUnitWindowCurrentLine .word ?                  ; $7F82C7
    wUnitWindowCurrentHighlightLine .word ?         ; $7F82C9
    wUnitWindowScrolledLines .word ?                ; $7F82CB
    wUnitWindowMaxRows .word ?                      ; $7F82CD
    wUnitWindowSkippedUnitCount .word ?             ; $7F82CF
    wUnitWindowCanScrollDownFlag .word ?            ; $7F82D1
    .word ?                                         ; $7F82D3
    wUnitWindowLastScrolledFlag .word ?             ; $7F82D5
    .word ?                                         ; $7F82D7
    wUnitWindowScrollingStep .word ?                ; $7F82D9
    wUnitWindowCursorYCoordinate .word ?            ; $7F82DB
    wUnitWindowScrollingFlag .word ?                ; $7F82DD
    wUnitWindowScrollPixels .word ?                 ; $7F82DF
    .word ?                                         ; $7F82E1
    wUnitWindowPageScrollFlag .word ?               ; $7F82E3
    wUnitWindowAction .word ?                       ; $7F82E5
      ; 0 none, 1 fading in, 2 fading out to rlUnitWindowCloseWithLocationReload,
      ; 3 rlUnitWindowCloseToMap, 4 fading out to rlUnitWindowOpenSelectedUnitScreen.
    wUnitWindowSortTypeFlag .word ?                 ; $7F82E7
    .word ?                                         ; $7F82E9
    wUnitWindowCurrentColumn .word ?                ; $7F82EB
    wUnitWindowUnitSwapStep .word ?                 ; $7F82ED
    wUnitWindowUnitSwapStartSlot .word ?            ; $7F82EF
    wUnitWindowUnitSwapStartCursorYCoordinate .word ? ; $7F82F1
    .fill 6                                         ; $7F82F3
    wUnitWindowHighlightStep .word ?                ; $7F82F9
    wUnitWindowHighlightCounter .word ?             ; $7F82FB
    aUnitWindowHighlightColors .fill $30            ; $7F82FD
    aUnitWindowDeploymentSlots .fill $32            ; $7F832D
    aUnitWindowEquippedWeaponPointers .fill $32     ; $7F835F
      ; Each line's equipped weapon, as wCurrentItemDataROMPointer.
    aUnitWindowSpriteSlots .fill $32                ; $7F8391
    aUnitWindowReadyToPromoteFlags .fill $32        ; $7F83C3
    wUnitWindowCurrentNameLine .word ?              ; $7F83F5
    .fill 4                                         ; $7F83F7
    wUnitWindowProcessingHighlightLine .word ?      ; $7F83FB
    wUnitWindowProcessingHighlightOffset .word ?    ; $7F83FD
    wUnitWindowCurrentLineSlotOffset .word ?        ; $7F83FF

    ; $7F8401

  .endvirtual

  .virtual $7F8405

    ; More of the unit window's variables; see $7F82C7.

    wUnitWindowCurrentItemIconSlot .word ?          ; $7F8405
    aUnitWindowSortScores .fill $32                 ; $7F8407

    ; $7F8439

  .endvirtual

  .virtual $7F757A

    ; The castle screen's working variables (engine/castle/). They reuse the map
    ; buffers (aMovementMap) and the world map reuses $7F8089-$7F808F, so the names
    ; are only written in the castle and arena files (see tools/name_ram.py).

    aCastleGridCharacters .fill 24 * size(word)       ; $7F757A
      ; Grid slot -> character index (generation ID - 1, times 2), from
      ; aCastleGridCharactersGen1/Gen2.
    aCastleUnitsByCharacter .fill 24 * size(word)     ; $7F75AA
      ; Character index -> unit RAM pointer, 0 if that character is not in the castle.
    aCastleCourtyardSpriteX .fill 24 * size(word)     ; $7F75DA
    aCastleCourtyardSpriteY .fill 24 * size(word)     ; $7F760A
      ; Character index -> pixel position of its courtyard sprite.
    wCastleUnitCount .word ?                          ; $7F763A
    .fill $2E                                         ; $7F763C
    wCastleFadePortrait .word ?                       ; $7F766A
      ; What the fade steps draw: 1 the unit's portrait, 2 the list sprites,
      ; 3 the courtyard portrait (rsCastleDrawFadingPortrait).
    wCastleStatusScreenUnit .word ?                   ; $7F766C
      ; The unit X opened the status screen for.
    .fill 2                                           ; $7F766E
    wCastleRedrawIcons .word ?                        ; $7F7670
      ; Nonzero: the next frame redraws the list's item icons instead of sending
      ; the BG3 tilemap.
    aCastleListItemIndices .fill $200                 ; $7F7672
    aCastleListItemRAMPointers .fill $200             ; $7F7872
    aCastleListItemIDs .fill $200                     ; $7F7A72
    aCastleListItemROMPointers .fill $200             ; $7F7C72
    aCastleListItemUnavailable .fill $200             ; $7F7E72
      ; $FFFF for a stock item that cannot be bought yet.
    aCastleListInventorySlots .fill $10               ; $7F8072
      ; The arena's weapon list: inventory slot of each weapon.
    wKeeper .word ?                                   ; $7F8082
      ; KEEPER_* (include/Castle.h).
    .fill 2                                           ; $7F8084
    lKeeperOptionList .long ?                         ; $7F8086
      ; The keeper's option codes (rsSetKeeperOptionList): 0 the stock list,
      ; 1 and 2 the inventory, 3 to 5 no list.
    wConversationLeftFadeInStep .word ?               ; $7F8089
    wConversationRightFadeInStep .word ?              ; $7F808B
    wConversationLeftFadeOutStep .word ?              ; $7F808D
    wConversationRightFadeOutStep .word ?             ; $7F808F
    wAuguryLastTopic .word ?                          ; $7F8091

  .endvirtual

  .virtual $7F8185

    ; The skill window's working variables (engine/menus/skill_window.asm). Other
    ; screens reuse this area, so the names are only written in that file.

    wSkillWindowCurrentSkill .word ?                ; $7F8185
      ; 0-17, the place in the skill list.
    wSkillWindowCursorRow .word ?                   ; $7F8187
    wSkillWindowCursorYCoordinate .word ?           ; $7F8189
    wSkillWindowCursorMoveDirection .word ?         ; $7F818B
      ; -1 up, 1 down, 0 not moving.
    wSkillWindowScrolledLines .word ?               ; $7F818D
    wSkillWindowScrollDirection .word ?             ; $7F818F
    wSkillWindowUnitCount .word ?                   ; $7F8191
    .word ?                                         ; $7F8193
    aSkillWindowUnits .fill $64                     ; $7F8195
    aSkillWindowSkillHolders .fill $540             ; $7F81F9
      ; 32 words per skill: unit RAM pointers, ended by 0.
    .word ?                                         ; $7F8739
    wSkillWindowHolderScrollDirection .word ?       ; $7F873B
    wSkillWindowHolderScroll .word ?                ; $7F873D
    .word ?                                         ; $7F873F
    aSkillWindowHolderCounts .fill $2C              ; $7F8741
    wSkillWindowSkillID .word ?                     ; $7F876D
      ; Used while building aSkillWindowSkillHolders.
    .fill $1E                                       ; $7F876F
    aSkillWindowSkillListTilemap .fill $7FE         ; $7F878D
    aSkillWindowDescriptionTilemap .fill $100       ; $7F8F8B
    aSkillWindowHolderTilemap .fill $22A            ; $7F908B

  .endvirtual

  .virtual $7F8183

    ; The chapter intro title card's variables (engine/worldmap/chapter_intro.asm).
    ; Other screens reuse this area, so the names are only written in that file.

    wChapterIntroFrames .word ?         ; $7F8183
    wChapterIntroPhaseFrames .word ?    ; $7F8185
      ; Frames in the current phase; the brightness steps every 6 (in) or 7 (out).
    wChapterIntroFadeFrames .word ?     ; $7F8187
    wChapterIntroFadeInterval .word ?   ; $7F8189
      ; Frames between palette fade steps.
    wChapterIntroPhase .word ?          ; $7F818B
    wChapterIntroTitleSettled .word ?   ; $7F818D
      ; Nonzero once every band of the title has slid into place.
    .fill $7F828F - *
    aChapterIntroBG2VOFSTable .fill $100 ; $7F828F
      ; HDMA table that waves the background.
    aChapterIntroBG1HOFSTable .fill $4E  ; $7F838F
      ; HDMA table: one horizontal offset per band of the title, slid to 0.

  .endvirtual

  .virtual $7F8183

    ; The data window's working variables (engine/menus/data_window.asm). Other
    ; screens reuse this area, so the names are only written in that file. The
    ; arrays are by place in the list of armies (up to 7).

    wDataWindowCurrentArmy .word ?                  ; $7F8183
      ; The place in the list.
    wDataWindowCursorYCoordinate .word ?            ; $7F8185
    wDataWindowCursorMoveDirection .word ?          ; $7F8187
      ; -1 up, 1 down, 0 not moving.
    aDataWindowLeaders .fill $10                    ; $7F8189
      ; Unit RAM pointers; 0 if the leader is dead or there is none.
    aDataWindowLeaderCharacterIDs .fill $10         ; $7F8199
    aDataWindowLeaderMapSprites .fill $10           ; $7F81A9
    aDataWindowPortraitPalettes .fill $100          ; $7F81B9
      ; 16 colors each.
    aDataWindowRelationPalettes .fill $100          ; $7F82B9
      ; 16 colors each, for the leader's map sprite.
    aDataWindowFactionSlots .fill $10               ; $7F83B9
    aDataWindowUnitCounts .fill $10                 ; $7F83C9
      ; Units alive.
    wDataWindowArmyCount .word ?                    ; $7F83D9
    .word ?                                         ; $7F83DB
    wDataWindowTemp1 .word ?                        ; $7F83DD
    wDataWindowTemp2 .word ?                        ; $7F83DF
    wDataWindowTemp3 .word ?                        ; $7F83E1
    .fill $1A                                       ; $7F83E3
    aDataWindowCOLDATAHDMATable .fill $100          ; $7F83FD
    aDataWindowBG3VOFSHDMATable .fill 9             ; $7F84FD

  .endvirtual

  .virtual $7F8467

    ; The item window's working variables (engine/menus/item_window.asm). Other
    ; screens reuse this area, so the names are only written in that file.

    wItemWindowCurrentLine .word ?                  ; $7F8467
      ; Counted from 1.
    .word ?                                         ; $7F8469
    wItemWindowItemCount .word ?                    ; $7F846B
    wItemWindowScrollOffset .word ?                 ; $7F846D
      ; The first visible line, times 2.
    wItemWindowMaxScroll .word ?                    ; $7F846F
      ; The furthest the first visible line can go: the item count less 12.
    wItemWindowCursorRow .word ?                    ; $7F8471
      ; 0-11, the cursor's row on the screen.
    wItemWindowCursorYCoordinate .word ?            ; $7F8473
    .fill 4                                         ; $7F8475
    wItemWindowScrollDirection .word ?              ; $7F8479
      ; -1 scrolling up, 1 scrolling down, 0 not scrolling.
    .word ?                                         ; $7F847B
    wItemWindowSortPanelRow .word ?                 ; $7F847D
      ; 0-2, the sort panel's cursor: owner, type, name.
    wItemWindowSelectedItemIcon .word ?             ; $7F847F
    .word ?                                         ; $7F8481
    aItemWindowList .fill $97                       ; $7F8483
      ; One byte per listed item: its player item index.
    aItemWindowItemRAMPointers .fill $12E           ; $7F851A
      ; By player item index, like the next two.
    aItemWindowItemROMPointers .fill $12E           ; $7F8648
    aItemWindowItemIcons .fill $12E                 ; $7F8776
    aItemWindowSortScores .fill $12A                ; $7F88A4
      ; By place in the list.
    .word ?                                         ; $7F89CE
    aItemWindowListTilemap .fill $2580              ; $7F89D0

  .endvirtual

  .virtual $7F8183

    ; The status screen's working variables (engine/menus/status_screen.asm).
    ; Other screens reuse this area, so the names are only written in the files
    ; tools/name_ram.py lists for them: the status screen's, and those that open it.

    wStatusScreenCaller .word ?                     ; $7F8183
      ; The low word of the bank $80 routine that opened the status screen and
      ; that closing it returns to: rsUnitWindowOpen, rsReviveScreenOpen or
      ; rsOpenCastleScreen; anything else (rsUnknown80B122) returns to the map.
    wStatusScreenItemSlot .word ?                   ; $7F8185
      ; The inventory slot (1-8) under the item cursor.
    wStatusScreenScroll .word ?                     ; $7F8187
      ; BG2 and BG3's scroll on the stat page: 0 the top half,
      ; STATUS_SCREEN_SCROLL_BOTTOM the bottom half.
    wStatusScreenSavedScroll .word ?                ; $7F8189
      ; BG2's scroll while the holy blood page is up.
    wStatusScreenUnitType .word ?                   ; $7F818B
      ; rlGetUnitType: 3 for an enemy, whose luck is shown as 0.
    wStatusScreenLoptousBlood .word ?               ; $7F818D
      ; 0, MinorHolyBlood or MajorHolyBlood of Loptous (holy blood $0C).
    wStatusScreenHolyBloodLoaded .word ?            ; $7F818F
      ; Set once the holy blood page's graphics are in VRAM.
    wStatusScreenHolyBloodDMAStep .word ?           ; $7F8191
      ; 0-5, the pieces of those graphics sent so far.
    wStatusScreenFactionSlot .word ?                ; $7F8193
      ; The unit's faction slot; 0 for the player, whose units show experience,
      ; uses, kills and lover.
    wStatusScreenCharacter .word ?                  ; $7F8195
    wStatusScreenLeadership .word ?                 ; $7F8197
      ; Leadership stars, drawn when the unit has no commander.
    wStatusScreenCommander .word ?                  ; $7F8199
      ; The character ID of the unit's commander (rlUnknown849FC4), or 0.
    wStatusScreenCanPromote .word ?                 ; $7F819B
      ; 1 when a player unit is at its promotion level.
    wStatusScreenReopenMode .word ?                 ; $7F819D
      ; 0 for a fresh screen; STATUS_SCREEN_REOPEN_* when R or L reopens it for
      ; another unit, to keep the page. The opener clears it.
    wStatusScreenFadeStep .word ?                   ; $7F819F
      ; Brightness change per frame in a fade.
    wStatusScreenStepAfterFade .word ?              ; $7F81A1
    wStatusScreenExitRoutine .word ?                ; $7F81A3
      ; The main loop routine STATUS_SCREEN_STEP_LEAVE installs.
    wStatusScreenNextUnit .word ?                   ; $7F81A5
      ; The unit R or L chose, selected when the fade-out ends.
    wStatusScreenDropItemSlot .word ?               ; $7F81A7
      ; The inventory slot of the item the unit drops or holds as unique, or 0.
    wStatusScreenUnitStates .word ?                 ; $7F81A9
      ; UnitState bits.
    wStatusScreenCondition .word ?                  ; $7F81AB
      ; Status (StatusHealthy...).
    wStatusScreenReopened .word ?                   ; $7F81AD
      ; Set when the screen was reopened for another unit.
    wStatusScreenSavedInventorySlot .word ?         ; $7F81AF
    wStatusScreenSkillCount .word ?                 ; $7F81B1
    aStatusScreenSkillIDs .fill 14                  ; $7F81B3
      ; A word per skill with an icon, as rlUnknown87A415 numbers them.
    aStatusScreenSkillIconTiles .fill 14            ; $7F81C1
    wStatusScreenSkillCursor .word ?                ; $7F81CF
    wStatusScreenGreyIndex .word ?                  ; $7F81D1
      ; 8 for a dead or captive unit, else 0: its index into
      ; aStatusScreenSpritePaletteOffsets, which gives the grey palette.
    aStatusScreenHolyBloodLevels .fill 26           ; $7F81D3
      ; A word per holy blood (13): 0, MinorHolyBlood or MajorHolyBlood.
    aStatusScreenGlintFrameIDs .fill 24             ; $7F81ED
      ; A word per blood in the ring (12), as the next three.
    aStatusScreenMajorGlintIDs .fill 24             ; $7F8205
    .fill $34                                       ; $7F821D
    wStatusScreenLoptousGlintFrame .word ?          ; $7F8251
    wStatusScreenLoptousGlint2Frame .word ?         ; $7F8253
    aStatusScreenGlintTimers .fill 24               ; $7F8255
    aStatusScreenMajorGlintTimers .fill 24          ; $7F826D
    .fill $34                                       ; $7F8285
    wStatusScreenLoptousGlintTimer .word ?          ; $7F82B9
    wStatusScreenLoptousGlint2Timer .word ?         ; $7F82BB
    wStatusScreenTemp1 .word ?                      ; $7F82BD
    wStatusScreenTemp2 .word ?                      ; $7F82BF
    wStatusScreenTemp3 .word ?                      ; $7F82C1
    wStatusScreenTemp4 .word ?                      ; $7F82C3
      ; Working values: a weapon type, a blood, a skill, a unit pointer, the
      ; digits of rlDrawStatBonus.

  .endvirtual

  .virtual $7F82C5

    wUnitWindowCaller .word ?                       ; $7F82C5
      ; The low word of the main loop routine that opened the unit window:
      ; rsOpenStatusScreen when coming back from the status screen, which keeps
      ; the list where it was; rsUnknown80B122 from the map menu.

  .endvirtual

  .virtual $7F8400

    ; The options menu's working variables (engine/menus/options_menu.asm). The
    ; debug menu uses the same area, so the names are only written in that file.

    wOptionsMenuCursor .word ?                      ; $7F8400
      ; The option under the cursor (OPTION_*).
    aOptionsMenuValues .block                       ; $7F8402
      ; A word per option, in OPTION_* order.
      wAnimation .word ?                            ; $7F8402
      wTerrainWindow .word ?                        ; $7F8404
      wUnitWindow .word ?                           ; $7F8406
      wMessageSpeed .word ?                         ; $7F8408
      wEnemySpeed .word ?                           ; $7F840A
      wSound .word ?                                ; $7F840C
      wAutoSave .word ?                             ; $7F840E
        ; 0 off, else the file to save to plus 1.
      wAutoCursor .word ?                           ; $7F8410
      wEnemyAI .word ?                              ; $7F8412
    .endblock
    aOptionsMenuOpeningValues .block                ; $7F8414
      ; The values when the menu opened, which Y puts back.
      wAnimation .word ?                            ; $7F8414
      wTerrainWindow .word ?                        ; $7F8416
      wUnitWindow .word ?                           ; $7F8418
      wMessageSpeed .word ?                         ; $7F841A
      wEnemySpeed .word ?                           ; $7F841C
      wSound .word ?                                ; $7F841E
      wAutoSave .word ?                             ; $7F8420
      wAutoCursor .word ?                           ; $7F8422
      wEnemyAI .word ?                              ; $7F8424
    .endblock
    .word ?                                         ; $7F8426
      ; Set to $23 as the menu opens; nothing reads it.
    wOptionsMenuCursorMove .word ?                  ; $7F8428
      ; $1000 moving down or $F000 moving up for one frame, else 0.
    .word ?                                         ; $7F842A
    wOptionsMenuShowEnemyAI .word ?                 ; $7F842C
      ; Set when the save has finished the game once: the ninth option shows.
    aOptionsMenuDescriptionBuffer .fill $11A        ; $7F842E
      ; The description text is drawn here, then copied to BG3.
    wOptionsMenuValueMarkerX .word ?                ; $7F8548
    .fill $10                                       ; $7F854A
    aOptionsMenuCOLDATAHDMABuffer .fill $200        ; $7F855A
    aOptionsMenuBG3VOFSHDMABuffer .fill $B7         ; $7F875A

  .endvirtual

  .virtual $7F8403

    wReviveScreenDrawMode .word ?                   ; $7F8403
      ; What rlReviveScreenUpkeep draws (REVIVE_SCREEN_DRAW_*). Only written in
      ; engine/menus/revive_screen.asm; the options menu uses the area.

  .endvirtual

  .virtual $7FAF50

    ; More of the status screen's variables; only written in its file.

    aStatusScreenTextBuffer .fill $C0               ; $7FAF50
      ; Item and skill descriptions are drawn here (aUnknown89ACBC,
      ; aUnknown89ACC5), then copied into the BG3 tilemap buffer.
    .fill $A6                                       ; $7FB010
    aStatusScreenGradientTable .fill $AA            ; $7FB0B6
      ; The COLDATA HDMA table (rlStatusScreenSetGradient).
    aStatusScreenBG1SplitTable .fill 8              ; $7FB160
      ; The BG1 scroll HDMA table (rlStatusScreenBuildBG1SplitTable).

  .endvirtual

  .virtual $7FB014

    ; The revive screen's variables (engine/menus/revive_screen.asm).

    .word ?                                         ; $7FB014
      ; Cleared as the screen opens; nothing reads it.
    wReviveScreenStaffUser .word ?                  ; $7FB016
      ; The unit pointer of the unit using the staff.
    wReviveScreenConfirmCursor .word ?              ; $7FB018
      ; 0 on yes, 1 on no.

  .endvirtual

  .virtual $7F8402

    wDebugMenuScreenIndex .word ? ; 7F8402

  .endvirtual

  .virtual $7F8410

    wDebugMenuTemp1 .word ? ; $7F8410
    wDebugMenuTemp2 .word ? ; $7F8412
    wDebugMenuTemp3 .word ? ; $7F8414
      ; Temporary values of the debug menu pages.

  .endvirtual




  .virtual $7FC54A

    aEpilogueUnitStates .fill 25 * size(word) ; $7FC54A
      ; indexed by CharacterID
      ; $8000 if dead
      ; $4000 if unrecruited
      ; $2000 + ora'd partners ID for selected children in aUnknown82F96C
    aUnknown7FC57C .fill 25 * size(word) ; $7FC57C
      ; indexed by Gen2 IDs, same as above

    ; $7FC5AE

  .endvirtual

  .virtual $7FC5CA

    aEpilogueUnitProcessedFlags .fill 25 * size(word) * 2 ; $7FC5CA
      ; -1 if unit hasn't been processed yet

    ; $7FC62E

  .endvirtual

  ; The map's terrain and unit windows (engine/map/windows.asm) draw into two
  ; 32x32 tilemaps here, uploaded to VRAM $5400 (BG2) and $5800 (BG3).

  .virtual $7FDD4A

    aMapWindowFrameBuffer .fill $680 ; $7FDD4A
    aMapWindowTextBuffer .fill $800  ; $7FE3CA

  .endvirtual

  .virtual $7FC64A

    aEpilogueMainCharacters .fill $40  ; $7FC64A
      ; Indexed by epilogue ID, holds CharacterIDs of units that get their own
      ; epilogue.
    aEpilogueSupportingCharacters .fill $40  ; $7FC68A
      ; Characters who are involved in the epilogues of the prior table, same offsets.
    aEpilogueChosenDialogueID .fill $32  ; $7FC6CA
      ; For every unit, holds the ID for their epilogue pointers + 1.
      ; 0 means the character doesnt get an epilogue

    ; $7FC6FC

  .endvirtual

  .virtual $7FC70A

    aUnknown7FC70A .fill 16 * size(byte)      ; $7FC70A 
      ; result | remainder
    aUnknown7FC71A .fill 7 * size(byte)       ; $7FC71A
      ; ?
    aUnknown7FC721 .fill 9 * size(byte)       ; $7FC721
      ; male lovers gen ids indexed by female gen ids starting with patty
    aUnknown7FC72A .fill (8 + 1) * size(byte) ; $7FC72A
      ; ?
    ; $7FC734

  .endvirtual

  .virtual $7FEB4A

    aUnit1DataBuffer .block
      _Personal   .structPersonalCharacterDataBuffer  ; $7FEB4A
      _Extended   .structExtendedCharacterDataBuffer  ; $7FEB66
      _ROM        .structCharacterROMDataBuffer       ; $7FEB84
      _Inventory  .structInventoryDataBuffer          ; $7FEBA6
      _Lover      .structLoverDataRAM                 ; $7FEBBA
    .bend

    aUnit2DataBuffer .block
      _Personal   .structPersonalCharacterDataBuffer  ; $7FEBD8
      _Extended   .structExtendedCharacterDataBuffer  ; $7FEBF4
      _ROM        .structCharacterROMDataBuffer       ; $7FEC12
      _Inventory  .structInventoryDataBuffer          ; $7FEC34
      _Lover      .structLoverDataRAM                 ; $7FEC48
    .bend

    ; 7fec66

  .endvirtual


  .virtual $7FEA4A

    wDialogueBoxHDMAYPixelPosition .word ?                ; $7FEA4A
    wDialogueBoxHDMACycleCounter .word ?                  ; $7FEA4C
    wDialogueBoxHDMAStatus .word ?                        ; $7FEA4E
      ; -1 = done
      ; other values = busy
    wDialogueBoxHDMAPositionIndicator .word ?             ; $7FEA50
      ; 0 for top box, 1 for bottom
    aDialogueBoxHDMAIndirectTableEven .fill 19 * 3 +1     ; $7FEA52
    aDialogueBoxHDMADataTableEven .fill 19 * size(word)   ; $7FEA8C
    aDialogueBoxHDMAIndirectTableOdd .fill 19 * 3 +1      ; $7FEAB2
    aDialogueBoxHDMADataTableOdd .fill 19 * size(word)    ; $7FEAEC

    ; $7FEB12

  .endvirtual


  .virtual $7FEEA8

    aMapMenuRAMArea .block                     ; $7FEEA8
      _Header .structRAMAreaHeader

      ; structRAMAreaEntryHeader
      .fill $0E4F
    .bend
    ; $7FFCFF

  .endvirtual



  .virtual $7FD000

    ; The title screen (engine/title/). The battle scene reuses this area, so
    ; tools/name_ram.py writes these names only in engine/title/.

    bTitleScreenPhase .byte ? ; $7FD000
      ; 0 the intro, 1 the title waiting for Start, 2 the fade out to the
      ; file menu (rlTitleScreenStep).
    wTitleScreenFrame .word ? ; $7FD001
      ; Frames since the phase's timeline started (rlResetTitleTimeline).
    lTitleTimelinePosition .long ? ; $7FD003
      ; The next timeline entry (rsRunTitleTimeline, include/TitleScreen.h).
    aTitleTimelineSlots .block ; $7FD006
      ; 16 slots of four bytes, run every frame by rsRunTitleTimelineSlots.
      bActive  .byte ? ; 1 while the slot runs; the routine clears it to stop
      lRoutine .long ? ; called with X = the slot's offset, data bank = its bank
      .fill 15 * 4
    .bend

  .endvirtual


  .virtual $7FD04C

    wTitleBrightnessStep .word ? ; $7FD04C
      ; Position in the brightness list (rlRunTitleBrightnessList).

  .endvirtual


  .virtual $7FD052

    lTitleBrightnessList .long ? ; $7FD052
      ; INIDISP values, one a frame, ended by $FF: aTitleSceneFadeInBrightness
      ; and the lists after it.

  .endvirtual


  .virtual $7FD073

    bTitleCaptionBrightness .byte ? ; $7FD073
      ; Brightness of the caption strip at the bottom of the intro
      ; (rlDrawTitleCaptionStrip), faded by rlStartFadingInTitleCaption and rlStartFadingOutTitleCaption.

  .endvirtual


  .virtual $7FD075

    bTitleScreenEdgeFade .byte ? ; $7FD075
      ; Nonzero: the screen is blanked at the top of the frame and the IRQ
      ; code (rlFadeTitleScreenTopEdge, rlDrawTitleCaptionStrip) fades the lines near the top
      ; and bottom edges in steps (aTitleScreenEdgeBrightness).

  .endvirtual


  .virtual $7FD08B

    bTitleLoadRequests .byte ? ; $7FD08B
      ; Entries of the load list rlRunTitleLoadList may start; each
      ; rlAllowTitleLoad call allows one more.
    lTitleLoadListPosition .long ? ; $7FD08C
      ; The next entry of the load list: type 0 (11 bytes) a decompression,
      ; type 2 (8 bytes) a copy (rlStartTitleLoadDecompression, rlStartTitleLoadCopy).
    aTitleSprites .dstruct structTitleSprite ; $7FD08F
      .fill 12 * size(structTitleSprite)

  .endvirtual


  .virtual $7FD8A5

    lTitleVBlankRoutine1 .long ? ; $7FD8A5
    lTitleVBlankRoutine2 .long ? ; $7FD8A8
      ; Called from the title's VBlank (rlRunTitleVBlankRoutines) when not 0, to update
      ; HDMA tables.
    bTitleCaption .byte ? ; $7FD8AB
      ; The next caption (rlShowNextTitleCaption).
    bTitleCaptionScroll .byte ? ; $7FD8AC
      ; BG1 horizontal scroll of the caption strip, from aTitleCaptionScrolls.
    aTitleScreenEdgeBrightness .fill 8 ; $7FD8AD
      ; INIDISP values for the lines near the edges (rlSetTitleEdgeBrightness).
    bTitleScreenDone .byte ? ; $7FD8B5
      ; Set when a timeline ends (rlEndTitleScreen): the title starts the
      ; opening, or after the fade out goes to the file menu.

  .endvirtual


  .virtual $7FD8B9

    bTitleScreenSkipIntro .byte ? ; $7FD8B9
      ; Set by rsOpenTitleScreenWithoutIntro, or when Start is held as the
      ; title opens: rlTitleScreenSetup goes straight to the title.
    bTitleScreenFlags .byte ? ; $7FD8BA
      ; $01 Start was pressed during the intro (once), $02 Start may end the
      ; title (rlAllowStartOnTitle), $04 skipping to the title, waiting for the
      ; decompression and APU uploads to finish, $08 set by rlTitleScreenSetup.

  .endvirtual
