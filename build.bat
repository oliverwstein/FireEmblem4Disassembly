SET startDir=%~dp0

SET as="%startDir%/tools/64tass"

REM Graphics: gfx\**\NAME.4bpp.png (indexed) to NAME.4bpp.
for /r "%startDir%gfx" %%f in (*.4bpp.png) do python "%startDir%tools\gfx.py" png2bpp "%%f" "%%~dpnf"

%as% -x -f -C -a -Wall -o "FE4Disassembly.sfc" --vice-labels -l "labels.txt" "Build.asm" 1>"log.txt" 2>&1 -Wno-portable -Wno-shadow -Wno-deprecated

pause