# My Windows dotfiles

My Windows 11 setup, with the configs I used for terminals, prompts, desktop tools, editors, and shortcuts.

I keep this separate from my [Linux dotfiles](https://github.com/ilyasmohaimel/dotfiles-linux) because the paths, tools, and window-manager setup are different. I write these notes so I can rebuild parts of my setup if I forget how I made them, or reuse parts of it in another Windows install.

This is a collection of personal configs, not a one-command installer. I copy over only the files I want and check paths, accounts, plugins, and themes first.

<p align="center">
  <a href="Wallpapers/CustomizedDesktop/savedWallpaper.jpg"><img src="Wallpapers/CustomizedDesktop/savedWallpaper.jpg" width="720" alt="My customized Windows desktop"></a>
</p>

## What's here

| Folder | What it contains |
| --- | --- |
| [`powershell/`](powershell/) | PowerShell profile, aliases, functions, and prompt setup |
| [`wezterm/`](wezterm/) | WezTerm terminal configuration |
| [`alacritty/`](alacritty/) | Alacritty terminal configuration |
| [`starship/`](starship/) | Starship prompt configuration |
| [`fastfetch/`](fastfetch/) | Fastfetch config and custom logo |
| [`autohotkey/`](autohotkey/) | My AutoHotkey shortcuts |
| [`glazewm/`](glazewm/) | GlazeWM layouts and keybinds |
| [`zebar/`](zebar/) | Zebar widgets and styles |
| [`flow-launcher/`](flow-launcher/) | Flow Launcher settings and plugin settings |
| [`vscode/`](vscode/) / [`vscodium/`](vscodium/) | Editor settings |
| [`vencord/`](vencord/) | Vencord settings |
| [`git/`](git/) | Git configuration and global ignore file |
| [`lazygit/`](lazygit/) | Lazygit configuration |
| [`nano/`](nano/) | Nano configuration |
| [`brave/`](brave/) | Brave browser theme manifest |
| [`scoop/`](scoop/) | Scoop app inventory |

## Wallpapers

My wallpaper collection is in [`Wallpapers/`](Wallpapers/). It includes a preview gallery, EVA, Firewatch, and main wallpaper folders.

## Using a config

Start with the specific program folder instead of copying the whole repository. These files are intentionally split up so I can restore a terminal theme without replacing editor settings, or bring back shortcuts without importing old launcher state.

For a fresh setup, I normally install the app first, open it once so it creates its folders, then copy in the matching config and restart the app. I keep personal credentials, browser data, private keys, and machine-specific app state out of this repository.

## Related setup

- [My Linux dotfiles](https://github.com/ilyasmohaimel/dotfiles-linux)
- [Wallpaper gallery](Wallpapers/README.md)
