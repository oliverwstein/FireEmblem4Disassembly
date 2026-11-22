; Shared UI, unit-relation, castle/shop, map-sprite, and chapter-intro palettes.


    .section Data8C9400Section

      .al
      .xl

      aUnitRelationOAMPalettes ; 8C/9400

        ; Read by rlLoadStatusScreenDisplay, rsDataWindowGetArmies.

        .word $5DF2, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF
        .word $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF
        .word $3000, $0C43, $1063, $120D, $0D24, $0CE1, $2125, $0880
        .word $0040, $0B5A, $0B41, $6D61, $6B5A, $083A, $0821, $6F1A
        .word $3000, $0C43, $1064, $36B8, $2F52, $25A7, $2125, $18E4
        .word $18A4, $4211, $2DCE, $216A, $18E6, $0CA4, $0862, $0842
        .word $3000, $1565, $21AA, $5A21, $4DC0, $3D40, $3500, $30E1
        .word $28A2, $4274, $4232, $39F2, $29D0, $1D29, $18C6, $1064
        .word $3000, $1064, $1965, $1D24, $579C, $3235, $10ED, $1086
        .word $77F6, $66A9, $3523, $1CA4, $77BD, $4B36, $258C, $14C4
        .word $4001, $1565, $31EA, $360B, $31C9, $2DA8, $2987, $1D65
        .word $1D26, $2188, $1D27, $1945, $1503, $10C3, $1083, $0C42
        .word $0001, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF
        .word $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF
        .word $4001, $7FFF, $7FFF, $0E8C, $0566, $20C5, $2185, $14C3
        .word $0861, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF

        ; 8C/9500

      aCastleScreenOAMPalettes ; 8C/9500

        ; Read by rlSetupCastleCourtyardDisplay, rsCastleLoadCourtyardScreen.

        .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; 8C/951E

      aPortraitAndMapUIOAMPalettes ; 8C/951E

        ; Read by rlUnknown888082, rlUnknown88821A, rlUnknown9EF76F, rsUnitWindowCopyGraphics, rsReviveScreenLoadGraphics.

        .word $0000, $3800, $7FFF, $0000, $0000, $4EB5, $2129, $7F56
        .word $7D28, $2862, $19DA, $0CCF, $1484, $4AFB, $2590, $1041
        .word $0021, $3800, $7FFF, $0000, $0000, $3253, $1929, $5AFD
        .word $0CF5, $0C49, $6DD0, $4C8A, $1085, $4AFB, $29B1, $0002
        .word $0400, $3800, $7FFF, $0000, $0000, $1DD1, $08EA, $5F95
        .word $2667, $08C1, $18FA, $004B, $10A4, $4AFB, $29B1, $0881
        .word $0401, $3800, $7FFF, $0000, $0000, $3A49, $1904, $375F
        .word $01EF, $0087, $7D8C, $34C4, $08A5, $4AFB, $29B1, $0063
        .word $0400, $3800, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $3800, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; 8C/95DE

      aMenuSpritePalette7Slice ; 8C/95DE

        ; Read by rsUnitWindowCopyGraphics, rsReviveScreenLoadGraphics.

        .word $0000, $3800, $6F7B, $4A52, $2108, $4210, $1CE7, $5EF7
        .word $318C, $1CE7, $4A52, $1CE7, $0C62, $4A52, $2D6B, $0821
        .word $0000

        ; 8C/9600

      aCastleShopBGPalettes ; 8C/9600

        ; Read by rsLoadShopBackground.

        .word $420F, $318B, $7FFF, $0C42, $7F7F, $49E3, $7FFA, $5400
        .word $7F7F, $00A9, $03FC, $0441, $7F7F, $2949, $564F, $0400
        .word $3000, $2D8C, $7FFF, $0C41, $7F7F, $420F, $420F, $420F
        .word $4E69, $28C4, $1042, $10E4, $14E6, $2504, $1CE4, $14C4
        .word $0843, $1D07, $20E8, $2613, $21D2, $1D8F, $218F, $19F8
        .word $1970, $110D, $10EC, $150B, $08F0, $0CCA, $0C87, $0444
        .word $5B39, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $3000, $5F9E, $3A7B, $2A19, $1551, $471F, $08C7, $4904
        .word $0879, $1D6B, $00EC, $0F1F, $3CC2, $0658, $3DCD, $0045
        .word $4001, $1D07, $20E8, $2613, $21D2, $1D8F, $10EC, $0C87
        .word $0000, $4629, $39E8, $31A6, $1D45, $1924, $10E2, $08A0
        .word $0001, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $4001, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F

        ; 8C/9700

      aCastleVendorOAMPalettes ; 8C/9700

        ; Read by rlConversationSceneSetup.

        .word $3800, $0C21, $23DF, $22BF, $0152, $7FFF, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $3800, $0467, $77DF, $3DEF, $294A, $03FF, $6AB4, $110E
        .word $3460, $00D3, $1ACC, $5FBF, $02BB, $1944, $4E51, $20C0
        .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; 8C/9800

    .endsection Data8C9400Section


    .section Data8C9D00Section

      .al
      .xl

      aMapAndCastleSpriteOAMPalettes ; 8C/9D00

        ; Read by rlSetupCastleCourtyardDisplay, rlSetupCastleTownDisplay, rlUnknown888082, rlUnknown8881A7, rlUnknown88821A, rsCastleLoadCourtyardScreen.

        .word $0842, $1463, $239D, $22BC, $0931, $7FFF, $634D, $0599
        .word $3546, $4A2C, $6312, $7398, $7C1F, $53BE, $023F, $7F7F
        .word $3800, $0842, $0888, $0CCE, $05B7, $271F, $6FFF, $18A3
        .word $3546, $4A2C, $6312, $7398, $7F7F, $7F7F, $7F7F, $7F7F
        .word $3800, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $0000, $0467, $77DF, $3DEF, $294A, $03FF, $6AB4, $154F
        .word $3460, $0135, $1ACC, $5FBF, $02BB, $1944, $4E2D, $20C0
        .word $3800, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $2D29, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $0442, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $0000, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F
        .word $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F, $7F7F

        ; 8C/9E00

    .endsection Data8C9D00Section


    .section TableDD7EB0Section

      .al
      .xl

      aChapterIntroAndUIBGPalettes ; DD/7EB0

        ; Eight palettes. rsLoadChapterIntroGraphics and rsReviveScreenLoadGraphics copy all of them
        ; into the BG palette buffer, and rsLoadChapterIntroGraphics then palette 6 over
        ; palette 7; both loops count an index from the size down to 2, so
        ; they read from the label minus 2.

        .word $0001, $318B, $7FFF, $1484, $420F, $296E, $56D6, $0C84
        .word $0000, $02FC, $5AF1, $528F, $524E, $4E2D, $4A0C, $04A7
        .word $3000, $41EE, $04A2, $7314, $7EF8, $3DAC, $1CA2, $7314
        .word $7FFF, $2E29, $77FC, $0441, $7FFF, $35CF, $0086, $4252
        .word $3000, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $62B1, $5A8F
        .word $0000, $02FC, $4EAE, $52CF, $528E, $4E6D, $4A4C, $04A7
        .word $7FFF, $420F, $7FFF, $7FFA, $7FFF, $7FFF, $7FFF, $7FFF
        .word $0000, $02FC, $0D4C, $092A, $0509, $04E8, $04C8, $10A6
        .word $3000, $0000, $1084, $1CE7, $35AD, $3DEF, $4210, $4A52
        .word $5294, $5EF7, $6318, $7FFF, $5000, $5000, $5000, $5000
        .word $4001, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF
        .word $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF
        .word $0001, $00AF, $00AE, $008D, $008C, $008B, $006A, $0069
        .word $0068, $0047, $0045, $0044, $0023, $0022, $0001, $0000
        .word $4001, $4C00, $5400, $5C00, $6400, $6C00, $7400, $7C00
        .word $0800, $1000, $1800, $2000, $2800, $3000, $3800, $4000

        ; DD/7FB0

    .endsection TableDD7EB0Section


