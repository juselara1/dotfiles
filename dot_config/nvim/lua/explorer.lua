---Setup netrw settings.
local function setup_netrw()
	vim.g.netrw_banner = 0
	vim.g.netrw_liststyle = 3
	vim.g.netrw_browse_split = 4
	vim.g.netrw_altv = 1
	vim.g.netrw_winsize = 20
	vim.g.netrw_bufsettings = "noma nomod nu rnu nobl ro"
end

---Setup netrw shortucts.
local function setup_netrw_keybindings()
	vim.keymap.set("n", "<leader>e", ":Lexplore<CR>", {
		silent = false,
		noremap = true,
		desc = "[E]xplorer.",
	})
end

---Main entrypoint.
local function main()
	setup_netrw()
	setup_netrw_keybindings()
end

main()

