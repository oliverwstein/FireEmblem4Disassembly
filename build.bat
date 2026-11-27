SET startDir=%~dp0

SET as="%startDir%/tools/64tass"

REM Graphics: gfx\**\NAME.4bpp.png and NAME.2bpp.png (indexed) to NAME.4bpp, NAME.2bpp.
for /r "%startDir%gfx" %%f in (*.4bpp.png *.2bpp.png) do python "%startDir%tools\gfx.py" png2bpp "%%f" "%%~dpnf"
REM Portraits: gfx\portraits\NAME.png to NAME.4bpp.
python "%startDir%tools\portrait_pack.py" build
REM Scenes & backgrounds: gfx\scenes\**\*.scene.json to .4bpp/.2bpp + .bin tilemaps.
python "%startDir%tools\scene_pack.py" build
REM Compressed graphics: NAME.4bpp / NAME.2bpp to NAME.4bpp.lz / NAME.2bpp.lz, keeping the original NAME.*bpp.comp while it matches.
for /r "%startDir%gfx" %%f in (*.4bpp.comp *.2bpp.comp) do if exist "%%~dpnf" python "%startDir%tools\gfx.py" lz "%%~dpnf" "%%f" "%%~dpnf.lz"
REM Data written as source: chapter map CSVs and map battle sprite data (.asm) to NAME.bin.
python "%startDir%tools\chapter_maps.py" build
python "%startDir%tools\map_battle_layouts.py" build
REM Other compressed data (tilemaps and the like): NAME.bin to NAME.bin.lz, the same way.
for /r "%startDir%gfx" %%f in (*.bin.comp) do if exist "%%~dpnf" python "%startDir%tools\gfx.py" lz "%%~dpnf" "%%f" "%%~dpnf.lz"
for /r "%startDir%audio" %%f in (*.bin.comp) do if exist "%%~dpnf" python "%startDir%tools\gfx.py" lz "%%~dpnf" "%%f" "%%~dpnf.lz"
REM Streams laid out across bank halves: LIST.streams to Layout.asm beside it.
for /r "%startDir%gfx" %%g in (*.streams) do python "%startDir%tools\stream_layout.py" "%%g" "%%~dpgLayout.asm"

python "%startDir%tools\check_paths.py"
%as% -x -f -C -a -Wall -o "FE4Disassembly.sfc" --vice-labels -l "labels.txt" "build.asm" 1>"log.txt" 2>&1 -Wno-portable -Wno-shadow -Wno-deprecated
python "%startDir%tools\checksums.py" --verify "FE4Disassembly.sfc"

pause