; Battle banners: the faction banner shown for each side of a battle.
; rlGetFactionBattleBannerID (units/factions.asm) picks the BattleBanner* index,
; and the battle scene code in bank $95 uses this table to load the banner.
; The banner graphics themselves are placed in build.asm.

    .section BattleBannerTableSection

      aBattleBannerTable ; 99/8D84

        ; One entry per BattleBanner* index (include/Battle.h):
        ; - a long pointer to the compressed banner graphics;
        ; - a long pointer to 7 colors in WRAM, which are copied into the
        ;   palette buffers when the banner is loaded.

        .long g4bppcBattleBannerLeonster,  $7E8B9A
        .long g4bppcBattleBannerDozel,     $7E8BBA
        .long g4bppcBattleBannerYngvi,     $7E8BDA
        .long g4bppcBattleBannerChalphy,   $7E8BFA
        .long g4bppcBattleBannerNordion,   $7E8C1A
        .long g4bppcBattleBannerIsaach,    $7E8C3A
        .long g4bppcBattleBannerThracia,   $7E8C5A
        .long g4bppcBattleBannerVelthomer, $7E8C7A
        .long g4bppcBattleBannerFreege,    $7E8C9A
        .long g4bppcBattleBannerSilesse,   $7E8CBA
        .long g4bppcBattleBannerEdda,      $7E8CDA
        .long g4bppcBattleBannerBelhalla,  $7E8CFA
        .long g4bppcBattleBannerLoptr,     $7E8D1A
        .long g4bppcBattleBannerDefault,   $7E8D3A

    .endsection BattleBannerTableSection
