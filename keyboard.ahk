#Requires AutoHotkey v2.0+
#SingleInstance Force


alpha    := StrSplit("abcfnrstuvwxyz")
numeric  := StrSplit("0123456789")
; function := ["F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12"]
; arrows   := ["Left","Right","Up","Down"]
; nav      := ["Home","End","PgUp","PgDn"]

allKeys := alpha.Clone()
allKeys.Push(numeric*)

shiftKeys := ["s", "p", "z", "n", "t", "v", "f"]

SendCtrl(key, withShift := false, *) {
  mods := withShift ? "^+" : "^"             ; ^ = Ctrl, + = Shift
  Send mods . (StrLen(key)=1 ? key : "{" key "}")
}

; Make win key do noting when pressed
~LWin:: Send "{Blind}{vk07}"
; Hold Win and press space -> simulate a Win tap
#Space::Send "{LWin}"

 
for k in allKeys {
  Hotkey("#" k, SendCtrl.Bind(k, false))
}

for k in shiftKeys {
  Hotkey("#+" k, SendCtrl.Bind(k, true))
}


#q::Send "!{F4}"
#Left::Send "{Home}"
#Right::Send "{End}"
#+Left::Send "+{Home}"
#+Right::Send "+{End}"

; Screenshot
#+4::Send "#+s"

; Delete
#Backspace::Send "{Delete}"

; Open the emoji panel
#^Space::Send "#."

; Simulate Alt + Tab behavior using Win + Tab
#Tab:: {
  Send "{Alt down}{Tab}"
  KeyWait "LWin"
  Send "{Alt up}"
}
#+Tab:: {
  Send "{Alt down}{Shift down}{Tab}"
  KeyWait "LWin"
  Send "{Shift up}{Alt up}"
}

; Simulate Win + Tab behavior using F13
F13::Send "#{Tab}"


; Simulate Ctrl + Click using Win + Click in the chrome
~LWin & LButton:: {
  if WinActive("ahk_exe chrome.exe") {
    Send("{Ctrl down}")
    Click("left")
    Send("{Ctrl up}")
    Return
  }

  Send("{LButton}")
}


#HotIf WinActive("ahk_exe chrome.exe")
#!i::Send "^+c"
#HotIf

#HotIf WinActive("ahk_exe wezterm-gui.exe")
#c:: Send "^+c"
#v:: Send "^+v"
#t:: Send "^+t"
#w:: Send "^+w"
#!p:: Send "^!p"
#HotIf 


$CapsLock:: {
  if KeyWait("CapsLock", "T0.5") {
    Send "{Alt down}{Shift}{Alt up}"
  } else {
    SetCapsLockState(GetKeyState("CapsLock", "T") ? "Off" : "On")
    KeyWait "CapsLock"
  }
}
