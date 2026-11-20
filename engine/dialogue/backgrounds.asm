; Dialogue backgrounds: the pictures behind DIALOGUE_WITH_BG scenes
; (DIALOGUE_BG_* in include/events/Helpers.h). rlUnknown8ABB3E loads the one
; numbered $08B6.

    .section DialogueBackgroundsSection

      .al
      .xl

      aDialogueBackgroundPointers ; 8A/BACF

        ; Indexed by DIALOGUE_BG_*. Each entry points to five long pointers:
        ; - foreground tiles (compressed 4bpp, to VRAM $2000: tiles 512-767);
        ; - picture tiles (compressed 4bpp, to VRAM $0000);
        ; - 256 colours (uncompressed), copied into aBGPaletteBuffer;
        ; - foreground tilemap (compressed, 32x32, to VRAM $7000);
        ; - picture tilemap (compressed, 32x11, to VRAM $7520).
        ; The foreground is the frame drawn over the picture (leaves, pillars).
        ; The last entry repeats the cloister.

        .long aDialogueBackgroundFountain
        .long aDialogueBackgroundGate
        .long aDialogueBackgroundAlley
        .long aDialogueBackgroundThrone
        .long aDialogueBackgroundHallway
        .long aDialogueBackgroundCloister
        .long aDialogueBackgroundCloister

      aDialogueBackgroundFountain ; 8A/BAE4

        .long g4bppcDialogueBackgroundFountainForeground, g4bppcDialogueBackgroundFountain, aDialogueBackgroundFountainPalette, acDialogueBackgroundFountainForegroundTilemap, acDialogueBackgroundFountainTilemap

      aDialogueBackgroundGate ; 8A/BAF3

        .long g4bppcDialogueBackgroundFountainForeground, g4bppcDialogueBackgroundGate, aDialogueBackgroundGatePalette, acDialogueBackgroundGateForegroundTilemap, acDialogueBackgroundGateTilemap

      aDialogueBackgroundAlley ; 8A/BB02

        .long g4bppcDialogueBackgroundFountainForeground, g4bppcDialogueBackgroundAlley, aDialogueBackgroundAlleyPalette, acDialogueBackgroundGateForegroundTilemap, acDialogueBackgroundAlleyTilemap

      aDialogueBackgroundHallway ; 8A/BB11

        .long g4bppcDialogueBackgroundHallwayForeground, g4bppcDialogueBackgroundHallway, aDialogueBackgroundHallwayPalette, acDialogueBackgroundHallwayForegroundTilemap, acDialogueBackgroundHallwayTilemap

      aDialogueBackgroundThrone ; 8A/BB20

        .long g4bppcDialogueBackgroundThroneForeground, g4bppcDialogueBackgroundThrone, aDialogueBackgroundThronePalette, acDialogueBackgroundThroneForegroundTilemap, acDialogueBackgroundThroneTilemap

      aDialogueBackgroundCloister ; 8A/BB2F

        .long g4bppcDialogueBackgroundCloisterForeground, g4bppcDialogueBackgroundCloister, aDialogueBackgroundCloisterPalette, acDialogueBackgroundCloisterForegroundTilemap, acDialogueBackgroundCloisterTilemap

    .endsection DialogueBackgroundsSection
