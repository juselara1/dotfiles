return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"AckslD/nvim-trevJ.lua"
	},
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"python", "commonlisp", "bash", "c",
				"lua", "julia", "dockerfile",
				"gitignore", "markdown", "json",
				"terraform", "go", "cuda"
			},
			sync_install = true,
			auto_install = false,
			ignore_install = {},
			highlight = {
				enable = true,
				disable = { "latex", "tex" }
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "gan",
					node_decremental = "gdn"
				}
			},
			modules = {}
		}
	end,
}
