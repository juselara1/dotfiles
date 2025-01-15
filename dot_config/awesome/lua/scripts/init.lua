local function setup(_)
	local awful = require("awful")
	awful.spawn.with_shell("picom")
	awful.spawn.with_shell(("feh --bg-scale %s"):format(os.getenv("HOME").."/.wallpaper.jpg"))
	awful.spawn.with_shell("polybar monitor1")
	awful.spawn.with_shell("polybar monitor2")
	awful.spawn.with_shell("polybar monitor3")
end

return {
	setup = setup
}
