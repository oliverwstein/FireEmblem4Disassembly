cd %~dp0text\dialogue

for /d %%f in (*.*) do (

	if %%f equ Convert (

	for %%t in (%%f\*.dialogue.txt) do (
		del %%t
	)
	)

)

pause