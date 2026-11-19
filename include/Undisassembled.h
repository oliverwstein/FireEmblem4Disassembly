; Routines that the disassembled code calls but that are not disassembled yet.
; They are still copied from the base ROM. Each name is declared weakly, so a real
; label of the same name takes over as soon as the routine is disassembled; remove
; the line here when that happens.

  .weak


    aUnknown85C51B                                           :?= address($85C51B) ; read by rlUnknown85C4E0
    aUnknown879481                                           :?= address($879481) ; read by rlDrawMenuTextLine
    aUnknown889FC3                                           :?= address($889FC3) ; read by rlUnknown889268, rlUnknown889305
    aUnknown88DEFC                                           :?= address($88DEFC) ; read by rsUnknown88DE40, rsUnknown88DE9E
    aUnknown89A76C                                           :?= address($89A76C) ; read by rlUnknown8A8496
    aUnknown8A98C4                                           :?= address($8A98C4) ; read by rlUnknown8A9858
    aUnknown8BBED5                                           :?= address($8BBED5) ; read by rlUnknown8BBE68
    aUnknown8BBFED                                           :?= address($8BBFED) ; read by rlUnknown8BBE68
    aUnknown8BC457                                           :?= address($8BC457) ; read by rlUnknown8BC43A
    aUnknown8C9520                                           :?= address($8C9520) ; read by rlUnknown888082, rlUnknown88821A, rlUnknown9EF76F
    aUnknown8C9800                                           :?= address($8C9800) ; read by rlUnknown8A8F68
    aUnknown8C9A00                                           :?= address($8C9A00) ; read by rlUnknown80BA52
    aUnknown8C9D00                                           :?= address($8C9D00) ; read by rlUnknown80BA52, rlUnknown888082, rlUnknown8881A7, rlUnknown88821A
    aUnknown8CA000                                           :?= address($8CA000) ; read by rsUnknown8AE076
    aUnknown8CDCB0                                           :?= address($8CDCB0) ; read by rsWorldMapMarkerShadowLoadRedPalette
    aUnknown8CDE20                                           :?= address($8CDE20) ; read by rsUnknown8B8114
    aUnknown91FA27                                           :?= address($91FA27) ; read by rlUnknown91F9DD
    aUnknown959894                                           :?= address($959894) ; read by rlUnknown9597FA
    aUnknown998944                                           :?= address($998944) ; read by rsUnknown959B84, rsUnknown959BC1
    aUnknown9EA513                                           :?= address($9EA513) ; read by rlUnknown9EA417
    aUnknown9F80D9                                           :?= address($9F80D9) ; read by rlUnknown9F84DD, rlUnknown9F850B, rlUnknown9F8575
    aUnknown9F8724                                           :?= address($9F8724) ; read by rlUnknown9F86BF
    aUnknownD77000                                           :?= address($D77000) ; read by rlUnknown80BA52
    aUnknownD95000                                           :?= address($D95000) ; read by rlUnknown888082, rlUnknown88821A
    aUnknownDE0000                                           :?= address($DE0000) ; read by rlUnknown859BBD, rlUnknown85C4E0, rsUnknown899FF3, rsUnknown89A00F, rsUnknown89A02B, rsUnknown89A047
    aUnknownDE6200                                           :?= address($DE6200) ; read by rlGetDialogueBoxGraphicsAndPalette
    aUnknownE00060                                           :?= address($E00060) ; read by rlUnknown9599E7
    aUnknownF77C12                                           :?= address($F77C12) ; read by rsUnknown8093C6

  .endweak
