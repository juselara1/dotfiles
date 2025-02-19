return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function ()
		require("aerial").setup {
			backends = { "treesitter", "lsp", "markdown", "man" },
			max_width = {0.5, 40},
			layout = {
				placement = "window",
				default_direction = "float",
				resize_to_content = true
			}
		}
	end,
	keys = {
		{
			"<leader>a",
			mode="n",
			":AerialToggle<CR>",
			desc="Aerial outline"
		}
	}
}
