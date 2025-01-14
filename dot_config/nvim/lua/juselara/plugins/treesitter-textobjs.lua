return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	lazy = true,
	config = function()
		require("nvim-treesitter.configs").setup {
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["a="] = {query = "@assignment.outer", desc="Around assignment"},
						["i="] = {query = "@assignment.inner", desc="Inside assignment"},
						["l="] = {query = "@assignment.lhs", desc="Left assignment"},
						["r="] = {query = "@assignment.rhs", desc="Right assignment"},

						["af"] = {query = "@function.outer", desc="Around function"},
						["if"] = {query = "@function.inner", desc="Inside function"},

						["ac"] = {query = "@class.outer", desc="Around class"},
						["ic"] = {query = "@class.inner", desc="Inside class"},
					}
				}
			}
		}
	end
}
