; Routines that the disassembled code calls but that are not disassembled yet.
; They are still copied from the base ROM. Each name is declared weakly, so a real
; label of the same name takes over as soon as the routine is disassembled; remove
; the line here when that happens.

  .weak

    aOAMUpperXBitTable                          :?= address($8083C7)
    aOAMSizeBitTable                            :?= address($8085C7)
    rlPushToOAMBuffer                           :?= address($8087C7)
    rlPushToOAMBufferTimed                      :?= address($80885F)
    rlUnknown808FA3                             :?= address($808FA3)
    rlUnknown808FAD                             :?= address($808FAD)
    rlFadeInByTimer                             :?= address($80A21C)
    rlFadeOutByTimer                            :?= address($80A25A)
    rlFindCharacterByGenerationID               :?= address($848726)
    rlCalculateFinalRankingScore                :?= address($848DC1)
    rlGetFatherUnitsChildrenRAMPointers         :?= address($848DF4)
    rlClearUnitWindowAndTerrainWindowProcs      :?= address($859B94)
    rlUnknown85AB3F                             :?= address($85AB3F)
    rlClearMapBufferAddBorders                  :?= address($86AE80)
    rlApplyMapTileChange                        :?= address($86C6E8)
    rlUnknown878459                             :?= address($878459)
    rlDrawMenuTextLine                          :?= address($879354)
    rlGetTextSpeedOption                        :?= address($87BEF1)
    aFormationPatternOffsets                    :?= address($87DCD8)
    rlCheckIfCharacterHasFemaleGenerationID     :?= address($87F4CF)
    rlCompactStaticDynamicUnitBuffer1UnitStates :?= address($87F9CE)
    rlCompactHolyEnemyUnitBuffer1UnitStates     :?= address($87FA1E)
    rlFillUnitsDeploymentSaveData               :?= address($87FA83)
    rlFillItemsOwnerAndSlotData                 :?= address($87FBC5)
    rlFillItemDurabilityData                    :?= address($87FC51)
    rlUnknown8885EF                             :?= address($8885EF)
    rlUnknown88863E                             :?= address($88863E)
    rlGetMapSpriteMovementSound                 :?= address($88C13E)
    rsMovingMapSpriteAppendDecomp               :?= address($88D67C)
    rlDrawMenuTextNumber                        :?= address($89A18C)
    rlClearHighlightWorldMapPart                :?= address($8B8A84)
    procWorldMapMarkerShadowFadeIn              :?= address($8B8B59)
    procUnknown9EC70B                           :?= address($9EC70B)

  .endweak
