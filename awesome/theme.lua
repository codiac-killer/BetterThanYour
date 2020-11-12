local dpi = require('beautiful').xresources.apply_dpi
local gears = require("gears")

local themes_path = "~/.config/awesome/"
local blue = "#0066ff"

theme = {}

theme.font              = "Cantarell Bold 11"

-- theme.bg_normal   = "#0d1a26" .. "00"
theme.bg_normal   = "#000000" .. "33"
theme.bg_focus    = "#222B2E" .. "00"
theme.bg_urgent   = "#000000" .. "00"
theme.bg_minimize = "#101010" .. "00"
theme.bg_wibar 	  = "#000000" .. "99"
theme.bg_systray  = "#555555" .. "00"

theme.fg_normal   = "#ffffff"
theme.fg_focus    = "#ffffff"
theme.fg_urgent   = "#ff0000"
theme.fg_minimize = "#ffffff"

theme.taglist_bg_focus = "#0d1a26" .. "50"

theme.tasklist_bg_focus = "#0d1a26" .. "50"
theme.tasklist_bg_normal   = "#8aa1a8" .. "10"

theme.border_width  = 1
theme.border_normal = "#000000"
theme.border_focus  = blue .. "30"
theme.border_marked = blue .. "30"

theme.titlebar_size = dpi(34)
theme.titlebar_bg_focus = "#000000" .. "a6"
theme.titlebar_bg_normal = "#000000" .. "a6"

theme.hotkeys_modifiers_fg = "#2EB398"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:

-- Display the taglist squares
theme.taglist_squares_sel   = themes_path .. "images/tag_buttons/selected_light.png"
theme.taglist_squares_unsel = themes_path .. "images/tag_buttons/inactive_filled.png"
theme.taglist_squares_sel_empty = themes_path .. "images/tag_buttons/selected_light.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "icons/submenu.png"
theme.menu_height = 25
theme.menu_width  = 200

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal              = themes_path .. "images/caption/normal.png"
theme.titlebar_close_button_focus               = themes_path .. "images/caption/close_focus.png"
theme.titlebar_close_button_focus_hover         = themes_path .. "images/caption/close_hover.png"
theme.titlebar_close_button_focus_press         = themes_path .. "images/caption/close_pressed.png"

theme.titlebar_minimize_button_normal              = themes_path .. "images/caption/normal.png"
theme.titlebar_minimize_button_focus               = themes_path .. "images/caption/minimize_focus.png"
theme.titlebar_minimize_button_focus_hover         = themes_path .. "images/caption/minimize_hover.png"
theme.titlebar_minimize_button_focus_press         = themes_path .. "images/caption/minimize_pressed.png"

theme.titlebar_maximized_button_normal_inactive       = themes_path .. "images/caption/normal.png"
theme.titlebar_maximized_button_focus_inactive        = themes_path .. "images/caption/maximize_focus.png"
theme.titlebar_maximized_button_focus_inactive_hover  = themes_path .. "images/caption/maximize_hover.png"
theme.titlebar_maximized_button_focus_inactive_press  = themes_path .. "images/caption/maximize_pressed.png"

theme.titlebar_maximized_button_normal_active   = themes_path .. "images/caption/normal.png"
theme.titlebar_maximized_button_focus_active    = themes_path .. "images/caption/maximize_pressed.png"
theme.titlebar_maximized_button_focus_active_hover  = themes_path .. "images/caption/maximize_hover.png"
theme.titlebar_maximized_button_focus_active_press  = themes_path .. "images/caption/maximize_focus.png"

-- theme.wallpaper = themes_path .. "images/wallpapers/austronaut-dark.jpg"
theme.lock_image = themes_path .. "images/wallpapers/aquarium.png"

-- You can use your own layout icons like this:
theme.layout_fairh      = themes_path .. "images/layouts/fairh.png"
theme.layout_fairv      = themes_path .. "images/layouts/fairv.png"
theme.layout_floating   = themes_path .. "images/layouts/floating.png"
theme.layout_magnifier  = themes_path .. "images/layouts/magnifier.png"
theme.layout_max        = themes_path .. "images/layouts/max.png"
theme.layout_fullscreen = themes_path .. "images/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path .. "images/layouts/tilebottom.png"
theme.layout_tileleft   = themes_path .. "images/layouts/tileleft.png"
theme.layout_tile       = themes_path .. "images/layouts/tile.png"
theme.layout_tiletop    = themes_path .. "images/layouts/tiletop.png"
theme.layout_spiral     = themes_path .. "images/layouts/spiral.png"
theme.layout_dwindle    = themes_path .. "images/layouts/dwindle.png"
theme.layout_cornernw   = themes_path .. "images/layouts/cornernw.png"
theme.layout_cornerne   = themes_path .. "images/layouts/cornerne.png"
theme.layout_cornersw   = themes_path .. "images/layouts/cornersw.png"
theme.layout_cornerse   = themes_path .. "images/layouts/cornerse.png"

theme.awesome_icon = themes_path .. "images/appmenu.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark"

-- Useless Gap (blank space between clients)
theme.useless_gap = dpi(10)

-- Wibar Style
theme.wibar_height = 35

-- Notifications
theme.notification_font = "Cantarell 9"
theme.notification_bg = "#eeeeee" .. "46"
theme.notification_fg = "#000000"
theme.notification_border_width = 1
theme.notification_border_color = blue .. "30"
theme.notification_icon_size = 30
theme.notification_width = 380
theme.notification_height = 75
theme.notification_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
end

-- Menubar
-- theme.menubar_fg_normal = "#ffffff"
theme.menubar_bg_focus = "#000000" .. "50"

return theme
