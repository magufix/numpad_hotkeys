#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook ; for something idk
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

; How to do if statements
; if (this = that) 
; 	do this			; must be underneath if expression


; #### Always active ####
;~LAlt::SendSuppressedKeyUp("LAlt")

; adding home and end by arrows by using alt instead of fn
!Left::send {Home}		; alt + left  = home
!Right::send {End}		; alt + right = end

; makes it possible to also highlight text with the hotkeys above for home and end
+!Left::send +{Home}
+!Right::send +{End}

; Shift + Wheel for horizontal scrolling
+WheelDown::WheelRight
+WheelUp::WheelLeft


; ###### Mode Dependent Hotkeys #######

; Modes
; 0 = Code Mode
; 1 = Misc Mode
; 3 = idk yet

modeTracker := 0

; ####### Code Mode ######
#If modeTracker = 0
NumpadIns:: send !o 	; numpad 0 : switches between header and source file.
NumpadEnd:: send ^d^c 	; numpad 1 : copy word
NumpadDown:: send ^d+8	; numpad 2 : puts brackets around word
NumpadPgDn:: send ^d^v	; numpad 3 : paste word
; NumpadLeft:: 			; numpad 4 : display meme
; NumpadClear:: 		; numpad 5 : do nothing
NumpadHome::!F12    	; numpad 7 : peek definition
NumpadUp:: send ^d^f 	; numpad 8 : searches word
NumpadPgUp::+F12		; numpad 9 : peek references

NumpadAdd::^+b 		; numpad + : builds the code
NumpadEnter::^F5 	; numpad Enter : runs file
NumpadDel:: send (millis() - ){Left} 	; numpad delete :  quicl write time comparison for coding


; other hotkeys and macros
:?*:.-::-> ; turn double dot into arrow
#If


; ####### Misc Mode ######
#If modeTracker = 1
NumpadLeft:: memeFunc()			; numpad 4 : display meme
NumpadUp::send ^a^a!hoi!wfr 	; numpad 8 : fits colums to text and freezes top row in excel
NumpadPgup::send ^a^a!hafi!ncr 	; numpad 9 : ^^ for norwegian excel



#If


; #### Change Mode ####
NumpadDiv::
	data := "Code Mode"
	modeTracker := 0
	DisplayTextOnScreen(data)
	return

NumpadMult::
	data := "Misc Mode"
	modeTracker := 1
	DisplayTextOnScreen(data)
	return

NumpadSub::
	data := "IDK Mode"
	modeTracker := 2
	DisplayTextOnScreen(data)
	return


; ##### GUI STUFF #####
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


; ###### Other Functions #######

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


; not sure what this was used for exactly
SendSuppressedKeyUp(key) {
    DllCall("keybd_event"
        , "char", GetKeyVK(key)
        , "char", GetKeySC(key)
        , "uint", KEYEVENTF_KEYUP := 0x2
        , "uptr", KEY_BLOCK_THIS := 0xFFC3D450)
}