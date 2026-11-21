; Portrait palettes, 16 colours each (BGR555), pointed at by
; aPortraitPalettePointers. Each is named after the first entry that uses it.
; Unused: palettes of entries that no character or class uses; Placeholder:
; the two developer placeholders ($AE, $B0); Unknown (by address): palettes
; that are not in the table at all.

aPortraitPaletteSigurd ; 8C/A800
  .word $3800, $7B9C, $431D, $329A, $1592, $477F, $1442, $0D0D
  .word $0486, $44C3, $3881, $5124, $002B, $6565, $0C63, $0C40

aPortraitPaletteNaoise ; 8C/A820
  .word $3800, $679C, $477F, $431D, $329A, $1592, $04A6, $0059
  .word $0830, $0C68, $277F, $1ABB, $0592, $00CA, $0C63, $0841

aPortraitPaletteAlec ; 8C/A840
  .word $3800, $329A, $477F, $431D, $1171, $00CA, $3107, $49EF
  .word $6AD6, $77BC, $00E0, $0180, $0623, $1C84, $0C63, $0441

aPortraitPaletteArden ; 8C/A860
  .word $3800, $431D, $329A, $1592, $00CA, $0883, $477F, $420A
  .word $3588, $2926, $12A0, $09C1, $00E0, $0441, $0C63, $528E

aPortraitPaletteFinn ; 8C/A880
  .word $3800, $477F, $431D, $329A, $1592, $00CA, $7FB7, $72F0
  .word $4DE9, $59C1, $5D60, $4CE1, $2083, $1042, $0C63, $0865

aPortraitPaletteQuan ; 8C/A8A0
  .word $3800, $431D, $477F, $329A, $1592, $00CA, $0429, $084A
  .word $108D, $0006, $458C, $34E5, $6294, $77BD, $0C63, $0022

aPortraitPaletteMidir ; 8C/A8C0
  .word $3800, $477F, $431D, $329A, $1191, $0D0D, $00A8, $08A2
  .word $0C17, $086B, $0A84, $0603, $0181, $0120, $0C63, $0062

aPortraitPaletteLewyn ; 8C/A8E0
  .word $3800, $477F, $329A, $1592, $08C9, $0181, $0603, $0A84
  .word $08C2, $4D8C, $6A73, $7B7B, $431D, $2CC6, $0C63, $0062

aPortraitPaletteChulainn ; 8C/A900
  .word $3800, $4B9F, $431D, $329A, $1592, $04A7, $01AF, $0277
  .word $0B3C, $0CEA, $1C60, $28A0, $5085, $0084, $0C63, $0062

aPortraitPaletteAzelle ; 8C/A920
  .word $3800, $63BF, $431D, $329A, $1592, $477F, $0002, $0045
  .word $00BF, $002E, $00B9, $000A, $08C9, $0012, $0C63, $0024

aPortraitPaletteJamke ; 8C/A940
  .word $3800, $431D, $329A, $1592, $0CEA, $04A7, $0429, $0C8C
  .word $00C0, $0140, $2108, $39CE, $5AD6, $73FF, $0C63, $0422

aPortraitPaletteClaud ; 8C/A960
  .word $3800, $431D, $329A, $1592, $012B, $0CEA, $01AF, $0277
  .word $04A7, $6F7B, $0B3C, $477F, $3D4B, $5210, $0C63, $0C42

aPortraitPaletteBeowulf ; 8C/A980
  .word $3800, $477F, $431D, $329A, $1592, $04A7, $0277, $0B3C
  .word $1883, $20C6, $3108, $458C, $01AF, $5A31, $0C63, $0062

aPortraitPaletteLex ; 8C/A9A0
  .word $3800, $7F99, $431D, $329A, $1592, $00CA, $1C81, $3CC2
  .word $4904, $5565, $6DA6, $0140, $00E0, $477F, $0C63, $0C21

aPortraitPaletteDew ; 8C/A9C0
  .word $3800, $477F, $431D, $329A, $1592, $00E9, $037D, $02B8
  .word $01F1, $014C, $00A6, $12A0, $1160, $0CE3, $0C63, $0043

aPortraitPaletteDeirdre ; 8C/A9E0
  .word $3800, $6EF6, $431D, $329A, $0D0D, $477F, $20A4, $2D28
  .word $7738, $418B, $4E0F, $5E93, $21B3, $1462, $0C63, $0C42

aPortraitPaletteEthlyn ; 8C/AA00
  .word $3800, $5F9E, $431D, $329A, $1592, $477F, $0C24, $186A
  .word $0CE9, $2490, $3515, $4178, $233F, $55FC, $0C63, $0023

aPortraitPaletteLachesis ; 8C/AA20
  .word $3800, $7B9C, $431D, $329A, $1592, $477F, $0085, $458C
  .word $014C, $035D, $02B8, $6294, $00E9, $01F1, $0C63, $0083

aPortraitPaletteAyra ; 8C/AA40
  .word $3800, $6737, $431D, $329A, $1592, $477F, $1083, $14A5
  .word $0842, $356D, $0CEC, $4E72, $1CE7, $2108, $0C63, $1062

aPortraitPaletteErinys ; 8C/AA60
  .word $3800, $7B9C, $431D, $329A, $1592, $477F, $04C1, $414A
  .word $6294, $0A84, $0603, $0181, $10EA, $0120, $0C63, $0861

aPortraitPaletteTailtiu ; 8C/AA80
  .word $3800, $6EF7, $431D, $329A, $150C, $477F, $2085, $3108
  .word $00BC, $456B, $51EF, $6273, $21D5, $0C4B, $0C63, $0C20

aPortraitPaletteSilvia ; 8C/AAA0
  .word $3800, $635F, $431D, $329A, $1592, $477F, $04C1, $2A1C
  .word $00D3, $0A84, $0603, $0181, $08A8, $0120, $0C63, $0062

aPortraitPaletteEdain ; 8C/AAC0
  .word $3800, $7B9C, $431D, $329A, $1592, $477F, $0084, $112C
  .word $456B, $233F, $229A, $6294, $00E9, $1237, $0C63, $0042

aPortraitPaletteBrigid ; 8C/AAE0
  .word $3800, $7B9C, $431D, $329A, $1592, $477F, $0084, $112C
  .word $456B, $233F, $229A, $66B5, $00E9, $1237, $0C63, $0042

aPortraitPaletteYoungOifey ; 8C/AB00
  .word $3800, $3275, $431D, $329A, $1592, $00E9, $116D, $21F1
  .word $0043, $477F, $1A57, $5294, $7BDE, $0086, $0C63, $0043

aPortraitPaletteYoungShannan ; 8C/AB20
  .word $3800, $477F, $431D, $329A, $1592, $0CEA, $6AB5, $2108
  .word $1CE7, $14A5, $0C63, $0421, $30E7, $49EF, $0C63, $7B5A

aPortraitPaletteGhostSigurd ; 8C/AB40
  .word $3800, $7777, $4318, $3295, $158D, $4759, $0C82, $0D08
  .word $0462, $3103, $24C1, $3D64, $0425, $51A5, $0C63, $0460

aPortraitPaletteGhostDeirdre ; 8C/AB60
  .word $3800, $6AB3, $4318, $3295, $0D07, $475B, $1861, $28E5
  .word $7AD5, $3D48, $49CC, $5A50, $21CC, $1460, $0C63, $1040

aPortraitPaletteUnknown8CAB80 ; 8C/AB80
  .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
  .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

aPortraitPaletteUnknown8CABA0 ; 8C/ABA0
  .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
  .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

aPortraitPaletteUnknown8CABC0 ; 8C/ABC0
  .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
  .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

aPortraitPaletteUnknown8CABE0 ; 8C/ABE0
  .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
  .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

aPortraitPaletteUnknown8CAC00 ; 8C/AC00
  .word $3800, $5F9E, $42DD, $323A, $1D73, $471F, $2408, $4831
  .word $6518, $10C7, $340C, $58B5, $00EC, $717B, $3DCD, $0065

aPortraitPaletteUnknown8CAC20 ; 8C/AC20
  .word $3800, $63BF, $3EBC, $2A19, $00EC, $471F, $14E8, $4A52
  .word $001F, $0F1F, $0658, $56F8, $1551, $0191, $3DCD, $0065

aPortraitPaletteUnknown8CAC40 ; 8C/AC40
  .word $3800, $7FFF, $3A7B, $2A19, $1551, $471F, $08C7, $150D
  .word $01C3, $0246, $0140, $0879, $25B6, $6104, $3DCD, $0045

aPortraitPaletteUnknown8CAC60 ; 8C/AC60
  .word $3800, $671B, $429C, $323A, $0D0F, $471F, $28C6, $3129
  .word $181F, $458C, $59EF, $6294, $2195, $5A52, $3DCD, $0005

aClassCardPaletteKnightLord ; 8C/AC80
  .word $3800, $7FFF, $4F1C, $3237, $1D92, $471F, $14E9, $1044
  .word $0987, $0DA4, $1826, $246C, $34AF, $6B3F, $3460, $0421

aPortraitPaletteUnknown3 ; 8C/ACA0
  .word $3800, $7FFF, $4F1C, $3237, $1D92, $471F, $14E9, $1044
  .word $0987, $0DA4, $1826, $246C, $34AF, $6B3F, $3460, $0421

aPortraitPaletteUnknown8CACC0 ; 8C/ACC0
  .word $3800, $0024, $0024, $0024, $0024, $0024, $0024, $0024
  .word $0024, $0024, $0024, $0024, $0024, $0024, $0024, $0024

aPortraitPaletteUnknown8CACE0 ; 8C/ACE0
  .word $3800, $0024, $0024, $0024, $0024, $0024, $0024, $0024
  .word $0024, $0024, $0024, $0024, $0024, $0024, $0024, $0024

aPortraitPaletteSeliph ; 8C/AD00
  .word $3800, $5F9E, $431D, $329A, $1592, $477F, $1C81, $150D
  .word $0813, $4904, $3CC2, $5565, $181F, $6DA6, $0C63, $0C21

aPortraitPaletteShannan ; 8C/AD20
  .word $3800, $6737, $431D, $329A, $1592, $477F, $1063, $18A5
  .word $0841, $356D, $10EC, $45F1, $20E7, $2508, $0C63, $0C42

aPortraitPaletteDalvin ; 8C/AD40
  .word $3800, $477F, $431D, $329A, $1592, $08CA, $18A5, $1063
  .word $20E7, $0C42, $2508, $4571, $34ED, $2508, $0C63, $0421

aPortraitPaletteAsaello ; 8C/AD60
  .word $3800, $6737, $431D, $329A, $1592, $477F, $0C63, $14A5
  .word $0421, $356D, $10EC, $4E72, $1CE7, $2108, $0C63, $1062

aPortraitPaletteLeif ; 8C/AD80
  .word $3800, $7B9C, $431D, $329A, $150D, $477F, $0023, $34E5
  .word $49CA, $1592, $08CC, $6290, $0488, $04AA, $0C63, $0065

aPortraitPaletteIuchar ; 8C/ADA0
  .word $3800, $431D, $329A, $1DD4, $0D0D, $477F, $0825, $0846
  .word $084A, $0C6B, $0C67, $3CC0, $0086, $2800, $0C63, $0043

aPortraitPaletteCharlot ; 8C/ADC0
  .word $3800, $477F, $431D, $329A, $1592, $150B, $1C81, $3CC2
  .word $4904, $5565, $3129, $6DA6, $6294, $77BF, $0C63, $0C21

aPortraitPaletteHawk ; 8C/ADE0
  .word $3800, $7B9C, $431D, $329A, $150D, $477F, $0023, $2084
  .word $2CE7, $1592, $08CC, $3D4A, $0488, $04AA, $0C63, $0065

aPortraitPaletteTristan ; 8C/AE00
  .word $3800, $431D, $329A, $1592, $150D, $477F, $0024, $0488
  .word $04AA, $08CC, $0065, $1C60, $4443, $4C85, $0C63, $0022

aPortraitPaletteAdultFinn ; 8C/AE20
  .word $3800, $477F, $431D, $329A, $150D, $0C86, $1592, $7FB7
  .word $72F0, $59C1, $5D60, $4CE1, $2083, $1042, $0C63, $4DE9

aPortraitPaletteDeimne ; 8C/AE40
  .word $3800, $477F, $329A, $1DD4, $0D0F, $00CA, $0423, $0844
  .word $0849, $0C6C, $0846, $0100, $0160, $05C1, $0C63, $0421

aPortraitPaletteHannibal ; 8C/AE60
  .word $3800, $431D, $329A, $1DD4, $0D0F, $0C65, $0CC8, $0D2B
  .word $198E, $25F1, $14A7, $082F, $1492, $3254, $0C63, $0443

aPortraitPaletteJuliaHand ; 8C/AE80
  .word $3800, $6EF6, $431D, $329A, $0D0D, $477F, $20A4, $2D28
  .word $007B, $418B, $4E0F, $5E93, $21B3, $1462, $0C63, $0C21

aPortraitPaletteAmid ; 8C/AEA0
  .word $3800, $431D, $329A, $1592, $0D0D, $00A8, $00A0, $0100
  .word $01A1, $0623, $3501, $4164, $477F, $28A0, $0C63, $0441

aPortraitPaletteOldLewyn ; 8C/AEC0
  .word $3800, $477F, $329A, $1592, $08C9, $0181, $0603, $0A84
  .word $08C2, $3D08, $6A73, $7B7B, $431D, $0522, $0C63, $0062

aPortraitPaletteDaisy ; 8C/AEE0
  .word $3800, $5F9E, $431D, $329A, $150D, $477F, $49FC, $08CC
  .word $3116, $04AA, $5A7F, $0CEC, $1592, $0067, $0C63, $0043

aPortraitPaletteCreidne ; 8C/AF00
  .word $3800, $6737, $3EFC, $2E79, $1171, $435E, $1062, $356D
  .word $290A, $18A5, $1063, $20E7, $0CEB, $2508, $0C63, $0421

aPortraitPaletteMuirne ; 8C/AF20
  .word $3800, $6B58, $431D, $329A, $1592, $477F, $1483, $18A4
  .word $0821, $356D, $04EA, $4E72, $20E6, $2507, $0C63, $1062

aPortraitPaletteJulia ; 8C/AF40
  .word $3800, $6EF6, $431D, $329A, $0D0D, $477F, $20A4, $2D28
  .word $007B, $418B, $4E0F, $5E93, $21B3, $1462, $0C63, $0C21

aPortraitPaletteAltena ; 8C/AF60
  .word $3800, $7B9C, $431D, $329A, $150D, $477F, $0C1C, $08CC
  .word $0413, $04AA, $040C, $0023, $1592, $0488, $0C63, $0065

aPortraitPaletteHermina ; 8C/AF80
  .word $3800, $7B9C, $431D, $329A, $1592, $477F, $0CC3, $10EB
  .word $458C, $0181, $0120, $0603, $6294, $0A84, $0C63, $0462

aPortraitPaletteLinda ; 8C/AFA0
  .word $3800, $7B9C, $431D, $329A, $150D, $477F, $7D55, $08CC
  .word $5CB0, $04AA, $486B, $0023, $1592, $0488, $0C63, $0065

aPortraitPaletteLaylea ; 8C/AFC0
  .word $3800, $5F9E, $431D, $329A, $1592, $477F, $0C63, $14A5
  .word $0841, $1E5C, $10EC, $15DB, $1CE7, $2108, $0C63, $1062

aPortraitPaletteJeanne ; 8C/AFE0
  .word $3800, $7B9C, $431D, $329A, $150D, $477F, $629F, $08CC
  .word $4DFA, $04AA, $3953, $0422, $1592, $0488, $0C63, $0065

aPortraitPaletteIucharba ; 8C/B000
  .word $3800, $431D, $329A, $1DD4, $0D0F, $00CA, $477F, $0865
  .word $046B, $00AD, $0623, $0100, $01A1, $0048, $0C63, $0043

aPortraitPaletteScathach ; 8C/B020
  .word $3800, $7378, $431D, $329A, $1592, $477F, $1063, $18A5
  .word $0421, $356D, $10EC, $45F1, $20E7, $2508, $0C63, $1062

aPortraitPaletteFebail ; 8C/B040
  .word $3800, $5F9E, $431D, $329A, $0CEA, $477F, $0066, $01AF
  .word $4960, $0B7E, $0277, $06FB, $2D00, $1592, $0C63, $0842

aPortraitPaletteCoirpre ; 8C/B060
  .word $3800, $7B9C, $431D, $329A, $1592, $477F, $0084, $112C
  .word $456B, $233F, $229A, $6294, $00E9, $1237, $0C63, $0042

aPortraitPaletteCed ; 8C/B080
  .word $3800, $431D, $329A, $1592, $090D, $00A8, $04A1, $0100
  .word $01A1, $0623, $477F, $4080, $5D24, $0A84, $0C63, $0443

aPortraitPaletteDiarmuid ; 8C/B0A0
  .word $3800, $431D, $329A, $1DD4, $000C, $0087, $0064, $0D91
  .word $1237, $2298, $010D, $19F4, $477F, $2EFB, $0C63, $0841

aPortraitPaletteLester ; 8C/B0C0
  .word $3800, $7B9C, $42DC, $327A, $0D30, $473F, $2060, $0CCA
  .word $38A1, $5565, $44E3, $000B, $00BC, $6DA6, $0C63, $0C41

aPortraitPaletteArthur ; 8C/B0E0
  .word $3800, $76F7, $431D, $329A, $1592, $477F, $20A5, $08CB
  .word $4962, $3900, $3929, $6A94, $5A10, $496B, $0C63, $1042

aPortraitPalettePatty ; 8C/B100
  .word $3800, $73FF, $431D, $329A, $1592, $477F, $0084, $0CEA
  .word $2D00, $0277, $01AF, $4960, $6244, $0B7E, $0C63, $0042

aPortraitPaletteLarcei ; 8C/B120
  .word $3800, $6737, $431D, $329A, $1592, $477F, $1083, $14A5
  .word $0842, $356D, $0CEC, $4E72, $1CE7, $2108, $0C63, $1062

aPortraitPaletteLana ; 8C/B140
  .word $3800, $7B9C, $42DC, $327A, $0D2F, $473F, $0087, $010D
  .word $6294, $0594, $0DFC, $269E, $21D5, $458C, $0C63, $0863

aPortraitPaletteFee ; 8C/B160
  .word $3800, $7B9C, $431D, $329A, $1592, $477F, $08A2, $458C
  .word $6294, $0A84, $0603, $0181, $0CEA, $0120, $0C63, $0461

aPortraitPaletteTine ; 8C/B180
  .word $3800, $6F18, $42DC, $327A, $0D2F, $473F, $24A6, $3129
  .word $00BC, $458C, $5210, $6294, $21D5, $0C4B, $0C63, $1461

aPortraitPaletteLene ; 8C/B1A0
  .word $3800, $5E9F, $431D, $329A, $1592, $477F, $04C1, $55FB
  .word $4157, $0A84, $0603, $0181, $08A8, $0120, $0C63, $0062

aPortraitPaletteNanna ; 8C/B1C0
  .word $3800, $7B9C, $431D, $329A, $1592, $477F, $0083, $458C
  .word $014C, $037D, $02B8, $6294, $00E9, $01F1, $0C63, $0820

aPortraitPaletteJuliaEnemy ; 8C/B1E0
  .word $3800, $6EF5, $431D, $329A, $0D0D, $477F, $20A4, $2D27
  .word $007B, $418A, $4E0E, $5E91, $21B3, $1462, $0C63, $0C21

aPortraitPaletteMunnir ; 8C/B200
  .word $3800, $477F, $431D, $329A, $1592, $00EC, $08A0, $1102
  .word $1D65, $0003, $0007, $084A, $108D, $0466, $0C63, $0440

aPortraitPaletteDiMaggio ; 8C/B220
  .word $3800, $477F, $431D, $329A, $1592, $0CEB, $08A7, $0422
  .word $0845, $0889, $0CCF, $00B5, $1E33, $116D, $0C63, $0463

aPortraitPaletteGerrard ; 8C/B240
  .word $3800, $431D, $329A, $1592, $0CEB, $08A7, $050A, $0D6D
  .word $1DCF, $477F, $0064, $00A7, $0D4E, $2820, $0C63, $0422

aPortraitPaletteCimbaeth ; 8C/B260
  .word $3800, $477F, $431D, $329A, $1592, $00CA, $010D, $1191
  .word $2215, $0C64, $0005, $0007, $084A, $108D, $0C63, $0422

aPortraitPaletteSandima ; 8C/B280
  .word $3800, $6F7B, $329A, $1592, $00CA, $0086, $0A14, $0EF9
  .word $08E0, $0D00, $1540, $19A0, $431D, $00A0, $0C63, $0461

aPortraitPaletteClement ; 8C/B2A0
  .word $3800, $431D, $329A, $1592, $010C, $0086, $0EF9, $0A14
  .word $477F, $19A0, $1540, $0D00, $08E0, $00A0, $0C63, $0421

aPortraitPaletteBordeaux ; 8C/B2C0
  .word $3800, $42FC, $3279, $1571, $00CA, $0086, $1615, $116E
  .word $475E, $19A0, $0D00, $00A0, $1CAD, $1087, $0C63, $0422

aPortraitPaletteElliot ; 8C/B2E0
  .word $3800, $431D, $329A, $1592, $00CA, $0086, $116E, $1615
  .word $2298, $475E, $1087, $1CAD, $08CA, $0443, $0C63, $0065

aPortraitPaletteZane ; 8C/B300
  .word $3800, $431D, $329A, $1592, $08EA, $00A7, $0C85, $04C8
  .word $0D0A, $154C, $1DAE, $000C, $477F, $007B, $0C63, $0842

aPortraitPalettePhilip ; 8C/B320
  .word $3800, $431D, $329A, $1592, $00C9, $0086, $0023, $0065
  .word $0488, $04AA, $477F, $08CC, $1087, $1CAD, $0C63, $0422

aPortraitPaletteWaltz ; 8C/B340
  .word $3800, $63BF, $431D, $329A, $0D0F, $477F, $1215, $0087
  .word $231C, $0191, $09B0, $092C, $00EC, $00C9, $0C63, $0044

aPortraitPaletteMacBeth ; 8C/B360
  .word $3800, $431D, $329A, $1592, $00EA, $0086, $0C63, $2108
  .word $318C, $4A52, $6318, $0C68, $108B, $1CEE, $0C63, $0842

aPortraitPaletteChagall ; 8C/B380
  .word $3800, $63BF, $3EDD, $2E7A, $08EF, $475F, $1215, $0087
  .word $22FB, $0191, $09B0, $092C, $00EC, $00C9, $1063, $0042

aPortraitPaletteJacobi ; 8C/B3A0
  .word $3800, $431D, $327A, $1171, $00E8, $0990, $1A14, $2EB9
  .word $00A6, $477F, $3B1C, $30C7, $2064, $3509, $1063, $0443

aPortraitPalettePizare ; 8C/B3C0
  .word $3800, $431D, $329A, $1592, $0CEB, $08A7, $2108, $318C
  .word $4210, $477F, $0C63, $14A5, $0D4E, $2820, $0C63, $0422

aPortraitPaletteDuvall ; 8C/B3E0
  .word $3800, $477F, $431D, $329A, $1592, $0CEB, $08A7, $0422
  .word $2882, $34E5, $4188, $562D, $1E33, $116D, $0C63, $0463

aPortraitPaletteAndrey ; 8C/B400
  .word $3800, $0080, $431D, $329A, $1592, $08A8, $0066, $00EB
  .word $0971, $19F5, $2677, $32DA, $00E0, $477F, $0C63, $0443

aPortraitPaletteBloom ; 8C/B420
  .word $3800, $6FFF, $431D, $329A, $1592, $477F, $14A7, $1CE9
  .word $35AD, $5AD6, $0C65, $4A52, $10EC, $000C, $0C63, $0821

aPortraitPaletteDanann ; 8C/B440
  .word $3800, $431D, $329A, $1592, $0D0D, $0087, $0D00, $1540
  .word $19A0, $08A0, $0007, $084A, $108D, $477F, $0C63, $0422

aPortraitPaletteLamia ; 8C/B460
  .word $3800, $5F9E, $431D, $329A, $1592, $477F, $0843, $1085
  .word $0422, $356D, $14EB, $0813, $14A6, $18C7, $0C63, $0085

aPortraitPaletteArvis ; 8C/B480
  .word $3800, $431D, $329A, $1592, $08A8, $0068, $0011, $0077
  .word $002B, $0024, $00BC, $3129, $477F, $77BF, $0C63, $0442

aPortraitPaletteEldigan ; 8C/B4A0
  .word $3800, $477F, $431D, $329A, $1592, $00EA, $0064, $035D
  .word $02B8, $01F1, $014C, $0096, $0028, $0022, $0C63, $00E9

aPortraitPaletteMyos ; 8C/B4C0
  .word $3800, $431D, $329A, $1592, $00CA, $0086, $116E, $1615
  .word $2298, $475E, $2003, $3406, $08CA, $0443, $0C63, $0065

aPortraitPaletteDaccar ; 8C/B4E0
  .word $3800, $42FC, $3279, $1571, $00CA, $0086, $1615, $116E
  .word $475E, $3406, $2805, $1402, $1540, $08E0, $0C63, $0422

aPortraitPalettePamela ; 8C/B500
  .word $3800, $6FFF, $431D, $329A, $1592, $477F, $0CC3, $0C1C
  .word $0181, $0A84, $0120, $0603, $10EC, $0603, $0C63, $0082

aPortraitPaletteDithorba ; 8C/B520
  .word $3800, $6FFF, $431D, $329A, $1592, $477F, $0CC3, $0C1C
  .word $0181, $0A84, $0120, $0603, $10EC, $0603, $0C63, $0082

aPortraitPaletteAnnand ; 8C/B540
  .word $3800, $7B9C, $431D, $329A, $1592, $477F, $0CC3, $458C
  .word $6294, $0A84, $0603, $0181, $10EC, $0120, $0C63, $0082

aPortraitPaletteDonovan ; 8C/B560
  .word $3800, $477F, $431D, $329A, $1592, $00CA, $010D, $1191
  .word $2215, $0C64, $08E0, $0D00, $1540, $19A0, $0C63, $0422

aPortraitPaletteLombard ; 8C/B580
  .word $3800, $477F, $431D, $329A, $1592, $0CEB, $0086, $737B
  .word $6B18, $5273, $3DAD, $2929, $1CC6, $0842, $0C63, $1063

aPortraitPalettePurpleAndrey ; 8C/B5A0
  .word $3800, $1002, $431D, $329A, $1592, $08A8, $0066, $00EB
  .word $0971, $19F5, $2677, $32DA, $2405, $477F, $0C63, $0843

aPortraitPaletteReptor ; 8C/B5C0
  .word $3800, $2929, $431D, $329A, $1592, $00CA, $04C0, $3DAD
  .word $5273, $6B18, $737B, $0902, $1564, $0842, $0C63, $1CC6

aPortraitPaletteRedIshtore ; 8C/B5E0
  .word $3800, $477F, $431D, $329A, $1592, $0D0D, $0087, $0009
  .word $000C, $0013, $003A, $0005, $0011, $77BD, $0C63, $0422

aPortraitPaletteVaja ; 8C/B600
  .word $3800, $6FFF, $431D, $329A, $1592, $477F, $14A5, $0C1C
  .word $35AD, $5AD6, $2108, $4A52, $10EC, $6584, $0C63, $0C62

aPortraitPaletteYoungTravant ; 8C/B620
  .word $3800, $431D, $329A, $1592, $08A8, $0083, $0107, $0129
  .word $00C5, $0062, $096B, $3129, $477F, $77BF, $0C63, $0041

aPortraitPaletteCuvuli ; 8C/B640
  .word $3800, $431D, $329A, $1592, $00CA, $0086, $0A14, $0EF9
  .word $1884, $1CA5, $24C6, $30E7, $0D2E, $1063, $0C63, $0C21

aPortraitPaletteMagorn ; 8C/B660
  .word $3800, $431D, $329A, $1592, $08EA, $00A7, $0C85, $04C8
  .word $0D0A, $154C, $1DAE, $0100, $477F, $01C0, $0C63, $0842

aPortraitPaletteAida ; 8C/B680
  .word $3800, $7F99, $431D, $329A, $1592, $477F, $150D, $0023
  .word $0045, $002E, $00B9, $0012, $08A8, $00BF, $0C63, $0046

aPortraitPaletteGraySandima ; 8C/B6A0
  .word $3800, $6F7B, $329A, $1592, $00CA, $0086, $0A14, $0EF9
  .word $1884, $1CA5, $3103, $3D65, $431D, $1063, $0C63, $0C21

aPortraitPaletteUnusedBrian ; 8C/B6C0
  .word $3800, $477F, $431D, $329A, $1592, $0086, $0464, $180D
  .word $0C08, $0805, $00C9, $116E, $1615, $2298, $0C63, $0043

aPortraitPaletteHarold ; 8C/B6E0
  .word $3800, $431D, $329A, $1592, $08EA, $00A7, $0C85, $04C8
  .word $0D0A, $154C, $1DAE, $0108, $477F, $01CE, $0C63, $0842

aPortraitPaletteBramsel ; 8C/B700
  .word $3800, $431D, $329A, $1592, $010C, $0086, $0EF9, $0A14
  .word $477F, $2410, $180D, $140A, $0C08, $0805, $0C63, $0422

aPortraitPaletteUnusedSandima ; 8C/B720
  .word $3800, $6F7B, $329A, $1592, $00CA, $0086, $0A14, $0EF9
  .word $1C44, $2486, $2CC7, $34E8, $431D, $1443, $0C63, $0C01

aPortraitPaletteJavarro ; 8C/B740
  .word $3800, $431D, $327A, $1171, $00E8, $0990, $1A14, $2EB9
  .word $00A6, $477F, $3B1C, $0C08, $0805, $180D, $1063, $0443

aPortraitPaletteIshtore ; 8C/B760
  .word $3800, $477F, $431D, $329A, $1592, $0D0D, $0485, $28E7
  .word $354A, $49EF, $5652, $1C84, $41AD, $77BD, $1063, $0822

aPortraitPaletteLiza ; 8C/B780
  .word $3800, $7F99, $431D, $329A, $1592, $477F, $150D, $0423
  .word $0805, $0C08, $1C0F, $180B, $08A8, $159F, $0C63, $0866

aPortraitPaletteUnusedBloom ; 8C/B7A0
  .word $3800, $6FFF, $431D, $329A, $1592, $477F, $14A7, $1CE9
  .word $35AD, $5AD6, $0C65, $4A52, $10EC, $000C, $0C63, $0821

aPortraitPaletteBanba ; 8C/B7C0
  .word $3800, $6FFF, $431D, $329A, $1592, $477F, $14A5, $0C1C
  .word $35AD, $5AD6, $2108, $4A52, $10EC, $726C, $0C63, $0C62

aPortraitPaletteFotla ; 8C/B7E0
  .word $3800, $6FFF, $431D, $329A, $1592, $477F, $14A5, $0C1C
  .word $35AD, $5AD6, $2108, $4A52, $10EC, $0012, $0C63, $0C62

aPortraitPaletteEriu ; 8C/B800
  .word $3800, $6FFF, $431D, $329A, $1592, $477F, $14A5, $0C1C
  .word $35AD, $5AD6, $2108, $4A52, $10EC, $0160, $0C63, $0C62

aPortraitPaletteAnnandDialogue ; 8C/B820
  .word $3800, $77BB, $431D, $329A, $1592, $477F, $08C2, $39C9
  .word $5EF3, $1284, $0E03, $0581, $10EC, $0120, $0C63, $0481

aPortraitPaletteUnknown ; 8C/B840
  .word $3800, $77BB, $431D, $329A, $1592, $477F, $08C2, $39C9
  .word $5EF3, $1284, $0E03, $0581, $10EC, $0120, $0C63, $0481

aPortraitPaletteUnknown2 ; 8C/B860
  .word $3800, $77BB, $431D, $329A, $1592, $477F, $08C2, $39C9
  .word $5EF3, $1284, $0E03, $0581, $10EC, $0120, $0C63, $0481

aPortraitPaletteArion ; 8C/B880
  .word $3800, $431D, $329A, $1592, $0D0D, $08A8, $0443, $0486
  .word $04C8, $090A, $154C, $0005, $0011, $477F, $0C63, $0420

aPortraitPalettePapilio ; 8C/B8A0
  .word $3800, $431D, $329A, $1592, $08EA, $00A7, $0C85, $04C8
  .word $0D0A, $154C, $1DAE, $00E7, $477F, $018F, $0C63, $0842

aPortraitPaletteMaykov ; 8C/B8C0
  .word $3800, $431D, $329A, $1592, $00C9, $0086, $0023, $0065
  .word $0488, $04AA, $477F, $08CC, $08C2, $0581, $0C63, $0422

aPortraitPaletteOvo ; 8C/B8E0
  .word $3800, $431D, $329A, $1592, $0D0D, $08A8, $7FFF, $477F
  .word $2827, $3069, $38AB, $2A37, $21F5, $0086, $0C63, $0822

aPortraitPaletteMuhammad ; 8C/B900
  .word $3800, $63BF, $3EDD, $2E7A, $08EF, $475F, $1215, $0087
  .word $22FB, $0191, $09B0, $092C, $00EC, $00C9, $1063, $0042

aPortraitPaletteMorrigan ; 8C/B920
  .word $3800, $431D, $329A, $1592, $010C, $0086, $0EF9, $0A14
  .word $477F, $098C, $014A, $0108, $00C6, $00A5, $1063, $0042

aPortraitPaletteTravant ; 8C/B940
  .word $3800, $431D, $329A, $1592, $08A8, $0083, $0107, $0129
  .word $00C5, $0062, $096B, $3129, $477F, $77BF, $1063, $0041

aPortraitPaletteMusar ; 8C/B960
  .word $3800, $431D, $329A, $1592, $08EA, $00A7, $0C85, $04C8
  .word $0D0A, $154C, $1DAE, $1C84, $477F, $28E7, $0C63, $0842

aPortraitPaletteDistler ; 8C/B980
  .word $3800, $42FC, $3279, $1571, $00CA, $0086, $1615, $116E
  .word $475E, $180D, $140A, $0C08, $0107, $00C5, $0C63, $0422

aPortraitPaletteKanatz ; 8C/B9A0
  .word $3800, $431D, $329A, $1592, $00C9, $0086, $0023, $0065
  .word $0488, $04AA, $477F, $08CC, $00C5, $0107, $0C63, $0422

aPortraitPaletteEve ; 8C/B9C0
  .word $3800, $433D, $3EFC, $2E79, $1171, $00C9, $0006, $000B
  .word $000E, $0015, $1D40, $3200, $5300, $000F, $0C64, $0422

aPortraitPaletteEva ; 8C/B9E0
  .word $3800, $433D, $3EFC, $2E79, $1171, $00C9, $0006, $000B
  .word $000E, $0015, $0141, $05C3, $0A84, $000F, $0C64, $0422

aPortraitPaletteAlva ; 8C/BA00
  .word $3800, $433D, $3EFC, $2E79, $1171, $00C9, $0006, $000B
  .word $000E, $0015, $014C, $02B8, $035D, $000F, $0C63, $0422

aPortraitPaletteJudah ; 8C/BA20
  .word $3800, $6F7B, $329A, $1592, $00CA, $0086, $0A14, $0EF9
  .word $00C5, $0107, $0129, $096B, $431D, $0083, $0C63, $0041

aPortraitPaletteHilda ; 8C/BA40
  .word $3800, $5F9E, $431D, $329A, $1592, $477F, $0843, $1085
  .word $0422, $356D, $14EB, $0813, $14A6, $18C7, $0C63, $0085

aPortraitPaletteMeng ; 8C/BA60
  .word $3800, $6FFF, $431D, $329A, $1592, $477F, $0024, $0C1C
  .word $00CD, $0156, $0088, $00D2, $10EC, $0035, $0C63, $0463

aPortraitPaletteMabel ; 8C/BA80
  .word $3800, $6FFF, $431D, $329A, $1592, $477F, $0024, $0C1C
  .word $00CD, $0156, $0088, $00D2, $10EC, $0035, $0C63, $0463

aPortraitPaletteAres ; 8C/BAA0
  .word $3800, $477F, $431D, $329A, $1592, $00EA, $0064, $035D
  .word $02B8, $01F1, $014C, $7BDE, $0028, $0022, $0C63, $00E9

aPortraitPaletteManfroy ; 8C/BAC0
  .word $3800, $6F7B, $3A79, $1D71, $0CA9, $0465, $1614, $1ED8
  .word $1402, $2003, $140A, $180D, $431D, $0C00, $0C63, $0821

aPortraitPaletteRiddell ; 8C/BAE0
  .word $3800, $431D, $329A, $1592, $08EA, $00A7, $0C85, $04C8
  .word $0D0A, $154C, $1DAE, $1C84, $477F, $4C13, $0C63, $0842

aPortraitPaletteOldArvis ; 8C/BB00
  .word $3800, $431D, $329A, $1592, $08A8, $0068, $0011, $0077
  .word $002B, $0024, $00BC, $56B5, $477F, $7BBC, $0C63, $0442

aPortraitPaletteJulius ; 8C/BB20
  .word $3800, $431D, $329A, $1592, $08A8, $0068, $0011, $0077
  .word $002B, $0024, $00BC, $3129, $477F, $77BF, $0C63, $0442

aPortraitPaletteUnusedLamia8B ; 8C/BB40
  .word $3800, $5F9E, $431D, $329A, $1592, $477F, $0843, $1085
  .word $0422, $356D, $14EB, $0813, $14A6, $18C7, $0C63, $0085

aPortraitPaletteIshtar ; 8C/BB60
  .word $3800, $6EF7, $431D, $329A, $0D0D, $477F, $20A4, $2D28
  .word $007B, $418B, $4E0F, $5E93, $21B3, $1462, $0C63, $0C21

aPortraitPaletteScipio ; 8C/BB80
  .word $3800, $0004, $431D, $329A, $1592, $08A8, $0066, $00EB
  .word $0971, $19F5, $2677, $32DA, $000C, $477F, $0C63, $0443

aPortraitPaletteBrian ; 8C/BBA0
  .word $3800, $477F, $431D, $329A, $1592, $0086, $0464, $180D
  .word $0C08, $0805, $00C9, $116E, $1615, $2298, $0C63, $0043

aPortraitPaletteCoulter ; 8C/BBC0
  .word $3800, $431D, $329A, $1592, $08EA, $00A7, $0C85, $04C8
  .word $0D0A, $154C, $1DAE, $1CE0, $477F, $3D80, $0C63, $0842

aPortraitPaletteZagam ; 8C/BBE0
  .word $3800, $6F7B, $329A, $1592, $00CA, $0086, $0A14, $0EF9
  .word $1C07, $2C0B, $0011, $003A, $431D, $1405, $0C63, $0802

aPortraitPaletteBaran ; 8C/BC00
  .word $3800, $6F7B, $329A, $1592, $00CA, $0086, $0A14, $0EF9
  .word $0805, $0C07, $28A0, $34C0, $431D, $0004, $0C63, $0422

aPortraitPaletteFisherDialogue ; 8C/BC20
  .word $3800, $431D, $329A, $1592, $00C9, $0086, $0023, $0065
  .word $0488, $04AA, $477F, $08CC, $1C84, $34A7, $0C63, $0422

aPortraitPaletteKutuzov ; 8C/BC40
  .word $3800, $431D, $329A, $1592, $00CA, $0086, $0A14, $0EF9
  .word $00A4, $00E6, $0107, $0149, $0D2E, $0083, $0C63, $0041

aPortraitPaletteJuphiel ; 8C/BC60
  .word $3800, $6F7B, $329A, $1592, $00CA, $0086, $0A14, $0EF9
  .word $1440, $1C60, $140A, $180D, $431D, $1000, $0C63, $0821

aPortraitPaletteOldEmissary ; 8C/BC80
  .word $3800, $431D, $329A, $1592, $0D0D, $0087, $2420, $2108
  .word $318C, $4A52, $5AD6, $477F, $4443, $14A5, $0C63, $0863

aPortraitPaletteAzmur ; 8C/BCA0
  .word $3800, $4B1B, $3A99, $1D91, $14EC, $08C7, $0C63, $2108
  .word $318C, $4A52, $6318, $0443, $0009, $14A5, $0C63, $0065

aPortraitPaletteKurth ; 8C/BCC0
  .word $3800, $431D, $329A, $1592, $477F, $00A8, $1085, $012F
  .word $0DB3, $1A16, $2677, $00ED, $318C, $6318, $0C63, $0842

aPortraitPaletteRing ; 8C/BCE0
  .word $3800, $431D, $327A, $1592, $00EC, $10A6, $2108, $3DEF
  .word $4E73, $6318, $0813, $48E0, $5D40, $0883, $0C63, $0843

aPortraitPaletteByron ; 8C/BD00
  .word $3800, $431D, $329A, $1592, $0D0D, $0486, $18C6, $2D6B
  .word $3DEF, $5294, $2529, $3460, $54C3, $6739, $0C63, $0443

aPortraitPaletteOifey ; 8C/BD20
  .word $3800, $431D, $329A, $1592, $08EA, $00A7, $0C85, $04C8
  .word $0D0A, $154C, $1DAE, $2405, $477F, $7BDE, $0C63, $0842

aPortraitPaletteSlayder ; 8C/BD40
  .word $3800, $477F, $431D, $329A, $1592, $0D0D, $0087, $4B5A
  .word $3EF7, $2E73, $1DEF, $00E7, $0084, $0042, $0C63, $0D6B

aPortraitPaletteUnknown4 ; 8C/BD60
  .word $3800, $6FFF, $431D, $329A, $1592, $477F, $14E8, $0047
  .word $35AD, $5AD6, $0884, $4A52, $150D, $6739, $0C63, $0C41

aPortraitPaletteBlueMacBeth ; 8C/BD80
  .word $3800, $431D, $329A, $1592, $00EA, $0086, $0C63, $2108
  .word $318C, $4A52, $6318, $2063, $2C84, $38E7, $0C63, $0842

aPortraitPaletteBatu ; 8C/BDA0
  .word $3800, $431D, $329A, $1592, $00CA, $0C85, $2108, $3DEF
  .word $4E73, $6318, $08E0, $1540, $19A0, $477F, $0C63, $0862

aPortraitPaletteRahna ; 8C/BDC0
  .word $3800, $7B9C, $431D, $329A, $1592, $477F, $1062, $14EB
  .word $6294, $18A5, $1063, $20E7, $45F1, $2508, $0C63, $0C21

aPortraitPaletteFelipe ; 8C/BDE0
  .word $3800, $431D, $327A, $1592, $00EC, $10A6, $2108, $3DEF
  .word $4E73, $6318, $0813, $002B, $0077, $0883, $0C63, $0843

aPortraitPalettePalmarch ; 8C/BE00
  .word $3800, $431D, $327A, $1592, $00EC, $10A6, $2108, $3DEF
  .word $4E73, $6318, $2D08, $24C6, $396B, $0883, $0C63, $0843

aPortraitPaletteRodan ; 8C/BE20
  .word $3800, $431D, $329A, $1592, $0D0D, $0087, $2420, $2108
  .word $318C, $4A52, $5AD6, $477F, $4443, $14A5, $0C63, $0863

aPortraitPaletteSoldier ; 8C/BE40
  .word $3800, $431D, $329A, $15B3, $0D2E, $0088, $3DEF, $2108
  .word $318C, $4A52, $5AD6, $477F, $6318, $14A5, $0C63, $0863

aPortraitPaletteEmpty ; 8C/BE60
  .word $3800, $0000, $3DEF, $7FFF, $3460, $0000, $0000, $0000
  .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

aPortraitPaletteUnusedLamiaA5 ; 8C/BE80
  .word $3800, $5F9E, $431D, $329A, $1592, $477F, $0843, $1085
  .word $0422, $356D, $14EB, $0813, $14A6, $18C7, $0C63, $0085

aPortraitPaletteRoberto ; 8C/BEA0
  .word $3800, $63BF, $431D, $329A, $0D0F, $477F, $1215, $0087
  .word $231C, $0191, $09B0, $092C, $00EC, $00C9, $0C63, $0044

aPortraitPaletteBoyce ; 8C/BEC0
  .word $3800, $431D, $327A, $1171, $00E8, $0990, $1A14, $2EB9
  .word $00A6, $477F, $3B1C, $2467, $1445, $28A8, $1063, $0443

aPortraitPaletteFisher ; 8C/BEE0
  .word $3800, $431D, $329A, $1592, $00C9, $0086, $0023, $0065
  .word $0488, $04AA, $477F, $08CC, $2064, $30C7, $0C63, $0422

aPortraitPaletteArmory ; 8C/BF00
  .word $3800, $5F9E, $431D, $329A, $1592, $0D0D, $0087, $008A
  .word $0045, $477F, $0967, $0D25, $0CC4, $0882, $0C63, $0443

aPortraitPaletteCivilianSmallBoy ; 8C/BF20
  .word $3800, $5F9E, $431D, $329A, $150D, $477F, $0464, $192C
  .word $08CA, $0488, $0466, $0C1C, $1592, $14EB, $0C63, $0421

aPortraitPaletteBlacksmith ; 8C/BF40
  .word $3800, $431D, $329A, $1592, $0D0D, $0087, $0845, $0026
  .word $0068, $08AB, $0967, $0D25, $477F, $0882, $0C63, $0043

aPortraitPaletteCivilianSmallGirl ; 8C/BF60
  .word $3800, $5F9E, $431D, $329A, $1592, $477F, $0065, $3515
  .word $4178, $08CC, $04AA, $0488, $150D, $55FC, $0C63, $0023

aPortraitPaletteArena ; 8C/BF80
  .word $3800, $431D, $329A, $1592, $0D0D, $0087, $0845, $0026
  .word $0068, $08AB, $0967, $0D25, $477F, $0882, $0C63, $0043

aPortraitPalettePlaceholderArena ; 8C/BFA0
  .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
  .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

aPortraitPaletteCivilian ; 8C/BFC0
  .word $3800, $431D, $329A, $1592, $0D0D, $08A8, $477F, $0005
  .word $0447, $048A, $0CCC, $0CC3, $0D25, $0967, $0C63, $0043

aPortraitPalettePlaceholderDepot ; 8C/BFE0
  .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
  .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

aPortraitPalettePawnbroker ; 8C/C000
  .word $3800, $477F, $431D, $329A, $1DF5, $112E, $08A8, $08CC
  .word $0889, $09B2, $016F, $10EA, $50E0, $1CA3, $0C63, $0043

aPortraitPaletteAnna ; 8C/C020
  .word $3800, $7F99, $431D, $329A, $1592, $477F, $150D, $0023
  .word $0045, $002E, $00B9, $0012, $08A8, $00BF, $0C63, $0046

aPortraitPaletteCivilianOldMan ; 8C/C040
  .word $3800, $6FFF, $42DC, $329A, $150D, $473F, $0023, $08CC
  .word $4A52, $56F8, $0488, $181F, $1592, $35AD, $0C63, $0065

aPortraitPaletteCivilianOldWoman ; 8C/C060
  .word $3800, $7FFF, $431D, $329A, $1592, $477F, $04A7, $150C
  .word $7B18, $5A31, $3129, $1CA5, $1463, $7B18, $0C63, $0062

aPortraitPaletteCivilian2 ; 8C/C080
  .word $3800, $431D, $329A, $1592, $0D0D, $08A8, $477F, $0005
  .word $0447, $048A, $0CCC, $0CC3, $0D25, $0967, $0C63, $0043

aPortraitPaletteCivilianWoman ; 8C/C0A0
  .word $3800, $7FFF, $42DC, $329A, $1592, $473F, $1CE7, $192E
  .word $458C, $5210, $2108, $14A5, $1062, $6EF7, $0C63, $1CE7

aPortraitPaletteCivilianYoungMan ; 8C/C0C0
  .word $3800, $7FFF, $431D, $329A, $1592, $477F, $04A6, $150D
  .word $1884, $20C6, $0CE8, $181F, $0064, $1063, $0C63, $0022

aPortraitPaletteCivilianYoungWoman ; 8C/C0E0
  .word $3800, $5F9E, $431D, $329A, $150D, $477F, $49FC, $08CC
  .word $2CF5, $04AA, $1C70, $0023, $1592, $0488, $0C63, $0065

aClassCardPaletteCavalier ; 8C/C100
  .word $294D, $4232, $214C, $10C8, $2D6B, $4631, $6F7B, $28A5
  .word $4676, $2DAF, $14E9, $29F5, $00E9, $10C8, $1E79, $0884

aClassCardPaletteLanceKnight ; 8C/C120
  .word $3000, $3A78, $1D8F, $10C8, $2D6B, $4631, $6F7B, $28A5
  .word $4ED9, $3215, $090E, $29F5, $28A5, $10C8, $1E79, $0CA5

aClassCardPaletteDukeKnight ; 8C/C140
  .word $3000, $7FFF, $7F35, $4567, $58E7, $7E0D, $7FFF, $58E7
  .word $7FFF, $7F35, $4567, $29F5, $0000, $10C8, $1E79, $0CA5

aClassCardPalettePaladin ; 8C/C160
  .word $7FFF, $7FFF, $7F35, $4567, $1E1F, $1F9F, $7FFF, $0987
  .word $6F7B, $5294, $2529, $29F5, $0000, $10C8, $1E79, $0CA5

aClassCardPaletteArchKnight ; 8C/C180
  .word $3000, $3A78, $1D8F, $10C8, $1E1F, $1F9F, $6F7B, $28A5
  .word $6F7B, $5294, $2529, $29F5, $28A5, $10C8, $1E79, $0CA5

aClassCardPaletteMageKnight ; 8C/C1A0
  .word $4001, $3A78, $1D8F, $10C8, $0015, $001F, $7FFF, $0987
  .word $6F7B, $5294, $2529, $29F5, $0000, $10C8, $1E79, $0CA5

aClassCardPaletteGreatKnight ; 8C/C1C0
  .word $0001, $42D9, $25D8, $1CB6, $1E1F, $1F9F, $7FFF, $0987
  .word $4ED9, $3215, $090E, $29F5, $0000, $10C8, $1E79, $0CA5

aClassCardPalettePegasusRider ; 8C/C1E0
  .word $4001, $7FFF, $7F35, $4567, $58E7, $7E0D, $7FFF, $0C63
  .word $1E1F, $1896, $0987, $29F5, $0080, $10C8, $1E79, $0CA5

aClassCardPaletteDragonRider ; 8C/C200
  .word $3800, $00C4, $0D28, $25CC, $3E72, $7FFF, $1E96, $1896
  .word $0E10, $0588, $00E5, $29F5, $10A3, $10C8, $1E79, $0463

aClassCardPaletteDragonKnight ; 8C/C220
  .word $3800, $00E0, $0567, $0DED, $1253, $7FFF, $19F5, $1896
  .word $4DCE, $4129, $34A5, $29F5, $0007, $10C8, $1E79, $0842

aClassCardPaletteArcher ; 8C/C240
  .word $3800, $0009, $112F, $294A, $3DEF, $3F13, $2A4D, $0D28
  .word $00E4, $5294, $6F7B, $29F5, $0106, $1087, $1E79, $0C63

aClassCardPaletteSniper ; 8C/C260
  .word $3800, $0009, $112F, $294A, $3DEF, $42B8, $3256, $19B2
  .word $012E, $5294, $6F7B, $29F5, $2462, $10C8, $1E79, $0C63

aClassCardPaletteGeneral ; 8C/C280
  .word $3800, $18C6, $2D4A, $41EF, $5294, $7FFF, $0C63, $0009
  .word $08AE, $1133, $1E1A, $29F5, $0000, $10C8, $1E79, $0CA5

aClassCardPaletteBaron ; 8C/C2A0
  .word $3800, $04CC, $112F, $29B2, $4A97, $7FFF, $0C63, $00C4
  .word $0D28, $25CC, $3E72, $29F5, $0000, $10C8, $1E79, $0CA5

aClassCardPaletteSpearSoldier ; 8C/C2C0
  .word $3800, $5294, $6F7B, $294A, $3DEF, $4212, $2D6E, $18CA
  .word $0C67, $5294, $6F7B, $29F5, $0106, $10A7, $1E79, $0C63

aClassCardPaletteLanceArmor ; 8C/C2E0
  .word $3800, $0047, $00AC, $08ED, $112F, $2DD3, $4A97, $1CE7
  .word $1E1A, $1EDA, $7FFF, $29F5, $0007, $10C8, $1E79, $0C63

aClassCardPaletteAxeArmor ; 8C/C300
  .word $294A, $0CA6, $14E9, $1D2A, $256C, $35D0, $4E95, $1CE7
  .word $1E1A, $1EDA, $7FFF, $29F5, $0007, $10C8, $1E79, $0C63

aClassCardPaletteBowArmor ; 8C/C320
  .word $3800, $00A3, $00E5, $0927, $1149, $25CC, $3E72, $1CE7
  .word $1E1A, $1EDA, $7FFF, $29F5, $0007, $10C8, $1E79, $0C63

aClassCardPaletteSwordArmor ; 8C/C340
  .word $3800, $14C5, $2508, $2D6B, $35AD, $3DEF, $5294, $1CE7
  .word $1E1A, $1EDA, $7FFF, $29F5, $0007, $10C8, $1E79, $0C63

aClassCardPaletteBarbarian ; 8C/C360
  .word $3800, $4F1B, $2A14, $19B2, $010D, $3E53, $218D, $0D0A
  .word $00A7, $5294, $6F7B, $29F5, $00EB, $0465, $1E79, $0863

aClassCardPaletteBrigand ; 8C/C380
  .word $3800, $4F1B, $2A14, $19B2, $010D, $3F13, $2A4D, $0924
  .word $00C1, $5294, $6F7B, $29F5, $1164, $0C86, $1E79, $0C84

aClassCardPalettePirate ; 8C/C3A0
  .word $3800, $4F1B, $2A14, $19B2, $010D, $572E, $3A46, $1540
  .word $0D00, $5294, $6F7B, $29F5, $28C4, $0C86, $1E79, $0C84

aClassCardPaletteWarMage ; 8C/C3C0
  .word $3800, $39D0, $294D, $18CA, $0C67, $0C63, $25CC, $0927
  .word $00E5, $00A2, $6F7B, $29F5, $0106, $10C8, $1E79, $0CA5

aClassCardPaletteWarMageF ; 8C/C3E0
  .word $3800, $42B8, $2A14, $1DD3, $010D, $0C63, $35B3, $1CF0
  .word $084D, $000A, $6F7B, $29F5, $0106, $10C8, $1E79, $0CA5

aClassCardPalettePriest ; 8C/C400
  .word $3800, $0CE6, $0D08, $0D6E, $1273, $0FBC, $2462, $0D08
  .word $084D, $1DD9, $77BD, $29F5, $2462, $10C8, $1E79, $0884

aClassCardPaletteMage ; 8C/C420
  .word $3800, $2107, $294A, $35AD, $4A52, $5AD6, $2462, $294A
  .word $000A, $1DD9, $6F7B, $29F5, $2462, $10C8, $1E79, $14A5

aClassCardPaletteFireMage ; 8C/C440
  .word $3800, $0007, $0429, $048C, $0D0F, $1A16, $2462, $0429
  .word $084D, $1DD9, $6F7B, $29F5, $2462, $10C8, $1E79, $0863

aClassCardPaletteWindMage ; 8C/C460
  .word $3800, $0D00, $1540, $25C3, $3A46, $572E, $2462, $1540
  .word $2462, $1DD9, $6F7B, $29F5, $2462, $10C8, $1E79, $0CA5

aClassCardPaletteHighPriest ; 8C/C480
  .word $3800, $00AA, $010D, $19B2, $2E35, $575D, $4A52, $1E79
  .word $00A2, $35AD, $77BD, $29F5, $0005, $10C8, $1E79, $0CA5

aClassCardPaletteDarkMage ; 8C/C4A0
  .word $3800, $0C63, $0C84, $18C6, $294A, $39EF, $4A52, $1E79
  .word $048C, $1DD9, $77BD, $29F5, $0000, $10C8, $1E79, $0842

aClassCardPaletteThief ; 8C/C4C0
  .word $3800, $00AA, $010D, $19B2, $0066, $2CE6, $084D, $000A
  .word $45AC, $66B4, $6F7B, $3237, $0D08, $10C8, $1E79, $0C63

aClassCardPaletteUnknown8CC4E0 ; 8C/C4E0
  .word $3800, $42B8, $2A14, $19B2, $012E, $35B8, $2134, $108F
  .word $000A, $5294, $6F7B, $29F5, $20E5, $0C86, $1E79, $0C84
