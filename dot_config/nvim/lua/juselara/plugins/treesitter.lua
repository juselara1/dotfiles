return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"AckslD/nvim-trevJ.lua"
	},
	config = function()
		require("nvim-treesitter.configs").setup {
			sync_install = true,
			auto_install = true,
			ignore_install = {},
			highlight = {
				enable = true,
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
