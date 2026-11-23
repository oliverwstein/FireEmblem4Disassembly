# Unidentified compressed streams

Made by `tools/stream_catalog.py`; do not edit. These streams are carved
(labelled, and placed by the build) but not identified: each is still the
ROM's bytes, `gcUnknownADDR.comp`. When the code that uses one is read, give it
a real name and format (a PNG if it is graphics) and run the tool again.

Previews draw the decompressed bytes as 4bpp tiles, 16 across, in grey. That
is only a first look: a stream may be 2bpp graphics, a tilemap, or other data.

242 streams.

## Region $94C140

### gcUnknown94E9EE

5503 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknown94E9EE](catalog/gcUnknown94E9EE.png)

### gcUnknown94FF6D

100 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknown94FF6D](catalog/gcUnknown94FF6D.png)

### gcUnknown94FFD1

40 bytes compressed, 128 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknown94FFD1](catalog/gcUnknown94FFD1.png)

## Region $9C8000

### gcUnknown9C8000

14605 bytes compressed, 18432 decompressed.
- `rlUnknown91D6EC` (engine/unsorted/bank91.asm:1871): `lda #(`gcUnknown9C8000)<<8`

![gcUnknown9C8000](catalog/gcUnknown9C8000.png)

### gcUnknown9CB90D

531 bytes compressed, 2048 decompressed.
- `rlUnknown91D6EC` (engine/unsorted/bank91.asm:1849): `lda #(`gcUnknown9CB90D)<<8`
- `rsUnknown91E583` (engine/unsorted/bank91.asm:4192): `lda #(`gcUnknown9CB90D)<<8`
- `rlUnknown91E793` (engine/unsorted/bank91.asm:4591): `lda #(`gcUnknown9CB90D)<<8`
- `rlUnknown91E82A` (engine/unsorted/bank91.asm:4660): `lda #(`gcUnknown9CB90D)<<8`

![gcUnknown9CB90D](catalog/gcUnknown9CB90D.png)

### gcUnknown9CBB20

151 bytes compressed, 2048 decompressed.
- `rlUnknown91D6EC` (engine/unsorted/bank91.asm:1884): `lda #(`gcUnknown9CBB20)<<8`
- `rsUnknown91E5B2` (engine/unsorted/bank91.asm:4228): `lda #(`gcUnknown9CBB20)<<8`

![gcUnknown9CBB20](catalog/gcUnknown9CBB20.png)

### gcUnknown9CBBB7

1002 bytes compressed, 2048 decompressed.
- `rlUnknown91D6EC` (engine/unsorted/bank91.asm:1897): `lda #(`gcUnknown9CBBB7)<<8`
- `rsUnknown91E5F4` (engine/unsorted/bank91.asm:4260): `lda #(`gcUnknown9CBBB7)<<8`

![gcUnknown9CBBB7](catalog/gcUnknown9CBBB7.png)

### gcUnknown9CBFA1

275 bytes compressed, 512 decompressed.
- `rlUnknown91D6EC` (engine/unsorted/bank91.asm:1910): `lda #(`gcUnknown9CBFA1)<<8`
- `rsUnknown91E622` (engine/unsorted/bank91.asm:4292): `lda #(`gcUnknown9CBFA1)<<8`

![gcUnknown9CBFA1](catalog/gcUnknown9CBFA1.png)

### gcUnknown9CC0B4

2734 bytes compressed, 8192 decompressed.
- `rlUnknown91E793` (engine/unsorted/bank91.asm:4604): `lda #(`gcUnknown9CC0B4)<<8`

![gcUnknown9CC0B4](catalog/gcUnknown9CC0B4.png)

### gcUnknown9CCB62

688 bytes compressed, 2048 decompressed.
- `rlUnknown91E793` (engine/unsorted/bank91.asm:4617): `lda #(`gcUnknown9CCB62)<<8`

![gcUnknown9CCB62](catalog/gcUnknown9CCB62.png)

### gcUnknown9CCE12

2311 bytes compressed, 8192 decompressed.
- `rlUnknown91E82A` (engine/unsorted/bank91.asm:4673): `lda #(`gcUnknown9CCE12)<<8`

![gcUnknown9CCE12](catalog/gcUnknown9CCE12.png)

### gcUnknown9CD719

509 bytes compressed, 2048 decompressed.
- `rlUnknown91E82A` (engine/unsorted/bank91.asm:4686): `lda #(`gcUnknown9CD719)<<8`

![gcUnknown9CD719](catalog/gcUnknown9CD719.png)

### gcUnknown9CD916

72 bytes compressed, 512 decompressed.
- `rlUnknown91E793` (engine/unsorted/bank91.asm:4630): `lda #(`gcUnknown9CD916)<<8`
- `rlUnknown91E82A` (engine/unsorted/bank91.asm:4699): `lda #(`gcUnknown9CD916)<<8`

![gcUnknown9CD916](catalog/gcUnknown9CD916.png)

## Region $A08000

### gcUnknownACC8C3

852 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownACC8C3](catalog/gcUnknownACC8C3.png)

### gcUnknownACCC17

1797 bytes compressed, 8192 decompressed.
- `rlUnknown9E88FA` (engine/unsorted/bank9E.asm:1708): `lda #(`gcUnknownACCC17)<<8`
- `rlProcUnknown9E9A43Cycle1` (engine/unsorted/bank9E.asm:4667): `lda #(`gcUnknownACCC17)<<8`
- `rlUnknown9ED2B5` (engine/unsorted/bank9E.asm:10607): `lda #(`gcUnknownACCC17)<<8`
- `rlProcUnknown9ED441Cycle1` (engine/unsorted/bank9E.asm:11095): `lda #(`gcUnknownACCC17)<<8`
- `rlProcUnknown9EF837Cycle1` (engine/events/cutscenes.asm:472): `lda #(`gcUnknownACCC17)<<8`

![gcUnknownACCC17](catalog/gcUnknownACCC17.png)

## Region $AFC8C0

### gcUnknownAFF670

1819 bytes compressed, 3072 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownAFF670](catalog/gcUnknownAFF670.png)

## Region $B48720

### gcUnknownB6FFCA

53 bytes compressed, 128 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownB6FFCA](catalog/gcUnknownB6FFCA.png)

## Region $C00A2B

### gcUnknownC00A2B

3920 bytes compressed, 6144 decompressed.
- `rlUnknown80B0D3` (engine/unsorted/bank80.asm:4471): `lda #(`gcUnknownC00A2B)<<8`
- Entry `aUnknown80E53D` (engine/unsorted/bank80.asm:6985): $1800 bytes to VRAM $4000; used by `rsUnknown80E4EB` (engine/unsorted/bank80.asm:6947).
- `rlUnknown9EA155` (engine/unsorted/bank9E.asm:5372): `lda #(`gcUnknownC00A2B)<<8`
- Entry `aUnknown80E13E` (engine/menus/revive_screen.asm:218): $1800 bytes to VRAM $0000; used by `rsUnknown80E0AE` (engine/menus/revive_screen.asm:154).
- Entry `aDataWindowDecompressionList` (engine/menus/data_window.asm:183): $1800 bytes to VRAM $0000; used by `rsDataWindowLoadGraphics` (engine/menus/data_window.asm:130).
- Entry `aUnknown8AE4BB` (engine/arena/arena.asm:26): $1800 bytes to VRAM $4000; used by `rlUnknown8AE2F8` (engine/unsorted/bank8A.asm:11842).
- Entry `aDecompressionDMAEntry80B0CB` (build.asm:768): $1800 bytes to VRAM $4000; used by `rlUnknown80B0BC` (engine/unsorted/bank80.asm:4444).
- Entry `aDecompressionDMAEntry80B99D` (build.asm:894): $1800 bytes to VRAM $4000; used by `rlUnknown80B827` (engine/unsorted/bank80.asm:5363).
- Entry `aDecompressionDMAEntry80BB45` (build.asm:938): $1800 bytes to VRAM $4000; used by `rlUnknown80BA52` (engine/unsorted/bank80.asm:5674).
- Entry `aDecompressionDMAEntry80BEF9` (build.asm:969): $1800 bytes to VRAM $4000; used by `rlUnknown80BD27` (engine/unsorted/bank80.asm:6050).
- Entry `aDecompressionDMAEntry80C5BE` (build.asm:1042): $1800 bytes to VRAM $4000; used by `rsUnitWindowCopyGraphics` (engine/menus/unit_window.asm:192).
- Entry `aDecompressionDMAEntry80CE8E` (build.asm:1120): $1800 bytes to VRAM $0000; used by `rsItemWindowCopyGraphics` (engine/menus/item_window.asm:128).
- Entry `aDecompressionDMAEntry80D41D` (build.asm:1171): $1800 bytes to VRAM $0000; used by `rsSkillWindowCopyGraphics` (engine/menus/skill_window.asm:128).
- Entry `aDecompressionDMAEntry80E72E` (build.asm:1238): $1800 bytes to VRAM $0000; used by `rsUnknown80E6C9` (engine/unsorted/bank80.asm:7172).
- Entry `aDecompressionDMAEntry8A8F58` (build.asm:7994): $1800 bytes to VRAM $4000; used by `rsUnknown8A8E08` (engine/unsorted/bank8A.asm:2395).
- Entry `aDecompressionDMAEntry8ABE4B` (build.asm:8512): $1800 bytes to VRAM $4000; used by `rlUnknown8ABCF8` (engine/unsorted/bank8A.asm:7571).
- Entry `aDecompressionDMAEntry8AD952` (build.asm:8767): $1800 bytes to VRAM $4000; used by `rlUnknown8AD81B` (engine/unsorted/bank8A.asm:10354).
- Entry `aDecompressionDMAEntry8AEE89` (build.asm:8985): $1800 bytes to VRAM $4000; used by `rlUnknown8AECEF` (engine/unsorted/bank8A.asm:12036).
- Entry `aDecompressionDMAEntry8AF263` (build.asm:9033): $1800 bytes to VRAM $4000; used by `rlUnknown8AF0F2` (engine/unsorted/bank8A.asm:12589).
- Entry `aDecompressionDMAEntry8AFA0C` (build.asm:9087): $1800 bytes to VRAM $4000; used by `rlUnknown8AF894` (engine/unsorted/bank8A.asm:13666).

![gcUnknownC00A2B](catalog/gcUnknownC00A2B.png)

### gcUnknownC0197B

1599 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry80B0FD` (build.asm:783): $0800 bytes to VRAM $4C00; used by `rlUnknown80B0EE` (engine/unsorted/bank80.asm:4494).

![gcUnknownC0197B](catalog/gcUnknownC0197B.png)

### gcUnknownC01FBA

764 bytes compressed, 1024 decompressed.
- Entry `aDecompressionDMAEntry80B09B` (build.asm:753): $0400 bytes to VRAM $3400; used by `rlUnknown80B08C` (engine/events/event_scripts.asm:4811).

![gcUnknownC01FBA](catalog/gcUnknownC01FBA.png)

### gcUnknownC022B6

652 bytes compressed, 1440 decompressed.
- Entry `aDecompressionDMAEntry85D669` (build.asm:4258): $0800 bytes to VRAM $4C00; used by `rlUnknown85D65A` (engine/unsorted/bank85.asm:12861).

![gcUnknownC022B6](catalog/gcUnknownC022B6.png)

### gcUnknownC02542

580 bytes compressed, 1024 decompressed.
- Entry `aDecompressionDMAEntry80B084` (build.asm:738): $0400 bytes to VRAM $3600; used by `rsUnknown80B065` (engine/events/event_scripts.asm:4782).

![gcUnknownC02542](catalog/gcUnknownC02542.png)

### gcUnknownC02786

997 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownC02786](catalog/gcUnknownC02786.png)

### gcUnknownC02B6B

2282 bytes compressed, 3520 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownC02B6B](catalog/gcUnknownC02B6B.png)

### gcUnknownC03455

259 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownC03455](catalog/gcUnknownC03455.png)

### gcUnknownC03558

258 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownC03558](catalog/gcUnknownC03558.png)

### gcUnknownC0365A

1451 bytes compressed, 3584 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownC0365A](catalog/gcUnknownC0365A.png)

## Region $D05673

### gcUnknownD05673

14246 bytes compressed, 24576 decompressed.
- Entry `aDecompressionDMAEntry80B61E` (build.asm:819): $6000 bytes to VRAM $0000; used by `rlUnknown80B452` (engine/unsorted/bank80.asm:4828).

![gcUnknownD05673](catalog/gcUnknownD05673.png)

### gcUnknownD10E19

2341 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD10E19](catalog/gcUnknownD10E19.png)

### gcUnknownD1173E

5906 bytes compressed, 9216 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD1173E](catalog/gcUnknownD1173E.png)

### gcUnknownD13C01

132 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD13C01](catalog/gcUnknownD13C01.png)

### gcUnknownD13D09

1573 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry80B626` (build.asm:820): $1000 bytes to VRAM $3000; used by `rlUnknown80B452` (engine/unsorted/bank80.asm:4866).

![gcUnknownD13D09](catalog/gcUnknownD13D09.png)

### gcUnknownD1432E

71 bytes compressed, 256 decompressed.
- Entry `aDecompressionDMAEntry80B62E` (build.asm:821): $0100 bytes to VRAM $4000; used by `rlUnknown80B452` (engine/unsorted/bank80.asm:4883).

![gcUnknownD1432E](catalog/gcUnknownD1432E.png)

### gcUnknownD14375

281 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry80B636` (build.asm:822): $0800 bytes to VRAM $6000; used by `rlUnknown80B452` (engine/unsorted/bank80.asm:4892).

![gcUnknownD14375](catalog/gcUnknownD14375.png)

### gcUnknownD22430

2011 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8ABF0F` (build.asm:8529): $1000 bytes to VRAM $0000; used by `rsUnknown8ABE63` (engine/unsorted/bank8A.asm:7681).

![gcUnknownD22430](catalog/gcUnknownD22430.png)

### gcUnknownD240B0

2148 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8AEE91` (build.asm:8986): $1000 bytes to VRAM $0000; used by `rlUnknown8AECEF` (engine/unsorted/bank8A.asm:12004).

![gcUnknownD240B0](catalog/gcUnknownD240B0.png)

### gcUnknownD24914

912 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry8AEEA1` (build.asm:8988): $0800 bytes to VRAM $2800; used by `rlUnknown8AECEF` (engine/unsorted/bank8A.asm:12022).

![gcUnknownD24914](catalog/gcUnknownD24914.png)

### gcUnknownD24CA4

7509 bytes compressed, 8192 decompressed.
- Entry `aDecompressionDMAEntry8AFA1C` (build.asm:9089): $2000 bytes to VRAM $1000; used by `rlUnknown8AF894` (engine/unsorted/bank8A.asm:13643).

![gcUnknownD24CA4](catalog/gcUnknownD24CA4.png)

### gcUnknownD269F9

2240 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8AFA14` (build.asm:9088): $1000 bytes to VRAM $0000; used by `rlUnknown8AF894` (engine/unsorted/bank8A.asm:13638).

![gcUnknownD269F9](catalog/gcUnknownD269F9.png)

### gcUnknownD272B9

995 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry8AFA24` (build.asm:9090): $0800 bytes to VRAM $2800; used by `rlUnknown8AF894` (engine/unsorted/bank8A.asm:13652).

![gcUnknownD272B9](catalog/gcUnknownD272B9.png)

### gcUnknownD2769C

2174 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8ABF1F` (build.asm:8531): $1000 bytes to VRAM $0000; used by `rsUnknown8ABE63` (engine/unsorted/bank8A.asm:7737).

![gcUnknownD2769C](catalog/gcUnknownD2769C.png)

### gcUnknownD27F1A

1980 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8ABF17` (build.asm:8530): $1000 bytes to VRAM $0000; used by `rsUnknown8ABE63` (engine/unsorted/bank8A.asm:7709).

![gcUnknownD27F1A](catalog/gcUnknownD27F1A.png)

### gcUnknownD306D6

2174 bytes compressed, 4096 decompressed.
- Entry `aUnknown8AE4C3` (engine/arena/arena.asm:32): $1000 bytes to VRAM $0000; used by `rlUnknown8AE2F8` (engine/unsorted/bank8A.asm:11815).

![gcUnknownD306D6](catalog/gcUnknownD306D6.png)

### gcUnknownD30F54

2124 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8AF26B` (build.asm:9034): $1000 bytes to VRAM $0000; used by `rlUnknown8AF0F2` (engine/unsorted/bank8A.asm:12562).

![gcUnknownD30F54](catalog/gcUnknownD30F54.png)

### gcUnknownD317A0

5419 bytes compressed, 8192 decompressed.
- Entry `aDecompressionDMAEntry80EFB0` (build.asm:1298): $2000 bytes to VRAM $2000; used by `rlUnknown80EE37` (engine/unsorted/bank80.asm:7604).

![gcUnknownD317A0](catalog/gcUnknownD317A0.png)

### gcUnknownD32CCB

965 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry80EFC0` (build.asm:1300): $1000 bytes to VRAM $6000; used by `rlUnknown80EE37` (engine/unsorted/bank80.asm:7624).

![gcUnknownD32CCB](catalog/gcUnknownD32CCB.png)

### gcUnknownD33090

1317 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry80EFC8` (build.asm:1301): $1000 bytes to VRAM $5000; used by `rlUnknown80EE37` (engine/unsorted/bank80.asm:7614).

![gcUnknownD33090](catalog/gcUnknownD33090.png)

### gcUnknownD335B5

2373 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry80EFD0` (build.asm:1302): $1000 bytes to VRAM $5800; used by `rlUnknown80EE37` (engine/unsorted/bank80.asm:7619).

![gcUnknownD335B5](catalog/gcUnknownD335B5.png)

### gcUnknownD33EFA

7238 bytes compressed, 8192 decompressed.
- Entry `aDecompressionDMAEntry80BB55` (build.asm:940): $2000 bytes to VRAM $1000; used by `rlUnknown80BA52` (engine/unsorted/bank80.asm:5679).

![gcUnknownD33EFA](catalog/gcUnknownD33EFA.png)

### gcUnknownD35B40

884 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry80BB4D` (build.asm:939): $0800 bytes to VRAM $5400; used by `rlUnknown80BA52` (engine/unsorted/bank80.asm:5684).

![gcUnknownD35B40](catalog/gcUnknownD35B40.png)

### gcUnknownD35EB4

17210 bytes compressed, 22528 decompressed.
- Entry `aDecompressionDMAEntry80F197` (build.asm:1319): $5800 bytes to VRAM $0000; used by `rlUnknown80EFD8` (engine/unsorted/bank80.asm:7807).
- Entry `aDecompressionDMAEntry8DAF95` (build.asm:10450): $3000 bytes to VRAM $0000; used by `rlUnknown8DAF33` (engine/unsorted/bank8D.asm:1356).

![gcUnknownD35EB4](catalog/gcUnknownD35EB4.png)

### gcUnknownD421EE

133 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry8DAF9D` (build.asm:10451): $0800 bytes to VRAM $5800; used by `rlUnknown8DAF33` (engine/unsorted/bank8D.asm:1361).

![gcUnknownD421EE](catalog/gcUnknownD421EE.png)

### gcUnknownD42273

1605 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8DB066` (build.asm:10468): $1000 bytes to VRAM $4000; used by `rlUnknown8DAFA5` (engine/unsorted/bank8D.asm:1422).

![gcUnknownD42273](catalog/gcUnknownD42273.png)

### gcUnknownD428B8

318 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry8DB05E` (build.asm:10467): $0800 bytes to VRAM $6800; used by nothing named.

![gcUnknownD428B8](catalog/gcUnknownD428B8.png)

### gcUnknownD429F6

602 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry8DB056` (build.asm:10466): $0800 bytes to VRAM $5800; used by `rlUnknown8DAFA5` (engine/unsorted/bank8D.asm:1417).

![gcUnknownD429F6](catalog/gcUnknownD429F6.png)

### gcUnknownD42C50

1970 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry80F19F` (build.asm:1320): $1000 bytes to VRAM $5800; used by `rlUnknown80EFD8` (engine/unsorted/bank80.asm:7812).

![gcUnknownD42C50](catalog/gcUnknownD42C50.png)

### gcUnknownD43402

3393 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD43402](catalog/gcUnknownD43402.png)

### gcUnknownD44143

344 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD44143](catalog/gcUnknownD44143.png)

### gcUnknownD4429B

1492 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD4429B](catalog/gcUnknownD4429B.png)

### gcUnknownD4486F

301 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD4486F](catalog/gcUnknownD4486F.png)

### gcOpeningCreditsFont

6316 bytes compressed, 12288 decompressed.
The font of the opening's staff credits (2bpp, BG3): entry `aOpeningCreditsFont`, $3000 bytes to VRAM $4000, used by `rsSetUpOpeningCreditsScreen` (engine/demo/opening_credits.asm).

![gcOpeningCreditsFont](catalog/gcOpeningCreditsFont.png)

### gcOpeningCreditsPage1

58 bytes compressed, 1792 decompressed.
Page 1 of the opening's staff credits, a BG3 tilemap: entry `aOpeningCreditsPage1Tilemap`, $0700 bytes to VRAM $5800, used by `rlShowOpeningCreditsPage1` (engine/demo/opening_credits.asm).

![gcOpeningCreditsPage1](catalog/gcOpeningCreditsPage1.png)

### gcOpeningCreditsPage2

132 bytes compressed, 1792 decompressed.
Page 2 of the opening's staff credits, a BG3 tilemap: entry `aOpeningCreditsPage2Tilemap`, $0700 bytes to VRAM $5800, used by `rlShowOpeningCreditsPage2` (engine/demo/opening_credits.asm).

![gcOpeningCreditsPage2](catalog/gcOpeningCreditsPage2.png)

### gcOpeningCreditsPage3

131 bytes compressed, 1792 decompressed.
Page 3 of the opening's staff credits, a BG3 tilemap: entry `aOpeningCreditsPage3Tilemap`, $0700 bytes to VRAM $5800, used by `rlShowOpeningCreditsPage3` (engine/demo/opening_credits.asm).

![gcOpeningCreditsPage3](catalog/gcOpeningCreditsPage3.png)

### gcOpeningCreditsPage4

134 bytes compressed, 1792 decompressed.
Page 4 of the opening's staff credits, a BG3 tilemap: entry `aOpeningCreditsPage4Tilemap`, $0700 bytes to VRAM $5800, used by `rlShowOpeningCreditsPage4` (engine/demo/opening_credits.asm).

![gcOpeningCreditsPage4](catalog/gcOpeningCreditsPage4.png)

### gcOpeningCreditsPage5

198 bytes compressed, 1792 decompressed.
Page 5 of the opening's staff credits, a BG3 tilemap: entry `aOpeningCreditsPage5Tilemap`, $0700 bytes to VRAM $5800, used by `rlShowOpeningCreditsPage5` (engine/demo/opening_credits.asm).

![gcOpeningCreditsPage5](catalog/gcOpeningCreditsPage5.png)

### gcOpeningCreditsPage6

147 bytes compressed, 1792 decompressed.
Page 6 of the opening's staff credits, a BG3 tilemap: entry `aOpeningCreditsPage6Tilemap`, $0700 bytes to VRAM $5800, used by `rlShowOpeningCreditsPage6` (engine/demo/opening_credits.asm).

![gcOpeningCreditsPage6](catalog/gcOpeningCreditsPage6.png)

### gcOpeningCreditsPage7

264 bytes compressed, 1792 decompressed.
Page 7 of the opening's staff credits, a BG3 tilemap: entry `aOpeningCreditsPage7Tilemap`, $0700 bytes to VRAM $5800, used by `rlShowOpeningCreditsPage7` (engine/demo/opening_credits.asm).

![gcOpeningCreditsPage7](catalog/gcOpeningCreditsPage7.png)

### gcOpeningCreditsPage8

33 bytes compressed, 1792 decompressed.
Page 8 of the opening's staff credits, a BG3 tilemap: entry `aOpeningCreditsPage8Tilemap`, $0700 bytes to VRAM $5800, used by `rlShowOpeningCreditsPage8` (engine/demo/opening_credits.asm).

![gcOpeningCreditsPage8](catalog/gcOpeningCreditsPage8.png)

### gcUnknownD46691

350 bytes compressed, 2048 decompressed.
- Entry `aUnknown8AE4CB` (engine/arena/arena.asm:38): $0800 bytes to VRAM $2800; used by `rlUnknown8AE2F8` (engine/unsorted/bank8A.asm:11828).
- Entry `aDecompressionDMAEntry8ABE53` (build.asm:8513): $0800 bytes to VRAM $2800; used by `rlUnknown8ABCF8` (engine/unsorted/bank8A.asm:7557).
- Entry `aDecompressionDMAEntry8AF273` (build.asm:9035): $0800 bytes to VRAM $2800; used by `rlUnknown8AF0F2` (engine/unsorted/bank8A.asm:12575).

![gcUnknownD46691](catalog/gcUnknownD46691.png)

### gcUnknownD467EF

180 bytes compressed, 2048 decompressed.
- Entry `aUnknown8AE4D3` (engine/arena/arena.asm:44): $0800 bytes to VRAM $2C00; used by `rlUnknown8AE2F8` (engine/unsorted/bank8A.asm:11833).
- Entry `aDecompressionDMAEntry8ABE5B` (build.asm:8514): $0800 bytes to VRAM $2C00; used by `rlUnknown8ABCF8` (engine/unsorted/bank8A.asm:7562).
- Entry `aDecompressionDMAEntry8AEEA9` (build.asm:8989): $0800 bytes to VRAM $2C00; used by `rlUnknown8AECEF` (engine/unsorted/bank8A.asm:12027).
- Entry `aDecompressionDMAEntry8AF27B` (build.asm:9036): $0800 bytes to VRAM $2C00; used by `rlUnknown8AF0F2` (engine/unsorted/bank8A.asm:12580).
- Entry `aDecompressionDMAEntry8AFA2C` (build.asm:9091): $0800 bytes to VRAM $2C00; used by `rlUnknown8AF894` (engine/unsorted/bank8A.asm:13657).

![gcUnknownD467EF](catalog/gcUnknownD467EF.png)

## Region $D50000

### gcUnknownD534DC

121 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD534DC](catalog/gcUnknownD534DC.png)

### gcUnknownD53555

111 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD53555](catalog/gcUnknownD53555.png)

### gcUnknownD535C4

107 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD535C4](catalog/gcUnknownD535C4.png)

### gcUnknownD5362F

65 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD5362F](catalog/gcUnknownD5362F.png)

### gcUnknownD53670

72 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD53670](catalog/gcUnknownD53670.png)

### gcUnknownD536B8

72 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD536B8](catalog/gcUnknownD536B8.png)

### gcUnknownD53CFF

147 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD53CFF](catalog/gcUnknownD53CFF.png)

### gcUnknownD53D92

90 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD53D92](catalog/gcUnknownD53D92.png)

### gcUnknownD53DEC

110 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD53DEC](catalog/gcUnknownD53DEC.png)

### gcUnknownD53E5A

115 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD53E5A](catalog/gcUnknownD53E5A.png)

### gcUnknownD54330

72 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54330](catalog/gcUnknownD54330.png)

### gcUnknownD54378

143 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54378](catalog/gcUnknownD54378.png)

### gcUnknownD54407

29 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54407](catalog/gcUnknownD54407.png)

### gcUnknownD54424

93 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54424](catalog/gcUnknownD54424.png)

### gcUnknownD548CE

72 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD548CE](catalog/gcUnknownD548CE.png)

### gcUnknownD54916

39 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54916](catalog/gcUnknownD54916.png)

### gcUnknownD54D91

72 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54D91](catalog/gcUnknownD54D91.png)

### gcUnknownD54DD9

135 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54DD9](catalog/gcUnknownD54DD9.png)

### gcUnknownD54E60

71 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54E60](catalog/gcUnknownD54E60.png)

### gcUnknownD54EA7

99 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54EA7](catalog/gcUnknownD54EA7.png)

### gcUnknownD54F0A

39 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54F0A](catalog/gcUnknownD54F0A.png)

### gcUnknownD54F31

72 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54F31](catalog/gcUnknownD54F31.png)

### gcUnknownD54F79

70 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54F79](catalog/gcUnknownD54F79.png)

### gcUnknownD55131

381 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD55131](catalog/gcUnknownD55131.png)

### gcUnknownD57B50

2190 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD57B50](catalog/gcUnknownD57B50.png)

### gcUnknownD629B1

684 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD629B1](catalog/gcUnknownD629B1.png)

### gcUnknownD64244

410 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD64244](catalog/gcUnknownD64244.png)

### gcUnknownD65010

323 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD65010](catalog/gcUnknownD65010.png)

### gcUnknownD65153

111 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD65153](catalog/gcUnknownD65153.png)

### gcUnknownD6564B

133 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD6564B](catalog/gcUnknownD6564B.png)

### gcUnknownD676F6

243 bytes compressed, 1024 decompressed.
- `rlUnknown9E9D3B` (engine/unsorted/bank9E.asm:4706): `lda #(`gcUnknownD676F6)<<8`

![gcUnknownD676F6](catalog/gcUnknownD676F6.png)

### gcUnknownD677E9

87 bytes compressed, 2048 decompressed.
- `rlUnknown9E9D3B` (engine/unsorted/bank9E.asm:4718): `lda #(`gcUnknownD677E9)<<8`

![gcUnknownD677E9](catalog/gcUnknownD677E9.png)

### gcUnknownD67D7D

414 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD67D7D](catalog/gcUnknownD67D7D.png)

## Region $DD0000

### gcUnknownDD0000

8352 bytes compressed, 9728 decompressed.
- `rsUnknown898105` (engine/unsorted/bank89.asm:385): `lda #(`gcUnknownDD0000)<<8`
- `rsUnknown89831F` (engine/unsorted/bank89.asm:635): `lda #(`gcUnknownDD0000)<<8`

![gcUnknownDD0000](catalog/gcUnknownDD0000.png)

### gcUnknownDD20A0

3150 bytes compressed, 4608 decompressed.
- Entry `aUnknown80E146` (engine/menus/revive_screen.asm:223): $1200 bytes to VRAM $3000; used by `rsUnknown80E0AE` (engine/menus/revive_screen.asm:159).
- Entry `aDecompressionDMAEntry80F187` (build.asm:1317): $1200 bytes to VRAM $3000; used by `rlUnknown80EFD8` (engine/unsorted/bank80.asm:7797).
- Entry `aDecompressionDMAEntry80F433` (build.asm:1385): $1200 bytes to VRAM $4000; used by `rsUnknown80F392` (engine/unsorted/bank80.asm:8260).

![gcUnknownDD20A0](catalog/gcUnknownDD20A0.png)

### gcUnknownDD2CEE

162 bytes compressed, 1792 decompressed.
- Entry `aUnknown80E14E` (engine/menus/revive_screen.asm:228): $0700 bytes to VRAM $1800; used by `rsUnknown80E0AE` (engine/menus/revive_screen.asm:198).

![gcUnknownDD2CEE](catalog/gcUnknownDD2CEE.png)

### gcUnknownDD2D90

699 bytes compressed, 2048 decompressed.
- Entry `aUnknown80E156` (engine/menus/revive_screen.asm:233): $0800 bytes to VRAM $2000; used by `rsUnknown80E0AE` (engine/menus/revive_screen.asm:203).
- Entry `aDecompressionDMAEntry80F18F` (build.asm:1318): $0800 bytes to VRAM $5000; used by `rlUnknown80EFD8` (engine/unsorted/bank80.asm:7802).
- Entry `aDecompressionDMAEntry80F43B` (build.asm:1386): $0800 bytes to VRAM $6000; used by `rsUnknown80F392` (engine/unsorted/bank80.asm:8308).

![gcUnknownDD2D90](catalog/gcUnknownDD2D90.png)

### gcUnknownDD304B

1775 bytes compressed, 2048 decompressed.
- `rsDataWindowLoadBanners` (engine/menus/data_window.asm:804): `lda #(`gcUnknownDD304B)<<8`

![gcUnknownDD304B](catalog/gcUnknownDD304B.png)

### gcUnknownDD373A

279 bytes compressed, 1792 decompressed.
- `rsDataWindowLoadGraphics` (engine/menus/data_window.asm:151): `lda #(`gcUnknownDD373A)<<8`

![gcUnknownDD373A](catalog/gcUnknownDD373A.png)

### gcUnknownDD3851

225 bytes compressed, 1216 decompressed.
- `rsDataWindowLoadGraphics` (engine/menus/data_window.asm:160): `lda #(`gcUnknownDD3851)<<8`

![gcUnknownDD3851](catalog/gcUnknownDD3851.png)

### gcUnknownDD3932

684 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry80E736` (build.asm:1239): $0800 bytes to VRAM $4200; used by `rsUnknown80E6C9` (engine/unsorted/bank80.asm:7189).

![gcUnknownDD3932](catalog/gcUnknownDD3932.png)

### gcUnknownDD3BDE

262 bytes compressed, 1792 decompressed.
- Entry `aDecompressionDMAEntry80E73E` (build.asm:1240): $0700 bytes to VRAM $2000; used by `rsUnknown80E6C9` (engine/unsorted/bank80.asm:7204).

![gcUnknownDD3BDE](catalog/gcUnknownDD3BDE.png)

### gcUnknownDD3CE4

220 bytes compressed, 1792 decompressed.
- Entry `aDecompressionDMAEntry80D425` (build.asm:1172): $0700 bytes to VRAM $1800; used by `rsSkillWindowCopyGraphics` (engine/menus/skill_window.asm:161).

![gcUnknownDD3CE4](catalog/gcUnknownDD3CE4.png)

### gcUnknownDD3DC0

214 bytes compressed, 1792 decompressed.
- `rsItemWindowCopyGraphics` (engine/menus/item_window.asm:151): `lda #(`gcUnknownDD3DC0)<<8`

![gcUnknownDD3DC0](catalog/gcUnknownDD3DC0.png)

### gcUnknownDD3E96

138 bytes compressed, 704 decompressed.
- `rsItemWindowCopyGraphics` (engine/menus/item_window.asm:160): `lda #(`gcUnknownDD3E96)<<8`

![gcUnknownDD3E96](catalog/gcUnknownDD3E96.png)

### gcUnknownDD3F20

134 bytes compressed, 2048 decompressed.
- Entry `aUnknown80E545` (engine/unsorted/bank80.asm:6990): $0800 bytes to VRAM $6000; used by `rsUnknown80E4EB` (engine/unsorted/bank80.asm:6973).
- Entry `aDecompressionDMAEntry80CE96` (build.asm:1121): $0800 bytes to VRAM $2800; used by `rsItemWindowCopyGraphics` (engine/menus/item_window.asm:173).
- Entry `aDecompressionDMAEntry80D42D` (build.asm:1173): $0800 bytes to VRAM $2000; used by `rsSkillWindowCopyGraphics` (engine/menus/skill_window.asm:166).

![gcUnknownDD3F20](catalog/gcUnknownDD3F20.png)

### gcUnknownDD3FA6

8952 bytes compressed, 16384 decompressed.
- Entry `aDecompressionDMAEntry80F42B` (build.asm:1384): $4000 bytes to VRAM $0000; used by `rsUnknown80F392` (engine/unsorted/bank80.asm:8255).

![gcUnknownDD3FA6](catalog/gcUnknownDD3FA6.png)

### gcUnknownDD629E

951 bytes compressed, 2304 decompressed.
- `rsUnknown80F392` (engine/unsorted/bank80.asm:8287): `lda #(`gcUnknownDD629E)<<8`

![gcUnknownDD629E](catalog/gcUnknownDD629E.png)

## Region $E04220

### gcUnknownE121ED

426 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownE121ED](catalog/gcUnknownE121ED.png)

### gcUnknownE168B9

426 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownE168B9](catalog/gcUnknownE168B9.png)

### gcUnknownE171EB

426 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownE171EB](catalog/gcUnknownE171EB.png)

### gcUnknownE235E5

30 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownE235E5](catalog/gcUnknownE235E5.png)

### gcUnknownE3799A

30 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownE3799A](catalog/gcUnknownE3799A.png)

### gcUnknownEA48E1

1001 bytes compressed, 3072 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEA48E1](catalog/gcUnknownEA48E1.png)

### gcUnknownEA4CCA

1094 bytes compressed, 6144 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEA4CCA](catalog/gcUnknownEA4CCA.png)

### gcUnknownEA5110

5945 bytes compressed, 10752 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEA5110](catalog/gcUnknownEA5110.png)

### gcUnknownEA6849

430 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEA6849](catalog/gcUnknownEA6849.png)

### gcUnknownEA793F

494 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEA793F](catalog/gcUnknownEA793F.png)

### gcUnknownEB3AB5

4072 bytes compressed, 7488 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEB3AB5](catalog/gcUnknownEB3AB5.png)

### gcUnknownEB4A9D

30 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEB4A9D](catalog/gcUnknownEB4A9D.png)

### gcUnknownEB4ABB

2560 bytes compressed, 5408 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEB4ABB](catalog/gcUnknownEB4ABB.png)

### gcUnknownEE2560

739 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEE2560](catalog/gcUnknownEE2560.png)

### gcUnknownEF0815

621 bytes compressed, 3072 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF0815](catalog/gcUnknownEF0815.png)

### gcUnknownEF0A82

398 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF0A82](catalog/gcUnknownEF0A82.png)

### gcUnknownEF0C10

803 bytes compressed, 3584 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF0C10](catalog/gcUnknownEF0C10.png)

### gcUnknownEF0F33

578 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF0F33](catalog/gcUnknownEF0F33.png)

### gcUnknownEF1175

1291 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF1175](catalog/gcUnknownEF1175.png)

### gcUnknownEF1680

814 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF1680](catalog/gcUnknownEF1680.png)

### gcUnknownEF19AE

4174 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF19AE](catalog/gcUnknownEF19AE.png)

### gcUnknownEF29FC

1206 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF29FC](catalog/gcUnknownEF29FC.png)

### gcUnknownEF2EB2

4415 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF2EB2](catalog/gcUnknownEF2EB2.png)

### gcUnknownEF3FF1

553 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF3FF1](catalog/gcUnknownEF3FF1.png)

### gcUnknownEF421A

44 bytes compressed, 544 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF421A](catalog/gcUnknownEF421A.png)

### gcUnknownEF4246

222 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF4246](catalog/gcUnknownEF4246.png)

### gcUnknownEF4324

1713 bytes compressed, 6144 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF4324](catalog/gcUnknownEF4324.png)

### gcUnknownEF49D5

606 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF49D5](catalog/gcUnknownEF49D5.png)

### gcUnknownEF4C33

2093 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF4C33](catalog/gcUnknownEF4C33.png)

### gcUnknownEF5460

361 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF5460](catalog/gcUnknownEF5460.png)

### gcUnknownEF55C9

368 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF55C9](catalog/gcUnknownEF55C9.png)

### gcUnknownEF5739

3546 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF5739](catalog/gcUnknownEF5739.png)

### gcUnknownEF6513

606 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF6513](catalog/gcUnknownEF6513.png)

### gcUnknownEF6771

338 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF6771](catalog/gcUnknownEF6771.png)

### gcUnknownEF68C3

202 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF68C3](catalog/gcUnknownEF68C3.png)

### gcUnknownEF698D

1002 bytes compressed, 1312 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF698D](catalog/gcUnknownEF698D.png)

### gcUnknownEF6D77

459 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF6D77](catalog/gcUnknownEF6D77.png)

### gcUnknownEF6F42

2608 bytes compressed, 5120 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF6F42](catalog/gcUnknownEF6F42.png)

### gcUnknownEF7972

1352 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF7972](catalog/gcUnknownEF7972.png)

### gcUnknownEF7EBA

322 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF7EBA](catalog/gcUnknownEF7EBA.png)

### gcUnknownEF7FFC

321 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownEF7FFC](catalog/gcUnknownEF7FFC.png)

### gcUnknownF0013D

4643 bytes compressed, 7168 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF0013D](catalog/gcUnknownF0013D.png)

### gcUnknownF01360

904 bytes compressed, 1280 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF01360](catalog/gcUnknownF01360.png)

### gcUnknownF016E8

532 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF016E8](catalog/gcUnknownF016E8.png)

### gcUnknownF018FC

248 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF018FC](catalog/gcUnknownF018FC.png)

### gcUnknownF019F4

2162 bytes compressed, 6144 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF019F4](catalog/gcUnknownF019F4.png)

### gcUnknownF02266

3419 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF02266](catalog/gcUnknownF02266.png)

### gcUnknownF02FC1

384 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF02FC1](catalog/gcUnknownF02FC1.png)

### gcUnknownF03141

1102 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF03141](catalog/gcUnknownF03141.png)

### gcUnknownF0358F

482 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF0358F](catalog/gcUnknownF0358F.png)

### gcUnknownF03771

561 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF03771](catalog/gcUnknownF03771.png)

### gcUnknownF039A2

122 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF039A2](catalog/gcUnknownF039A2.png)

### gcUnknownF03A1C

3235 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF03A1C](catalog/gcUnknownF03A1C.png)

### gcUnknownF046BF

9401 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF046BF](catalog/gcUnknownF046BF.png)

### gcUnknownF06B78

1169 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF06B78](catalog/gcUnknownF06B78.png)

### gcUnknownF07009

1103 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF07009](catalog/gcUnknownF07009.png)

### gcUnknownF07458

1165 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF07458](catalog/gcUnknownF07458.png)

### gcUnknownF078E5

3709 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF078E5](catalog/gcUnknownF078E5.png)

### gcUnknownF10762

1683 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF10762](catalog/gcUnknownF10762.png)

### gcUnknownF10DF5

1169 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF10DF5](catalog/gcUnknownF10DF5.png)

### gcUnknownF11286

4649 bytes compressed, 7168 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF11286](catalog/gcUnknownF11286.png)

### gcUnknownF124AF

850 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF124AF](catalog/gcUnknownF124AF.png)

### gcUnknownF12801

369 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF12801](catalog/gcUnknownF12801.png)

### gcUnknownF12972

5871 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF12972](catalog/gcUnknownF12972.png)

### gcUnknownF14061

1235 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF14061](catalog/gcUnknownF14061.png)

### gcUnknownF14534

1169 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF14534](catalog/gcUnknownF14534.png)

### gcUnknownF149C5

1098 bytes compressed, 2560 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF149C5](catalog/gcUnknownF149C5.png)

### gcUnknownF14E0F

385 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF14E0F](catalog/gcUnknownF14E0F.png)

### gcUnknownF14F90

384 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF14F90](catalog/gcUnknownF14F90.png)

### gcUnknownF15110

2071 bytes compressed, 7680 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF15110](catalog/gcUnknownF15110.png)

### gcUnknownF15927

859 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF15927](catalog/gcUnknownF15927.png)

### gcUnknownF15C82

859 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF15C82](catalog/gcUnknownF15C82.png)

### gcUnknownF15FDD

2357 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF15FDD](catalog/gcUnknownF15FDD.png)

### gcUnknownF16912

394 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF16912](catalog/gcUnknownF16912.png)

### gcUnknownF16A9C

376 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF16A9C](catalog/gcUnknownF16A9C.png)

### gcUnknownF16C14

364 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF16C14](catalog/gcUnknownF16C14.png)

### gcUnknownF16D80

758 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF16D80](catalog/gcUnknownF16D80.png)

### gcUnknownF17076

279 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF17076](catalog/gcUnknownF17076.png)

### gcUnknownF1718D

184 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF1718D](catalog/gcUnknownF1718D.png)

### gcUnknownF17245

400 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF17245](catalog/gcUnknownF17245.png)

### gcUnknownF173D5

405 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF173D5](catalog/gcUnknownF173D5.png)

### gcUnknownF1756A

221 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF1756A](catalog/gcUnknownF1756A.png)

### gcUnknownF17647

214 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF17647](catalog/gcUnknownF17647.png)

### gcUnknownF1771D

2406 bytes compressed, 4608 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF1771D](catalog/gcUnknownF1771D.png)

### gcUnknownF20083

1654 bytes compressed, 3328 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF20083](catalog/gcUnknownF20083.png)

### gcUnknownF206F9

709 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF206F9](catalog/gcUnknownF206F9.png)

### gcUnknownF209BE

1731 bytes compressed, 6144 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF209BE](catalog/gcUnknownF209BE.png)

### gcUnknownF21081

1967 bytes compressed, 4608 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF21081](catalog/gcUnknownF21081.png)

### gcUnknownF21830

2013 bytes compressed, 3584 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF21830](catalog/gcUnknownF21830.png)

### gcUnknownF2200D

283 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF2200D](catalog/gcUnknownF2200D.png)

### gcUnknownF22128

280 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF22128](catalog/gcUnknownF22128.png)

### gcUnknownF22240

825 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF22240](catalog/gcUnknownF22240.png)

### gcUnknownF22579

728 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF22579](catalog/gcUnknownF22579.png)

### gcUnknownF22851

222 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF22851](catalog/gcUnknownF22851.png)

### gcUnknownF2292F

1361 bytes compressed, 2560 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF2292F](catalog/gcUnknownF2292F.png)

### gcUnknownF22E80

344 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF22E80](catalog/gcUnknownF22E80.png)

### gcUnknownF22FD8

402 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF22FD8](catalog/gcUnknownF22FD8.png)

### gcUnknownF2316A

342 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF2316A](catalog/gcUnknownF2316A.png)

### gcUnknownF232C0

2233 bytes compressed, 5632 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF232C0](catalog/gcUnknownF232C0.png)

### gcUnknownF23B79

2308 bytes compressed, 3840 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF23B79](catalog/gcUnknownF23B79.png)

### gcUnknownF2447D

605 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF2447D](catalog/gcUnknownF2447D.png)

### gcUnknownF246DA

417 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF246DA](catalog/gcUnknownF246DA.png)

### gcUnknownF2487B

2574 bytes compressed, 5632 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF2487B](catalog/gcUnknownF2487B.png)

### gcUnknownF25289

2510 bytes compressed, 4608 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF25289](catalog/gcUnknownF25289.png)

### gcUnknownF25C57

381 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF25C57](catalog/gcUnknownF25C57.png)

### gcUnknownF25DD4

403 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF25DD4](catalog/gcUnknownF25DD4.png)

### gcUnknownF25F67

837 bytes compressed, 6144 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF25F67](catalog/gcUnknownF25F67.png)

### gcUnknownF262AC

4289 bytes compressed, 6144 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF262AC](catalog/gcUnknownF262AC.png)

### gcUnknownF2736D

883 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF2736D](catalog/gcUnknownF2736D.png)

### gcUnknownF276E0

1689 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF276E0](catalog/gcUnknownF276E0.png)

### gcUnknownF27D79

249 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF27D79](catalog/gcUnknownF27D79.png)

### gcUnknownF27E72

4093 bytes compressed, 6144 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF27E72](catalog/gcUnknownF27E72.png)

### gcUnknownF30E6F

10222 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF30E6F](catalog/gcUnknownF30E6F.png)

## Region $F623D3

### gcUnknownF63A2C

44 bytes compressed, 128 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF63A2C](catalog/gcUnknownF63A2C.png)

### gcUnknownF63A58

53 bytes compressed, 128 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF63A58](catalog/gcUnknownF63A58.png)

### gcUnknownF63A8D

59 bytes compressed, 128 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF63A8D](catalog/gcUnknownF63A8D.png)

### gcUnknownF63AC8

51 bytes compressed, 128 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF63AC8](catalog/gcUnknownF63AC8.png)

### gcUnknownF63AFB

62 bytes compressed, 128 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF63AFB](catalog/gcUnknownF63AFB.png)

### gcUnknownF63B39

55 bytes compressed, 128 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF63B39](catalog/gcUnknownF63B39.png)

### gcUnknownF63B70

62 bytes compressed, 128 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF63B70](catalog/gcUnknownF63B70.png)

### gcUnknownF63BAE

62 bytes compressed, 128 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF63BAE](catalog/gcUnknownF63BAE.png)

### gcUnknownF63BEC

31 bytes compressed, 128 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF63BEC](catalog/gcUnknownF63BEC.png)

### gcUnknownF676FE

13781 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF676FE](catalog/gcUnknownF676FE.png)
