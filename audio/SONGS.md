# Song scripts

Made by `tools/songs.py` on 2026-11-25; do not edit. A song is a script in `aSoundScripts`
(`audio/sound_data.asm`), asked for by its number in `wMusicID`. For each number:
where the game asks for it, its place in the debug sound test, and what the script
does (upload lists with their chunk IDs; `@xxxx` sets the SPC address). Nothing
here names a song; it is the evidence to name them from.

160 script numbers; 132 asked for somewhere in the source; 131 in the sound test.

## $01 (`aSoundScriptF795EA`) `SONG_TITLE_INTRO_1`, sound test 108

- **code** (1): `rlPlayTitleIntroSong` music, engine/title/title_scenes.asm:6728
- **script**: deferred upload FD `aSoundUploadF7ACE6` (cmd B $094 $1AC $1AD @5000 $0DC $12B $108 $11A $103 $12C $337)

## $02 (`aSoundScriptF795F0`) `SONG_TITLE_INTRO_2`, sound test 109

- **code** (1): `rlPlayTitleIntroSong2` music (Song 2, at frame $10F2 of the intro.), engine/title/title_scenes.asm:6759
- **script**: deferred upload FD `aSoundUploadF7AD02` (cmd B $095 $1AE $1AF @5000 $12D $0DC $0E3 $12E $12F $0DA $0DB indirect 3D $33B $33A)

## $03 (`aSoundScriptF795F6`) `SONG_TITLE_SCREEN`, sound test 110

- **code** (1): `rlPlayTitleSong` music (Song 3 (rlTitleScreenShowTitle).), engine/title/title_scenes.asm:6785
- **script**: deferred upload FD `aSoundUploadF7AD24` (cmd B $095 $1AE $1AF @5000 $12D $0DC $0E3 $12E $12F $0DA $0DB indirect 3D $33C $33A)

## $04 (`aSoundScriptF7988A`) `SONG_JUGDRAL_HISTORY`, sound test 56

- **code** (1): `rsJugdralHistorySetup` music, engine/save/jugdral_history.asm:153
- **script**: deferred upload FD `aSoundUploadF7A68C` ($08D $196 $197 @7400 $108 $0DC cmd B); queue command (checked) $00C8

## $05 (`aSoundScriptF79588`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF79C6C` (cmd F $343 $344 $345)

## $06 (`aSoundScriptF795B8`), sound test 89

- **event** (1): EventChapterFinalJuliaVelthomerVisit
- **script**: deferred upload FD `aSoundUploadF79CD8` ($0A6 $064 $228 $229 @7400 $0FE $101 $145 $144 indirect 3C $33F $33A)

## $07 (`aSoundScriptF795BE`)

- **dialogue** (1): ChapterFinal/JuliaVelthomerVisit
- **script**: sound effect 2 $000E

## $08 (`aSoundScriptF795CA`)

- **dialogue** (1): ChapterFinal/JuliaVelthomerVisit
- **script**: queue command $08C8

## $09 (`aSoundScriptF795A4`)

- **dialogue** (2): Chapter02/Opening2, Chapter07/AresRecruitment1
- **script**: deferred upload FD `aSoundUploadF79CBC` ($224 $225 @7400 $143 indirect 3C); sound effect 2 $000C, wait 46

## $0A (`aSoundScriptF795AE`)

- **dialogue** (1): Chapter04/LowerBridge
- **script**: deferred upload FD `aSoundUploadF79CCA` ($226 $227 @7400 $144 indirect 3C); sound effect 2 $000D, wait 44

## $0B (`aSoundScriptF795FC`) `SONG_EPILOGUE_MEMORIAL`, sound test 120

- **dialogue** (1): Epilogue/Memorial88E9E5
- **code** (1): `rlSetupEpilogueRankingsDisplay` music, engine/epilogue/credits.asm:861
- **script**: deferred upload FD `aSoundUploadF7AD74` (cmd B $0D3 $1B6 $1B7 @7400 $102 $136 $116 $33D $33A)

## $0C (`aSoundScriptF79614`), sound test 123

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A7D2` (cmd B $098 $1B4 $1B5 @5000 $135 $0DC $107 $100 $0D9 $0E1 $104 $0E8 $0E4 $0E5 $101 $33E $33A)

## $0D (`aSoundScriptF7961A`) `SONG_EPILOGUE_CREDITS`, sound test 122

- **code** (1): `rlSetupEpilogueCreditsDisplay` music, engine/epilogue/credits.asm:661
- **script**: deferred upload FD `aSoundUploadF7A76A` (cmd B $096 $1B0 $1B1 @4C00 $0DC $0E6 $125 $130 $131 $132 $133 $134 $337)

## $0E (`aSoundScriptF7960E`) `SONG_EPILOGUE_RANKINGS`, sound test 124

- **code** (2): `rlSetupEpilogueRankingsDisplay` music (_F125), engine/epilogue/credits.asm:854 (x2)
- **script**: deferred upload FD `aSoundUploadF7A7AA` (cmd B $098 $1B4 $1B5 @5000 $135 $0DC $107 $100 $0D9 $0E1 $104 $0E8 $0E4 $0E5 $101 $33D $33A)

## $0F (`aSoundScriptF79626`) `SONG_WORLD_MAP_EPILOGUE`, sound test 121

- **event** (1): EventChapterEpilogueWorldMap
- **script**: deferred upload FD `aSoundUploadF7A7FA` (cmd B $097 $1B2 $1B3 @4C00 $106 $0D9 $0EF $0FB $107 $0E6 $0DF $0DA $0DB $33D $33A)

## $10 (`aSoundScriptF7957E`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF79C62` (indirect 3C $334 $335 $336); sound effect 2 $0031

## $11 (`aSoundScriptF7962C`) `SONG_PLAYER_PHASE_PROLOGUE`, sound test 0

- **table** (2): `aPlayerPhaseChapterSongIDs` player phase: Prologue, `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Prologue
- **script**: deferred upload FD `aSoundUploadF7A058` ($065 $146 $147 @7400 $0D7 $0D8 $0D9 $0DA $0DB $340 indirect 3C), wait 4; queue command (checked) $00CB

## $12 (`aSoundScriptF79636`) `SONG_PLAYER_PHASE_CHAPTER6`, sound test 6

- **table** (2): `aPlayerPhaseChapterSongIDs` player phase: Chapter 6, `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Chapter 6
- **script**: deferred upload FD `aSoundUploadF7A072` ($06B $152 $153 @7400 $0DC $0DD $0D8 $0DE $0DF $0E0 $0E1 $0E2 $0E3 $0E4 $0E5 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $13 (`aSoundScriptF79640`) `SONG_PLAYER_PHASE_CHAPTER1`, sound test 1

- **table** (2): `aPlayerPhaseChapterSongIDs` player phase: Chapter 1, `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Chapter 1
- **script**: deferred upload FD `aSoundUploadF7A098` ($066 $148 $149 @7400 $0DC $0E0 $0D8 $0E6 $0E7 $0E2 $0E3 $0E8 $0E4 $0E5 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $14 (`aSoundScriptF7964A`) `SONG_PLAYER_PHASE_CHAPTER4`, sound test 4

- **dialogue** (1): Chapter04/LowerBridge
- **table** (2): `aPlayerPhaseChapterSongIDs` player phase: Chapter 4, `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Chapter 4
- **script**: deferred upload FD `aSoundUploadF7A0BC` ($069 $14E $14F @7400 $0DC $0E9 $0D8 $0EA $0EB $0EC $340 indirect 3C), wait 4; queue command (checked) $00CB

## $15 (`aSoundScriptF795D6`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF79CF4` (cmd B indirect 3D $22A $22B @5000 $355 $356); queue command (checked) $00C4, wait 4; sound effect 2 $0004

## $16 (`aSoundScriptF795E4`)

- Not asked for by number anywhere in the source.
- **script**: sound effect 2 $0012

## $17 (`aSoundScriptF79726`) `SONG_ENEMY_PHASE_DUKES_2`, sound test 24

- **event** (2): EventChapterFinalDozelSpawn, EventChapterFinalFriegeSpawn
- **table** (7): `aNonPlayerFactionPhaseSongIDs` phase of the faction: Velthomer2, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Friege2, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Belhalla2, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Dozel2, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Edda2, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Chalphy2, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Yngvi2
- **script**: deferred upload FD `aSoundUploadF7A0D8` ($07B $172 $173 @7400 $0ED $0EE $0EF $0F0 $0F1 $0F2 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $18 (`aSoundScriptF79654`) `SONG_PLAYER_PHASE_CHAPTER7`, sound test 7

- **table** (2): `aPlayerPhaseChapterSongIDs` player phase: Chapter 7, `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Chapter 7
- **script**: deferred upload FD `aSoundUploadF7A0F4` ($06C $154 $155 @7400 $0F3 $0F4 $0E0 $0F5 $0F6 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $19 (`aSoundScriptF79730`) `SONG_ENEMY_PHASE_DUKES_1`, sound test 23

- **event** (4): EventChapter04AndreyLeave, EventChapter04AndreySpawn, EventChapter04AnnandDeathAndreyResponse, EventChapter09GrutiaSpawn
- **table** (8): `aNonPlayerFactionPhaseSongIDs` phase of the faction: Velthomer1, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Friege1, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Belhalla1, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Dozel1, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Edda1, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Chalphy1, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Yngvi1, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Lubeck
- **script**: deferred upload FD `aSoundUploadF7A0D8` ($07B $172 $173 @7400 $0ED $0EE $0EF $0F0 $0F1 $0F2 $340 indirect 3C), wait 4; queue command (checked) $00CC

## $1A (`aSoundScriptF798F8`), sound test 116

- **event** (11): EventChapter05AyraArdenTalk, EventChapter05AyraChulainnTalk, EventChapter05AyraLexTalk, EventChapter05LachesisBeowulfTalk, EventChapter05LachesisNaoiseTalk, EventChapter05SigurdAyraTalk, EventChapter08CedSeliphTalk, EventChapterFinalJeanneLeifTalk, EventChapterFinalNannaJeanne_SeliphTalk, EventChapterFinalNannaLeifTalk, EventChapterFinalWorldMap
- **script**: deferred upload FD `aSoundUploadF7A836` ($099 $1B8 $1B9 @7400 $0DC $108 $0F4 $0E6 $12E $0DE $0E3 indirect 3C); queue command (checked) $00C8

## $1B (`aSoundScriptF7965E`) `SONG_PLAYER_PHASE_CHAPTER10`, sound test 10

- **table** (2): `aPlayerPhaseChapterSongIDs` player phase: Chapter 10, `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Chapter 10
- **script**: deferred upload FD `aSoundUploadF7A10E` ($06F $15A $15B @7400 $0DC $0F0 $0D8 $0EA $0F7 $0F8 $0E8 $0E4 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $1C (`aSoundScriptF79668`) `SONG_PLAYER_PHASE_CHAPTER3`, sound test 3

- **table** (2): `aPlayerPhaseChapterSongIDs` player phase: Chapter 3, `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Chapter 3
- **script**: deferred upload FD `aSoundUploadF7A12E` ($068 $14C $14D @7400 $0F9 $0FA $0FB $0FC $0E7 $0E2 $0E4 $0FD $340 indirect 3C), wait 4; queue command (checked) $00CB

## $1D (`aSoundScriptF79672`) `SONG_ALLIED_PHASE`, sound test 25

- **event** (1): EventChapter01NordionSpawn
- **code** (1): `rsGetActiveFactionSongID`, engine/sound/music.asm:55
- **script**: deferred upload FD `aSoundUploadF7A14E` ($07C $174 $175 @7400 $0DC $0ED $0E9 $0EA $0F1 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $1E (`aSoundScriptF7967C`) `SONG_PLAYER_PHASE_CHAPTER8`, sound test 8

- **table** (2): `aPlayerPhaseChapterSongIDs` player phase: Chapter 8, `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Chapter 8
- **script**: deferred upload FD `aSoundUploadF7A168` ($06D $156 $157 @7400 $0DC $0EF $0DE $0FE $0EA $0DA $0FF $340 indirect 3C), wait 4; queue command (checked) $00CB

## $1F (`aSoundScriptF79686`) `SONG_ENEMY_PHASE_SILESSE`, sound test 17

- **table** (4): `aNonPlayerFactionPhaseSongIDs` phase of the faction: Tofa, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Sailane, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Zaxon, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Silesse
- **script**: deferred upload FD `aSoundUploadF7A186` ($075 $166 $167 @7400 $0D7 $0F0 $0FB $0E6 $0EF $340 indirect 3C), wait 4; queue command (checked) $00CB

## $20 (`aSoundScriptF79690`), sound test 13

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A1A0` ($071 $15E $15F @7400 $0F9 $0F0 $100 $0DA $0E7 $0E2 $0E4 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $21 (`aSoundScriptF796CC`) `SONG_ENEMY_PHASE_VERDANE`, sound test 14

- **table** (4): `aNonPlayerFactionPhaseSongIDs` phase of the faction: Verdane, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Evans, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Genoa, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Marpha
- **script**: deferred upload FD `aSoundUploadF7A23E` ($072 $160 $161 @7400 $0DC $0F0 $0D8 $117 $118 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $22 (`aSoundScriptF796D6`) `SONG_ENEMY_PHASE_AGUSTRIA`, sound test 15

- **event** (2): EventChapter01HeirheinSpawn, EventChapter03SylvaleSpawn
- **table** (7): `aNonPlayerFactionPhaseSongIDs` phase of the faction: Madino, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Sylvale, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Infini, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Agusti, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Heirhein, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Mackily, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Nordion
- **script**: deferred upload FD `aSoundUploadF7A258` ($073 $162 $163 @7400 $0DC $0F0 $0D8 $0E7 $0F1 $10D $119 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $23 (`aSoundScriptF796E0`) `SONG_ENEMY_PHASE_ORGAHIL`, sound test 16

- **event** (1): EventChapter03Opening
- **table** (1): `aNonPlayerFactionPhaseSongIDs` phase of the faction: Orgahil
- **script**: deferred upload FD `aSoundUploadF7A276` ($074 $164 $165 @7400 $0DC $0EF $0D8 $0F6 $0E4 $0EE $340 indirect 3C), wait 4; queue command (checked) $00CB

## $24 (`aSoundScriptF796EA`) `SONG_PLAYER_PHASE_CHAPTER9`, sound test 9

- **table** (2): `aPlayerPhaseChapterSongIDs` player phase: Chapter 9, `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Chapter 9
- **script**: deferred upload FD `aSoundUploadF7A292` ($06E $158 $159 @7400 $0D7 $0EA $0E4 $0FB $0E0 $0E6 $0F5 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $25 (`aSoundScriptF796F4`) `SONG_ENEMY_PHASE_AED`, sound test 18

- **table** (3): `aNonPlayerFactionPhaseSongIDs` phase of the faction: Phinora, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Aed, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Dahna
- **script**: deferred upload FD `aSoundUploadF7A2B0` ($076 $168 $169 @7400 $0DC $0D8 $11A $117 $11B $11C $340 indirect 3C), wait 4; queue command (checked) $00CB

## $26 (`aSoundScriptF796FE`) `SONG_ENEMY_PHASE_ISAACH`, sound test 19

- **event** (1): EventChapter06BrotherRecruitedDanannResponse
- **table** (6): `aNonPlayerFactionPhaseSongIDs` phase of the faction: Tirnanog, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Ganeishire, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Sofala, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Isaach, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Ribaut, `aChapterIntroSongs` per chapter (rsChapterIntroBegin): Chapter 6
- **script**: deferred upload FD `aSoundUploadF7A2CC` ($077 $16A $16B @7400 $0DC $0EF $11D $0FF $119 $11E $340 indirect 3C), wait 4; queue command (checked) $00CB

## $27 (`aSoundScriptF79708`) `SONG_ENEMY_PHASE_MUNSTER`, sound test 20

- **table** (5): `aNonPlayerFactionPhaseSongIDs` phase of the faction: Leonster, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Connacht, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Munster, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Melgen, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Ulster
- **script**: deferred upload FD `aSoundUploadF7A2E8` ($078 $16C $16D @7400 $0DC $0E9 $0D8 $0EA $0E2 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $28 (`aSoundScriptF79712`) `SONG_ENEMY_PHASE_THRACIA`, sound test 21

- **event** (6): EventChapter03SylvaleSeized, EventChapter03ThraciaSpawn, EventChapter03TravantLeave, EventChapter08MunsterSavedMaykovReaction, EventChapter09ArionCharge, EventChapter09GrutiaSpawn
- **table** (5): `aNonPlayerFactionPhaseSongIDs` phase of the faction: Meath, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Kapathogia, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Luthecia, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Thracia, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Grutia
- **script**: deferred upload FD `aSoundUploadF7A302` ($079 $16E $16F @7400 $0DC $0F0 $11F $110 $0FF $11D $0EE $0EF $340 indirect 3C), wait 4; queue command (checked) $00CB

## $29 (`aSoundScriptF7971C`) `SONG_ENEMY_PHASE_MILETOS`, sound test 22

- **table** (4): `aNonPlayerFactionPhaseSongIDs` phase of the faction: Miletos, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Peruluke, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Chronos, `aNonPlayerFactionPhaseSongIDs` phase of the faction: Rados
- **script**: deferred upload FD `aSoundUploadF7A322` ($07A $170 $171 @7400 $0DC $0E9 $0F0 $0E7 $0E2 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $2A (`aSoundScriptF7969A`) `SONG_NEUTRAL_PHASE`, sound test 26

- **event** (1): EventChapter02InfiniBrigandsSpawn
- **code** (1): `rsGetActiveFactionSongID`, engine/sound/music.asm:59
- **script**: deferred upload FD `aSoundUploadF7A1BE` ($07D $176 $177 @7400 $0ED $0F0 $0EA $0E7 $0E2 $0E4 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $2B (`aSoundScriptF796A4`) `SONG_PLAYER_PHASE_CHAPTER5`, sound test 5

- **table** (2): `aPlayerPhaseChapterSongIDs` player phase: Chapter 5, `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Chapter 5
- **script**: deferred upload FD `aSoundUploadF7A1DA` ($06A $150 $151 @7400 $0D7 $0EE $0E9 $101 $0EA $0F1 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $2C (`aSoundScriptF796AE`) `SONG_PLAYER_PHASE_CHAPTER2`, sound test 2

- **table** (2): `aPlayerPhaseChapterSongIDs` player phase: Chapter 2, `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Chapter 2
- **script**: deferred upload FD `aSoundUploadF7A1F6` ($067 $14A $14B @7400 $0F9 $0FA $0FB $0E0 $102 $103 $0E1 $104 $0E8 $105 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $2D (`aSoundScriptF796B8`) `SONG_PLAYER_PHASE_FINAL`, sound test 11

- **table** (1): `aPlayerPhaseChapterSongIDs` player phase: Final chapter
- **script**: deferred upload FD `aSoundUploadF7A21A` ($070 $15C $15D @7400 $106 $0D9 $0F4 $0DF $107 $103 $0E1 $104 $0E4 $105 $340 indirect 3C), wait 4; queue command (checked) $00CB

## $2E (`aSoundScriptF796C2`) `SONG_FIRST_PHASE_FINAL`, sound test 12

- **table** (1): `aChapterFirstPhaseSongIDs` first phase of the chapter (rsStartChapterFirstPhaseSong): Final chapter
- **script**: deferred upload FD `aSoundUploadF7A21A` ($070 $15C $15D @7400 $106 $0D9 $0F4 $0DF $107 $103 $0E1 $104 $0E4 $105 $340 indirect 3C), wait 4; queue command (checked) $00CC

## $2F (`aSoundScriptF795C4`)

- Not asked for by number anywhere in the source.
- **script**: sound effect 2 $000F

## $30 (`aSoundScriptF795D0`)

- **dialogue** (1): DeathQuote/Gen2EnemyNPC/JuliusChFinalDefault
- **script**: sound effect 2 $000D

## $31 (`aSoundScriptF79764`) `SONG_BATTLE_PLAYER`, sound test 27

- **code** (3): `rlGetBattleSong` battle song (Player attack), engine/battle/battle.asm:410, `rsActionStructCheckForDance`, engine/battle/battle.asm:2342, `rsSetStaffBattleSong`, engine/battle/effects.asm:516
- **script**: deferred upload FD `aSoundUploadF7A3AE` ($081 $17E $17F @7400 $0DC $10E $0F0 $0E1 $0E2 $10F $0E4 indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0000, wait 4; queue command (checked) $00C8

## $32 (`aSoundScriptF79756`) `SONG_BATTLE_ENEMY`, sound test 28

- **code** (2): `rlGetBattleSong` battle song (_EnemyAttack), engine/battle/battle.asm:414, `rsSetStaffBattleSong` battle song, engine/battle/effects.asm:520
- **script**: deferred upload FD `aSoundUploadF7A38E` ($080 $17C $17D @7400 $0DC $0D8 $0F0 $10D indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0000, wait 4; queue command (checked) $00C8

## $33 (`aSoundScriptF797EC`) `SONG_BATTLE_BOSS`, sound test 29

- **code** (2): `rlGetBattleSong` battle song (_Boss), engine/battle/battle.asm:422, `rlActionStructBuildScriptedBattleRounds` battle song, engine/battle/battle.asm:2061
- **script**: deferred upload FD `aSoundUploadF7A4FA` ($0C9 $218 $219 @7400 $0DC $0F9 $12E $0DE $0DA indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0000, wait 4; queue command (checked) $00C8

## $34 (`aSoundScriptF7973A`) `SONG_BATTLE_ARVIS`, sound test 30

- **code** (1): `rlGetBattleSong` battle song (_Arvis), engine/battle/battle.asm:430
- **script**: deferred upload FD `aSoundUploadF7A33C` ($088 $18C $18D @7400 $0DC $0D8 $10A $0D9 $0F5 $117 $104 $0E8 $105 indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0000, wait 4; queue command (checked) $00C8

## $35 (`aSoundScriptF79748`) `SONG_BATTLE_JULIUS`, sound test 31

- **code** (1): `rlGetBattleSong` battle song (_Julius), engine/battle/battle.asm:438
- **script**: deferred upload FD `aSoundUploadF7A366` ($07F $17A $17B @7400 $108 $109 $10A $10B $10C $0E2 $0E8 $0E4 indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0000, wait 4; queue command (checked) $00C8

## $36 (`aSoundScriptF7978E`) `SONG_BATTLE_MAJOR_BOSS`, sound test 32

- **code** (1): `rlGetBattleSong` battle song (_MajorBoss), engine/battle/battle.asm:426
- **script**: deferred upload FD `aSoundUploadF7A414` ($084 $184 $185 @7400 $0DC $109 $10A $10C $0F8 $10F $0E4 indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0000, wait 4; queue command (checked) $00C8

## $37 (`aSoundScriptF79772`), sound test 35

- **code** (1): `rsActionStructDance` battle song, engine/battle/battle.asm:3851
- **script**: deferred upload FD `aSoundUploadF7A3D4` ($082 $180 $181 @7400 $110 $111 indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0001, wait 4; queue command (checked) $00C8

## $38 (`aSoundScriptF79780`) `SONG_BATTLE_DANCE`, sound test 36

- **code** (1): `rsActionStructCheckForDance` battle song, engine/battle/battle.asm:2345
- **script**: deferred upload FD `aSoundUploadF7A3F0` ($083 $182 $183 @7400 $110 $0FC $112 $113 $114 $115 indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0000, wait 4; queue command (checked) $00C8

## $39 (`aSoundScriptF797BE`), sound test 37

- **code** (1): `rlBattleSceneScriptSetVictoryMusic` music, engine/battle_scene/hud.asm:3057
- **script**: deferred upload FD `aSoundUploadF7A49A` ($089 $18E $18F @7400 $108 $0DD $100 $337)

## $3A (`aSoundScriptF797D0`) `SONG_BATTLE_STAFF`, sound test 34

- **code** (4): `rsActionStructStaffEffectHeal` battle song, engine/battle/battle.asm:3669, `rsActionStructStaffEffectFortify` battle song, engine/battle/battle.asm:3707, `rsActionStructStaffEffectReturn` battle song, engine/battle/battle.asm:3756, `rsActionStructStaffEffectRescue` battle song, engine/battle/effects.asm:345
- **script**: deferred upload FD `aSoundUploadF7A4C2` ($08A $190 $191 @7400 $116 indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0000, wait 4; queue command (checked) $00C8

## $3B (`aSoundScriptF797DE`), sound test 40

- **code** (1): `rlStartArenaBattle` battle song, engine/arena/arena.asm:1793
- **script**: deferred upload FB `aSoundUploadF7A4DC` ($08B $192 $193 @7400 $109 $100 $10B indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0000, wait 4; queue command (checked) $00C8

## $3C (`aSoundScriptF7979C`), sound test 41

- **code** (1): `rlStartCastleClassChange` battle song, engine/castle/class_change.asm:60
- **script**: deferred upload FD `aSoundUploadF7A43A` ($085 $34F $350 $351 $186 $187 @7400 $0F9 $0DD indirect 3E); queue command (checked) $00C8

## $3D (`aSoundScriptF797A6`) `SONG_BATTLE_VALKYRIE`, sound test 42

- **code** (1): `rsActionStructStaffEffectValkyrie` battle song, engine/battle/effects.asm:437
- **script**: deferred upload FD `aSoundUploadF7A452` ($086 $188 $189 @7400 $0DF $116 $103 $111 indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); queue command (checked) $00C8

## $3E (`aSoundScriptF797B0`) `SONG_BATTLE_RECRUITABLE`, sound test 33

- **code** (1): `rlGetBattleSong` battle song (_RecruitableEnemy), engine/battle/battle.asm:418
- **script**: deferred upload FD `aSoundUploadF7A472` ($087 $18A $18B @7400 $10A $10E $0F0 $0E1 $0E2 $0E8 $0E4 $0DB indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0000, wait 4; queue command (checked) $00C8

## $3F (`aSoundScriptF797C4`), sound test 38

- **code** (1): `rlBattleSceneScriptSetVictoryMusic` music (_87A7), engine/battle_scene/hud.asm:3062
- **script**: deferred upload FB `aSoundUploadF7A49A` ($089 $18E $18F @7400 $108 $0DD $100 $337)

## $40 (`aSoundScriptF797CA`), sound test 39

- **code** (1): `rlBattleSceneScriptSetVictoryMusic` music (_87AC), engine/battle_scene/hud.asm:3067
- **script**: deferred upload FD `aSoundUploadF7A4AE` ($089 $18E $18F @7400 $108 $0DD $100 $338)

## $41 (`aSoundScriptF79826`), sound test 43

- **event** (1): EventChapter07UlsterSpawn
- **dialogue** (1): Chapter07/AresThreatensBramsel
- **script**: deferred upload FD `aSoundUploadF7A590` ($081 $17E $17F @7400 $0DC $10E $0F0 $0E1 $0E2 $10F $0E4 indirect 3C); queue command (checked) $00C8

## $42 (`aSoundScriptF7981C`), sound test 44

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A57A` ($080 $17C $17D @7400 $0DC $0D8 $0F0 $10D indirect 3C); queue command (checked) $00C8

## $43 (`aSoundScriptF798EE`), sound test 45

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A81E` ($0C9 $218 $219 @7400 $0DC $0F9 $12E $0DE $0DA indirect 3C); queue command (checked) $00C8

## $44 (`aSoundScriptF79808`), sound test 46

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A53C` ($088 $18C $18D @7400 $0DC $0D8 $10A $0D9 $0F5 $117 $104 $0E8 $105 indirect 3C); queue command (checked) $00C8

## $45 (`aSoundScriptF79812`), sound test 47

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A55C` ($07F $17A $17B @7400 $108 $109 $10A $10B $10C $0E2 $0E8 $0E4 indirect 3C); queue command (checked) $00C8

## $46 (`aSoundScriptF79844`), sound test 48

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A5D8` ($084 $184 $185 @7400 $0DC $109 $10A $10C $0F8 $10F $0E4 indirect 3C); queue command (checked) $00C9

## $47 (`aSoundScriptF79830`), sound test 51

- **event** (1): EventChapter04VillageSafeguardSilvia
- **dialogue** (1): Chapter02/LewynSilviaSpawn
- **script**: deferred upload FD `aSoundUploadF7A5AC` ($082 $180 $181 @7400 $110 $111 indirect 3C); queue command (checked) $00C8

## $48 (`aSoundScriptF7983A`), sound test 52

- **event** (5): EventChapter02AlecSilviaTalk, EventChapter02SilviaSigurdTalk, EventChapter07AresThreatensBramsel, EventChapter07LeneLaylea_SeliphTalk, EventChapter09LayleaCharlotTalk
- **script**: deferred upload FD `aSoundUploadF7A5BE` ($083 $182 $183 @7400 $110 $0FC $112 $113 $114 $115 indirect 3C); queue command (checked) $00C8

## $49 (`aSoundScriptF7986C`), sound test 53

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A63A` ($089 $18E $18F @7400 $108 $0DD $100 indirect 3C); queue command (checked) $00C8

## $4A (`aSoundScriptF79876`), sound test 50

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A64E` ($08A $190 $191 @7400 $116 indirect 3C); queue command (checked) $00C8

## $4B (`aSoundScriptF79880`), sound test 57

- **code** (1): `rlArenaScreenSetup` music, engine/arena/arena.asm:1574
- **script**: deferred upload FD `aSoundUploadF7A65E` ($08C $194 $195 @4C00 $100 $0EA $0FC $0F5 $0E0 $120 $121 $122 $0D6 $352 $353 $354 $334 $335 $336 cmd F $337); queue command (checked) $00C9

## $4C (`aSoundScriptF79826`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A590` ($081 $17E $17F @7400 $0DC $10E $0F0 $0E1 $0E2 $10F $0E4 indirect 3C); queue command (checked) $00C8

## $4D (`aSoundScriptF7984E`), sound test 54

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A5F4` ($085 $186 $187 @7400 $0F9 $0DD indirect 3C); queue command (checked) $00C8

## $4E (`aSoundScriptF79858`), sound test 55

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A606` ($086 $188 $189 @7400 $0DF $116 $103 $111 indirect 3C); queue command (checked) $00C8

## $4F (`aSoundScriptF79862`), sound test 49

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A61C` ($087 $18A $18B @7400 $10A $10E $0F0 $0E1 $0E2 $0E8 $0E4 $0DB indirect 3C); queue command (checked) $00C8

## $50 (`aSoundScriptF797FA`) `SONG_BATTLE_JULIA`

- **code** (1): `rlGetBattleSong` battle song (_Julia), engine/battle/battle.asm:434
- **script**: deferred upload FD `aSoundUploadF7A51C` ($0A5 $1CE $1CF @7400 $0D7 $108 $12F $0DC indirect 3E cmd A indirect 03 indirect 04 indirect 01 indirect 02); battle terrain command $0000, wait 4; queue command (checked) $00C9

## $51 (`aSoundScriptF799A2`), sound test 78

- **event** (3): EventChapter01Village3, EventChapter03ClaudTailtiuSpawn, EventChapterFinalVillage1
- **script**: deferred upload FD `aSoundUploadF7A9D0` ($0AA $1DC $1DD @7400 $0FC $138 $12F $110 indirect 3C); queue command (checked) $00C8

## $52 (`aSoundScriptF79608`), sound test 118

- **event** (1): EventChapter05Ending
- **script**: deferred upload FD `aSoundUploadF7AD60` ($0D2 $1DA $1DB @7400 $103 $135 indirect 3C $337)

## $53 (`aSoundScriptF799D4`), sound test 90

- **dialogue** (1): Chapter10/SeliphAtSea
- **script**: deferred upload FD `aSoundUploadF7AA24` ($0AE $1E4 $1E5 @7400 $0DE $0D9 $136 indirect 3C); queue command (checked) $00C8

## $54 (`aSoundScriptF7990C`), sound test 85

- **event** (5): EventChapter01DeirdreSpawn, EventChapter01MarphaSeized, EventChapter02DeirdreEthlynTalk, EventChapter03MadinoSeized, EventChapter08JuliaSeliphTalk
- **dialogue** (1): Chapter10/SeliphAtSea
- **script**: deferred upload FD `aSoundUploadF7A888` ($09B $1BC $1BD @7400 $0DC $138 $0E6 $103 $0DE indirect 3C); queue command (checked) $00C8

## $55 (`aSoundScriptF79916`), sound test 67

- **event** (2): EventChapter01NordionSpawn, EventChapterFinalEnding
- **table** (2): `aChapterIntroSongs` per chapter (rsChapterIntroBegin): Chapter 1, `aChapterIntroSongs` per chapter (rsChapterIntroBegin): Chapter 2
- **script**: deferred upload FD `aSoundUploadF7A8A0` ($09C $1BE $1BF @7400 $0DC $0E0 $12E $139 $0E3 $0DB indirect 3C); queue command (checked) $00C8

## $56 (`aSoundScriptF79920`), sound test 68

- **event** (5): EventChapter02ErinysGroupArrive, EventChapter02LewynErinysTalk, EventChapter06FeeArthurSpawn, EventChapter08FeeCedTalk, EventChapterFinalEnding
- **table** (1): `aChapterIntroSongs` per chapter (rsChapterIntroBegin): Chapter 4
- **script**: deferred upload FD `aSoundUploadF7A8BA` ($09D $1C0 $1C1 @7400 $0E0 $13A $0EA $0E6 $106 indirect 3C); queue command (checked) $00C8

## $57 (`aSoundScriptF798C6`), sound test 106

- **table** (5): `aCastleSongs` castle (rlPlayCastleSong): Meath, `aCastleSongs` castle (rlPlayCastleSong): Kapathogia, `aCastleSongs` castle (rlPlayCastleSong): Luthecia, `aCastleSongs` castle (rlPlayCastleSong): Thracia, `aCastleSongs` castle (rlPlayCastleSong): Grutia
- **script**: deferred upload FD `aSoundUploadF7A742` ($09E $1AA $1AB @7400 $126 $12A indirect 3C); queue command (checked) $00CB

## $58 (`aSoundScriptF7992A`), sound test 81

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A8D2` ($09F $1C2 $1C3 @7400 $13A $0E0 $139 $13B indirect 3C); queue command (checked) $00C8

## $59 (`aSoundScriptF79A24`), sound test 115

- **event** (1): EventChapter05LubeckSeized
- **script**: deferred upload FD `aSoundUploadF7AAC4` ($0B5 $1F2 $1F3 @7400 $0DC $0DA $0DB $100 indirect 3C); queue command (checked) $00C8

## $5A (`aSoundScriptF79620`)

- **code** (1): `rlSetupEpilogueCreditsDisplay` music, engine/epilogue/credits.asm:535
- **script**: deferred upload FD `aSoundUploadF7A78A` (cmd B $096 $1B0 $1B1 @4C00 $0DC $0E6 $125 $130 $131 $132 $133 $134 $338)

## $5B (`aSoundScriptF79A10`), sound test 74

- **event** (6): EventChapter04ErinysSilviaAdjacent, EventChapter06DeimneIsaachVisit, EventChapter07BramselWaiting, EventChapter07VillageBarrierBladeLaylea, EventChapter08ArthurAmid_FeeHerminaTalk, EventChapter10FebailAsaello_LanaMuirneTalk
- **dialogue** (2): Chapter04/SilviaClaudTalk, Chapter09/FebailPattyTalk
- **script**: deferred upload FD `aSoundUploadF7AA98` ($0B3 $1EE $1EF @7400 $12F $0EA $13D indirect 3C); queue command (checked) $00C8

## $5C (`aSoundScriptF79A42`) `SONG_WORLD_MAP_GENERATION2`, sound test 114

- **event** (5): EventChapter06WorldMap, EventChapter07WorldMap, EventChapter08WorldMap, EventChapter09WorldMap, EventChapter10WorldMap
- **script**: deferred upload FD `aSoundUploadF7AB02` ($0B8 $1F8 $1F9 @7400 $0DC $108 $0E2 $100 indirect 3C); queue command (checked) $00C8

## $5D (`aSoundScriptF799B6`), sound test 87

- **event** (2): EventChapter03EldiganDeathSigurdResponse, EventChapter04AnnandDeathPlayerResponses
- **dialogue** (1): Chapter05/PhinoraSeized1
- **script**: deferred upload FD `aSoundUploadF7A9FE` ($0AC $1E0 $1E1 @7400 $106 $0F9 $101 indirect 3C); queue command (checked) $00C8

## $5E (`aSoundScriptF79A1A`) `SONG_WORLD_MAP_GENERATION1`, sound test 112

- **event** (5): EventChapter01WorldMap, EventChapter02WorldMap, EventChapter03WorldMap, EventChapter04WorldMap, EventPrologueWorldMap
- **script**: deferred upload FD `aSoundUploadF7AAAC` ($0B4 $1F0 $1F1 @7400 $0DC $12E $0DE $13C $13E indirect 3C); queue command (checked) $00C8

## $5F (`aSoundScriptF799DE`), sound test 91

- **event** (1): EventChapter08MuirneSeliphAdjacent
- **script**: deferred upload FD `aSoundUploadF7AA24` ($0AE $1E4 $1E5 @7400 $0DE $0D9 $136 indirect 3C); queue command (checked) $00C9

## $60 (`aSoundScriptF799CA`), sound test 88

- **event** (15): EventChapter01AzelleEdainTalk, EventChapter01EdainEthlynTalk, EventChapter02BeowulfLachesisTalk, EventChapter03MidirBrigidTalk, EventChapter04EdainAzelleTalk, EventChapter04EdainJamkeTalk, EventChapter04EdainMidirTalk, EventChapter06DeimneMuirneTalk, EventChapter06Seliph_LanaMuirneTalk, EventChapter07FinnLanaTalk, EventChapter07FinnLarceiTalk, EventChapter07FinnNannaTalk, EventChapterFinalLanaFebailTalk, EventChapterFinalLanaMuirne_ScathachDalvinTalk, EventChapterFinalLanaMuirne_SeliphTalk
- **script**: deferred upload FD `aSoundUploadF7AA12` ($0AD $1E2 $1E3 @7400 $103 $106 indirect 3C); queue command (checked) $00C8

## $61 (`aSoundScriptF79A2E`) `SONG_WORLD_MAP_CHAPTER5`, sound test 113

- **event** (1): EventChapter05WorldMap
- **script**: deferred upload FD `aSoundUploadF7AADA` ($0B6 $1F4 $1F5 @7400 $0DC $0F9 $108 indirect 3C); queue command (checked) $00C8

## $62 (`aSoundScriptF79A38`), sound test 65

- **event** (31): EventChapter01MidirEdainTalk, EventChapter03EdainBrigidTalk, EventChapter03LachesisEldiganTalk, EventChapter04LewynSigurdTalk, EventChapter04LewynSilesseVisit, EventChapter04SilviaClaudTalk, EventChapter05AlecNaoiseTalk, EventChapter05BrigidAlecTalk, EventChapter05BrigidJamkeTalk, EventChapter05BrigidMidirTalk, EventChapter05DewJamkeTalk, EventChapter05EdainBrigidTalk, EventChapter05ErinysArdenTalk, EventChapter05ErinysLewynTalk, EventChapter05ErinysNaoiseTalk, EventChapter05LachesisDewTalk, EventChapter05SigurdByronTalk, EventChapter05SilviaAlecTalk, EventChapter05SilviaLewynTalk, EventChapter07ArthurAmid_TineLindaTalk, EventChapter07DiarmuidNannaTalk, EventChapter07TristanJeanneTalk, EventChapter08NannaAresTalk, EventChapter09FebailPattyTalk, EventChapter09FinnAltenaTalk, EventChapter09HannibalAltenaTalk, EventChapter09LeifAltenaTalk, EventChapter09LeneCoirpreTalk, EventChapter09Opening, EventChapter09SeliphAltenaTalk, EventChapter10SeliphPalmarchTalk
- **dialogue** (1): Chapter02/InfiniSeized
- **script**: deferred upload FD `aSoundUploadF7AAEE` ($0B7 $1F6 $1F7 @7400 $0DC $0F9 $108 indirect 3C); queue command (checked) $00C8

## $63 (`aSoundScriptF79934`), sound test 71

- **event** (21): EventChapter01Opening, EventChapter01VerdaneSpawn, EventChapter02AgustiSpawn, EventChapter02InfiniSpawn, EventChapter02MackilySpawn, EventChapter03Ending, EventChapter04DaccarAndreyPreparing, EventChapter04PamelaSpawn, EventChapter04ZaxonSpawn (x2), EventChapter05AidaBetrayal, EventChapter05Opening, EventChapter05PhinoraSeized, EventChapter07BramselWaiting, EventChapter07MelgenSpawn, EventChapter07Opening, EventChapter07UlsterSpawn (x2), EventChapter08FebailAsaello_Spawn, EventChapter08IshtarSpawn, EventChapterFinalYngviSpawn
- **dialogue** (1): Chapter02/Opening2
- **table** (2): `aChapterIntroSongs` per chapter (rsChapterIntroBegin): Chapter 3, `aChapterIntroSongs` per chapter (rsChapterIntroBegin): Chapter 8
- **script**: deferred upload FD `aSoundUploadF7A8E8` ($0A0 $1C4 $1C5 @7400 $12E $13C $0DA $0E2 $0DB indirect 3C); queue command (checked) $00C8

## $64 (`aSoundScriptF79A9C`), sound test 80

- **event** (4): EventChapter02ArdenPursuitRing, EventChapter05ArdenOnCliff, EventChapter06LarceiCreidne_IucharTalk, EventChapter06LarceiCreidne_IucharbaTalk
- **script**: deferred upload FD `aSoundUploadF7ABD2` ($0C2 $20A $20B @7400 $141 $12E $139 $0DC indirect 3C); queue command (checked) $00C8

## $65 (`aSoundScriptF79A92`)

- **event** (11): EventChapter04ErinysLewynTalk, EventChapterFinalDaisyDeimneTalk, EventChapterFinalFeeHermina_ArthurAmidTalk, EventChapterFinalFeeHermina_SeliphTalk, EventChapterFinalFeeOifeyTalk, EventChapterFinalLarceiCreidne_IucharTalk, EventChapterFinalLarceiCreidne_IucharbaTalk, EventChapterFinalLarceiCreidne_SeliphTalk, EventChapterFinalLarceiCreidne_ShannanTalk, EventChapterFinalMuirneAsaelloTalk, EventChapterFinalNannaAresTalk
- **script**: deferred upload FD `aSoundUploadF7ABB6` ($0C0 $208 $209 @7400 $106 $103 $0D9 $138 $0E4 $0E5 $0E6 indirect 3C); queue command (checked) $00C8

## $66 (`aSoundScriptF79AA6`), sound test 59

- **event** (8): EventChapter02Opening, EventChapter03EldiganApproachesSigurd, EventChapter03LachesisEldiganTalk, EventChapter03SigurdApproachesEldigan, EventChapter03SylvaleSpawn, EventChapter05Opening, EventChapter08Opening, EventChapter10ChalphySpawn
- **table** (1): `aChapterIntroSongs` per chapter (rsChapterIntroBegin): Chapter 5
- **script**: deferred upload FD `aSoundUploadF7ABE8` ($0C3 $20C $20D @7400 $138 $0DC $0F9 $12E $0E8 indirect 3C); queue command (checked) $00C8

## $67 (`aSoundScriptF79AB0`)

- **event** (4): EventChapter10LeifAltenaTalk, EventChapter10NannaJeanne_LeifTalk, EventChapter10SeliphFeeTalk, EventChapter10SeliphLeneTalk
- **script**: deferred upload FD `aSoundUploadF7AC00` ($0C4 $20E $20F @7400 $138 $0DE $0F4 $142 indirect 3C); queue command (checked) $00C8

## $68 (`aSoundScriptF79ABA`), sound test 60

- **event** (12): EventChapter03ClaudSigurdTalk, EventChapter07AresSeliphTalk, EventChapter07LeifSeliphTalk, EventChapter07Opening, EventChapter07SeliphShannanTalk, EventChapter09Opening, EventChapter10OifeySeliphTalk, EventChapter10ShannanSeliphTalk, EventPrologueAzelleSigurdTalk, EventPrologueEthlynSigurdTalk, EventPrologueLexSigurdTalk, EventPrologueQuanSigurdTalk
- **script**: deferred upload FD `aSoundUploadF7AC16` ($0C5 $210 $211 @7400 $0F9 $0DD $100 $0DA $142 indirect 3C); queue command (checked) $00C8

## $69 (`aSoundScriptF79AC4`), sound test 82

- **event** (8): EventChapter04SigurdClaudTalk, EventChapter05ClaudEdainTalk, EventChapter05LexAzelleTalk, EventChapter05SilviaClaudTalk, EventChapter05TailtiuAzelleTalk, EventChapter05TailtiuClaudTalk, EventChapter05TailtiuLexTalk, EventChapterFinalDozelSeized
- **dialogue** (2): Chapter03/ClaudSigurdTalk, Chapter03/MadinoSeized2
- **script**: deferred upload FD `aSoundUploadF7AC2E` ($0C6 $212 $213 @7400 $0DC $0F9 $142 indirect 3C); queue command (checked) $00C8

## $6A (`aSoundScriptF79ACE`), sound test 84

- **event** (16): EventChapter01EthlynDied, EventChapter01FinnDied, EventChapter01QuanDied, EventChapter02EthlynDied, EventChapter02FinnDied, EventChapter02QuanDied, EventChapter03EthlynDied, EventChapter03FinnDied, EventChapter03QuanDied, EventPrologueEthlynDied, EventPrologueFinnDied, EventPrologueQuanDied, EventGen1HomeCastleSeized, EventGen2HomeCastleSeized, EventSeliphDeathReaction, EventSigurdDeathReaction
- **script**: deferred upload FD `aSoundUploadF7AC42` ($0C7 $214 $215 @7400 $13F $103 indirect 3C); queue command (checked) $00C8

## $6B (`aSoundScriptF79AD8`), sound test 58

- **event** (12): EventChapter02LewynSilviaSpawn, EventChapter02Opening, EventChapter03Ending, EventChapter03Opening (x2), EventChapter04AnnandPamelaCloseByTalk, EventChapter04AnnandSpawn, EventChapter04ZaxonSpawn, EventChapter05ThraciaSpawn, EventChapter06Opening, EventChapter08MeathSpawn, EventChapter10Opening
- **table** (2): `aChapterIntroSongs` per chapter (rsChapterIntroBegin): Prologue, `aChapterIntroSongs` per chapter (rsChapterIntroBegin): Chapter 7
- **script**: deferred upload FD `aSoundUploadF7AC54` ($0C8 $216 $217 @7400 $0F9 $0DC $12E $100 $0E7 $104 indirect 3C); queue command (checked) $00C8

## $6C (`aSoundScriptF79B28`), sound test 70

- **event** (10): EventChapter01EdainGroupSpawn, EventChapter03OrgahilSpawn, EventChapter04DonovanSpawn, EventChapter04Opening, EventChapter04RaiseBridge, EventChapter04SilesseSeizedDaccarResponse, EventChapter07AresRecruitment, EventChapter09CoirpreHostage, EventPrologueEdainAbduction (x2)
- **script**: deferred upload FD `aSoundUploadF7A86E` ($07E $178 $179 @7400 $0DC $0DD $0D8 $0DA $0E4 $0E5 indirect 3C); queue command (checked) $00C8

## $6D (`aSoundScriptF798DA`), sound test 100

- **table** (7): `aCastleSongs` castle (rlPlayCastleSong): Velthomer, `aCastleSongs` castle (rlPlayCastleSong): Friege, `aCastleSongs` castle (rlPlayCastleSong): Belhalla, `aCastleSongs` castle (rlPlayCastleSong): Dozel, `aCastleSongs` castle (rlPlayCastleSong): Edda, `aCastleSongs` castle (rlPlayCastleSong): Chalphy, `aCastleSongs` castle (rlPlayCastleSong): Yngvi
- **script**: deferred upload FD `aSoundUploadF7A6B6` ($0CA $19C $19D @7400 $126 $0EF $127 indirect 3C); queue command (checked) $00CB

## $6E (`aSoundScriptF798E4`), sound test 101

- **table** (7): `aCastleSongs` castle (rlPlayCastleSong): Madino, `aCastleSongs` castle (rlPlayCastleSong): Sylvale, `aCastleSongs` castle (rlPlayCastleSong): Infini, `aCastleSongs` castle (rlPlayCastleSong): Agusti, `aCastleSongs` castle (rlPlayCastleSong): Heirhein, `aCastleSongs` castle (rlPlayCastleSong): Mackily, `aCastleSongs` castle (rlPlayCastleSong): Nordion
- **script**: deferred upload FD `aSoundUploadF7A6CA` ($0CB $19E $19F @7400 $126 $0E0 $128 $0FC $0E4 $0FD indirect 3C); queue command (checked) $00CB

## $6F (`aSoundScriptF799AC`), sound test 79

- **event** (11): EventChapter01DewEdainTalk, EventChapter02DewLachesisTalk, EventChapter06Village2Seliph, EventChapter07DaisyShannanAdjacent, EventChapter07PattyDaisy_SeliphTalk, EventChapter09HawkLutheciaVisit, EventChapter09PattyDaisy_CoirpreCharlotTalk, EventChapter10LesterDeimne_PattyDaisyTalk, EventChapterFinalPattyDaisy_SeliphTalk, EventChapterFinalPattyDaisy_ShannanTalk, EventChapterFinalPattyLesterTalk
- **script**: deferred upload FD `aSoundUploadF7A9E6` ($0AB $1DE $1DF @7400 $135 $12F $138 $0EE $110 indirect 3C); queue command (checked) $00C8

## $70 (`aSoundScriptF799E8`), sound test 69

- **event** (8): EventChapter01QuanFinnTalk, EventChapter02QuanFinnTalk, EventChapter03EthlynQuanTalk, EventChapter04Opening (x3), EventChapter05LeonsterSpawn, EventChapter08FinnLeifTalk
- **script**: deferred upload FD `aSoundUploadF7AA38` ($0AF $1E6 $1E7 @7400 $138 $0F9 $0DC $0EA $0E3 indirect 3C); queue command (checked) $00C8

## $71 (`aSoundScriptF798D0`), sound test 107

- **table** (4): `aCastleSongs` castle (rlPlayCastleSong): Miletos, `aCastleSongs` castle (rlPlayCastleSong): Perlucos, `aCastleSongs` castle (rlPlayCastleSong): Chronos, `aCastleSongs` castle (rlPlayCastleSong): Rados
- **script**: deferred upload FD `aSoundUploadF7A754` ($0C1 $1A8 $1A9 @7400 $126 $0FC $128 $0E0 indirect 3C); queue command (checked) $00CB

## $72 (`aSoundScriptF799C0`) `SONG_GAME_OVER`

- **code** (1): `rlProcGameOverInit` music, engine/menus/game_over.asm:174
- **script**: deferred upload FD `aSoundUploadF7A9FE` ($0AC $1E0 $1E1 @7400 $106 $0F9 $101 indirect 3C); queue command (checked) $00C9

## $73 (`aSoundScriptF79902`), sound test 66

- **event** (29): EventChapter01EdainJamkeTalk, EventChapter01SigurdAyraTalk, EventChapter01SigurdEdainTalk, EventChapter02BeowulfTalkSuccess, EventChapter02ChulainnRecruitmentEvans, EventChapter02ChulainnRecruitmentHeirhein, EventChapter02ChulainnRecruitmentInfini, EventChapter02ChulainnRecruitmentMackily, EventChapter02ChulainnRecruitmentNordion, EventChapter02ErinysSigurdTalk, EventChapter02SigurdLewynTalk, EventChapter03SigurdBrigidTalk, EventChapter06ArthurAmid_SeliphTalk, EventChapter06FeeSeliphTalk, EventChapter06HerminaSeliphTalk, EventChapter06LesterLanaTalk, EventChapter06OifeyGroupSpawn, EventChapter07AresDahnaVisit, EventChapter07AresRecruitment, EventChapter07LarceiCreidne_ShannanTalk, EventChapter08FebailAsaello_SeliphTalk, EventChapter08HerminaHawkTalk, EventChapter08PattyDaisy_FebailAsaelloTalk, EventChapter08Seliph_CedHawkTalk, EventChapter09CoirpreCharlot_HannibalTalk, EventPrologueLexAzelleSpawn, EventPrologueQuanGroupSpawn, EventPrologueUnusedMidirAzelleTalk, EventPrologueYngviSeized
- **dialogue** (2): Chapter02/LewynErinysTalk, Chapter02/LewynSilviaSpawn
- **script**: deferred upload FD `aSoundUploadF7A852` ($09A $1BA $1BB @7400 $0F9 $0EF $100 $137 $117 $104 $0E4 indirect 3C); queue command (checked) $00C8

## $74 (`aSoundScriptF79AE2`), sound test 86

- **event** (6): EventChapter05BelhallaConversation, EventChapter05Ending, EventChapter05PhinoraSpawn, EventChapter10MiletosSpawn, EventPrologueArvisSpawn, EventPrologueSigurdArvisTalk
- **script**: deferred upload FD `aSoundUploadF7AC6E` ($0CC $21A $21B @7400 $103 $108 $0DC $0DA indirect 3C); queue command (checked) $00C8

## $75 (`aSoundScriptF79AEC`), sound test 77

- **event** (8): EventChapter03ChulainnAyraTalk, EventChapter03LexAyraTalk, EventChapter06DalvinCreidneTalk, EventChapter06ScathachLarceiTalk, EventChapter07Oifey_DiarmuidTristanTalk, EventChapter09AsaelloDaisyTalk, EventPrologueUnusedAlecEthlynTalk, EventPrologueUnusedNaoiseAlecTalk
- **script**: deferred upload FD `aSoundUploadF7AC84` ($0CD $21C $21D @7400 $135 $13A $0D9 $142 $0E3 indirect 3C); queue command (checked) $00C8

## $76 (`aSoundScriptF79AF6`), sound test 61

- **event** (7): EventChapter02InfiniSeized, EventChapter03Ending, EventChapter04Ending, EventChapter05Ending, EventChapter07Ending, EventChapter10Ending, EventPrologueEnding
- **script**: deferred upload FD `aSoundUploadF7AC9C` ($0CE $21E $21F @7400 $0F9 $0DC $12E $0E0 $0DE $0EA $0E3 indirect 3C); queue command (checked) $00C8

## $77 (`aSoundScriptF79B14`), sound test 64

- **event** (15): EventChapter01Ending, EventChapter01GenoaSeized, EventChapter02Ending, EventChapter02SigurdLachesisTalk, EventChapter03SylvaleSeized, EventChapter04SilesseSeized, EventChapter07MelgenSeized, EventChapter08Ending, EventChapter09GrutiaSeized, EventChapter09HannibalNotRecruited, EventChapter09LutheciaSeized, EventChapter10ChronosSeized, EventChapter10MiletosSeized, EventChapter10RadosSeized, EventChapterFinalEddaSeized
- **script**: deferred upload FD `aSoundUploadF7ACB8` ($0CF $220 $221 @7400 $0F9 $0DC $108 $100 indirect 3C); queue command (checked) $00C8

## $78 (`aSoundScriptF79B1E`), sound test 119

- **event** (1): EventChapter05Ending
- **script**: deferred upload FD `aSoundUploadF7ACCE` ($0D0 $222 $223 @7400 $0DC $108 $12E $100 $0E4 indirect 3C); queue command (checked) $00C8

## $79 (`aSoundScriptF7962C`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A058` ($065 $146 $147 @7400 $0D7 $0D8 $0D9 $0DA $0DB $340 indirect 3C), wait 4; queue command (checked) $00CB

## $7A (`aSoundScriptF7993E`), sound test 93

- **event** (4): EventChapter03MadinoSeized, EventChapter07KutuzovFenrirFound, EventChapter07Opening, EventChapterFinalSeliphJuliaTalkManfroyAlive
- **dialogue** (5): Chapter01/VerdaneSpawn2, Chapter02/AgustiSpawn1, Chapter05/PhinoraSpawn1, Chapter10/ChalphySpawn1, Chapter10/MiletosSpawn
- **table** (1): `aChapterIntroSongs` per chapter (rsChapterIntroBegin): Chapter 10
- **script**: deferred upload FD `aSoundUploadF7A900` ($0A1 $1C6 $1C7 @7400 $0DC $108 $12E indirect 3C); queue command (checked) $00C8

## $7B (`aSoundScriptF79948`), sound test 76

- **event** (9): EventChapter04TailtiuAzelleTalk, EventChapter07TineLinda_SeliphTalk, EventChapter08Seliph_TineLindaTalk, EventChapter10SeliphTineTalk, EventChapterFinalAmidLindaTalk, EventChapterFinalArthurTineTalk, EventChapterFinalTineLinda_CedHawkTalk, EventChapterFinalTineLinda_LeifTalk, EventChapterFinalTineLinda_SeliphTalk
- **script**: deferred upload FD `aSoundUploadF7A914` ($0A2 $1C8 $1C9 @7400 $102 $116 $13D indirect 3C); queue command (checked) $00C8

## $7C (`aSoundScriptF79B00`) `SONG_CASTLE_SEIZED`, sound test 62

- **event** (11): EventChapter01GenoaSeized, EventChapter02HeirheinSeized, EventChapter02MackilySeized, EventChapter03MadinoSeized, EventChapter04TofaSeized, EventChapter05PhinoraSeized, EventChapter06GaneishireSeized, EventChapter06IsaachSeized, EventChapter06SofalaSeized, EventChapter07LeonsterSeized, EventChapter08ConnachtSeized
- **script**: deferred upload FD `aSoundUploadF7AC9C` ($0CE $21E $21F @7400 $0F9 $0DC $12E $0E0 $0DE $0EA $0E3 indirect 3C); queue command (checked) $00C9

## $7D (`aSoundScriptF79B0A`), sound test 63

- **event** (1): EventChapter06Ending
- **script**: deferred upload FD `aSoundUploadF7AC9C` ($0CE $21E $21F @7400 $0F9 $0DC $12E $0E0 $0DE $0EA $0E3 indirect 3C); queue command (checked) $00CA

## $7E (`aSoundScriptF79984`)

- **event** (1): EventChapterFinalEnding
- **script**: deferred upload FD `aSoundUploadF7A988` ($0A7 $1D2 $1D3 @7400 $108 $139 $0D9 $0D8 $117 $0E8 $116 $13E $0DA indirect 3C); queue command (checked) $00C9

## $7F (`aSoundScriptF7962C`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A058` ($065 $146 $147 @7400 $0D7 $0D8 $0D9 $0DA $0DB $340 indirect 3C), wait 4; queue command (checked) $00CB

## $80 (`aSoundScriptF7962C`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A058` ($065 $146 $147 @7400 $0D7 $0D8 $0D9 $0DA $0DB $340 indirect 3C), wait 4; queue command (checked) $00CB

## $81 (`aSoundScriptF79952`), sound test 83

- **event** (6): EventChapter09AltenaRespawn, EventChapter09HannibalCharge, EventChapter09LeifAltenaTalk, EventChapter09TravantSpawnAltenaDead, EventChapter10CoirpreCharlot_AltenaTalk, EventChapterFinalAltenaArionTalk
- **table** (1): `aChapterIntroSongs` per chapter (rsChapterIntroBegin): Chapter 9
- **script**: deferred upload FD `aSoundUploadF7A928` ($0A3 $1CA $1CB @7400 $0F9 $0D7 $108 $138 $0DF indirect 3C); queue command (checked) $00C8

## $82 (`aSoundScriptF7995C`), sound test 94

- **event** (4): EventChapter07Shannan_PattyDaisyTalk, EventChapter09SeliphHannibalTalk, EventChapterFinalFriegeSeized, EventChapterFinalOpening
- **script**: deferred upload FD `aSoundUploadF7A940` ($0A4 $1CC $1CD @7400 $106 $12E $0E0 $0D8 $0DA $0DB $0D9 indirect 3C); queue command (checked) $00C8

## $83 (`aSoundScriptF79966`), sound test 95

- **event** (10): EventChapter08IshtarDied, EventChapter08IshtarLeave, EventChapter09ArionDied, EventChapter10IshtarDied, EventChapter10IshtarKilledUnit, EventChapter10JuliusDied, EventChapter10JuliusKilledUnit, EventChapterFinalBelhallaSpawn, EventChapterFinalOpening, EventChapterFinalVelthomerSeized
- **dialogue** (1): Chapter08/Seliph_TineLindaTalk
- **script**: deferred upload FD `aSoundUploadF7A95C` ($0A5 $1CE $1CF @7400 $0D7 $108 $12F $0DC indirect 3C); queue command (checked) $00C8

## $84 (`aSoundScriptF79970`), sound test 96

- **event** (5): EventChapter06JuliaSeliphTalk, EventChapter06LanaMuirne_JuliaTalk, EventChapter09JuliaSeliphTalk, EventChapterFinalJuliusDied, EventChapterFinalSeliphJuliaTalkManfroyDead
- **dialogue** (1): Chapter06/GaneishireSeized1
- **script**: deferred upload FD `aSoundUploadF7A972` ($0A6 $1D0 $1D1 @7400 $0FE $118 $101 $0DF indirect 3C); queue command (checked) $00C8

## $85 (`aSoundScriptF7998E`), sound test 72

- **event** (10): EventChapter05EthlynDied, EventChapter05QuanAndEthlynDead, EventChapter05ThraciaSpawn, EventChapter08CoulterCharge, EventChapter08MeathSpawn, EventChapter08Opening, EventChapter09HannibalDefend, EventChapter09Opening, EventChapter09ThraciaSpawn, EventChapterFinalThraciaSpawn
- **script**: deferred upload FD `aSoundUploadF7A9A8` ($0A8 $1D4 $1D5 @7400 $0DC $108 $11F $0DA indirect 3C); queue command (checked) $00C8

## $86 (`aSoundScriptF79998`), sound test 97

- **event** (3): EventChapter07AedSeized, EventChapter07DahnaSeized, EventChapter09ThraciaSeized
- **dialogue** (1): Chapter06/Ending
- **script**: deferred upload FD `aSoundUploadF7A9BE` ($0A9 $1D6 $1D7 @7400 $0DC $0F9 indirect 3C); queue command (checked) $00C8

## $87 (`aSoundScriptF7997A`), sound test 98

- **event** (2): EventChapter06OifeySeliphTalk, EventChapterFinalVillage2
- **dialogue** (2): Chapter06/Ending, Chapter10/OifeySeliphTalk
- **script**: deferred upload FD `aSoundUploadF7A988` ($0A7 $1D2 $1D3 @7400 $108 $139 $0D9 $0D8 $117 $0E8 $116 $13E $0DA indirect 3C); queue command (checked) $00C8

## $88 (`aSoundScriptF79894`), sound test 99

- **event** (1): EventChapter02ChulainnRecruitmentEvans
- **table** (4): `aCastleSongs` castle (rlPlayCastleSong): Verdane, `aCastleSongs` castle (rlPlayCastleSong): Evans, `aCastleSongs` castle (rlPlayCastleSong): Genoa, `aCastleSongs` castle (rlPlayCastleSong): Marpha
- **script**: deferred upload FD `aSoundUploadF7A69E` ($08F $19A $19B @7400 $126 $10E $0F0 $0F6 $0E1 indirect 3C); queue command (checked) $00CB

## $89 (`aSoundScriptF7989E`), sound test 102

- **table** (5): `aCastleSongs` castle (rlPlayCastleSong): Tofa, `aCastleSongs` castle (rlPlayCastleSong): Sailane, `aCastleSongs` castle (rlPlayCastleSong): Zaxon, `aCastleSongs` castle (rlPlayCastleSong): Silesse, `aCastleSongs` castle (rlPlayCastleSong): Lubeck
- **script**: deferred upload FD `aSoundUploadF7A6E4` ($090 $1A0 $1A1 @7400 $126 $0E0 $0EA $0EC $128 indirect 3C); queue command (checked) $00CB

## $8A (`aSoundScriptF798A8`), sound test 103

- **table** (5): `aCastleSongs` castle (rlPlayCastleSong): Tirnanog, `aCastleSongs` castle (rlPlayCastleSong): Ganeishire, `aCastleSongs` castle (rlPlayCastleSong): Sofala, `aCastleSongs` castle (rlPlayCastleSong): Isaach, `aCastleSongs` castle (rlPlayCastleSong): Ribaut
- **script**: deferred upload FD `aSoundUploadF7A6FC` ($091 $1A2 $1A3 @7400 $126 $110 $119 $11C $0FF indirect 3C); queue command (checked) $00CB

## $8B (`aSoundScriptF798B2`), sound test 104

- **table** (3): `aCastleSongs` castle (rlPlayCastleSong): Phinora, `aCastleSongs` castle (rlPlayCastleSong): Aed, `aCastleSongs` castle (rlPlayCastleSong): Dahna
- **script**: deferred upload FD `aSoundUploadF7A714` ($092 $1A4 $1A5 @7400 $126 $129 $10D $119 indirect 3C); queue command (checked) $00CB

## $8C (`aSoundScriptF798BC`), sound test 105

- **table** (6): `aCastleSongs` castle (rlPlayCastleSong): Leonster, `aCastleSongs` castle (rlPlayCastleSong): Connacht, `aCastleSongs` castle (rlPlayCastleSong): Munster, `aCastleSongs` castle (rlPlayCastleSong): Melgen, `aCastleSongs` castle (rlPlayCastleSong): Ulster, `aCastleSongs` castle (rlPlayCastleSong): Orgahil
- **script**: deferred upload FD `aSoundUploadF7A72A` ($093 $1A6 $1A7 @7400 $126 $0DD $127 $113 $0E2 indirect 3C); queue command (checked) $00CB

## $8D (`aSoundScriptF79602`), sound test 117

- **dialogue** (1): Chapter05/Ending2
- **script**: deferred upload FD `aSoundUploadF7AD46` ($0D1 $1D8 $1D9 @7400 $0DC $0F9 $0E6 $0DA $0D9 indirect 3C $337)

## $8E (`aSoundScriptF7958E`)

- **event** (1): EventChapter01LexBraveAxe
- **script**: deferred upload FD `aSoundUploadF79C9E` ($08E $198 $199 @5000 $123 $124 $125 $0EC $103 $0F5 $0D6 $337 cmd F); queue command (checked) $00C9

## $8F (`aSoundScriptF79598`)

- **dialogue** (1): Chapter01/LexBraveAxe
- **script**: sound effect 2 $0003

## $90 (`aSoundScriptF7959E`)

- **dialogue** (1): Chapter01/LexBraveAxe
- **script**: send command $00D0

## $91 (`aSoundScriptF799F2`), sound test 125

- **event** (2): EventChapter01AyraQuanTalk, EventChapterFinalEnding
- **script**: deferred upload FD `aSoundUploadF7AA50` ($0B0 $1E8 $1E9 @7400 $0DC $0EF $12E $11D $0FF $11E indirect 3C); queue command (checked) $00C8

## $92 (`aSoundScriptF799FC`), sound test 126

- **event** (1): EventChapterFinalEnding
- **script**: deferred upload FD `aSoundUploadF7AA6A` ($0B1 $1EA $1EB @7400 $138 $0DC $11F $0D8 $0EA indirect 3C); queue command (checked) $00C8

## $93 (`aSoundScriptF79A06`), sound test 127

- **event** (1): EventChapterFinalEnding
- **script**: deferred upload FD `aSoundUploadF7AA82` ($0B2 $1EC $1ED @7400 $138 $13A $0E6 $0DC indirect 3C); queue command (checked) $00C8

## $94 (`aSoundScriptF79A4C`), sound test 128

- **event** (1): EventChapterFinalEnding
- **script**: deferred upload FD `aSoundUploadF7AB18` ($0B9 $1FA $1FB @7400 $0F9 $0DC $0E0 $12E indirect 3C); queue command (checked) $00C8

## $95 (`aSoundScriptF79A56`), sound test 129

- **event** (1): EventChapterFinalEnding
- **script**: deferred upload FD `aSoundUploadF7AB2E` ($0BA $1FC $1FD @7400 $13A $0DC $12E $0DA indirect 3C); queue command (checked) $00C8

## $96 (`aSoundScriptF79A60`), sound test 130

- **event** (1): EventChapterFinalEnding
- **script**: deferred upload FD `aSoundUploadF7AB44` ($0BB $1FE $1FF @7400 $138 $12E $0D9 $106 $0E6 indirect 3C); queue command (checked) $00C8

## $97 (`aSoundScriptF79A6A`), sound test 131

- **event** (1): EventChapterFinalEnding
- **script**: deferred upload FD `aSoundUploadF7AB5C` ($0BC $200 $201 @7400 $0E6 $0E0 $106 indirect 3C); queue command (checked) $00C8

## $98 (`aSoundScriptF79A74`), sound test 132

- **event** (1): EventChapterFinalEnding
- **script**: deferred upload FD `aSoundUploadF7AB70` ($0BD $202 $203 @7400 $12E $103 $108 $0DC $0E4 indirect 3C); queue command (checked) $00C8

## $99 (`aSoundScriptF79A7E`), sound test 133

- **event** (1): EventChapterFinalEnding
- **script**: deferred upload FD `aSoundUploadF7AB88` ($0BE $204 $205 @7400 $106 $0F9 $0D9 $13F $0E3 indirect 3C); queue command (checked) $00C8

## $9A (`aSoundScriptF79A88`), sound test 134

- **event** (1): EventChapterFinalEnding
- **script**: deferred upload FD `aSoundUploadF7ABA0` ($0BF $206 $207 @7400 $0E6 $140 $103 $101 indirect 3C); queue command (checked) $00C8

## $9B (`aSoundScriptF7962C`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A058` ($065 $146 $147 @7400 $0D7 $0D8 $0D9 $0DA $0DB $340 indirect 3C), wait 4; queue command (checked) $00CB

## $9C (`aSoundScriptF7962C`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A058` ($065 $146 $147 @7400 $0D7 $0D8 $0D9 $0DA $0DB $340 indirect 3C), wait 4; queue command (checked) $00CB

## $9D (`aSoundScriptF7962C`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A058` ($065 $146 $147 @7400 $0D7 $0D8 $0D9 $0DA $0DB $340 indirect 3C), wait 4; queue command (checked) $00CB

## $9E (`aSoundScriptF7962C`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A058` ($065 $146 $147 @7400 $0D7 $0D8 $0D9 $0DA $0DB $340 indirect 3C), wait 4; queue command (checked) $00CB

## $9F (`aSoundScriptF7962C`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A058` ($065 $146 $147 @7400 $0D7 $0D8 $0D9 $0DA $0DB $340 indirect 3C), wait 4; queue command (checked) $00CB

## $A0 (`aSoundScriptF7962C`)

- Not asked for by number anywhere in the source.
- **script**: deferred upload FD `aSoundUploadF7A058` ($065 $146 $147 @7400 $0D7 $0D8 $0D9 $0DA $0DB $340 indirect 3C), wait 4; queue command (checked) $00CB
