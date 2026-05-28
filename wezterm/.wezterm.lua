local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Shell + working dir
config.default_prog = { 'powershell.exe', '-NoLogo' }
config.default_cwd = 'C:\\Users\\LookFrost'

-- Theme
config.color_scheme = 'Tokyo Night'

-- Font (CommitMono primary, JetBrainsMono Nerd Font fallback for glyphs/icons
-- used by Starship and other prompts)
config.font = wezterm.font_with_fallback({
  { family = 'CommitMono', weight = 'Regular' },
  'JetBrainsMono Nerd Font',
  'Symbols Nerd Font',
})
config.font_size = 11.0

-- Window appearance
config.window_background_opacity = 0.4
config.win32_system_backdrop = 'Acrylic'
config.window_padding = { left = 15, right = 15, top = 15, bottom = 15 }
config.window_decorations = 'NONE'
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Use iGPU so DWM can composite Acrylic transparency (hybrid Intel+NVIDIA system)
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'LowPower'

-- Shift+Enter → ESC + CR (mirrors Alacritty keybind for REPL newlines)
config.keys = {
  {
    key = 'Enter',
    mods = 'SHIFT',
    action = wezterm.action.SendString('\x1b\r'),
  },
}

config.scrollback_lines = 10000
config.audible_bell = 'Disabled'
config.window_close_confirmation = 'NeverPrompt'

return config
