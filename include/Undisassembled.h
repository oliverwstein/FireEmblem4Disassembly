; Routines that the disassembled code calls but that are not disassembled yet.
; They are still copied from the base ROM. Each name is declared weakly, so a real
; label of the same name takes over as soon as the routine is disassembled; remove
; the line here when that happens.

  .weak

    aASMapSpriteCode                                         :?= address($8189E0)
    rsUnknown81AD8E                                          :?= address($81AD8E)
    rsUnknown81B270                                          :?= address($81B270)
    rlGetFatherUnitsChildrenRAMPointers                      :?= address($848DF4)
    rlUnknown85AB3F                                          :?= address($85AB3F)
    aItemObtainedText                                        :?= address($85BC8C)
    rlUnknown8780F9                                          :?= address($8780F9)
    rlDrawMenuTextLine                                       :?= address($879354)
    rlEventMovementBuildTargetDistanceMap                    :?= address($87B197)
    rlFillEventMovementMoveCostMap                           :?= address($87B386)
    rlEventMovementCreateMovementScriptFromTargetDistanceMap :?= address($87B3F3)
    aEventMovementDirectionLookupTable                       :?= address($87B4FD)
    rlFillItemsOwnerAndSlotData                              :?= address($87FBC5)
    rlUnknown88C4D9                                          :?= address($88C4D9)
    aUnknown88CBE8                                           :?= address($88CBE8)
    rlDrawMenuTextNumber                                     :?= address($89A18C)
    rlProcUnknown8AE199Init                                  :?= address($8AE1A1)
    aBattleMapSpriteData                                     :?= address($9EB50D)
    aBelhallaAttackingMagePositions                          :?= address($9EF811)

  .endweak
