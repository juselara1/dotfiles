---Setups spacing for Lua files.
local function setup_spacing()
	vim.o.shiftwidth = 2
	vim.o.tabstop = 2
end

---Setups snippets.
local function setup_snippets()
	local ok, _ = pcall(require, "snippets.fennel")
	if not ok then
		vim.notify("Could not load Fennel snippets", vim.log.levels.WARN)
	end
end

---Main entrypoint.
local function main()
	setup_spacing()
	setup_snippets()
end

main()
