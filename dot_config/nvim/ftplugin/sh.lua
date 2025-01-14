---Setups spacing for Lua files.
local function setup_spacing()
	vim.o.shiftwidth = 4
	vim.o.tabstop = 4
end

---Setups snippets.
local function setup_snippets()
	local ok, _ = pcall(require, "snippets.sh")
	if not ok then
		vim.notify("Could not load Shell snippets", vim.log.levels.WARN)
	end
end

---Main entrypoint.
local function main()
	setup_spacing()
	setup_snippets()
end

main()
