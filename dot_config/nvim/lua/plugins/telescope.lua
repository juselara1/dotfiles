return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>f",
			desc = "Fuzzy file",
		},
		{
			"<leader>b",
			desc = "Buffers",
		},
	},
	config = function()
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
			pickers = {
				buffers = {
					mappings = {
						n = {
							d = actions.delete_buffer,
						},
					},
				},
			},
		})

		vim.keymap.set(
			"n",
			"<leader>ff",
			builtin.find_files,
			{ noremap = true, silent = true, desc = "[F]uzzy [F]ile" }
		)
		vim.keymap.set(
			"n",
			"<leader>fb",
			builtin.buffers,
			{ noremap = true, silent = true, desc = "[F]uzzy [B]uffers" }
		)
	end,
}
