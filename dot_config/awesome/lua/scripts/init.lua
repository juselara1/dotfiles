local function setup(_)
	local awful = require("awful")
	awful.spawn.with_shell("picom")
	awful.spawn.with_shell(("feh --bg-scale %s"):format(os.getenv("HOME").."/.wallpaper.jpg"))
end

return {
	setup = setup
}
