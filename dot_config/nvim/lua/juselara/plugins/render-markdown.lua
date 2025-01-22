return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"},
	ft = {"markdown"},
	keys = {
		{
			"<leader>m",
			mode="n",
			":RenderMarkdown toggle",
			desc="Render Markdown"
		},
	}
}
