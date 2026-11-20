SET startDir=%~dp0

SET as="%startDir%/tools/64tass"

REM Graphics: gfx\**\NAME.4bpp.png (indexed) to NAME.4bpp.
for /r "%startDir%gfx" %%f in (*.4bpp.png) do python "%startDir%tools\gfx.py" png2bpp "%%f" "%%~dpnf"
REM Compressed graphics: NAME.4bpp to NAME.4bpp.lz, keeping the original NAME.4bpp.comp while it matches.
for /r "%startDir%gfx" %%f in (*.4bpp.comp) do if exist "%%~dpnf" python "%startDir%tools\gfx.py" lz "%%~dpnf" "%%f" "%%~dpnf.lz"
REM Streams laid out across bank halves: LIST.streams to Layout.asm beside it.
for /r "%startDir%gfx" %%g in (*.streams) do python "%startDir%tools\stream_layout.py" "%%g" "%%~dpgLayout.asm"

%as% -x -f -C -a -Wall -o "FE4Disassembly.sfc" --vice-labels -l "labels.txt" "Build.asm" 1>"log.txt" 2>&1 -Wno-portable -Wno-shadow -Wno-deprecated

pause