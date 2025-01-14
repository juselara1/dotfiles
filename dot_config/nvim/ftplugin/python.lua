---Setups spacing for Lua files.
local function setup_spacing()
	vim.o.shiftwidth = 4
	vim.o.tabstop = 4
end

---Enables LSP servers.
local function setup_lsp()
	vim.lsp.enable({"jedi_language_server"})
end

---Setups snippets.
local function setup_snippets()
	local ok, _ = pcall(require, "snippets.python")
	if not ok then
		vim.notify("Could not load Python snippets", vim.log.levels.WARN)
	end
end

---Main entrypoint.
local function main()
	setup_spacing()
	setup_lsp()
	setup_snippets()
end

main()
