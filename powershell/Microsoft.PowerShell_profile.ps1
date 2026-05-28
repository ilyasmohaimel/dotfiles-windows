# ─── Scoop + GNU coreutils on PATH ──────────────────────────────────────────
# Prepend so GNU `find` / `grep` / `sed` win over Windows' System32 versions
# and so unshimmed coreutils bins (ls, cat, cp, mv, rm, pwd, echo, sort) work.
$coreutilsBin = "$env:USERPROFILE\scoop\apps\coreutils\current\bin"
$scoopShims   = "$env:USERPROFILE\scoop\shims"
$env:PATH = "$coreutilsBin;$scoopShims;" + $env:PATH

# ─── PSReadLine: Tokyo Night Storm + fish-style ─────────────────────────────
# Tokyo Night Storm palette (mirrors folke/tokyonight.nvim extras/fish)
Import-Module PSReadLine

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -MaximumHistoryCount 10000
Set-PSReadLineOption -ShowToolTips

# Fish-style autosuggestions: inline grey ghost text from history
# (HistoryAndPlugin requires PS 7.2+; on PS 5.1 we use History only)
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView

# Tokyo Night Storm syntax colors (matches the fish theme)
# Selection bg uses an ANSI escape — built with [char]27 because PS 5.1
# doesn't expand the `e backtick-escape in double-quoted strings.
$esc = [char]27
Set-PSReadLineOption -Colors @{
    Command            = "#7dcfff"   # cyan      (fish_color_command)
    Parameter          = "#9d7cd8"   # purple    (fish_color_param)
    Operator           = "#9ece6a"   # green     (fish_color_operator)
    Variable           = "#c0caf5"   # fg        (fish_color_normal)
    String             = "#e0af68"   # yellow    (fish_color_quote)
    Number             = "#ff9e64"   # orange    (fish_color_end)
    Type               = "#7dcfff"   # cyan
    Comment            = "#565f89"   # comment   (fish_color_comment)
    Keyword            = "#bb9af7"   # pink      (fish_color_keyword)
    Error              = "#f7768e"   # red       (fish_color_error)
    Member             = "#7dcfff"   # cyan
    Default            = "#c0caf5"   # fg
    Emphasis           = "#7aa2f7"   # blue
    Selection          = "$esc[48;2;46;60;100m"   # bg 2e3c64 (fish_color_selection)
    ContinuationPrompt = "#565f89"
    InlinePrediction   = "#565f89"   # autosuggestion grey (fish_color_autosuggestion)
}

# Fish-like key bindings
Set-PSReadLineKeyHandler -Key Tab          -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow      -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow    -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key RightArrow   -Function ForwardChar      # accept suggestion char-by-char
Set-PSReadLineKeyHandler -Key Ctrl+f       -Function AcceptSuggestion # fish-style: Ctrl+F accepts whole suggestion
Set-PSReadLineKeyHandler -Key Alt+RightArrow -Function AcceptNextSuggestionWord
Set-PSReadLineKeyHandler -Key Ctrl+d       -Function DeleteCharOrExit
Set-PSReadLineKeyHandler -Key Ctrl+w       -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow  -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord

# ─── Starship prompt (Tokyo Night) ──────────────────────────────────────────
# Config lives at C:\Users\LookFrost\.config\starship.toml
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (& starship init powershell)
}

# ─── zoxide (fish-like `z foo` directory jumping) ───────────────────────────
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# ─── fzf + PSFzf (fuzzy Ctrl+R history, Ctrl+T file search) ─────────────────
if (Get-Module -ListAvailable -Name PSFzf) {
    Import-Module PSFzf
    # Tokyo Night Storm colors for fzf itself
    $env:FZF_DEFAULT_OPTS = @(
        '--height 40% --layout=reverse --border --info=inline'
        '--color=bg+:#2e3c64,bg:#1d2030,spinner:#bb9af7,hl:#7aa2f7'
        '--color=fg:#c0caf5,header:#7aa2f7,info:#e0af68,pointer:#bb9af7'
        '--color=marker:#9ece6a,fg+:#c0caf5,prompt:#7aa2f7,hl+:#7dcfff'
    ) -join ' '
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+r' -PSReadlineChordReverseHistory 'Ctrl+t'
}

# ─── fastfetch on launch (non-blocking) ─────────────────────────────────────
if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    Start-Process -FilePath (Get-Command fastfetch).Source -NoNewWindow
}

# ─── Let GNU coreutils win ──────────────────────────────────────────────────
# Remove PS built-in aliases that shadow the real Linux commands installed
# via scoop (coreutils, sed, gawk, grep, less, etc.). The scoop shims are
# already on PATH so once these aliases are gone the GNU binaries take over.
$shadowAliases = @(
    'ls','cat','cp','mv','rm','rmdir','pwd','echo','sleep','sort','tee',
    'tr','wc','curl','wget','diff','man','sed','awk','grep','kill'
)
foreach ($a in $shadowAliases) {
    if (Get-Alias $a -ErrorAction SilentlyContinue) {
        Remove-Item "Alias:$a" -Force -ErrorAction SilentlyContinue
    }
}

# ─── Navigation ─────────────────────────────────────────────────────────────
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function ~ { Set-Location ~ }

# ─── Modern Rust CLI replacements ───────────────────────────────────────────
# eza for ls (icons + git status + colors), bat for cat (syntax highlight),
# ripgrep (rg) is its own command. Real coreutils ls/cat are still available
# via their full path or by uninstalling these aliases.
if (Get-Command eza -ErrorAction SilentlyContinue) {
    function ls { eza --icons --git @args }
    function ll { eza -lh --icons --git @args }
    function la { eza -lah --icons --git @args }
    function lt { eza -lh --icons --git --tree --level=2 @args }
} else {
    function ll { Get-ChildItem -Force @args }
    function la { Get-ChildItem -Force -Hidden @args }
}
if (Get-Command bat -ErrorAction SilentlyContinue) {
    Set-Alias -Name cat -Value bat -Option AllScope
}
function rmrf { Remove-Item -Recurse -Force @args }
function which { Get-Command @args | Select-Object -ExpandProperty Source }
function lg { lazygit @args }

# Edit profile / common configs quickly
function nvprofile { notepad $PROFILE }
function nvrc { notepad "$HOME\.wezterm.lua" }

# ─── System (Windows-specific power/reload) ─────────────────────────────────
function reboot   { Restart-Computer -Force }
function poweroff { Stop-Computer -Force }
function shutdown { Stop-Computer -Force }
function top      { Get-Process | Sort-Object CPU -Descending | Select-Object -First 20 }
function reload   { . $PROFILE }
