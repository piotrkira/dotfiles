hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "1",
})

local terminal = "ghostty"
local browser  = "firefox"
local menu     = "bemenu-run"


-- autostart --
hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("waybar")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("kanshi")
end)


hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-- looks --
hl.config({
  general = {
    gaps_in     = 5,
    gaps_out    = 10,
    border_size = 3,
    col         = {
      active_border   = "rgba(a7c080ff)",
      inactive_border = "rgba(595959aa)",
    },
    layout      = "master",
  },
  decoration = {
    rounding         = 0,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    shadow           = { enabled = false },
    blur             = { enabled = false },
  },
  animations = {
    enabled = false,
  },
})


-- smart gaps --
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
  name        = "no-gaps-wtv1",
  match       = { float = false, workspace = "w[tv1]" },
  border_size = 0,
  rounding    = 0,
})
hl.window_rule({
  name        = "no-gaps-f1",
  match       = { float = false, workspace = "f[1]" },
  border_size = 0,
  rounding    = 0,
})

hl.config({
  dwindle = {
    preserve_split = true,
  },
})

hl.config({
  master = {
    new_status = "master",
  },
})

hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

-- misc --
hl.config({
  misc = {
    force_default_wallpaper        = 0,
    disable_hyprland_logo          = true,
    disable_splash_rendering       = true,
    enable_swallow                 = true,
    swallow_regex                  = "Alacritty|com.mitchellh.ghostty",
    exit_window_retains_fullscreen = true,
    on_focus_under_fullscreen      = 1,
  },
})

hl.config({
  binds = {
    movefocus_cycles_fullscreen = true,
  }
})

-- input --
hl.config({
  input = {
    kb_layout    = "pl",
    kb_options   = "",
    follow_mouse = 1,
    sensitivity  = 0,
    touchpad     = {
      natural_scroll = true,
      scroll_factor = 0.8
    },
  },
})

hl.config({
  gestures = {
    workspace_swipe_cancel_ratio = 0.1,
  }
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

hl.device({
  name = "at-translated-set-2-keyboard",
  kb_options = "caps:swapescape"
})


-- keys --
local mainMod = "SUPER"
local subMod = mainMod .. " + SHIFT"

hl.define_submap("open", "reset", function()
  hl.bind("T", hl.dsp.exec_cmd(terminal))
  hl.bind("B", hl.dsp.exec_cmd(browser))
  hl.bind("catchall", hl.dsp.submap("reset"))
end)
hl.bind(mainMod .. " + O", hl.dsp.submap("open"))

hl.define_submap("system", "reset", function()
  hl.bind("S",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
  hl.bind("R", hl.dsp.exec_cmd("reboot"))
  hl.bind("L", hl.dsp.exec_cmd("loginctl lock-session"))
  hl.bind("catchall", hl.dsp.submap("reset"))
end)
hl.bind(mainMod .. " + S", hl.dsp.submap("system"))

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(subMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(subMod .. " + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(subMod .. " + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(subMod .. " + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(subMod .. " + J", hl.dsp.window.swap({ direction = "down" }))

for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.window_rule({
  name           = "suppress-maximize-events",
  match          = { class = ".*" },
  suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})
