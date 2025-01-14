local Filetypes = {
	"lua",
	"python",
	"markdown",
	"markdown_inline",
	"c",
	"bash",
	"dockerfile",
	"gitignore",
	"json",
	"yaml",
	"toml",
	"terraform",
	"fennel",
}

local function setup()
	require("nvim-treesitter.configs").setup({
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["a="] = { query = "@assignment.outer", desc = "[A]round [=]" },
					["i="] = { query = "@assignment.inner", desc = "[I]nside [=]" },
					["l="] = { query = "@assignment.lhs", desc = "[L]eft [=]" },
					["r="] = { query = "@assignment.rhs", desc = "[R]ight [=]" },
					["af"] = { query = "@function.outer", desc = "[A]round [F]unction" },
					["if"] = { query = "@function.inner", desc = "[I]nside [F]unction" },
					["ac"] = { query = "@class.outer", desc = "[A]round [C]lass" },
					["ic"] = { query = "@class.inner", desc = "[I]nside [C]lass" },
				},
			},
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = setup,
	ft = Filetypes,
}
