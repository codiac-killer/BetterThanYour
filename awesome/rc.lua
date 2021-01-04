-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Freedesktop menu
local freedesktop = require("freedesktop")
-- Enable VIM help for hotkeys widget when client with matching name is opened:
require("awful.hotkeys_popup.keys.vim")
-- Volume Control Widget
-- local volume_widget = require("volume-widget.volume")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                                  title = "Oops, there were errors during startup!",
                                  text = awesome.startup_errors })
end
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical,
                                      title = "Oopsie Poopsie!!!",
                                      text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- Chosen colors and buttons look alike adapta maia theme
beautiful.init(require("theme"))

-- This is used later as the default terminal and editor to run.
-- Browsers --------------------------------------------------------------------
browser = "exo-open --launch WebBrowser" or "firefox"
--------------------------------------------------------------------------------
-- Filemanager -----------------------------------------------------------------
filemanager = "exo-open --launch FileManager" or "thunar"
--------------------------------------------------------------------------------
-- Text Editor -----------------------------------------------------------------
gui_editor = "subl"
--------------------------------------------------------------------------------
-- Terminal Emulator -----------------------------------------------------------
terminal = os.getenv("TERMINAL") or "alacritty"
--------------------------------------------------------------------------------

-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    -- awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil
    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

shape_hexagon = function(cr, width, height)
    cr:move_to(height/4,0)
    cr:line_to(width,0)
    cr:line_to(width,height - height/4)
    cr:line_to(width - height/4,height)
    cr:line_to(0,height)
    cr:line_to(0,height/4)
    cr:close_path()
end
-- }}}


-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end, menubar.utils.lookup_icon("preferences-desktop-keyboard-shortcuts") },
    { "manual", terminal .. " -e man awesome", menubar.utils.lookup_icon("system-help") },
    { "edit config", gui_editor .. " " .. awesome.conffile,  menubar.utils.lookup_icon("accessories-text-editor") },
    { "edit theme", gui_editor .. " ~/.config/awesome/theme.lua",  menubar.utils.lookup_icon("accessories-text-editor") },
    { "restart", awesome.restart, menubar.utils.lookup_icon("system-restart") }
}
myexitmenu = {
    { "log out", function() awesome.quit() end, menubar.utils.lookup_icon("system-log-out") },
    { "suspend", "systemctl suspend", menubar.utils.lookup_icon("system-suspend") },
    { "hibernate", "systemctl hibernate", menubar.utils.lookup_icon("system-suspend-hibernate") },
    { "reboot", "systemctl reboot", menubar.utils.lookup_icon("system-reboot") },
    { "shutdown", "poweroff", menubar.utils.lookup_icon("system-shutdown") }
}
mymainmenu = freedesktop.menu.build({
    icon_size = 32,
    before = {
        { "Terminal", terminal, menubar.utils.lookup_icon("utilities-terminal") },
        { "Browser", browser, menubar.utils.lookup_icon("internet-web-browser") },
        { "Files", filemanager, menubar.utils.lookup_icon("system-file-manager") },
        -- other triads can be put here
    },
    after = {
        { "Awesome", myawesomemenu, "/usr/share/awesome/icons/awesome32.png" },
        { "Exit", myexitmenu, menubar.utils.lookup_icon("system-shutdown") },
        -- other triads can be put here
    }
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock()
local month_calendar = awful.widget.calendar_popup.month({bg = "#2f2f2fc6"})
month_calendar:attach( mytextclock, "br" )

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

darkblue    = beautiful.bg_focus
blue        = "#0066ff"
red         = "#EB8F8F"
separator = wibox.widget.textbox(' <span color="' .. blue .. '">| </span>')
spacer = wibox.widget.textbox(' <span color="' .. "#00000000" .. '"> </span>')

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Functions to update active window indicators
local function set_tasklist_underline(tasklist_icon, client, index, objects)
    if client:isvisible() then
        tasklist_icon:get_children_by_id("underline")[1].bg = "#1e90ff"
    else 
        tasklist_icon:get_children_by_id("underline")[1].bg = "#212121"
    end
end

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    -- set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "🌍", "📜", "⏯️", "📦", "⚙" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    

    -----------------------------------------------------------------------------------------------
    -- Layout Box ---------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    local layoutbox = awful.widget.layoutbox(s)
    layoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

     -- Use container to adjust widgets size
     local size_cont_layout_box = wibox.container.constraint(layoutbox, 'exact', 25, 25)
     -- Use container to adjust widgets alignment
     s.layout_widget = wibox.container.place( size_cont_layout_box, 'center', 'center')
    -----------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------------
    -- Systray ------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------
    local systray_pure_widget = wibox.widget.systray()
    local size_cont_systray =  wibox.container.constraint(systray_pure_widget, 'exact', nil, 25)
    s.systray_widget = wibox.container.place( size_cont_systray, 'center', 'center')
    -----------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------------
    -- Shutdown button ----------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------
    local logout_button = awful.widget.launcher({ image = menubar.utils.lookup_icon("system-shutdown"), command = 'oblogout' })
    -- Use container to adjust widgets size
    local size_cont_logout = wibox.container.constraint(logout_button, 'exact', 35, 35)
    -- Use container to adjust widgets alignment
    s.logout = wibox.container.place(size_cont_logout, 'center', 'center')
    -----------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------------
    -- Create a taglist widget --------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------

    local taglist_pure_widget = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style   = {
            shape_border_width = 1,
            shape_border_color = beautiful.taglist_border,
            shape = shape_hexagon
        },
        layout   = {
            spacing = 5,
            layout  = wibox.layout.fixed.horizontal
            -- layout  = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
            create_callback = function(self, tag, index, objects) --luacheck: no unused args
                self:connect_signal('mouse::enter', function()
                    self.bg = '#1e90ff'
                end)
                self:connect_signal('mouse::leave', function()
                    if tag.selected then self.bg = beautiful.taglist_bg_focus else self.bg = "#00000000" end
                end)
		
            end,
        },
        buttons = taglist_buttons
    }

    local size_cont_taglist =  wibox.container.constraint(taglist_pure_widget, 'exact', nil, 30)
    s.taglist = wibox.container.place(size_cont_taglist, 'center', 'center')
    -----------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------
    
    -----------------------------------------------------------------------------------------------
    -- Create a tasklist widget -------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------
    -- local tasklist_pure_widget = awful.widget.tasklist {
    s.tasklist = awful.widget.tasklist {
  	    screen   = s,
  	    filter   = awful.widget.tasklist.filter.currenttags,
  	    buttons  = tasklist_buttons,
  	    style    = {
  	    },
  	    layout   = {
  	        -- spacing = 5,
            -- layout  = wibox.layout.flex.horizontal
            layout  = wibox.layout.fixed.horizontal
  	    },
        widget_template = {
            {
                {
                    {
                        {
                            left = 10,
                            right = 10,
                            top = 3,
                            widget = wibox.container.margin
                        },
                        id = 'underline',
                        bg = '#ffffff',
                        shape = gears.shape.rectangle,
                        widget = wibox.container.background
                    },
                    {
                        {
                            {
                                id = 'icon_role',
                                widget = wibox.widget.imagebox,
                            },
			    id = 'icon_container',
                            margins = 10,
                            widget = wibox.container.margin
                        },
                        shape = gears.shape.rectangle,
                        widget = wibox.container.background
                    },
                    layout = wibox.layout.align.vertical,
                },
                left = 1,
                right = 1,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            shape = gears.shape.rectangle,
            create_callback = function(self, client, index, objects)
              set_tasklist_underline(self, client, index, objects)
              -- Signals for hover effect
              self:connect_signal('mouse::enter', function()
                    if self.bg ~= '#ffffff28' then
                        self.backup     = self.bg
                        self.has_backup = true
                    end
                    self.bg = '#ffffff28'
		    self:get_children_by_id("icon_container")[1].margins = 9 
                end)
                self:connect_signal('mouse::leave', function()
                    if self.has_backup then self.bg = self.backup end
		    self:get_children_by_id("icon_container")[1].margins = 10 
                end)
             end,
            update_callback = function(self, client, index, objects) set_tasklist_underline(self, client, index, objects) end
        },

  	}
    -- local size_cont_tasklist =  wibox.container.constraint(tasklist_pure_widget, 'exact', nil, 30)
    -- s.tasklist = wibox.container.place(size_cont_tasklist, 'center', 'left')
    -----------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------------
    -- Create Volume widget -----------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------
    volume_widget = wibox.widget.textbox()
    volume_widget:set_align("right")

    function update_volume(widget)
       local fd = io.popen("amixer sget Master")
       local status = fd:read("*all")
       fd:close()

       local volume = string.match(status, "(%d?%d?%d)%%")
       volume = string.format("% 3d", volume)

       status = string.match(status, "%[(o[^%]]*)%]")

       if string.find(status, "on", 1, true) then
       -- For the volume number percentage 
           volume = volume .. "%"
       else
       -- For displaying the mute status.
           volume = volume .. "X"
           
       end
       widget:set_markup(" 🔊 " .. volume)
    end

    update_volume(volume_widget)

    mytimer = timer({ timeout = 0.2 })
    mytimer:connect_signal("timeout", function () update_volume(volume_widget) end)
    mytimer:start()
    
    volume_widget:connect_signal("button::release", function () awful.spawn("pavucontrol") end)

    -----------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------------
    -- Mystery Button -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------

    function update_music(widget)
       local fd = io.popen("playerctl metadata title")
       local title = fd:read("*all")
       fd:close()

       if title == '' then
       -- When there is no track playing
           title = 'No track Playing'
       end
       widget:set_markup(title)
    end


    local media_icon = wibox.widget.textbox("♬: ")
    local media_text = wibox.widget.textbox()

    local media_box = wibox.widget {
       layout = wibox.container.scroll.horizontal,
       max_size = 150,
       step_function = wibox.container.scroll.step_functions.linear_increase,
       speed = 13,
       extra_space = 30,
       {
           widget = media_text
       }
    }

    local size_cont_media =  wibox.container.constraint(media_box, 'exact', nil, 30)
    centered_media_box = wibox.container.place(size_cont_media, 'center', 'left')

    update_music(media_text)

    -- mytimer = timer({ timeout = 0.2 })
    mytimer:connect_signal("timeout", function () update_music(media_text) end)

    -----------------------------------------------------------------------------------------------
    -- Create the wibox ---------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------
    s.mywibox = awful.wibar({ position = "bottom", screen = s, bg = beautiful.bg_wibar }) 
    
    -----------------------------------------------------------------------------------------------
    -- Add widgets to the wibox -------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacer,
--             mylauncher,
            s.taglist,
            -- s.mypromptbox,
            separator,
        },
        s.tasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacer,
            s.systray_widget,
            separator,
            media_icon,
            centered_media_box,
            separator,
            mykeyboardlayout,
            separator,
            volume_widget,
            separator,
            mytextclock,
            separator,
            s.layout_widget,
            s.logout,
            spacer
        },
    }
    -----------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------

end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({ }, 1, function () mymainmenu:hide() end),
    awful.button({ }, 3, function () mymainmenu:toggle() end)
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,           }, "z", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "=",     function () awful.tag.incmwfact( 0.05)                 end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "-",     function () awful.tag.incmwfact(-0.05)                 end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true)        end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true)        end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)           end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)           end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey     }, "b", function () awful.spawn(browser)          end,
              {description = "launch Browser", group = "launcher"}),
    awful.key({ modkey, "Control"}, "Escape", function () awful.spawn("/usr/bin/rofi -show drun -modi drun -theme oneDark") end,
              {description = "launch rofi", group = "launcher"}),
    awful.key({ modkey,           }, "e", function () awful.spawn(filemanager)            end,
              {description = "launch filemanager", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                       end,
              {description = "select previous", group = "layout"}),
     -- awful.key({ }, "Print", function () awful.util.spawn("ksnapshot") end),
    awful.key({                   }, "Print", function () awful.spawn.with_shell("sleep 0.1 && /usr/bin/maim -B --select ~/Pictures/screenshots/$(date +%F_%H-%M-%S).png")   end,
              {description = "capture a screenshot of selection", group = "screenshot"}),
    awful.key({"Control"          }, "Print", function () awful.spawn.with_shell("sleep 0.1 && /usr/bin/maim -i $(xdotool getactivewindow) -B ~/Pictures/screenshots/$(date +%F_%H-%M-%S).png")   end,
              {description = "capture a screenshot of active window", group = "screenshot"}),
    awful.key({"Shift"            }, "Print", function () awful.spawn.with_shell("sleep 0.1 && /usr/bin/maim --hidecursor ~/Pictures/screenshots/$(date +%F_%H-%M-%S).png")   end,
              {description = "capture a screenshot of whole screen", group = "screenshot"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "`",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey, "Shift"   }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "x",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey,         }, "f",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),
    awful.key({}, "XF86AudioRaiseVolume", 
        function () 
            awful.util.spawn("amixer -D pulse sset Master 5%+", false) 
        end, 
        {description = "Raise volume with media keys", group = "media"}),
    awful.key({}, "XF86AudioLowerVolume", 
        function () 
            awful.util.spawn("amixer -D pulse sset Master 5%-", false) 
        end, 
        {description = "lower volume with media keys", group = "media"}),
    awful.key({}, "XF86AudioMute", 
        function () 
            awful.util.spawn("amixer -D pulse sset Master toggle", false) 
        end, 
        {description = "Mute with media keys", group = "media"}),
    awful.key({}, "XF86AudioPlay", 
        function () 
            awful.util.spawn("playerctl play-pause", false) 
        end, 
        {description = "Play/Pause with media keys", group = "media"}),
    awful.key({}, "XF86AudioStop", 
        function () 
            awful.util.spawn("playerctl stop", false) 
        end, 
        {description = "Stop with media keys", group = "media"}),
    awful.key({}, "XF86AudioPrev", 
        function () 
            awful.util.spawn("playerctl previous", false) 
        end, 
        {description = "Previous with media keys", group = "media"}),
    awful.key({}, "XF86AudioNext", 
        function () 
            awful.util.spawn("playerctl next", false) 
        end, 
        {description = "Previous with media keys", group = "media"}),
     awful.key({modkey,           }, "l", 
        function () 
            awful.util.spawn("light-locker-command -l")
        end, 
        {description = "Lock Screen", group = "System"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise()
                 mymainmenu:hide() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

function titlebar(c)
    awful.titlebar.add(c, { modkey = modkey, height = 20, font = "Terminus 6"})
end


-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false, -- Remove gaps between terminals
                     screen = awful.screen.preferred,
                     callback = awful.client.setslave,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" } },
      except_any = { class = { "Code", "Google-chrome", "Opera", "firefox" } },
      properties = { titlebars_enabled = true }
    },
	
    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- 🌍 📜 ⏯️ 📦
    { rule = { class = "Firefox" }, properties = { screen = 1, tag = "🌍" } },
    { rule = { class = "Yandex-browser-beta" }, properties = { screen = 1, tag = "🌍" } },
    { rule = { class = "Transmission-gtk" }, properties = { screen = 1, tag = "🌍" } },
    { rule = { class = "Google-chrome" }, properties = { screen = 1, tag = "🌍" } },
    { rule = { class = "Brave-browser" }, properties = { screen = 1, tag = "🌍" } },
    { rule = { class = "Opera" }, properties = { screen = 1, tag = "🌍" } },
    { rule = { class = "Subl" }, properties = { screen = 1, tag = "📜" } },  
    { rule = { class = "gwenview" }, properties = { screen = 1, tag = "⏯️" } },  
    { rule = { class = "vlc" }, properties = { screen = 1, tag = "⏯️" } },  
    { rule = { class = "Gimp-2.10" }, properties = { screen = 1, tag = "⏯️" } }, 
    { rule = { class = "Vncviewer" }, properties = { screen = 1, tag = "📦" } }, 

    -- Rule to keep oblogout covering the whole screen & be on every tag
    { rule = { class = "Oblogout" }, properties = { fullscreen = true, sticky = true, opacity = 0.5 } }, 
  	
}
-- }}}

-- {{{ Signals


-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.closebutton(c),
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
        -- Hide the menubar if we are not floating
   -- local l = awful.layout.get(c.screen)
   -- if not (l.name == "floating" or c.floating) then
   --     awful.titlebar.hide(c)
   -- end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Disable borders on lone windows
-- Handle border sizes of clients.
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
  local clients = awful.client.visible(s)
  local layout = awful.layout.getname(awful.layout.get(s))

  for _, c in pairs(clients) do
    -- No borders with only one humanly visible client
    if c.maximized then
      -- NOTE: also handled in focus, but that does not cover maximizing from a
      -- tiled state (when the client had focus).
      c.border_width = 0
    elseif c.floating or layout == "floating" then
      c.border_width = beautiful.border_width
    elseif layout == "max" or layout == "fullscreen" then
      c.border_width = 0
    else
    --   local tiled = awful.client.tiled(c.screen)
    --   if #tiled == 1 then -- and c == tiled[1] then
        -- tiled[1].border_width = 0
        -- if layout ~= "max" and layout ~= "fullscreen" then
        -- XXX: SLOW!
        -- awful.client.moveresize(0, 0, 2, 0, tiled[1])
        -- end
    --   else
        c.border_width = beautiful.border_width
    --   end
    end
  end
end)
end

-- }}}

-- client.connect_signal("property::floating", function (c)
--    if c.floating then
--        awful.titlebar.show(c)
--    else
--        awful.titlebar.hide(c)
--    end
-- end)

-- Set client shape
client.connect_signal("manage", function (c)
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,3)
    end
end)

awful.spawn.with_shell("~/.config/awesome/autorun.sh")

-------------------------------------------------------
-- Titlebar mods --------------------------------------
-------------------------------------------------------
-- no tooltip
awful.titlebar.enable_tooltip = false
