cd %~dp0text\dialogue

for /r %%f in (*.dialogue.txt) do (
	del %%f
)

pause