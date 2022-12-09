#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\BogSave\Plane.ico
#AutoIt3Wrapper_Outfile=..\..\BogSave\BogJet_v1.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Godspeed
#AutoIt3Wrapper_Res_Description=Bog's Save Play Clicker
#AutoIt3Wrapper_Res_Fileversion=1.1.0.2
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=© 2016
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------
	Author: Bog (jeffbogg@gmail.com)
	Date: 01/27/2016
	Script Function: Save Click, Replay Click

	Instructions:
	Use ALT + F5 to set the location of the save button once the mouse is over it.
	Use ALT + F6 to set the location of the replay button once the mouse is over it.
	F5: Will click the save button
	F6: WIll click the replay button

	Abort:
	ALT + End: If for any reason this script has issues and does not work or gets hung up, ALT+END will kill it.
#ce ----------------------------------------------------------------------------

Opt("MouseClickDragDelay", 0) ; Alters the length of the brief pause at the start and end of a mouse drag operation.
Opt("MouseCoordMode", 1) ; Sets the way coords are used in the mouse functions, 0 = relative coords to the active window

If Not FileExists(@ScriptDir & "\_Macros.ini") Then
	IniWrite(@ScriptDir & "\_Macros.ini", "Save", "X", "0")
	IniWrite(@ScriptDir & "\_Macros.ini", "Save", "Y", "0")
	IniWrite(@ScriptDir & "\_Macros.ini", "Play", "A", "0")
	IniWrite(@ScriptDir & "\_Macros.ini", "Play", "B", "0")
	Sleep(500)
EndIf

HotKeySet("!{F5}", "_SetSaveCoords") ; Press 'Alt'+'F5' to set the location of your Save ITEM BUTTON.
HotKeySet("!{F6}", "_SetPlayCoords") ; Press 'Alt'+'F5' to set the location of your Play ITEM BUTTON.
HotKeySet("{F5}", "_ClickSave") ; Press F5 to click your Save button
HotKeySet("{F6}", "_ClickPlay") ; Press F6 to click your Replay button
HotKeySet("!{END}", "Terminate") ; Terminate the script

Global $Paused
Global $SaveTargetX = IniRead(@ScriptDir & "\_Macros.ini", "Save", "X", "0")
Global $SaveTargetY = IniRead(@ScriptDir & "\_Macros.ini", "Save", "Y", "0")
Global $PlayTargetX = IniRead(@ScriptDir & "\_Macros.ini", "Play", "A", "0")
Global $PlayTargetY = IniRead(@ScriptDir & "\_Macros.ini", "Play", "B", "0")
Global $user32dll = DllOpen("user32.dll") ; should be cleaned up at exit

; Idle
While 1
	Sleep(10)
WEnd

Func _SetSaveCoords()
	$Pos = MouseGetPos()
	IniWrite(@ScriptDir & "\_Macros.ini", "Save", "X", $Pos[0])
	IniWrite(@ScriptDir & "\_Macros.ini", "Save", "Y", $Pos[1])
	$SaveTargetX = $Pos[0]
	$SaveTargetY = $Pos[1]
EndFunc   ;==>_SetSaveCoords

Func _SetPlayCoords()
	$MousePos = MouseGetPos()
	IniWrite(@ScriptDir & "\_Macros.ini", "Play", "A", $MousePos[0])
	IniWrite(@ScriptDir & "\_Macros.ini", "Play", "B", $MousePos[1])
	$PlayTargetX = $MousePos[0]
	$PlayTargetY = $MousePos[1]
EndFunc   ;==>_SetSaveCoords

Func _ClickSave()
	$Pos = MouseGetPos()
	MouseMove($SaveTargetX, $SaveTargetY, 1)
	Sleep(50)
	MouseClick("left")
	Sleep(150)
	MouseMove($Pos[0],$Pos[1],0)
EndFunc   ;==>_ClickSave

Func _ClickPlay()
	$MousePos = MouseGetPos()
	MouseMove($PlayTargetX, $PlayTargetY, 1)
	Sleep(50)
	MouseClick("left")
	Sleep(150)
	MouseMove($MousePos[0],$MousePos[1],0)
EndFunc   ;==>_ClickSave

Func Terminate()
	Exit
	DllClose($user32dll)
EndFunc   ;==>Terminate
