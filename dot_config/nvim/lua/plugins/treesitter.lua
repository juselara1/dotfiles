local Filetypes = {
	"lua",
	"python",
	"markdown",
	"markdown_inline",
	"c",
	"bash",
	"dockerfile",
	"gitignore",
	"json",
	"yaml",
	"toml",
	"terraform",
	"fennel",
}

---Setups Treesitter.
local function setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = Filetypes,
		sync_install = true,
		auto_install = false,
		highlight = {enable = true},
		incrementaL_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "gan",
				node_decremental = "gdn"
			}
		}
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	config = setup,
	ft = Filetypes
}
