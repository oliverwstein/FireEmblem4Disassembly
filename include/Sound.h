  ; The sound data (audio/sound_data.asm; formats in tools/sound.py).

  ; Chunk table flags.
  SOUND_CHUNK_COMPRESSED = $01 ; decompressed into a WRAM buffer before the upload
  SOUND_CHUNK_BUFFER2    = $02 ; that buffer is $7E6358 (last chunk in $0504), not $7E5358 ($0502)

  ; Song script numbers (wMusicID, wBattleSong) where the code or every use
  ; says what they are for; audio/SONGS.md lists the uses of all 160.
  SONG_PLAYER_PHASE_PROLOGUE  = $11 ; aPlayerPhaseChapterSongIDs
  SONG_PLAYER_PHASE_CHAPTER1  = $13
  SONG_PLAYER_PHASE_CHAPTER2  = $2C
  SONG_PLAYER_PHASE_CHAPTER3  = $1C
  SONG_PLAYER_PHASE_CHAPTER4  = $14
  SONG_PLAYER_PHASE_CHAPTER5  = $2B
  SONG_PLAYER_PHASE_CHAPTER6  = $12
  SONG_PLAYER_PHASE_CHAPTER7  = $18
  SONG_PLAYER_PHASE_CHAPTER8  = $1E
  SONG_PLAYER_PHASE_CHAPTER9  = $24
  SONG_PLAYER_PHASE_CHAPTER10 = $1B
  SONG_PLAYER_PHASE_FINAL     = $2D
  SONG_ALLIED_PHASE           = $1D ; rsGetActiveFactionSongID
  SONG_NEUTRAL_PHASE          = $2A

  SONG_BATTLE_PLAYER          = $31 ; rlGetBattleSong, rsSetStaffBattleSong
  SONG_BATTLE_ENEMY           = $32
  SONG_BATTLE_BOSS            = $33
  SONG_BATTLE_ARVIS           = $34
  SONG_BATTLE_JULIUS          = $35
  SONG_BATTLE_MAJOR_BOSS      = $36
  SONG_BATTLE_DANCE           = $38 ; rsActionStructCheckForDance
  SONG_BATTLE_STAFF           = $3A ; heal, fortify, return and rescue staves
  SONG_BATTLE_VALKYRIE        = $3D
  SONG_BATTLE_RECRUITABLE     = $3E
  SONG_BATTLE_JULIA           = $50

  SONG_WORLD_MAP_GENERATION1  = $5E ; the world map events of the prologue to chapter 4
  SONG_WORLD_MAP_CHAPTER5     = $61
  SONG_WORLD_MAP_GENERATION2  = $5C ; chapters 6 to 10
  SONG_WORLD_MAP_EPILOGUE     = $0F
  SONG_CASTLE_SEIZED          = $7C ; the castle-seized events that do not end a chapter

  SONG_TITLE_INTRO_1          = $01 ; rlPlayTitleIntroSong
  SONG_TITLE_INTRO_2          = $02 ; rlPlayTitleIntroSong2
  SONG_TITLE_SCREEN           = $03 ; rlPlayTitleSong
  SONG_JUGDRAL_HISTORY        = $04 ; rsJugdralHistorySetup
  SONG_EPILOGUE_MEMORIAL      = $0B
  SONG_EPILOGUE_CREDITS       = $0D ; rlSetupEpilogueCreditsDisplay
  SONG_EPILOGUE_RANKINGS      = $0E ; rlSetupEpilogueRankingsDisplay
  SONG_ENEMY_PHASE_DUKES_2    = $17 ; Velthomer2..Yngvi2
  SONG_ENEMY_PHASE_DUKES_1    = $19 ; Velthomer1..Yngvi1, Lubeck
  SONG_ENEMY_PHASE_SILESSE    = $1F
  SONG_ENEMY_PHASE_VERDANE    = $21
  SONG_ENEMY_PHASE_AGUSTRIA   = $22
  SONG_ENEMY_PHASE_ORGAHIL    = $23
  SONG_ENEMY_PHASE_AED        = $25
  SONG_ENEMY_PHASE_ISAACH     = $26
  SONG_ENEMY_PHASE_MUNSTER    = $27
  SONG_ENEMY_PHASE_THRACIA    = $28
  SONG_ENEMY_PHASE_MILETOS    = $29
  SONG_FIRST_PHASE_FINAL      = $2E ; aChapterFirstPhaseSongIDs Final chapter
  SONG_GAME_OVER              = $72 ; rlProcGameOverInit
