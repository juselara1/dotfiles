local function setup()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
			},
		},
	})

	vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true, desc = "[F]ind [F]ile" })
	vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true, silent = true, desc = "[F]ind [B]uffer" })
	vim.keymap.set("n", "<leader>fc", builtin.commands, { noremap = true, silent = true, desc = "[F]ind [C]ommands" })
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true, silent = true, desc = "[F]ind [H]elp" })
	vim.keymap.set("n", "<leader>fm", builtin.marks, { noremap = true, silent = true, desc = "[F]ind [M]arks" })
	vim.keymap.set("n", "<leader>fr", builtin.registers, { noremap = true, silent = true, desc = "[F]ind [R]egisters" })
	vim.keymap.set("n", "<leader>fq", builtin.quickfix, { noremap = true, silent = true, desc = "[F]ind [Q]uickfix" })
end

--TODO: add a telescope picker for functions and classes.
return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>ff", desc = "[F]ind [F]ile" },
		{ "<leader>fb", desc = "[F]ind [B]uffer" },
		{ "<leader>fc", desc = "[F]ind [C]ommands" },
		{ "<leader>fh", desc = "[F]ind [H]elp" },
		{ "<leader>fm", desc = "[F]ind [M]arks" },
		{ "<leader>fr", desc = "[F]ind [R]egisters" },
		{ "<leader>fq", desc = "[F]ind [Q]uickfix" },
	},
	config = setup,
}
