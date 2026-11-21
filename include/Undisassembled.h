; Routines that the disassembled code calls but that are not disassembled yet.
; They are still copied from the base ROM. Each name is declared weakly, so a real
; label of the same name takes over as soon as the routine is disassembled; remove
; the line here when that happens.

  .weak


    aUnknown879481                                           :?= address($879481) ; read by rlDrawMenuTextLine
    aUnknown89A76C                                           :?= address($89A76C) ; read by rlUnknown8A8496
    aUnknown8C9520                                           :?= address($8C9520) ; read by rlUnknown888082, rlUnknown88821A, rlUnknown9EF76F
    aUnknown8C9800                                           :?= address($8C9800) ; read by rlUnknown8A8F68
    aUnknown8C9A00                                           :?= address($8C9A00) ; read by rlUnknown80BA52
    aUnknown8CA000                                           :?= address($8CA000) ; read by rsUnknown8AE076
    aUnknown8CDCB0                                           :?= address($8CDCB0) ; read by rsWorldMapMarkerShadowLoadRedPalette
    aUnknown998944                                           :?= address($998944) ; read by rsUnknown959B84, rsUnknown959BC1
    aUnknown9EA513                                           :?= address($9EA513) ; read by rlUnknown9EA417
    aUnknownD77000                                           :?= address($D77000) ; read by rlUnknown80BA52
    aUnknownD95000                                           :?= address($D95000) ; read by rlUnknown888082, rlUnknown88821A
    aUnknownDE0000                                           :?= address($DE0000) ; read by rlUnknown859BBD, rlUnknown85C4E0, rsUnknown899FF3, rsUnknown89A00F, rsUnknown89A02B, rsUnknown89A047

    aUnknown80D1AE                                           :?= address($80D1AE) ; read by rlItemWindowGetItemData
    aUnknown85BE87                                           :?= address($85BE87) ; read by rlUnknown85BDA1
    aUnknown8A945E                                           :?= address($8A945E) ; read by rsUnknown8A9389
    aUnknown8AA241                                           :?= address($8AA241) ; read by rsUnknown8AA142
    aUnknown8CD600                                           :?= address($8CD600) ; read by rlUnknown8AE2F8
    aUnknown8D9BF6                                           :?= address($8D9BF6) ; read by rlUnknown91ACE2
    aUnknownDA7000                                           :?= address($DA7000) ; read by rsUnknown8AA9A6

    aUnknown80EA80                                           :?= address($80EA80) ; read by rlUnknown80E9B2
    aUnknown88958F                                           :?= address($88958F) ; read by rsUnknown889506
    aUnknown89F338                                           :?= address($89F338) ; read by rlUnknown89F246
    aUnknown8A9DD5                                           :?= address($8A9DD5) ; read by rsUnknown8AC168, rsUnknown8AC524, rsUnknown8AC6BA, rsUnknown8AC8B9, rsUnknown8AC984, rsUnknown8ACAE9, rsUnknown8ACC58, rsUnknown8ACDAB, rsUnknown8AEBD1, rsUnknown8AF313, rsUnknown8AF4B8, rsUnknown8AF556, rsUnknown8AF6EC, rsUnknown8AF791, rsUnknown8AFAF0, rsUnknown8AFB5D
    aUnknown8BDC22                                           :?= address($8BDC22) ; read by rsSkillWindowRenderArrows
    aUnknown8CA200                                           :?= address($8CA200) ; read by rlUnknown80EE37
    aUnknown8CA400                                           :?= address($8CA400) ; read by rlUnknown80EFD8, rlUnknown8DAF33
    aUnknown8CA620                                           :?= address($8CA620) ; read by rlUnknown88E033
    aUnknown8CD000                                           :?= address($8CD000) ; read by rlUnknown8AECEF
    aUnknown8CD200                                           :?= address($8CD200) ; read by rsUnknown8ABE63
    aUnknown8CD400                                           :?= address($8CD400) ; read by rsUnknown8ABE63
    aUnknown8CD800                                           :?= address($8CD800) ; read by rlUnknown8AF0F2
    aUnknown8CDA00                                           :?= address($8CDA00) ; read by rlUnknown8AF894
    aUnknown91B34C                                           :?= address($91B34C) ; read by rlUnknown91B164, rsUnknown91B20A, rsUnknown91B2E5, rsUnknown91B511
    aUnknown91B546                                           :?= address($91B546) ; read by rsUnknown91B511
    aUnknown95AB80                                           :?= address($95AB80) ; read by rlUnknown95AB53
    aUnknown95AD8C                                           :?= address($95AD8C) ; read by rlUnknown95ACF6
    aUnknown978F3A                                           :?= address($978F3A) ; read by rlUnknown95B993
    aUnknown97BEAC                                           :?= address($97BEAC) ; read by rlBattleSceneCommandBGScrollEffect
    aUnknown97C2D4                                           :?= address($97C2D4) ; read by rlBattleSceneStartBG2Shake
    aUnknown97C462                                           :?= address($97C462) ; read by rlUnknown96C008
    aUnknown97E8FB                                           :?= address($97E8FB) ; read by rsBattleAnimationGetBodyIndex
    aUnknown97EA9A                                           :?= address($97EA9A) ; read by rlBattleAnimationGetBodyWidth, rlBattleAnimationGetSpacing, rlUnknown95B5FD, rlUnknown95B6D0, rsBattleAnimationGetSpeedA, rsBattleAnimationGetSpeedB, rsUnknown96B894
    aUnknown97EC1A                                           :?= address($97EC1A) ; read by rlUnknown95B80C
    aUnknown97FB12                                           :?= address($97FB12) ; read by rlUnknown9BE5E4
    aUnknown98AD65                                           :?= address($98AD65) ; read by rlUnknown95CAD5
    aUnknown98B231                                           :?= address($98B231) ; read by rsUnknown96F7EB
    aUnknown998000                                           :?= address($998000) ; read by rlUnknown96C8A1
    aUnknown998B0E                                           :?= address($998B0E) ; read by rsUnknown95C0F3
    aUnknown998DF8                                           :?= address($998DF8) ; read by rlUnknown95A167
    aUnknown9AA30A                                           :?= address($9AA30A) ; read by rlUnknown96B517, rsUnknown96B56F, rsUnknown9FEB4F, rsUnknown9FF376
    aUnknown9F8C3A                                           :?= address($9F8C3A) ; read by rlUnknown9F8B7A, rlUnknown9F8C05
    aUnknownD97C00                                           :?= address($D97C00) ; read by rlUnknown88E033
    aUnknownDA65B2                                           :?= address($DA65B2) ; read by rsUnknown8A8CB7
    aUnknownDE2ABE                                           :?= address($DE2ABE) ; read by rlUnknown80BD27
    aUnknownDE2C9E                                           :?= address($DE2C9E) ; read by rsUnknown898105, rsUnknown89831F, rsUnknown898536
    aUnknownE02299                                           :?= address($E02299) ; read by rlUnknown9BE1C0
    aUnknownE023B1                                           :?= address($E023B1) ; read by rlUnknown9BE1C0
    aUnknownE024E3                                           :?= address($E024E3) ; read by rlUnknown9BF3F3

  .endweak
