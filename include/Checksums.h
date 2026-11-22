
  ; Anti-tamper and code integrity checks:
  ;
  ; 1. Word-sum checks (aCodeChecksums at $8F/8000, copied at $87/8008 and $88/8000):
  ;    - rlCheckCodeChecksums ($8F/8006), rlCheckCodeChecksumsCopy88 ($88/800F), and
  ;      rlUnknown878074 ($87/8074) add up 16-bit words across $80/8D56-$80/8E2C
  ;      (inside rlReset) and $87/8017-$87/80A9 (inside rlUnknown878017/2A/74)
  ;      and compare them against the three structCodeChecksums tables.
  ;    - When ChecksEnabled is 0, the checks pass without summing; the original
  ;      ROM stores $5349 ("IS").
  ;
  ; 2. Second integrity check & copier detection (rlUnknown878017 / rlUnknown87802A):
  ;    - rlUnknown878017 ($87/8017) copies 128 bytes from $88/8888-$88/8907
  ;      (starting at rlUnknown8887EC._8880+8) into aSpriteExtBuffer ($001E00).
  ;    - rlUnknown87802A ($87/802A) compares $88/8888-$88/8907 against $001E00.
  ;      If any word differs, it returns cleanly; if all 128 bytes match (e.g.
  ;      on a reset after rlUnknown878017 already tripped, or if $88/8888-$88/8907
  ;      was zeroed to match cleared WRAM), it enters the trap at _803E (clears
  ;      $001FFC/$001FFE, writes SRAM anti-piracy marker #$6A19, and hangs).
  ;    - rlReset ($80/8D56) also scans WRAM $0000-$1FFE for copier/cheat hooks
  ;      (indirect/direct jumps to $FFFC or $8D56, or ascending $60..$7F stubs)
  ;      and jumps to rlUnknown87802A._803E if detected, otherwise calling
  ;      rlUnknown878074.
  ;
  ; 3. Unattributed bulk code reads in fe4.cdl:
  ;    - The prologue code/data log also recorded bulk data reads across
  ;      $88/8888-$88/8AC7 (576 bytes, extending beyond the 128 bytes read by
  ;      rlUnknown878017/2A) and $82/8888-$82/890D (134 bytes). No static ROM
  ;      reference in the built source targets $82/8888 or $88/8908-$88/8AC7
  ;      directly; finding their reader requires a Mesen read breakpoint.

  structCodeChecksums .struct Bank80Sum, Bank87Sum, ChecksEnabled
    Bank80Sum     .word \Bank80Sum     ; sum of words in $80/8D56-$80/8E2C (step 2, < $8E2D)
    Bank87Sum     .word \Bank87Sum     ; sum of words in $87/8017-$87/80A9 (step 2, < $80AA)
    ChecksEnabled .word \ChecksEnabled ; 0 turns the checks off; the game has "IS"
  .endstruct
