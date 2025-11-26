local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- --- VISUALS: REMOVE TABS & TITLE BAR ---
-- Hide the tab bar if you only have one tab (clean look)
config.hide_tab_bar_if_only_one_tab = true

-- Remove the Windows title bar (maximize screen real estate)
-- "RESIZE" keeps the border resizable but removes the white bar at the top
config.window_decorations = "RESIZE"

-- Optional: Make it translucent (Glass effect)
config.window_background_opacity = 0.90
config.win32_system_backdrop = "Acrylic"


-- --- STARTUP: DEFAULT TO WSL ---
-- Automatically find your default WSL distro
-- If you have multiple (e.g., Ubuntu, Debian), set specifically like 'WSL:Ubuntu'
config.default_domain = 'WSL:Ubuntu'

-- (Optional) If you want to force it to start in your home directory
-- config.default_cwd = os.getenv('UserProfile')

return config