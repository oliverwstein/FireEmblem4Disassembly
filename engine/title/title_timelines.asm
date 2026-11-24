; The title screen's timelines (include/TitleScreen.h): the intro (phase 0,
; about two minutes, ending in the title with its logo), the title (phase 1,
; after skipping the intro) and the fade out (phase 2).

    .section TitleTimelinesSection

      .al
      .xl

      aTitleIntroTimeline ; 97/EC63

        TITLE_TIMELINE_AT $0000
          TITLE_TIMELINE_CALL 0, rlStartTitleEdgeFade
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0001
          TITLE_TIMELINE_SLOT 0, rlStartTitleSceneFadeIn
          TITLE_TIMELINE_SLOT 1, rlStartTitleIntroScene1Scroll
          TITLE_TIMELINE_SLOT 4, rlUnknown9BE5B2
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $00DC
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $01EA
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0217
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0280
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $038E
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $03BB
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0424
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0528
          TITLE_TIMELINE_CALL 0, rlUnknown95EAA8
          TITLE_TIMELINE_SLOT 0, rlStartTitleSceneFadeOut
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0532
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $059D
          TITLE_TIMELINE_CALL 0, rlUnknown95EAA9
          TITLE_TIMELINE_CALL 0, rlUnknown9BE697
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $05FA
          TITLE_TIMELINE_SLOT 0, rlStartTitleSceneFadeIn
          TITLE_TIMELINE_SLOT 1, rlStartTitleIntroScene2Scroll
          TITLE_TIMELINE_CALL 0, rlSetUpTitleIntroScene2
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0604
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $06D6
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0703
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0780
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $082A
          TITLE_TIMELINE_SLOT 2, rlUnknown95FABC
          TITLE_TIMELINE_SLOT 3, rlUnknown95F48E
          TITLE_TIMELINE_CALL 0, rlUnknown95F9CE
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0848
          TITLE_TIMELINE_SLOT 3, rlUnknown95F48E
          TITLE_TIMELINE_CALL 0, rlUnknown95F9FB
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0852
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0866
          TITLE_TIMELINE_SLOT 3, rlUnknown95F48E
          TITLE_TIMELINE_CALL 0, rlUnknown95FA1E
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $087F
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0884
          TITLE_TIMELINE_SLOT 3, rlUnknown95F4F0
          TITLE_TIMELINE_CALL 0, rlUnknown95FA41
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $08A2
          TITLE_TIMELINE_SLOT 3, rlUnknown95F4F0
          TITLE_TIMELINE_CALL 0, rlUnknown95FA64
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $08C0
          TITLE_TIMELINE_SLOT 3, rlUnknown95F4F0
          TITLE_TIMELINE_CALL 0, rlUnknown95FA87
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $08F2
          TITLE_TIMELINE_SLOT 3, rlUnknown95F552
          TITLE_TIMELINE_CALL 0, rlUnknown95FAAA
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $08FC
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0A0A
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0B2A
          TITLE_TIMELINE_CALL 0, rlUnknown95EB3B
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0B3A
          TITLE_TIMELINE_CALL 0, rlTitleIntroScene2FadePalette
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0BEE
          TITLE_TIMELINE_CALL 0, rlUnknown95EB4C
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0C26
          TITLE_TIMELINE_SLOT 1, rlStartTitleIntroScene3Scroll
          TITLE_TIMELINE_SLOT 4, rlUnknown95F630
          TITLE_TIMELINE_CALL 0, rlSetUpTitleIntroScene3
          TITLE_TIMELINE_CALL 0, rlUnknown95F2E5
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0C46
          TITLE_TIMELINE_CALL 0, rlSetUpTitleIntroScene3b
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0C62
          TITLE_TIMELINE_CALL 0, rlSetUpTitleIntroScene4
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0C71
          TITLE_TIMELINE_CALL 0, rlUnknown95F2F9
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0CA6
          TITLE_TIMELINE_CALL 0, rlUnknown95EC4D
          TITLE_TIMELINE_CALL 0, rlUnknown95F30D
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0CD6
          TITLE_TIMELINE_CALL 0, rlUnknown95F321
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0CD9
          TITLE_TIMELINE_CALL 0, rlUnknown95F831
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0CDA
          TITLE_TIMELINE_CALL 0, rlUnknown95EC58
          TITLE_TIMELINE_CALL 0, rlUnknown95F85B
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0D34
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0D4E
          TITLE_TIMELINE_CALL 0, rlUnknown95F86D
          TITLE_TIMELINE_SLOT 5, rlStartTitleQuickFadeOut
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0D5E
          TITLE_TIMELINE_CALL 0, rlUnknown95EC63
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0D6E
          TITLE_TIMELINE_SLOT 0, rlStartTitleSceneFadeIn
          TITLE_TIMELINE_SLOT 1, rlStartTitleIntroScene5Scroll
          TITLE_TIMELINE_CALL 0, rlSetUpTitleIntroScene5
          TITLE_TIMELINE_CALL 0, rlFreeBattleScenePaletteSlots
          TITLE_TIMELINE_CALL 0, rlUnknown95F335
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0D8C
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0E67
          TITLE_TIMELINE_CALL 0, rlUnknown95F777
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0E68
          TITLE_TIMELINE_CALL 0, rlUnknown95ECD6
          TITLE_TIMELINE_CALL 0, rlUnknown95F7A5
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0E9A
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0EDE
          TITLE_TIMELINE_SLOT 5, rlStartTitleQuickFadeOut
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0EEE
          TITLE_TIMELINE_CALL 0, rlUnknown95ECE1
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0EFE
          TITLE_TIMELINE_SLOT 0, rlStartTitleSceneFadeIn
          TITLE_TIMELINE_SLOT 1, rlStartTitleIntroScene6Scroll
          TITLE_TIMELINE_CALL 0, rlSetUpTitleIntroScene6
          TITLE_TIMELINE_CALL 0, rlFreeBattleScenePaletteSlots
          TITLE_TIMELINE_CALL 0, rlUnknown95F349
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0F1C
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0FF7
          TITLE_TIMELINE_CALL 0, rlUnknown95F7B7
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0FF8
          TITLE_TIMELINE_CALL 0, rlUnknown95ED4E
          TITLE_TIMELINE_CALL 0, rlUnknown95F7E5
          TITLE_TIMELINE_CALL 0, rlUnknown95F47A
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $102A
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1039
          TITLE_TIMELINE_SLOT 6, rlUnknown9BF23C
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1057
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1084
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1098
          TITLE_TIMELINE_CALL 0, rlUnknown95ED59
          TITLE_TIMELINE_SLOT 0, rlStartTitleSceneFadeOut
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $110D
          TITLE_TIMELINE_CALL 0, rlUnknown95ED6A
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $10F2
          TITLE_TIMELINE_CALL 0, rlPlayTitleIntroSong2
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1192
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $11FB
          TITLE_TIMELINE_SLOT 0, rlStartTitleSceneFadeIn
          TITLE_TIMELINE_SLOT 1, rlStartTitleIntroScene7Scroll
          TITLE_TIMELINE_SLOT 4, rlUnknown9BE6AD
          TITLE_TIMELINE_CALL 0, rlSetUpTitleIntroScene7
          TITLE_TIMELINE_CALL 0, rlFreeBattleScenePaletteSlots
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1205
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1236
          TITLE_TIMELINE_CALL 0, rlTitleIntroScene7StartSpritePalettes
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1237
          TITLE_TIMELINE_CALL 0, rlUnknown9BE2A4
          TITLE_TIMELINE_SLOT 2, rlUnknown9BE435
          TITLE_TIMELINE_SLOT 3, rlUnknown9BE372
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $12D7
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1304
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1301
          TITLE_TIMELINE_CALL 0, rlUnknown95EDEA
          TITLE_TIMELINE_SLOT 5, rlUnknown9BE7A7
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1302
          TITLE_TIMELINE_SLOT 6, rlUnknown9BF49E
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $136D
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1383
          TITLE_TIMELINE_SLOT 3, rlUnknown9BE396
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $143F
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $146C
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $14B4
          TITLE_TIMELINE_CALL 0, rlFreeBattleScenePaletteSlots
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $14B5
          TITLE_TIMELINE_CALL 0, rlUnknown9BE317
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $14B6
          TITLE_TIMELINE_CALL 0, rlUnknown9BE2FD
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $14B7
          TITLE_TIMELINE_CALL 0, rlUnknown9BF548
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $14B9
          TITLE_TIMELINE_SLOT 6, rlUnknown9BF57A
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $14BA
          TITLE_TIMELINE_CALL 0, rlUnknown9BFBB0
          TITLE_TIMELINE_SLOT 3, rlUnknown9BE40B
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $14CD
          TITLE_TIMELINE_SLOT 7, rlStartFadingInTitleCaption
          TITLE_TIMELINE_CALL 0, rlShowNextTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $15DB
          TITLE_TIMELINE_SLOT 7, rlStartFadingOutTitleCaption
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1637
          TITLE_TIMELINE_CALL 0, rlUnknown95EDF5
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1638
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $166F
          TITLE_TIMELINE_SLOT 8, rlUnknown9BE9AE
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1671
          TITLE_TIMELINE_CALL 0, rlEndTitleEdgeFade
          TITLE_TIMELINE_CALL 0, rlTitleIntroScene7DimPalette
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1719
          TITLE_TIMELINE_CALL 0, rlSetUpTitleIntroScene8
          TITLE_TIMELINE_CALL 0, rlFreeBattleScenePaletteSlots
          TITLE_TIMELINE_CALL 0, rlUnknown95F3D3
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1745
          TITLE_TIMELINE_CALL 0, rlUnknown9BFBB8
          TITLE_TIMELINE_CALL 0, rlUnknown95F3E7
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1791
          TITLE_TIMELINE_SLOT 7, rlUnknown9BFA11
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1809
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 0, rlUnknown9BF218
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1859
          TITLE_TIMELINE_SLOT 6, rlStartTitleIntroScene8Sprite
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1860
          TITLE_TIMELINE_CALL 0, rlUnknown9BE791
          TITLE_TIMELINE_SLOT 1, rlUnknown9BF77A
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $186D
          TITLE_TIMELINE_CALL 0, rlEnterTitlePhase
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1873
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_SLOT 7, rlUnknown9BF65C
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1874
          TITLE_TIMELINE_CALL 0, rlStartTitleLogoSprite1
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1876
          TITLE_TIMELINE_CALL 0, rlStartTitleLogoSprite2
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1878
          TITLE_TIMELINE_CALL 0, rlStartTitleLogoSprite3
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $187A
          TITLE_TIMELINE_CALL 0, rlStartTitleLogoSprite4
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $187C
          TITLE_TIMELINE_CALL 0, rlStartTitleLogoSprite5
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $187D
          TITLE_TIMELINE_CALL 0, rlStartTitleLogoSprite6
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1880
          TITLE_TIMELINE_CALL 0, rlStartTitleLogoSprite7
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1883
          TITLE_TIMELINE_CALL 0, rlStartTitleLogoSprite8
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1884
          TITLE_TIMELINE_CALL 0, rlAllowStartOnTitle
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1885
          TITLE_TIMELINE_CALL 0, rlStartTitleLogoSprite9
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1887
          TITLE_TIMELINE_CALL 0, rlStartTitleLogoSprite10
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1889
          TITLE_TIMELINE_CALL 0, rlStartTitleLogoSprite11
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1893
          TITLE_TIMELINE_SLOT 7, rlUnknown9BF6D6
          TITLE_TIMELINE_CALL 0, rlUnknown95F426
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1BF9
          TITLE_TIMELINE_SLOT 0, rlStartTitleSceneFadeOut
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $1C9F
          TITLE_TIMELINE_CALL 0, rlEndTitleScreen
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_END

      aTitleTimeline ; 97/F12D

        TITLE_TIMELINE_AT $0000
          TITLE_TIMELINE_SLOT 0, rlStartTitleFadeIn
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0001
          TITLE_TIMELINE_CALL 0, rlAllowStartOnTitle
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $003A
          TITLE_TIMELINE_SLOT 7, rlUnknown9BF65C
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $005A
          TITLE_TIMELINE_SLOT 7, rlUnknown9BF6D6
          TITLE_TIMELINE_CALL 0, rlUnknown95F426
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $038C
          TITLE_TIMELINE_SLOT 0, rlStartTitleSceneFadeOut
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $041E
          TITLE_TIMELINE_CALL 0, rlEndTitleScreen
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_END

      aTitleFadeOutTimeline ; 97/F15D

        TITLE_TIMELINE_AT $0000
          TITLE_TIMELINE_SLOT 4, rlStartDimmingTitle
          TITLE_TIMELINE_CALL 0, rlUnknown95F440
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0004
          TITLE_TIMELINE_CALL 0, rlUnknown9BFA58
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0028
          TITLE_TIMELINE_CALL 0, rlUnknown9BFA6E
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 2, rlAllowTitleLoad
          TITLE_TIMELINE_CALL 0, rlUnknown9BFA85
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_AT $0031
          TITLE_TIMELINE_CALL 0, rlUnknown9BFAA1
          TITLE_TIMELINE_CALL 0, rlEndTitleScreenFadeOut
        TITLE_TIMELINE_NEXT
        TITLE_TIMELINE_END

        ; 97/F19B

    .endsection TitleTimelinesSection
