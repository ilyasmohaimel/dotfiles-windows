# My Windows dotfiles

My Windows 11 setup, with the configs I used for terminals, prompts, desktop tools, editors, and shortcuts.

I keep this separate from my [Linux dotfiles](https://github.com/ilyasmohaimel/dotfiles-linux) because the paths, tools, and window-manager setup are different. I write these notes so I can rebuild parts of my setup if I forget how I made them, or reuse parts of it in another Windows install.

This is a collection of personal configs, not a one-command installer. I copy over only the files I want and check paths, accounts, plugins, and themes first.

<p align="center">
  <a href="Wallpapers/CustomizedDesktop/savedWallpaper.jpg"><img src="Wallpapers/CustomizedDesktop/savedWallpaper.jpg" width="720" alt="My customized Windows desktop"></a>
</p>

## What's here

```text
.
├── browser/       Brave and Discord/Vencord settings
├── desktop/       Window managers, launcher state, and shortcuts
├── development/   Git and Lazygit
├── editors/       VS Code and VSCodium
├── packages/      Scoop inventory
├── terminal/      Shells, terminals, prompt, and CLI tools
└── Wallpapers/    Wallpaper gallery
```

| Category | Contents |
| --- | --- |
| [`terminal/`](terminal/) | [PowerShell](terminal/powershell/), [WezTerm](terminal/wezterm/), [Alacritty](terminal/alacritty/), [Starship](terminal/starship/), [Fastfetch](terminal/fastfetch/), and [Nano](terminal/nano/) |
| [`desktop/`](desktop/) | [GlazeWM and Zebar](desktop/window-managers/), [Flow Launcher](desktop/launchers/), and [AutoHotkey](desktop/shortcuts/) |
| [`editors/`](editors/) | [VS Code](editors/vscode/) and [VSCodium](editors/vscodium/) settings |
| [`development/`](development/) | [Git](development/git/) and [Lazygit](development/lazygit/) configuration |
| [`browser/`](browser/) | [Brave](browser/brave/) theme files and [Vencord](browser/discord/vencord/) settings |
| [`packages/`](packages/) | [Scoop app inventory](packages/scoop/) |

## Wallpapers

My wallpaper collection is in [`Wallpapers/`](Wallpapers/). It includes a preview gallery, EVA, Firewatch, and main wallpaper folders.

## Using a config

Start with the specific program folder instead of copying the whole repository. These files are intentionally split up so I can restore a terminal theme without replacing editor settings, or bring back shortcuts without importing old launcher state.

For a fresh setup, I normally install the app first, open it once so it creates its folders, then copy in the matching config and restart the app. I keep personal credentials, browser data, private keys, and machine-specific app state out of this repository.

## Related setup

- [My Linux dotfiles](https://github.com/ilyasmohaimel/dotfiles-linux)
- [Wallpaper gallery](Wallpapers/README.md)
