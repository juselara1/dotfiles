return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {"nvim-lua/plenary.nvim"},
	keys = {
		{
			"<leader>f",
			desc = "Fuzzy file"
		},
		{
			"<leader>b",
			desc = "Buffers"
		}
	},
	config = function ()
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local telescope = require("telescope")
		telescope.setup{
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					}
				}
			}
		}

		vim.keymap.set('n', "<leader>f", builtin.find_files, {noremap = true, silent=true, desc="Fuzzy file"})
		vim.keymap.set('n', "<leader>b", builtin.buffers, {noremap = true, silent=true, desc="Buffers"})
	end
}
