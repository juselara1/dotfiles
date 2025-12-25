return {
	"olimorris/codecompanion.nvim",
	version = "^18.0.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local provider = {
			name = "openai",
			model = "gpt-4o-mini",
		}
		require("codecompanion").setup({
			interactions = {
				chat = {
					adapter = provider,
				},
				inline = {
					adapter = provider,
				},
				cmd = {
					adapter = provider
				},
				background = {
					adapter = provider,
				},
			},
		})
	end,
}
