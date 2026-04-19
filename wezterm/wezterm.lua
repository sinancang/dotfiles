local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.enable_tab_bar = false

-- Color theme
config.color_scheme = "Gruvbox dark, medium (base16)"

-- Use bash instead of zsh
config.default_prog = { '/bin/bash', '-l' }

-- Configure Option + Left or Option + Right to skip over words
local act = wezterm.action
config.keys = {
	{ key = 'LeftArrow', mods = 'OPT', action = act.SendKey { key = 'b', mods = 'ALT' } },
	{ key = 'RightArrow', mods = 'OPT', action = act.SendKey { key = 'f', mods = 'ALT' } },
}

return config
