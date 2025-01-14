return {
	"nvim-tree/nvim-tree.lua",
	keys = {
		{
			"<leader>e",
			desc = "Nvim tree"
		},
	},
	config = function()
		require("nvim-tree").setup {
			sort = {
				sorter = "case_sensitive",
				folders_first = true
			},
			view = {
				width = 40,
				number = true,
				relativenumber = true,
			}
		}

		vim.keymap.set(
			'n', "<leader>e", ":NvimTreeToggle<CR>", {
				noremap = true, silent=true,
				desc="Nvim tree"
				}
			)
	end
}
