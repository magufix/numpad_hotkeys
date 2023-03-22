#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; comments:
; + means shift
; ^ means ctrl
; ! means alt


; open a random meme
; change the dirpath to whatever folder your memes are in
memeFunc()
{
	FileList := ""  ; Initialize to be blank.
	listSize := 0
	memePath := ""
	dirPath := "C:\Users\mfh\Pictures\memes"

	Loop, %dirPath%\*.*
	{
	    FileList .= A_LoopFileLongPath "`n" ;A_LoopFileName "`n"
	    ++listSize
	}
	--listSize
	Random, rand, 0, listSize
	Loop, parse, FileList, `n
	{
    		if (A_LoopField = "")  ; Ignore the blank item at the end of the list.
    		    continue

		if (A_Index = rand)
		{
			memePath = %A_LoopField%
			;MsgBox, 4,, File number %memePath% is %listSize%. rand is %rand%  Continue?
			break
		}
	}
	
	Run %memePath%

	;MsgBox, 4,, File number "%memePath%" is file.  Continue?"
	
}

; choose a button to press to call the function
NumpadLeft::memeFunc()