#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; Description
; these are numpad macros for VS Code
; could describe more here if neede, just ask me for now


; comments:
; + means shift
; ^ means ctrl
; ! means alt


#InstallKeybdHook ; for something idk
SendSuppressedKeyUp(key) {
    DllCall("keybd_event"
        , "char", GetKeyVK(key)
        , "char", GetKeySC(key)
        , "uint", KEYEVENTF_KEYUP := 0x2
        , "uptr", KEY_BLOCK_THIS := 0xFFC3D450)
}


; adding home and end by arrows by using alt instead of fn
;~LAlt::SendSuppressedKeyUp("LAlt")
!Left::send {Home}
!Right::send {End}

+!Left::send +{Home}
+!Right::send +{End}


;!Left::Home
;NumpadRight::End

;NumpadClear::^d
NumpadHome::!F12  ; NumpadEnd::!F12
NumpadPgUp::+F12
NumpadUp:: send ^d^f ; searches word

NumpadEnd:: send ^d^c
NumpadPgDn:: send ^d^v
NumpadDown:: send ^d+8


NumpadIns:: send !o ; switches between header and source file.

NumpadAdd::^+b ; builds the code
NumpadEnter::^F5 ; runs file

:?*:.-::-> ; turn double dot into arrow

NumpadDel:: send (millis() - ){Left} ; quicl write time comparison for coding

; fits colums to text and freezes top row in excel
; NumpadMult::send ^a^a!hoi!wfr

; for norwegian excel
; NumpadDiv::send ^a^a!hafi!ncr
; NumpadDiv::

; Shift + Wheel for horizontal scrolling
+WheelDown::WheelRight

+WheelUp::WheelLeft


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





; sonme testing
NumpadDiv::
	data := "Code Mode"
	DisplayTextOnScreen(data)
	return

NumpadMult::
	data := "Misc Mode"
	DisplayTextOnScreen(data)
	return

; function to display some text on screen
DisplayTextOnScreen(data) {
	SetTimer, modeTextTimer, 1000
	; https://www.autohotkey.com/boards/viewtopic.php?p=395842#p395842
	Gui, -Caption +AlwaysOnTop +Owner +LastFound +E0x20
	WinSet, TransColor, 1
	Gui, Color, 1
	Gui, Font, c00FF00 s30 w700 q4, Times New Roman
	Gui, Add, Text,, % data
	Gui, Show, Xcenter Y50 NA
	return
}

; Make it alsways possible to disable GUI
^Esc::Gui, Destroy

; triggered by GUI timer to remove GUI text
modeTextTimer:
	Gui, Destroy
	SetTimer, modeTextTimer, off
	return
