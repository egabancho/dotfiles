local wezterm = require 'wezterm'
return {
	-- color_scheme = 'termnial.sexy',
    color_scheme = 'Catppuccin Frappe',
	enable_tab_bar = false,
	font_size = 12.0,
	font = wezterm.font('JetBrains Mono'),
	-- macos_window_background_blur = 40,
	macos_window_background_blur = 30,
	
	window_background_opacity = 0.9,
	-- window_background_opacity = 1.0,
	-- window_background_opacity = 0.20,
	window_decorations = 'RESIZE',
	keys = {
		{
			key = 'f',
			mods = 'CTRL',
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = '\'',
			mods = 'CTRL',
			action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
		},
	},
	mouse_bindings = {
	  -- Ctrl-click will open the link under the mouse cursor
	  {
	    event = { Up = { streak = 1, button = 'Left' } },
	    mods = 'CTRL',
	    action = wezterm.action.OpenLinkAtMouseCursor,
	  },
	},
}
