return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function ()
		require("aerial").setup {
			backends = { "treesitter", "lsp", "markdown", "man" },
			layout = {
				placemnt = "window",
				default_direction = "right"
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
