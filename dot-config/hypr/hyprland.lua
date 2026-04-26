-- ───Monitors───────────────────────────────────────────────────────────
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

hl.monitor({
	output = "desc:Lenovo",
	mode = "2240x1400@60",
	position = "0x0",
	scale = "auto",
	bitdepth = 10,
})

hl.monitor({
	output = "desc:AOC",
	mode = "1920x1080@120",
	position = "auto-up",
	scale = "auto",
})

-- # ───Workspaces────────────────────────────────────────────────────────

for i = 1, 5 do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = "HDMI-A-1",
		default = i == 1,
	})
end

for i = 6, 10 do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = "eDP-1",
		default = i == 6,
	})
end

-- ───Startup────────────────────────────────────────────────────────────

hl.workspace_rule({
	workspace = "11",
	monitor = "SUNSHINE",
	-- border = false,
	-- rounding = false,
	-- decorate = false,
	-- shadow = false,
})

hl.layer_rule({
	match = { namespace = "wofi" },
	no_anim = true,
})

hl.layer_rule({
	match = { namespace = "launcher" },
	no_anim = true,
})

hl.window_rule({
	match = { workspace = "11" },
	fullscreen = true,
	immediate = true,
	maximize = true,
})

hl.window_rule({
	match = { class = "gamescope-wrapped" },
	monitor = "SUNSHINE",
})

local FLOAT_CANDIDATES = {
	{ title = "Unlock Database- KeePassXC" },
	{ title = "Virtual Gamepad" },
	{ title = "KeePassXC- Passkey credentials" },
	{ title = "Authentication Required" },
}
for _, candidate in ipairs(FLOAT_CANDIDATES) do
	hl.window_rule({
		match = candidate,
		float = true,
	})
end

hl.window_rule({
	match = {
		fullscreen = true,
	},
	immediate = true,
})

hl.window_rule({
	match = { class = "zen" },
	scrolling_width = 1.0,
	workspace = "2",
})

hl.window_rule({
	match = { class = "keepassxc" },
	workspace = "8",
})

-- For all categories, see https://wiki.hyprland.org/Configuring/Variables/
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		follow_mouse = 0,
		touchpad = {
			natural_scroll = true,
		},
		sensitivity = 0.0,
		-- -1.0 - 1.0, 0 means no modification.
		accel_profile = "adaptive",
		force_no_accel = false,
	},
})

hl.config({
	general = {
		-- See https://wiki.hyprland.org/Configuring/Variables/ for more
		gaps_in = 0,
		gaps_out = 0,
		border_size = 3,
		col = {
			active_border = { colors = { "#33ccffee", "#00ff99ee" }, angle = 45 },
			inactive_border = "#595959aa",
		},
		layout = "scrolling",
	},
})

hl.config({
	cursor = {
		inactive_timeout = 5,
	},
})

hl.config({
	decoration = {
		-- See https://wiki.hyprland.org/Configuring/Variables/ for more
		rounding = 0,
		blur = {
			enabled = false,
			size = 5,
			passes = 2,
			new_optimizations = true,
		},
		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
	},
})

hl.config({
	animations = {
		enabled = true,
		-- Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
		--# Defaults
		-- animation = workspaces, 1, 6, default
		-- animation = windows, 1, 7, myBezier
		-- animation = windowsOut, 1, 7, default, popin 80%
		-- animation = fade, 1, 7, default
	},
})

hl.config({
	scrolling = {
		column_width = 0.95,
		fullscreen_on_one_column = true,
		focus_fit_method = 1,
		explicit_column_widths = "0.5, 0.7, 0.95, 1.0",
	},
})

hl.config({
	dwindle = {
		-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
		-- pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
		preserve_split = true,
		-- you probably want this
		default_split_ratio = 1.5,
	},
})

hl.config({
	master = {
		-- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
		new_status = "master",
		mfact = 0.6,
	},
})

hl.config({
	misc = {
		enable_swallow = false,
		swallow_regex = "^(ghostty|Alacritty|kitty|footclient)$",
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

hl.config({
	gestures = {
		-- See https://wiki.hyprland.org/Configuring/Variables/ for more
	},
})

hl.config({
	xwayland = {
		enabled = true,
		force_zero_scaling = true,
	},
})

local mainMod = "SUPER"
local secondaryMod = "SUPER + SHIFT"
-- Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
hl.bind(mainMod .. " + " .. "Return", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + " .. "E", hl.dsp.window.close())
hl.bind(secondaryMod .. " + " .. "E", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(secondaryMod .. " + " .. "Q", hl.dsp.exec_cmd("uwsm stop"))
hl.bind("F10", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/powermenu"))
hl.bind(mainMod .. " + " .. "P", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/quickclip"))
hl.bind(secondaryMod .. " + " .. "S", hl.dsp.window.float())
hl.bind(
	mainMod .. " + " .. "Space",
	hl.dsp.exec_cmd("sh -c 'exec $(tofi-run --require-match=false --fuzzy-match=true)'")
)
hl.bind(secondaryMod .. " + " .. "D", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/emoji-selector"))
-- Apps
hl.bind("SUPER + ALT" .. " + " .. "B", hl.dsp.exec_cmd(os.getenv("BROWSER")))
hl.bind("SUPER + ALT" .. " + " .. "D", hl.dsp.exec_cmd("dev.vencord.Vesktop"))
hl.bind("SUPER + ALT" .. " + " .. "W", hl.dsp.exec_cmd("nsxiv -a -f -t /home/media/Sync/Wallpapers"))
-- hyprscrolling
hl.bind(mainMod .. " + " .. "h", hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + " .. "l", hl.dsp.layout("move +col"))
hl.bind(secondaryMod .. " + " .. "h", hl.dsp.layout("swapcol l"))
hl.bind(secondaryMod .. " + " .. "l", hl.dsp.layout("swapcol r"))
-- bind = $secondaryMod, k, layoutmsg, movewindowto u
-- bind = $secondaryMod, j, layoutmsg, movewindowto d
hl.bind("SUPER + ALT" .. " + " .. "h", hl.dsp.layout("colresize -conf"))
hl.bind("SUPER + ALT" .. " + " .. "l", hl.dsp.layout("colresize +conf"))
-- hyprexpo
-- bind = $mainMod, g, hyprexpo:expo, toggle
-- # Move focus with mainMod + hjkl keys
-- bind = $mainMod, h, movefocus, l
-- bind = $mainMod, l, movefocus, r
-- bind = $mainMod, k, movefocus, u
-- bind = $mainMod, j, movefocus, d
--
-- # Move window with mainMod + shift + hjkl keys
-- bind = $secondaryMod, h, movewindow, l
-- bind = $secondaryMod, l, movewindow, r
-- bind = $secondaryMod, k, movewindow, u
-- bind = $secondaryMod, j, movewindow, d

-- Switch workspaces with mainMod + [0-9]
for i = 1, 11 do
	key = tostring(i)
	if i == 10 then
		key = tostring(0)
	end
	if i == 11 then
		key = "minus"
	end
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 11 do
	key = tostring(i)
	if i == 10 then
		key = tostring(0)
	elseif i == 11 then
		key = "minus"
	end
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end

-- TODO: manual review (unknown dispatcher: swapactiveworkspaces)
-- hl.bind("$mainMod + S", hl.dsp.swapactiveworkspaces("HDMI-A-1 eDP-1"))
hl.bind(mainMod .. " + " .. "M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + " .. "F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
-- hl.bind(mainMod .. " + " .. "G", hl.dsp.layout("swapwithmaster"))

-- Scroll through existing workspaces with mainMod + scroll

hl.bind(mainMod .. " + " .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + " .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging

hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl high"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl low"))

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -m"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Scratchpads
hl.bind(mainMod .. " + " .. "U", hl.dsp.exec_cmd("pypr-client toggle term"))
hl.bind(secondaryMod .. " + " .. "Y", hl.dsp.exec_cmd("pypr-client toggle top"))
hl.bind(secondaryMod .. " + " .. "M", hl.dsp.exec_cmd("pypr-client toggle music"))
hl.bind(secondaryMod .. " + " .. "F", hl.dsp.exec_cmd("pypr-client toggle fm"))
hl.bind(secondaryMod .. " + " .. "P", hl.dsp.exec_cmd("pypr-client toggle volume"))

-- Lid Switch

--# Sleep on lid close

hl.bind(
	"switch:on:Lid Switch",
	hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/sleep_on_lid"),
	{ locked = true }
)

-- bindl = , switch:on:Lid Switch, exec, systemctl suspend-then-hibernate

--# Lock screen on lid close

-- bindl = , switch:on:Lid Switch, exec, loginctl lock-session && sleep 1 && hyprctl dispatch dpms off

-- bindl = , switch:on:Lid Switch, exec, sleep 1 && hyprctl dispatch dpms off

hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("sleep 1 && hyprctl dispatch dpms on"), { locked = true })

hl.bind(
	mainMod .. " + " .. "V",
	hl.dsp.exec_cmd("cliphist list| wofi -S dmenu| cliphist decode| wl-copy --type text/plain")
)

-- Screenshot

hl.bind("F12", hl.dsp.exec_cmd("fish -c grim -g (slurp) ~/Screenshots/screenshot_(date  +%Y-%m-%dT%H:%M:%S%Z).png"))

-- Dunst

hl.bind("CTRL" .. " + " .. "space", hl.dsp.exec_cmd("makoctl dismiss --all"))

hl.bind("CTRL" .. " + " .. "grave", hl.dsp.exec_cmd("makoctl restore"))

hl.bind("CTRL + SHIFT" .. " + " .. "period", hl.dsp.exec_cmd("makoctl menu bemenu"))

-- xwaylandvideobridge

-- windowrulev2 = opacity 0.0 override, class:^(xwaylandvideobridge)$

-- windowrulev2 = noanim, class:^(xwaylandvideobridge)$

-- windowrulev2 = noinitialfocus, class:^(xwaylandvideobridge)$

-- windowrulev2 = maxsize 1 1, class:^(xwaylandvideobridge)$

-- windowrulev2 = noblur, class:^(xwaylandvideobridge)$

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("source " .. os.getenv("HOME") .. "/.profile")
	hl.exec_cmd("pypr")
	hl.exec_cmd("playerctld daemon")
	hl.exec_cmd("autoadb ~/scripts/android-webcam.sh")
	hl.exec_cmd("blueman-applet & nm-applet & pcmanfm -d")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprctl dispatch workspace 1")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("wl-clip-persist --clipboard regular")
	hl.exec_cmd("uwsm finalize")
	hl.exec_cmd("hyprlock")
end)
