# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

`dotfiles-windows` is a config backup for LookFrost's (Ilyas Mohaimel) Windows 11 tiling-WM setup. There is no build step, no package manager, and no test suite — changes are made to source config files and then synced here manually (copy → commit → push).

**Hardware context**: i7-8550U + NVIDIA MX150 (4GB), 8GB RAM. On Windows 11 Pro because of hybrid GPU driver issues on Linux — would otherwise run EndeavourOS. Performance-sensitive config choices (e.g. `webgpu_power_preference = 'LowPower'`, opacity 0.4 rather than higher) reflect this hardware. Has 6+ years of Linux WM experience (Qtile, Hyprland, i3, Sway, bspwm, etc.) — understands configs at a deep level, no need to over-explain.

**Live config locations → repo paths:**

| Tool | Live location | Repo path |
|------|--------------|-----------|
| WezTerm | `~\.wezterm.lua` | `wezterm/.wezterm.lua` |
| GlazeWM | `~\.glzr\glazewm\config.yaml` | `glazewm/config.yaml` |
| AutoHotkey | `~\Documents\AutoHotkey\hotkeys.ahk` | `autohotkey/hotkeys.ahk` |
| Zebar widget | `%APPDATA%\zebar\downloads\glzr-io.starter@0.0.0\` | `zebar/` |
| PowerShell profile | `%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1` | `powershell/Microsoft.PowerShell_profile.ps1` |
| Starship | `~\.config\starship.toml` | `starship/starship.toml` |
| Flow Launcher | `%APPDATA%\FlowLauncher\Settings\` | `flow-launcher/` |
| Git config | `~\.gitconfig` | `git/.gitconfig` |
| VS Code | `%APPDATA%\Code\User\settings.json` | `vscode/settings.json` |
| VSCodium | `%APPDATA%\VSCodium\User\settings.json` | `vscodium/settings.json` |
| lazygit | `%APPDATA%\lazygit\config.yml` | `lazygit/config.yml` |
| fastfetch | `%APPDATA%\fastfetch\` | `fastfetch/` |
| Alacritty | `%APPDATA%\alacritty\alacritty.toml` | `alacritty/alacritty.toml` |
| nano | `~\.nanorc` | `nano/.nanorc` |
| Scoop app list | generated via `scoop list` | `scoop/apps.txt` |

## How to update a config in this repo

1. Edit the **live** file (e.g. `~\.wezterm.lua`)
2. Copy it into the repo: `Copy-Item ~\.wezterm.lua .\wezterm\.wezterm.lua`
3. Commit and push — commits must be solely from `Ilyas Mohaimel`, never add `Co-Authored-By`.

To refresh the scoop list: `scoop list > .\scoop\apps.txt`

## Stack overview

- **GlazeWM** — tiling WM. Config at `glazewm/config.yaml`. Starts Zebar on launch (`startup_commands: ["shell-exec zebar"]`). WezTerm needs an explicit `set-tiling` rule because `window_decorations = 'NONE'` strips `WS_CAPTION` and GlazeWM would otherwise treat it as floating.
- **WezTerm** (nightly, via Scoop) — terminal. Tokyo Night theme, CommitMono 11pt, Acrylic backdrop (blur), no decorations, no close confirmation.
- **AutoHotkey v2** (`autohotkey/hotkeys.ahk`) — runs **elevated** (self-`*RunAs`) so hotkeys reach UAC-elevated apps. Handles: taskbar hiding, Win+Space/R for Flow Launcher focus, Win+W → `Alt+F4` (works on all apps), Win+Enter → WezTerm, Win+B → Brave, Win+drag to move windows, strip Zebar's `WS_SYSMENU` on startup.
- **Zebar** — status bar. The `with-glazewm` widget (`zebar/with-glazewm.html`) is a React/Babel component using `https://esm.sh/zebar@3`. Styled with Tokyo Night Storm in `zebar/styles.css`. **Never start Zebar yourself** — kill it (`Stop-Process -Name zebar`) and let the user restart it.
- **PowerShell profile** — GNU coreutils on PATH (wins over System32), PSReadLine with Tokyo Night Storm colors + fish-style keybindings, Starship prompt, zoxide, fzf+PSFzf, eza/bat aliases.
- **Starship** — Tokyo Night Storm prompt with Nerd Font glyphs. Config at `~\.config\starship.toml` (symlinked or copied to `starship/starship.toml` here).
- **Flow Launcher** — triggered via `Alt+F1` (remapped to Win+Space/R in AHK). 39+ plugins with per-plugin settings backed up under `flow-launcher/plugins/`.
- **Git** — `delta` as pager, Tokyo Night Storm syntax theme, side-by-side diffs.

## Key constraints

- **No Co-Authored-By in commits** — ever, in this repo or any other.
- **No Zebar auto-start** — killing it is fine; starting it is the user's job.
- **AHK is elevated** — the script self-elevates via `*RunAs`; UAC prompt appears on first launch. The `StripZebarChrome` timer fires 2 s after startup and removes `WS_SYSMENU` (0x80000) from the Zebar window.
- **Floating windows** — `shown_on_top: true` in GlazeWM makes them always render above tiled windows.
- **WezTerm path** — installed as `wezterm-nightly` via Scoop: `~\scoop\apps\wezterm-nightly\current\wezterm-gui.exe`.
