return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff" },
				json = { "jq" },
				jsonc = { "jq" },
				nix = { "alejandra" },
				terraform = { "terraform_fmt" },
				toml = { "tombi" },
				dockerfile = { "dockerfmt" },
        sh = {"shellharden"},
			},
		})
	end,
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({
					lsp_fallback = false,
				})
			end,
			desc = "[C]ode [F]ormat",
		},
	},
}
