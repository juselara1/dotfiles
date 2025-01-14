---Setups spacing for Lua files.
local function setup_spacing()
	vim.o.shiftwidth = 2
	vim.o.tabstop = 2
end

---Enables LSP servers.
local function setup_lsp()
	vim.lsp.enable({"terraformls"})
end

---Setups snippets.
local function setup_snippets()
	local ok, _ = pcall(require, "snippets.terraform")
	if not ok then
		vim.notify("Could not load Terraform snippets", vim.log.levels.WARN)
	end
end

---Main entrypoint.
local function main()
	setup_spacing()
	setup_lsp()
	setup_snippets()
end

main()
