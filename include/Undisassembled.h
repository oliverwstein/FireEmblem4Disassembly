; Routines that the disassembled code calls but that are not disassembled yet.
; They are still copied from the base ROM. Each name is declared weakly, so a real
; label of the same name takes over as soon as the routine is disassembled; remove
; the line here when that happens.

  .weak

    aASMapSpriteCode                                         :?= address($8189E0)
    rlUnknown85AB3F                                          :?= address($85AB3F)
    rlDrawMenuTextLine                                       :?= address($879354)
    rlUnknown88C4D9                                          :?= address($88C4D9)
    aUnknown88CBE8                                           :?= address($88CBE8)
    rlDrawMenuTextNumber                                     :?= address($89A18C)
    aBattleMapSpriteData                                     :?= address($9EB50D)

  .endweak
