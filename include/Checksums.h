
  ; The game keeps sums of two stretches of its own code and checks them while it
  ; runs (rlCheckCodeChecksums and others). The sums are stored three times:
  ; aCodeChecksums in bank $8F and copies at the start of banks $87 and $88.

  structCodeChecksums .struct Bank80Sum, Bank87Sum, ChecksEnabled
    Bank80Sum     .word \Bank80Sum     ; sum of the words in $80/8D56-8E2C
    Bank87Sum     .word \Bank87Sum     ; sum of the words in $87/8017-80A9
    ChecksEnabled .word \ChecksEnabled ; 0 turns the checks off; the game has "IS"
  .endstruct
