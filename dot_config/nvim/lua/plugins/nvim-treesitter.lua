return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		if vim.fn.executable("tree-sitter-cli") then
			local languages = {
				"c",
				"json",
				"lua",
				"python",
				"toml",
				"go",
				"dockerfile",
			}
			local treesitter = require("nvim-treesitter")
			treesitter.install(languages)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,
				callback = function()
					vim.treesitter.start()
				end,
			})
		else
			logging.warning("[treesitter] `tree-sitter-cli` command not found")
		end
	end,
}
