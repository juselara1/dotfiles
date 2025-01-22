return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function ()
		require("aerial").setup {
			backends = { "treesitter", "lsp", "markdown", "man" },
			layout = {
				max_width = {0.3},
				min_width = {0.1}
				placement = "edge",
				default_direction = "float"
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
