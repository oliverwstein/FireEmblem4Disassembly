SET pd=%~dp0tools\process_dialogue.py
SET font=%~dp0text\dialogue\DialogueFont.txt

cd %~dp0text\dialogue

for /d %%f in (*.*) do (

	if %%f equ Convert (

	for %%t in (%%f\*.txt) do (
		python "%pd%" "%%t" "%font%" "%%f\%%~nt.dialogue.txt"
	)
	)

)

pause