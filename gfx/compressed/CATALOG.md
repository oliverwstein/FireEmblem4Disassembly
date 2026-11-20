# Unidentified compressed streams

Made by `tools/stream_catalog.py`; do not edit. These streams are carved
(labelled, and placed by the build) but not identified: each is still the
ROM's bytes, `gcUnknownADDR.comp`. When the code that uses one is read, give it
a real name and format (a PNG if it is graphics) and run the tool again.

Previews draw the decompressed bytes as 4bpp tiles, 16 across, in grey. That
is only a first look: a stream may be 2bpp graphics, a tilemap, or other data.

243 streams.

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
- `rlUnknown9ED2B5` (engine/unsorted/bank9E.asm:10606): `lda #(`gcUnknownACCC17)<<8`
- `rlProcUnknown9ED441Cycle1` (engine/unsorted/bank9E.asm:11094): `lda #(`gcUnknownACCC17)<<8`
- `rlProcUnknown9EF837Cycle1` (engine/events/cutscenes.asm:472): `lda #(`gcUnknownACCC17)<<8`

![gcUnknownACCC17](catalog/gcUnknownACCC17.png)

## Region $C00A2B

### gcUnknownC00A2B

3920 bytes compressed, 6144 decompressed.
- `rlUnknown80B0D3` (engine/unsorted/bank80.asm:4464): `lda #(`gcUnknownC00A2B)<<8`
- Entry `aUnknown80E53D` (engine/unsorted/bank80.asm:6978): $1800 bytes to VRAM $4000; used by `rsUnknown80E4EB` (engine/unsorted/bank80.asm:6940).
- `rlUnknown9EA155` (engine/unsorted/bank9E.asm:5372): `lda #(`gcUnknownC00A2B)<<8`
- Entry `aUnknown80E13E` (engine/menus/revive_screen.asm:218): $1800 bytes to VRAM $0000; used by `rsUnknown80E0AE` (engine/menus/revive_screen.asm:154).
- Entry `aDataWindowDecompressionList` (engine/menus/data_window.asm:183): $1800 bytes to VRAM $0000; used by `rsDataWindowLoadGraphics` (engine/menus/data_window.asm:130).
- Entry `aUnknown8AE4BB` (engine/arena/arena.asm:26): $1800 bytes to VRAM $4000; used by `rlUnknown8AE2F8` (engine/unsorted/bank8A.asm:11842).
- Entry `aDecompressionDMAEntry80B0CB` (build.asm:759): $1800 bytes to VRAM $4000; used by `rlUnknown80B0BC` (engine/unsorted/bank80.asm:4437).
- Entry `aDecompressionDMAEntry80B99D` (build.asm:885): $1800 bytes to VRAM $4000; used by `rlUnknown80B827` (engine/unsorted/bank80.asm:5356).
- Entry `aDecompressionDMAEntry80BB45` (build.asm:929): $1800 bytes to VRAM $4000; used by `rlUnknown80BA52` (engine/unsorted/bank80.asm:5667).
- Entry `aDecompressionDMAEntry80BEF9` (build.asm:960): $1800 bytes to VRAM $4000; used by `rlUnknown80BD27` (engine/unsorted/bank80.asm:6043).
- Entry `aDecompressionDMAEntry80C5BE` (build.asm:1033): $1800 bytes to VRAM $4000; used by `rsUnitWindowCopyGraphics` (engine/menus/unit_window.asm:192).
- Entry `aDecompressionDMAEntry80CE8E` (build.asm:1111): $1800 bytes to VRAM $0000; used by `rsItemWindowCopyGraphics` (engine/menus/item_window.asm:128).
- Entry `aDecompressionDMAEntry80D41D` (build.asm:1162): $1800 bytes to VRAM $0000; used by `rsSkillWindowCopyGraphics` (engine/menus/skill_window.asm:128).
- Entry `aDecompressionDMAEntry80E72E` (build.asm:1229): $1800 bytes to VRAM $0000; used by `rsUnknown80E6C9` (engine/unsorted/bank80.asm:7165).
- Entry `aDecompressionDMAEntry8A8F58` (build.asm:7975): $1800 bytes to VRAM $4000; used by `rsUnknown8A8E08` (engine/unsorted/bank8A.asm:2395).
- Entry `aDecompressionDMAEntry8ABE4B` (build.asm:8486): $1800 bytes to VRAM $4000; used by `rlUnknown8ABCF8` (engine/unsorted/bank8A.asm:7571).
- Entry `aDecompressionDMAEntry8AD952` (build.asm:8741): $1800 bytes to VRAM $4000; used by `rlUnknown8AD81B` (engine/unsorted/bank8A.asm:10354).
- Entry `aDecompressionDMAEntry8AEE89` (build.asm:8959): $1800 bytes to VRAM $4000; used by `rlUnknown8AECEF` (engine/unsorted/bank8A.asm:12036).
- Entry `aDecompressionDMAEntry8AF263` (build.asm:9007): $1800 bytes to VRAM $4000; used by `rlUnknown8AF0F2` (engine/unsorted/bank8A.asm:12589).
- Entry `aDecompressionDMAEntry8AFA0C` (build.asm:9061): $1800 bytes to VRAM $4000; used by `rlUnknown8AF894` (engine/unsorted/bank8A.asm:13666).

![gcUnknownC00A2B](catalog/gcUnknownC00A2B.png)

### gcUnknownC0197B

1599 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry80B0FD` (build.asm:774): $0800 bytes to VRAM $4C00; used by `rlUnknown80B0EE` (engine/unsorted/bank80.asm:4487).

![gcUnknownC0197B](catalog/gcUnknownC0197B.png)

### gcUnknownC01FBA

764 bytes compressed, 1024 decompressed.
- Entry `aDecompressionDMAEntry80B09B` (build.asm:744): $0400 bytes to VRAM $3400; used by `rlUnknown80B08C` (engine/events/event_scripts.asm:4811).

![gcUnknownC01FBA](catalog/gcUnknownC01FBA.png)

### gcUnknownC022B6

652 bytes compressed, 1440 decompressed.
- Entry `aDecompressionDMAEntry85D669` (build.asm:4249): $0800 bytes to VRAM $4C00; used by `rlUnknown85D65A` (engine/unsorted/bank85.asm:12859).

![gcUnknownC022B6](catalog/gcUnknownC022B6.png)

### gcUnknownC02542

580 bytes compressed, 1024 decompressed.
- Entry `aDecompressionDMAEntry80B084` (build.asm:729): $0400 bytes to VRAM $3600; used by `rsUnknown80B065` (engine/events/event_scripts.asm:4782).

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
- Entry `aDecompressionDMAEntry80B61E` (build.asm:810): $6000 bytes to VRAM $0000; used by `rlUnknown80B452` (engine/unsorted/bank80.asm:4821).

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
- Entry `aDecompressionDMAEntry80B626` (build.asm:811): $1000 bytes to VRAM $3000; used by `rlUnknown80B452` (engine/unsorted/bank80.asm:4859).

![gcUnknownD13D09](catalog/gcUnknownD13D09.png)

### gcUnknownD1432E

71 bytes compressed, 256 decompressed.
- Entry `aDecompressionDMAEntry80B62E` (build.asm:812): $0100 bytes to VRAM $4000; used by `rlUnknown80B452` (engine/unsorted/bank80.asm:4876).

![gcUnknownD1432E](catalog/gcUnknownD1432E.png)

### gcUnknownD14375

281 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry80B636` (build.asm:813): $0800 bytes to VRAM $6000; used by `rlUnknown80B452` (engine/unsorted/bank80.asm:4885).

![gcUnknownD14375](catalog/gcUnknownD14375.png)

### gcUnknownD1448E

5418 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD1448E](catalog/gcUnknownD1448E.png)

### gcUnknownD159B8

328 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD159B8](catalog/gcUnknownD159B8.png)

### gcUnknownD15B00

365 bytes compressed, 704 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD15B00](catalog/gcUnknownD15B00.png)

### gcUnknownD15C6D

5974 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD15C6D](catalog/gcUnknownD15C6D.png)

### gcUnknownD173C3

397 bytes compressed, 704 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD173C3](catalog/gcUnknownD173C3.png)

### gcUnknownD17550

1841 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD17550](catalog/gcUnknownD17550.png)

### gcUnknownD17C81

4182 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD17C81](catalog/gcUnknownD17C81.png)

### gcUnknownD20CD7

264 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD20CD7](catalog/gcUnknownD20CD7.png)

### gcUnknownD20DDF

276 bytes compressed, 704 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD20DDF](catalog/gcUnknownD20DDF.png)

### gcUnknownD20EF3

1392 bytes compressed, 8192 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD20EF3](catalog/gcUnknownD20EF3.png)

### gcUnknownD21463

3325 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD21463](catalog/gcUnknownD21463.png)

### gcUnknownD22160

273 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD22160](catalog/gcUnknownD22160.png)

### gcUnknownD22271

447 bytes compressed, 704 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD22271](catalog/gcUnknownD22271.png)

### gcUnknownD22430

2011 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8ABF0F` (build.asm:8503): $1000 bytes to VRAM $0000; used by `rsUnknown8ABE63` (engine/unsorted/bank8A.asm:7681).

![gcUnknownD22430](catalog/gcUnknownD22430.png)

### gcUnknownD22C0B

5285 bytes compressed, 8192 decompressed.
- Entry `aDecompressionDMAEntry8AEE99` (build.asm:8961): $2000 bytes to VRAM $1000; used by `rlUnknown8AECEF` (engine/unsorted/bank8A.asm:12009).

![gcUnknownD22C0B](catalog/gcUnknownD22C0B.png)

### gcUnknownD240B0

2148 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8AEE91` (build.asm:8960): $1000 bytes to VRAM $0000; used by `rlUnknown8AECEF` (engine/unsorted/bank8A.asm:12004).

![gcUnknownD240B0](catalog/gcUnknownD240B0.png)

### gcUnknownD24914

912 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry8AEEA1` (build.asm:8962): $0800 bytes to VRAM $2800; used by `rlUnknown8AECEF` (engine/unsorted/bank8A.asm:12022).

![gcUnknownD24914](catalog/gcUnknownD24914.png)

### gcUnknownD24CA4

7509 bytes compressed, 8192 decompressed.
- Entry `aDecompressionDMAEntry8AFA1C` (build.asm:9063): $2000 bytes to VRAM $1000; used by `rlUnknown8AF894` (engine/unsorted/bank8A.asm:13643).

![gcUnknownD24CA4](catalog/gcUnknownD24CA4.png)

### gcUnknownD269F9

2240 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8AFA14` (build.asm:9062): $1000 bytes to VRAM $0000; used by `rlUnknown8AF894` (engine/unsorted/bank8A.asm:13638).

![gcUnknownD269F9](catalog/gcUnknownD269F9.png)

### gcUnknownD272B9

995 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry8AFA24` (build.asm:9064): $0800 bytes to VRAM $2800; used by `rlUnknown8AF894` (engine/unsorted/bank8A.asm:13652).

![gcUnknownD272B9](catalog/gcUnknownD272B9.png)

### gcUnknownD2769C

2174 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8ABF1F` (build.asm:8505): $1000 bytes to VRAM $0000; used by `rsUnknown8ABE63` (engine/unsorted/bank8A.asm:7737).

![gcUnknownD2769C](catalog/gcUnknownD2769C.png)

### gcUnknownD27F1A

1980 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8ABF17` (build.asm:8504): $1000 bytes to VRAM $0000; used by `rsUnknown8ABE63` (engine/unsorted/bank8A.asm:7709).

![gcUnknownD27F1A](catalog/gcUnknownD27F1A.png)

### gcUnknownD306D6

2174 bytes compressed, 4096 decompressed.
- Entry `aUnknown8AE4C3` (engine/arena/arena.asm:32): $1000 bytes to VRAM $0000; used by `rlUnknown8AE2F8` (engine/unsorted/bank8A.asm:11815).

![gcUnknownD306D6](catalog/gcUnknownD306D6.png)

### gcUnknownD30F54

2124 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8AF26B` (build.asm:9008): $1000 bytes to VRAM $0000; used by `rlUnknown8AF0F2` (engine/unsorted/bank8A.asm:12562).

![gcUnknownD30F54](catalog/gcUnknownD30F54.png)

### gcUnknownD317A0

5419 bytes compressed, 8192 decompressed.
- Entry `aDecompressionDMAEntry80EFB0` (build.asm:1289): $2000 bytes to VRAM $2000; used by `rlUnknown80EE37` (engine/unsorted/bank80.asm:7597).

![gcUnknownD317A0](catalog/gcUnknownD317A0.png)

### gcUnknownD32CCB

965 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry80EFC0` (build.asm:1291): $1000 bytes to VRAM $6000; used by `rlUnknown80EE37` (engine/unsorted/bank80.asm:7617).

![gcUnknownD32CCB](catalog/gcUnknownD32CCB.png)

### gcUnknownD33090

1317 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry80EFC8` (build.asm:1292): $1000 bytes to VRAM $5000; used by `rlUnknown80EE37` (engine/unsorted/bank80.asm:7607).

![gcUnknownD33090](catalog/gcUnknownD33090.png)

### gcUnknownD335B5

2373 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry80EFD0` (build.asm:1293): $1000 bytes to VRAM $5800; used by `rlUnknown80EE37` (engine/unsorted/bank80.asm:7612).

![gcUnknownD335B5](catalog/gcUnknownD335B5.png)

### gcUnknownD33EFA

7238 bytes compressed, 8192 decompressed.
- Entry `aDecompressionDMAEntry80BB55` (build.asm:931): $2000 bytes to VRAM $1000; used by `rlUnknown80BA52` (engine/unsorted/bank80.asm:5672).

![gcUnknownD33EFA](catalog/gcUnknownD33EFA.png)

### gcUnknownD35B40

884 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry80BB4D` (build.asm:930): $0800 bytes to VRAM $5400; used by `rlUnknown80BA52` (engine/unsorted/bank80.asm:5677).

![gcUnknownD35B40](catalog/gcUnknownD35B40.png)

### gcUnknownD35EB4

17210 bytes compressed, 22528 decompressed.
- Entry `aDecompressionDMAEntry80F197` (build.asm:1310): $5800 bytes to VRAM $0000; used by `rlUnknown80EFD8` (engine/unsorted/bank80.asm:7800).
- Entry `aDecompressionDMAEntry8DAF95` (build.asm:10309): $3000 bytes to VRAM $0000; used by `rlUnknown8DAF33` (engine/unsorted/bank8D.asm:1354).

![gcUnknownD35EB4](catalog/gcUnknownD35EB4.png)

### gcUnknownD421EE

133 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry8DAF9D` (build.asm:10310): $0800 bytes to VRAM $5800; used by `rlUnknown8DAF33` (engine/unsorted/bank8D.asm:1359).

![gcUnknownD421EE](catalog/gcUnknownD421EE.png)

### gcUnknownD42273

1605 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry8DB066` (build.asm:10327): $1000 bytes to VRAM $4000; used by `rlUnknown8DAFA5` (engine/unsorted/bank8D.asm:1420).

![gcUnknownD42273](catalog/gcUnknownD42273.png)

### gcUnknownD428B8

318 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry8DB05E` (build.asm:10326): $0800 bytes to VRAM $6800; used by nothing named.

![gcUnknownD428B8](catalog/gcUnknownD428B8.png)

### gcUnknownD429F6

602 bytes compressed, 2048 decompressed.
- Entry `aDecompressionDMAEntry8DB056` (build.asm:10325): $0800 bytes to VRAM $5800; used by `rlUnknown8DAFA5` (engine/unsorted/bank8D.asm:1415).

![gcUnknownD429F6](catalog/gcUnknownD429F6.png)

### gcUnknownD42C50

1970 bytes compressed, 4096 decompressed.
- Entry `aDecompressionDMAEntry80F19F` (build.asm:1311): $1000 bytes to VRAM $5800; used by `rlUnknown80EFD8` (engine/unsorted/bank80.asm:7805).

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

### gcUnknownD4499C

6316 bytes compressed, 12288 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD4499C](catalog/gcUnknownD4499C.png)

### gcUnknownD46248

58 bytes compressed, 1792 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD46248](catalog/gcUnknownD46248.png)

### gcUnknownD46282

132 bytes compressed, 1792 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD46282](catalog/gcUnknownD46282.png)

### gcUnknownD46306

131 bytes compressed, 1792 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD46306](catalog/gcUnknownD46306.png)

### gcUnknownD46389

134 bytes compressed, 1792 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD46389](catalog/gcUnknownD46389.png)

### gcUnknownD4640F

198 bytes compressed, 1792 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD4640F](catalog/gcUnknownD4640F.png)

### gcUnknownD464D5

147 bytes compressed, 1792 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD464D5](catalog/gcUnknownD464D5.png)

### gcUnknownD46568

264 bytes compressed, 1792 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD46568](catalog/gcUnknownD46568.png)

### gcUnknownD46670

33 bytes compressed, 1792 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD46670](catalog/gcUnknownD46670.png)

### gcUnknownD46691

350 bytes compressed, 2048 decompressed.
- Entry `aUnknown8AE4CB` (engine/arena/arena.asm:38): $0800 bytes to VRAM $2800; used by `rlUnknown8AE2F8` (engine/unsorted/bank8A.asm:11828).
- Entry `aDecompressionDMAEntry8ABE53` (build.asm:8487): $0800 bytes to VRAM $2800; used by `rlUnknown8ABCF8` (engine/unsorted/bank8A.asm:7557).
- Entry `aDecompressionDMAEntry8AF273` (build.asm:9009): $0800 bytes to VRAM $2800; used by `rlUnknown8AF0F2` (engine/unsorted/bank8A.asm:12575).

![gcUnknownD46691](catalog/gcUnknownD46691.png)

### gcUnknownD467EF

180 bytes compressed, 2048 decompressed.
- Entry `aUnknown8AE4D3` (engine/arena/arena.asm:44): $0800 bytes to VRAM $2C00; used by `rlUnknown8AE2F8` (engine/unsorted/bank8A.asm:11833).
- Entry `aDecompressionDMAEntry8ABE5B` (build.asm:8488): $0800 bytes to VRAM $2C00; used by `rlUnknown8ABCF8` (engine/unsorted/bank8A.asm:7562).
- Entry `aDecompressionDMAEntry8AEEA9` (build.asm:8963): $0800 bytes to VRAM $2C00; used by `rlUnknown8AECEF` (engine/unsorted/bank8A.asm:12027).
- Entry `aDecompressionDMAEntry8AF27B` (build.asm:9010): $0800 bytes to VRAM $2C00; used by `rlUnknown8AF0F2` (engine/unsorted/bank8A.asm:12580).
- Entry `aDecompressionDMAEntry8AFA2C` (build.asm:9065): $0800 bytes to VRAM $2C00; used by `rlUnknown8AF894` (engine/unsorted/bank8A.asm:13657).

![gcUnknownD467EF](catalog/gcUnknownD467EF.png)

## Region $D50000

### gcUnknownD531ED

381 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD531ED](catalog/gcUnknownD531ED.png)

### gcUnknownD5336A

370 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD5336A](catalog/gcUnknownD5336A.png)

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

### gcUnknownD53700

397 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD53700](catalog/gcUnknownD53700.png)

### gcUnknownD5388D

369 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD5388D](catalog/gcUnknownD5388D.png)

### gcUnknownD539FE

370 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD539FE](catalog/gcUnknownD539FE.png)

### gcUnknownD53B70

399 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD53B70](catalog/gcUnknownD53B70.png)

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

### gcUnknownD53ECD

379 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD53ECD](catalog/gcUnknownD53ECD.png)

### gcUnknownD54048

379 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54048](catalog/gcUnknownD54048.png)

### gcUnknownD541C3

365 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD541C3](catalog/gcUnknownD541C3.png)

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

### gcUnknownD54481

369 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54481](catalog/gcUnknownD54481.png)

### gcUnknownD545F2

370 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD545F2](catalog/gcUnknownD545F2.png)

### gcUnknownD54764

362 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54764](catalog/gcUnknownD54764.png)

### gcUnknownD548CE

72 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD548CE](catalog/gcUnknownD548CE.png)

### gcUnknownD54916

39 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54916](catalog/gcUnknownD54916.png)

### gcUnknownD5493D

369 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD5493D](catalog/gcUnknownD5493D.png)

### gcUnknownD54AAE

369 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54AAE](catalog/gcUnknownD54AAE.png)

### gcUnknownD54C1F

370 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54C1F](catalog/gcUnknownD54C1F.png)

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

### gcUnknownD54FBF

370 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD54FBF](catalog/gcUnknownD54FBF.png)

### gcUnknownD55131

381 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD55131](catalog/gcUnknownD55131.png)

### gcUnknownD552AE

370 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD552AE](catalog/gcUnknownD552AE.png)

### gcUnknownD55420

370 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD55420](catalog/gcUnknownD55420.png)

### gcUnknownD55592

370 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD55592](catalog/gcUnknownD55592.png)

### gcUnknownD55704

370 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD55704](catalog/gcUnknownD55704.png)

### gcUnknownD55876

369 bytes compressed, 512 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD55876](catalog/gcUnknownD55876.png)

### gcUnknownD559E7

407 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD559E7](catalog/gcUnknownD559E7.png)

### gcUnknownD55B7E

256 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD55B7E](catalog/gcUnknownD55B7E.png)

### gcUnknownD55C7E

999 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD55C7E](catalog/gcUnknownD55C7E.png)

### gcUnknownD56065

497 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD56065](catalog/gcUnknownD56065.png)

### gcUnknownD56256

689 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD56256](catalog/gcUnknownD56256.png)

### gcUnknownD56507

677 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD56507](catalog/gcUnknownD56507.png)

### gcUnknownD567AC

204 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD567AC](catalog/gcUnknownD567AC.png)

### gcUnknownD56878

230 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD56878](catalog/gcUnknownD56878.png)

### gcUnknownD5695E

617 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD5695E](catalog/gcUnknownD5695E.png)

### gcUnknownD56BC7

182 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD56BC7](catalog/gcUnknownD56BC7.png)

### gcUnknownD56C7D

186 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD56C7D](catalog/gcUnknownD56C7D.png)

### gcUnknownD56D37

1298 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD56D37](catalog/gcUnknownD56D37.png)

### gcUnknownD57249

531 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD57249](catalog/gcUnknownD57249.png)

### gcUnknownD5745C

764 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD5745C](catalog/gcUnknownD5745C.png)

### gcUnknownD57758

604 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD57758](catalog/gcUnknownD57758.png)

### gcUnknownD579B4

120 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD579B4](catalog/gcUnknownD579B4.png)

### gcUnknownD57A2C

111 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD57A2C](catalog/gcUnknownD57A2C.png)

### gcUnknownD57A9B

181 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD57A9B](catalog/gcUnknownD57A9B.png)

### gcUnknownD57B50

2190 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD57B50](catalog/gcUnknownD57B50.png)

### gcUnknownD603DE

1979 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD603DE](catalog/gcUnknownD603DE.png)

### gcUnknownD60B99

38 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD60B99](catalog/gcUnknownD60B99.png)

### gcUnknownD60BBF

388 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD60BBF](catalog/gcUnknownD60BBF.png)

### gcUnknownD60D43

2582 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD60D43](catalog/gcUnknownD60D43.png)

### gcUnknownD61759

72 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD61759](catalog/gcUnknownD61759.png)

### gcUnknownD617A1

154 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD617A1](catalog/gcUnknownD617A1.png)

### gcUnknownD6183B

471 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD6183B](catalog/gcUnknownD6183B.png)

### gcUnknownD61A12

497 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD61A12](catalog/gcUnknownD61A12.png)

### gcUnknownD61C03

177 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD61C03](catalog/gcUnknownD61C03.png)

### gcUnknownD61CB4

184 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD61CB4](catalog/gcUnknownD61CB4.png)

### gcUnknownD61D6C

184 bytes compressed, 2048 decompressed.
- `rlUnknown9F850B` (engine/unsorted/bank9F.asm:632): `lda #(`gcUnknownD61D6C)<<8`

![gcUnknownD61D6C](catalog/gcUnknownD61D6C.png)

### gcUnknownD61E24

171 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD61E24](catalog/gcUnknownD61E24.png)

### gcUnknownD61ECF

171 bytes compressed, 2048 decompressed.
- `rlUnknown9F850B` (engine/unsorted/bank9F.asm:618): `lda #(`gcUnknownD61ECF)<<8`

![gcUnknownD61ECF](catalog/gcUnknownD61ECF.png)

### gcUnknownD61F7A

174 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD61F7A](catalog/gcUnknownD61F7A.png)

### gcUnknownD62028

166 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD62028](catalog/gcUnknownD62028.png)

### gcUnknownD620CE

353 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD620CE](catalog/gcUnknownD620CE.png)

### gcUnknownD6222F

135 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD6222F](catalog/gcUnknownD6222F.png)

### gcUnknownD622B6

166 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD622B6](catalog/gcUnknownD622B6.png)

### gcUnknownD6235C

527 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD6235C](catalog/gcUnknownD6235C.png)

### gcUnknownD6256B

272 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD6256B](catalog/gcUnknownD6256B.png)

### gcUnknownD6267B

237 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD6267B](catalog/gcUnknownD6267B.png)

### gcUnknownD62768

154 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD62768](catalog/gcUnknownD62768.png)

### gcUnknownD62802

129 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD62802](catalog/gcUnknownD62802.png)

### gcUnknownD62883

135 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD62883](catalog/gcUnknownD62883.png)

### gcUnknownD6290A

167 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD6290A](catalog/gcUnknownD6290A.png)

### gcUnknownD629B1

684 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD629B1](catalog/gcUnknownD629B1.png)

### gcUnknownD62C5D

623 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD62C5D](catalog/gcUnknownD62C5D.png)

### gcUnknownD62ECC

109 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD62ECC](catalog/gcUnknownD62ECC.png)

### gcUnknownD62F39

183 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD62F39](catalog/gcUnknownD62F39.png)

### gcUnknownD62FF0

636 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD62FF0](catalog/gcUnknownD62FF0.png)

### gcUnknownD6326C

383 bytes compressed, 2048 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD6326C](catalog/gcUnknownD6326C.png)

### gcUnknownD633EB

556 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD633EB](catalog/gcUnknownD633EB.png)

### gcUnknownD63617

278 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD63617](catalog/gcUnknownD63617.png)

### gcUnknownD6372D

397 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD6372D](catalog/gcUnknownD6372D.png)

### gcUnknownD638BA

518 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD638BA](catalog/gcUnknownD638BA.png)

### gcUnknownD63AC0

223 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD63AC0](catalog/gcUnknownD63AC0.png)

### gcUnknownD63B9F

697 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD63B9F](catalog/gcUnknownD63B9F.png)

### gcUnknownD63E58

566 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD63E58](catalog/gcUnknownD63E58.png)

### gcUnknownD6408E

438 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD6408E](catalog/gcUnknownD6408E.png)

### gcUnknownD64244

410 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD64244](catalog/gcUnknownD64244.png)

### gcUnknownD643DE

277 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD643DE](catalog/gcUnknownD643DE.png)

### gcUnknownD644F3

474 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD644F3](catalog/gcUnknownD644F3.png)

### gcUnknownD646CD

615 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD646CD](catalog/gcUnknownD646CD.png)

### gcUnknownD64934

698 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD64934](catalog/gcUnknownD64934.png)

### gcUnknownD64BEE

352 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD64BEE](catalog/gcUnknownD64BEE.png)

### gcUnknownD64D4E

706 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD64D4E](catalog/gcUnknownD64D4E.png)

### gcUnknownD65010

323 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD65010](catalog/gcUnknownD65010.png)

### gcUnknownD65153

111 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD65153](catalog/gcUnknownD65153.png)

### gcUnknownD651C2

567 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD651C2](catalog/gcUnknownD651C2.png)

### gcUnknownD653F9

594 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD653F9](catalog/gcUnknownD653F9.png)

### gcUnknownD6564B

133 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD6564B](catalog/gcUnknownD6564B.png)

### gcUnknownD656D0

608 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD656D0](catalog/gcUnknownD656D0.png)

### gcUnknownD65930

713 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD65930](catalog/gcUnknownD65930.png)

### gcUnknownD65BF9

788 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD65BF9](catalog/gcUnknownD65BF9.png)

### gcUnknownD676F6

243 bytes compressed, 1024 decompressed.
- `rlUnknown9E9D3B` (engine/unsorted/bank9E.asm:4706): `lda #(`gcUnknownD676F6)<<8`

![gcUnknownD676F6](catalog/gcUnknownD676F6.png)

### gcUnknownD677E9

87 bytes compressed, 2048 decompressed.
- `rlUnknown9E9D3B` (engine/unsorted/bank9E.asm:4718): `lda #(`gcUnknownD677E9)<<8`

![gcUnknownD677E9](catalog/gcUnknownD677E9.png)

### gcUnknownD67840

324 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD67840](catalog/gcUnknownD67840.png)

### gcUnknownD67984

578 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD67984](catalog/gcUnknownD67984.png)

### gcUnknownD67BC6

257 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD67BC6](catalog/gcUnknownD67BC6.png)

### gcUnknownD67CC7

182 bytes compressed, 1024 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownD67CC7](catalog/gcUnknownD67CC7.png)

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
- Entry `aDecompressionDMAEntry80F187` (build.asm:1308): $1200 bytes to VRAM $3000; used by `rlUnknown80EFD8` (engine/unsorted/bank80.asm:7790).
- Entry `aDecompressionDMAEntry80F433` (build.asm:1376): $1200 bytes to VRAM $4000; used by `rsUnknown80F392` (engine/unsorted/bank80.asm:8253).

![gcUnknownDD20A0](catalog/gcUnknownDD20A0.png)

### gcUnknownDD2CEE

162 bytes compressed, 1792 decompressed.
- Entry `aUnknown80E14E` (engine/menus/revive_screen.asm:228): $0700 bytes to VRAM $1800; used by `rsUnknown80E0AE` (engine/menus/revive_screen.asm:198).

![gcUnknownDD2CEE](catalog/gcUnknownDD2CEE.png)

### gcUnknownDD2D90

699 bytes compressed, 2048 decompressed.
- Entry `aUnknown80E156` (engine/menus/revive_screen.asm:233): $0800 bytes to VRAM $2000; used by `rsUnknown80E0AE` (engine/menus/revive_screen.asm:203).
- Entry `aDecompressionDMAEntry80F18F` (build.asm:1309): $0800 bytes to VRAM $5000; used by `rlUnknown80EFD8` (engine/unsorted/bank80.asm:7795).
- Entry `aDecompressionDMAEntry80F43B` (build.asm:1377): $0800 bytes to VRAM $6000; used by `rsUnknown80F392` (engine/unsorted/bank80.asm:8301).

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
- Entry `aDecompressionDMAEntry80E736` (build.asm:1230): $0800 bytes to VRAM $4200; used by `rsUnknown80E6C9` (engine/unsorted/bank80.asm:7182).

![gcUnknownDD3932](catalog/gcUnknownDD3932.png)

### gcUnknownDD3BDE

262 bytes compressed, 1792 decompressed.
- Entry `aDecompressionDMAEntry80E73E` (build.asm:1231): $0700 bytes to VRAM $2000; used by `rsUnknown80E6C9` (engine/unsorted/bank80.asm:7197).

![gcUnknownDD3BDE](catalog/gcUnknownDD3BDE.png)

### gcUnknownDD3CE4

220 bytes compressed, 1792 decompressed.
- Entry `aDecompressionDMAEntry80D425` (build.asm:1163): $0700 bytes to VRAM $1800; used by `rsSkillWindowCopyGraphics` (engine/menus/skill_window.asm:161).

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
- Entry `aUnknown80E545` (engine/unsorted/bank80.asm:6983): $0800 bytes to VRAM $6000; used by `rsUnknown80E4EB` (engine/unsorted/bank80.asm:6966).
- Entry `aDecompressionDMAEntry80CE96` (build.asm:1112): $0800 bytes to VRAM $2800; used by `rsItemWindowCopyGraphics` (engine/menus/item_window.asm:173).
- Entry `aDecompressionDMAEntry80D42D` (build.asm:1164): $0800 bytes to VRAM $2000; used by `rsSkillWindowCopyGraphics` (engine/menus/skill_window.asm:166).

![gcUnknownDD3F20](catalog/gcUnknownDD3F20.png)

### gcUnknownDD3FA6

8952 bytes compressed, 16384 decompressed.
- Entry `aDecompressionDMAEntry80F42B` (build.asm:1375): $4000 bytes to VRAM $0000; used by `rsUnknown80F392` (engine/unsorted/bank80.asm:8248).

![gcUnknownDD3FA6](catalog/gcUnknownDD3FA6.png)

### gcUnknownDD629E

951 bytes compressed, 2304 decompressed.
- `rsUnknown80F392` (engine/unsorted/bank80.asm:8280): `lda #(`gcUnknownDD629E)<<8`

![gcUnknownDD629E](catalog/gcUnknownDD629E.png)

## Region $DF3192

### gcUnknownDF3192

13295 bytes compressed, 16384 decompressed.
- Entry `aDecompressionDMAEntry80EFA8` (build.asm:1288): $4000 bytes to VRAM $0000; used by `rlUnknown80EE37` (engine/unsorted/bank80.asm:7592).

![gcUnknownDF3192](catalog/gcUnknownDF3192.png)

### gcUnknownDF6581

1024 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownDF6581](catalog/gcUnknownDF6581.png)

### gcUnknownDF6981

1657 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownDF6981](catalog/gcUnknownDF6981.png)

### gcUnknownDF6FFA

4094 bytes compressed, 7488 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownDF6FFA](catalog/gcUnknownDF6FFA.png)

## Region $F623D3

### gcUnknownF623D3

5721 bytes compressed, 7200 decompressed.
- Entry `aDecompressionDMAEntry80EFB8` (build.asm:1290): $2000 bytes to VRAM $3000; used by `rlUnknown80EE37` (engine/unsorted/bank80.asm:7602).

![gcUnknownF623D3](catalog/gcUnknownF623D3.png)

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

### gcUnknownF63C0B

1105 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF63C0B](catalog/gcUnknownF63C0B.png)

### gcUnknownF6405C

1135 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF6405C](catalog/gcUnknownF6405C.png)

### gcUnknownF644CB

718 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF644CB](catalog/gcUnknownF644CB.png)

### gcUnknownF64799

12133 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF64799](catalog/gcUnknownF64799.png)

### gcUnknownF676FE

13781 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF676FE](catalog/gcUnknownF676FE.png)

### gcUnknownF72CD3

1225 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF72CD3](catalog/gcUnknownF72CD3.png)

### gcUnknownF7319C

10488 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF7319C](catalog/gcUnknownF7319C.png)

### gcUnknownF75A94

1053 bytes compressed, 4096 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF75A94](catalog/gcUnknownF75A94.png)

### gcUnknownF75EB1

7447 bytes compressed, 16384 decompressed.
Nothing in the source names it (found between other streams).

![gcUnknownF75EB1](catalog/gcUnknownF75EB1.png)
