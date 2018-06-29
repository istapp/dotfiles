
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local config = { }

function config.init(context)

    context.keys = context.keys or { }
    context.mouse = context.mouse or { }

    context.keys.short = { }
    context.keys.short.m = context.keys.modkey
    context.keys.short.a = context.keys.altkey
    context.keys.short.c = context.keys.ctrlkey
    context.keys.short.s = context.keys.shiftkey
    context.keys.short.l = context.keys.leftkey
    context.keys.short.r = context.keys.rightkey
    context.keys.short.u = context.keys.upkey
    context.keys.short.d = context.keys.downkey

    local k           = context.keys.short
    local terminal    = context.vars.terminal
    local browser     = context.vars.browser

    -- Exit mode
    context.keys.escape =
        awful.key({                    }, "Escape", context.util.exit_keys_mode,
                  { description = "exit mode", group = "awesome" })

    -- Global key bindings
    context.keys.global = gears.table.join(
        -- Awesome Hotkeys
        awful.key({ k.m, k.c           }, "s", hotkeys_popup.show_help,
                  { description = "show help", group = "awesome" }),
        awful.key({ k.m, k.c           }, "w", function() awful.util._mainmenu:show() end,
                  { description = "show main menu", group = "awesome" }),
        awful.key({ k.m, k.c           }, "r", awesome.restart,
                  { description = "reload awesome", group = "awesome" }),
        awful.key({ k.m, k.c           }, "q", awesome.quit,
                  { description = "quit awesome", group = "awesome" }),
        awful.key({ k.m, k.c           }, "z", function() awful.spawn("sync"); awful.spawn("xautolock -locknow") end,
                  { description = "lock screen", group = "awesome" }),

        -- Switch to alternative theme
        awful.key({ k.m, k.a           }, "z", context.util.alternate_theme,
                  { description = "switch to alternative theme", group = "awesome" }),

        -- Hotkeys
        awful.key({ k.m                }, "Return", function() awful.spawn(terminal) end,
                  { description = "open a terminal", group = "launcher" }),
        awful.key({ k.m, k.c           }, "Return", function() awful.spawn(terminal,
                  { floating = true, placement = awful.placement.centered }) end,
                  { description = "open a floating terminal", group = "launcher" }),
        awful.key({ k.m                }, "b", function() awful.spawn(browser) end,
                  { description = "open browser", group = "launcher" }),
        awful.key({ k.m                }, "e", function() awful.spawn("thunderbird") end,
                  { description = "open email client", group = "launcher" }),
        awful.key({ k.m                }, "w", function() awful.spawn("Whatsapp") end,
                  { description = "open whatsapp", group = "launcher" }),

        -- Screenshot
        awful.key({                    }, "Print", function()
            awful.spawn(context.vars.scripts_dir .. "/make-screenshot")
        end,
                  { description = "take screenshot", group = "screenshot" }),
        awful.key({ k.s                }, "Print", function()
            awful.spawn(context.vars.scripts_dir .. "/make-screenshot -s")
        end,
                  { description = "take screenshot, select area", group = "screenshot" }),
        awful.key({ k.c                }, "Print", function()
            awful.spawn(context.vars.scripts_dir .. "/make-screenshot -C")
        end,
                  { description = "take screenshot, hide mouse", group = "screenshot" }),
        awful.key({ k.c, k.s           }, "Print", function()
            awful.spawn(context.vars.scripts_dir .. "/make-screenshot -sC")
        end,
                  { description = "take screenshot, hide mouse, select area", group = "screenshot" }),
        awful.key({ k.m                }, "Print", function()
            awful.spawn(context.vars.scripts_dir .. "/make-screenshot -t")
        end,
                  { description = "wait 5s, take screenshot", group = "screenshot" }),
        awful.key({ k.m, k.c           }, "Print", function()
            awful.spawn(context.vars.scripts_dir .. "/make-screenshot -tH")
        end,
                  { description = "wait 5s, take screenshot, hide mouse", group = "screenshot" }),
        awful.key({ k.a                }, "Print", function()
            awful.spawn(context.vars.scripts_dir .. "/upload-to-imgur")
        end,
                  { description = "upload last screenshot to Imgur", group = "screenshot" }),

        -- -- Copy primary to clipboard (terminals to gtk)
        -- awful.key({ k.m }, "c", function() awful.spawn("xsel | xsel -i -b") end),
        -- -- Copy clipboard to primary (gtk to terminals)
        -- awful.key({ k.m }, "v", function() awful.spawn("xsel -b | xsel") end),

        -- Prompt
        awful.key({ k.m                }, "r", function() awful.screen.focused()._promptbox:run() end,
                  { description = "run prompt", group = "launcher" }),
        awful.key({ k.m                }, "p", function() menubar.show() end,
                  { description = "show the menubar", group = "launcher" }),
        awful.key({ k.m                }, "-", function()
            context.util.easy_async_with_unfocus("rofi -show drun")
            -- awful.spawn("dmenu_run")
            -- awful.spawn(string.format("dmenu_run -i -t -dim 0.5 -p 'Run: ' -h 21 -fn 'Meslo LG S for Powerline-10' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
            -- beautiful.tasklist_bg_normal, beautiful.fg_normal, beautiful.tasklist_bg_urgent, beautiful.tasklist_fg_urgent))
        end,
                  { description = "show application menu (rofi)", group = "launcher" }),
        awful.key({ k.m                }, ".", function()
            context.util.easy_async_with_unfocus("rofi -show run")
        end,
                  { description = "show commands menu (rofi)", group = "launcher" }),
        awful.key({ k.m                }, "$", function()
            context.util.easy_async_with_unfocus(context.vars.scripts_dir .. "/rofi-session")
        end,
                  { description = "show session menu (rofi)", group = "launcher" }),
        -- awful.key({ k.a                }, "space", function()
        --     -- awful.spawn(string.format("dmenu_run -i -fn 'Meslo LG S for Powerline' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
        --     awful.spawn(string.format("rofi -show run -width 100 -location 1 -lines 5 -bw 2 -yoffset -2",
        --     beautiful.tasklist_bg_normal, beautiful.tasklist_fg_normal, beautiful.tasklist_bg_urgent, beautiful.tasklist_fg_urgent))
        -- end),
        awful.key({ k.m                }, "x", function()
                      awful.prompt.run {
                          prompt       = "Run Lua code: ",
                          textbox      = awful.screen.focused()._promptbox.widget,
                          exe_callback = awful.util.eval,
                          history_path = gears.filesystem.get_cache_dir() .. "/history_eval",
                      }
                  end,
                  { description = "lua execute prompt", group = "awesome" }),

        -- Dropdown application
        awful.key({ k.m                }, "y", function() awful.screen.focused().quake:toggle() end,
                  { description = "open quake application", group = "screen" }),

        -- Screen browsing
        awful.key({ k.c, k.a           }, k.l, function() awful.screen.focus_relative(-1) end,
                  { description = "focus the previous screen", group = "screen" }),
        awful.key({ k.c, k.a           }, k.r, function() awful.screen.focus_relative(1) end,
                  { description = "focus the next screen", group = "screen" }),

        -- -- Tag browsing
        -- awful.key({ k.c, k.a           }, k.l, awful.tag.viewprev,
        --           { description = "view previous", group = "tag" }),
        -- awful.key({ k.c, k.a           }, k.r, awful.tag.viewnext,
        --           { description = "view next", group = "tag" }),
        -- awful.key({ k.c, k.a           }, "Escape", awful.tag.history.restore,
        --           { description = "go back", group = "tag" }),

        -- Dynamic tagging
        awful.key({ k.m, k.a           }, k.l, function() lain.util.move_tag(-1) end,
                  { description = "move tag backward", group = "tag" }),
        awful.key({ k.m, k.a           }, k.r, function() lain.util.move_tag(1) end,
                  { description = "move tag forward", group = "tag" }),
        awful.key({ k.m, k.a           }, "n", function() lain.util.add_tag() end,
                  { description = "new tag", group = "tag" }),
        awful.key({ k.m, k.a           }, "r", function() lain.util.rename_tag() end,
                  { description = "rename tag", group = "tag" }),
        awful.key({ k.m, k.a           }, "d", function() lain.util.delete_tag() end,
                  { description = "delete tag", group = "tag" }),
        awful.key({ k.m, k.a           }, "a", function()
                for i = 1, 9 do
                    awful.tag.add(tostring(i), {
                        screen = awful.screen.focused(),
                        layout = layout or awful.layout.suit.tile,
                    })
                end
            end,
                  { description = "add row of tags", group = "tag" }),
        awful.key({ k.m, k.a           }, "BackSpace", awful.tag.history.restore,
                  { description = "go back", group = "tag" }),

        -- Non-empty tag browsing
        awful.key({ k.m, k.c           }, k.l, function() lain.util.tag_view_nonempty(-1) end,
                  { description = "view previous nonempty", group = "tag" }),
        awful.key({ k.m, k.c           }, k.r, function() lain.util.tag_view_nonempty(1) end,
                  { description = "view next nonempty", group = "tag" }),

        -- Select tag in grid
        awful.key({ k.m                }, k.l, function() context.util.select_tag_in_grid("l") end,
                  { description = "view previous", group = "tag" }),
        awful.key({ k.m                }, k.r, function() context.util.select_tag_in_grid("r") end,
                  { description = "view next", group = "tag" }),
        awful.key({ k.m, k.c           }, k.u, function() context.util.select_tag_in_grid("u") end,
                  { description = "view above", group = "tag" }),
        awful.key({ k.m, k.c           }, k.d, function() context.util.select_tag_in_grid("d") end,
                  { description = "view below", group = "tag" }),

        -- Move client to tag in grid
        awful.key({ k.m, k.c, k.s      }, k.l, function() context.util.move_client_in_grid("l") end,
                  { description = "move to previous tag", group = "client" }),
        awful.key({ k.m, k.c, k.s      }, k.r, function() context.util.move_client_in_grid("r") end,
                  { description = "move to next tag", group = "client" }),
        awful.key({ k.m, k.c, k.s      }, k.u, function() context.util.move_client_in_grid("u") end,
                  { description = "move to tag above", group = "client" }),
        awful.key({ k.m, k.c, k.s      }, k.d, function() context.util.move_client_in_grid("d") end,
                  { description = "move to tag below", group = "client" }),

        -- Client manipulation
        awful.key({ k.m                }, k.u, function() awful.client.focus.byidx(-1) end,
                  { description = "focus previous client by index", group = "client" }),
        awful.key({ k.m                }, k.d, function() awful.client.focus.byidx(1) end,
                  { description = "focus next client by index", group = "client" }),
        awful.key({ k.m, k.s           }, k.u, function() awful.client.swap.byidx(-1) end,
                  { description = "swap with previous client by index", group = "client" }),
        awful.key({ k.m, k.s           }, k.d, function() awful.client.swap.byidx(1) end,
                  { description = "swap with next client by index", group = "client" }),
        awful.key({ k.m                }, "u", awful.client.urgent.jumpto,
                  { description = "jump to urgent client", group = "client" }),

        awful.key({ k.m, k.a           }, k.u, function()
            awful.client.cycle(false)
            awful.client.focus.byidx(1)
        end,
                  { description = "counterclockwise cycle", group = "client" }),
        awful.key({ k.m, k.a           }, k.d, function()
            awful.client.cycle(true)
            awful.client.focus.byidx(-1)
        end,
                  { description = "clockwise cycle", group = "client" }),

        awful.key({ k.m,               }, "Tab", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
                  { description = "go back", group = "client" }),

        awful.key({ k.m, k.c           }, "n", function()
            local c = awful.client.restore()
            if c then
                client.focus = c
                c:raise()
            end
        end,
                  { description = "restore minimized", group = "client" }),

        -- Layout manipulation
        awful.key({ k.m, k.s           }, k.r, function() awful.tag.incmwfact(0.01) end,
                  { description = "increase master width factor", group = "layout" }),
        awful.key({ k.m, k.s           }, k.l, function() awful.tag.incmwfact(-0.01) end,
                  { description = "decrease master width factor", group = "layout" }),
        awful.key({ k.m, k.a, k.s      }, k.u, function() awful.tag.incnmaster(1, nil, true) end,
                  { description = "increase the number of master clients", group = "layout" }),
        awful.key({ k.m, k.a, k.s      }, k.d, function() awful.tag.incnmaster(-1, nil, true) end,
                  { description = "decrease the number of master clients", group = "layout" }),
        awful.key({ k.m, k.a, k.s      }, k.r, function() awful.tag.incncol(1, nil, true) end,
                  { description = "increase the number of slave columns", group = "layout" }),
        awful.key({ k.m, k.a, k.s      }, k.l, function() awful.tag.incncol(-1, nil, true) end,
                  { description = "decrease the number of slave columns", group = "layout" }),
        awful.key({ k.m,               }, "space", function() awful.layout.inc(1) end,
                  { description = "select next", group = "layout" }),
        awful.key({ k.m, k.s           }, "space", function() awful.layout.inc(-1) end,
                  { description = "select previous", group = "layout" }),

        -- Show/Hide Wibox
        awful.key({ k.m, k.c           }, "b", function()
            for s in screen do
                s._wibox.visible = not s._wibox.visible
                if s._bottomwibox then
                    s._bottomwibox.visible = not s._bottomwibox.visible
                end
            end
        end),

        -- ALSA volume control
        awful.key({                    }, "XF86AudioRaiseVolume", function()
            awful.spawn.easy_async(string.format("amixer -q set %s 1%%+", beautiful.volume.channel),
            function(stdout, stderr, reason, exit_code) --luacheck: no unused args
                beautiful.volume.manual = true
                beautiful.volume.update()
            end)
        end),
        awful.key({                    }, "XF86AudioLowerVolume", function()
            awful.spawn.easy_async(string.format("amixer -q set %s 1%%-", beautiful.volume.channel),
            function(stdout, stderr, reason, exit_code) --luacheck: no unused args
                beautiful.volume.manual = true
                beautiful.volume.update()
            end)
        end),
        awful.key({                    }, "XF86AudioMute", function()
            awful.spawn.easy_async(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel),
            function(stdout, stderr, reason, exit_code) --luacheck: no unused args
                beautiful.volume.manual = true
                beautiful.volume.update()
            end)
        end),
        awful.key({ k.c                }, "XF86AudioRaiseVolume", function()
            awful.spawn.easy_async(string.format("amixer -q set %s 100%%", beautiful.volume.channel),
            function(stdout, stderr, reason, exit_code) --luacheck: no unused args
                beautiful.volume.manual = true
                beautiful.volume.update()
            end)
        end),
        awful.key({ k.c                }, "XF86AudioLowerVolume", function()
            awful.spawn.easy_async(string.format("amixer -q set %s 0%%", beautiful.volume.channel),
            function(stdout, stderr, reason, exit_code) --luacheck: no unused args
                beautiful.volume.manual = true
                beautiful.volume.update()
            end)
        end),
        awful.key({ k.c                }, "XF86AudioMute", function()
            awful.spawn.easy_async(string.format("amixer -q set %s mute", beautiful.volume.togglechannel or beautiful.volume.channel),
            function(stdout, stderr, reason, exit_code) --luacheck: no unused args
                beautiful.volume.manual = true
                beautiful.volume.update()
            end)
        end),

        -- Backlight / Brightness
        awful.key({                    }, "XF86MonBrightnessUp", function()
            awful.spawn("light -A 2")
        end),
        awful.key({                    }, "XF86MonBrightnessDown", function()
            awful.spawn.easy_async_with_shell("light -G",
            function(stdout, stderr, reason, exit_code) --luacheck: no unused args
                if tonumber(stdout) > 2 then
                    awful.spawn("light -U 2")
                end
            end)
        end),
        awful.key({ k.c                }, "XF86MonBrightnessUp", function()
            awful.spawn("light -S 100")
        end),
        awful.key({ k.c                }, "XF86MonBrightnessDown", function()
            awful.spawn("light -S 1")
        end),

        -- -- Backlight / Brightness (using xbacklight)
        -- awful.key({ }, "XF86MonBrightnessUp",
        --     function()
        --         awful.spawn("xbacklight -inc 2 -time 1 -steps 1")
        --     end),
        -- awful.key({ }, "XF86MonBrightnessDown",
        --     function()
        --         awful.spawn.easy_async_with_shell("xbacklight -get | sed 's/\\..*//'",
        --         function(stdout, stderr, reason, exit_code)
        --             if tonumber(stdout) > 2 then
        --                 awful.spawn("xbacklight -dec 2 -time 1 -steps 1")
        --             end
        --         end)
        --     end),
        -- awful.key({ k.c }, "XF86MonBrightnessUp",
        --     function()
        --         awful.spawn("xbacklight -set 100 -time 1 -steps 1")
        --     end),
        -- awful.key({ k.c }, "XF86MonBrightnessDown",
        --     function()
        --         awful.spawn("xbacklight -set 1 -time 1 -steps 1")
        --     end),

        -- MPD control
        awful.key({                    }, "XF86AudioPlay", function()
            awful.spawn.with_shell("mpc toggle")
            beautiful.mpd.update()
        end),
        awful.key({ k.c                }, "XF86AudioPlay", function()
            awful.spawn.with_shell("mpc stop")
            beautiful.mpd.update()
        end),
        awful.key({                    }, "XF86AudioPrev", function()
            awful.spawn.with_shell("mpc prev")
            beautiful.mpd.update()
        end),
        awful.key({                    }, "XF86AudioNext", function()
            awful.spawn.with_shell("mpc next")
            beautiful.mpd.update()
        end),
        awful.key({ k.a                }, "0", function()
            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            if beautiful.mpd.timer.started then
                beautiful.mpd.timer:stop()
                common.text = common.text .. lain.util.markup.bold("OFF")
            else
                beautiful.mpd.timer:start()
                common.text = common.text .. lain.util.markup.bold("ON")
            end
            naughty.notify(common)
        end)
    )

    -- Bind all key numbers to tags.
    -- NOTE: Using keycodes to make it works on any keyboard layout.
    for i = 1, 10 do
        context.keys.global = gears.table.join(context.keys.global,
            -- View tag only.
            awful.key({ k.m                }, "#" .. i + 9, function()
                local _screen = awful.screen.focused()
                local _tag = _screen.tags[i]
                if _tag then
                    _tag:view_only()
                end
            end),

            -- Toggle tag display.
            awful.key({ k.m, k.c           }, "#" .. i + 9, function()
                local _screen = awful.screen.focused()
                local _tag = _screen.tags[i]
                if _tag then
                    awful.tag.viewtoggle(_tag)
                end
            end),

            -- Move client to tag.
            awful.key({ k.m, k.s           }, "#" .. i + 9, function()
                if client.focus then
                    local _tag = client.focus.screen.tags[i]
                    if _tag then
                        client.focus:move_to_tag(_tag)
                    end
                end
            end),

            -- Move client to tag and view it.
            awful.key({ k.m, k.c, k.s      }, "#" .. i + 9, function()
                if client.focus then
                    local _tag = client.focus.screen.tags[i]
                    if _tag then
                        client.focus:move_to_tag(_tag)
                        _tag:view_only()
                    end
                end
            end),

            -- Toggle tag on focused client.
            awful.key({ k.m, k.a           }, "#" .. i + 9, function()
                if client.focus then
                    local _tag = client.focus.screen.tags[i]
                    if _tag then
                        client.focus:toggle_tag(_tag)
                    end
                end
            end)
        )
    end

--    -- Fake bindings for description
--    gears.table.join(context.keys.global,
--        -- View tag only.
--        awful.key({ k.m                }, "1..9", nil,
--                  { description = "view tag", group = "numeric keys" }),
--
--        -- Toggle tag display.
--        awful.key({ k.m, k.c           }, "1..9", nil,
--                  { description = "toggle tag", group = "numeric keys" }),
--
--        -- Move client to tag.
--        awful.key({ k.m, k.s           }, "1..9", nil,
--                  { description = "move focused client to tag", group = "numeric keys" }),
--
--        -- Move client to tag and view it.
--        awful.key({ k.m, k.c, k.s      }, "1..9", nil,
--                  { description = "move focused client to tag and view it", group = "numeric keys" }),
--
--        -- Toggle tag on focused client.
--        awful.key({ k.m, k.a           }, "1..9", nil,
--                  { description = "toggle focused client on tag", group = "numeric keys" })
--    )
--
    -- Set keys
    root.keys(context.keys.global)

    -- Mouse bindings
    context.mouse.global = gears.table.join(
        awful.button({                    }, 3, function() awful.util._mainmenu:toggle() end)
        -- awful.button({                    }, 4, awful.tag.viewnext),
        -- awful.button({                    }, 5, awful.tag.viewprev)
    )

    -- Set buttons
    root.buttons(context.mouse.global)

end

return config
