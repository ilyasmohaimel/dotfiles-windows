#Requires AutoHotkey v2.0
#SingleInstance Force

; Elevate so hotkeys reach admin windows (Task Manager, HWMonitor, etc.)
if not A_IsAdmin {
    Run('*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"')
    ExitApp
}

; ─── Strip Zebar's native close button (WS_SYSMENU) ─────────────────────────
; Zebar's zpack has no "decorations: false" option, so we remove the style here.
SetTimer StripZebarChrome, 2000
StripZebarChrome() {
    if WinExist("ahk_exe zebar.exe") {
        WinSetStyle("-0x80000", "ahk_exe zebar.exe")  ; -WS_SYSMENU
        SetTimer StripZebarChrome, 0  ; run once, then stop
    }
}

; ─── Hide taskbar on startup and keep it hidden ───────────────────────────────
HideTaskbar() {
    if WinExist("ahk_class Shell_TrayWnd")
        WinHide("ahk_class Shell_TrayWnd")
    if WinExist("ahk_class Shell_SecondaryTrayWnd")
        WinHide("ahk_class Shell_SecondaryTrayWnd")
}
HideTaskbar()
SetTimer HideTaskbar, 500

; ─── Hotkeys ──────────────────────────────────────────────────────────────────

; Win+Space → Open Flow Launcher and force focus (prevents lost-keyboard-input issue)
#Space:: {
    Send("!{F1}")
    if WinWait("ahk_exe Flow.Launcher.exe",, 1)
        WinActivate("ahk_exe Flow.Launcher.exe")
}

; Win+R → Open Flow Launcher (overrides Run dialog)
#r:: {
    Send("!{F1}")
    if WinWait("ahk_exe Flow.Launcher.exe",, 1)
        WinActivate("ahk_exe Flow.Launcher.exe")
}

; Win+Q → Block Windows search/Copilot
#q::return

; Win+L → Block lock screen (used by GlazeWM for window focus)
#l::return

; Win+W → Close the focused window (Alt+F4 = SC_CLOSE, works for all apps)
#w::Send("!{F4}")

; Win+Enter → Launch WezTerm
#Enter::Run("C:\Users\LookFrost\scoop\apps\wezterm-nightly\current\wezterm-gui.exe")

; Win+B → Launch Brave
#b::Run("brave.exe")

; Win+LButton drag → Move any window from anywhere (like Hyprland/qtile Super+drag)
#LButton::
{
    CoordMode "Mouse", "Screen"
    MouseGetPos &mX, &mY, &winHwnd
    WinGetPos &wX, &wY,,, winHwnd
    offsetX := mX - wX
    offsetY := mY - wY
    while GetKeyState("LButton", "P") {
        MouseGetPos &mX, &mY
        WinMove mX - offsetX, mY - offsetY,,, winHwnd
    }
}