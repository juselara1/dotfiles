return {
	"stevearc/oil.nvim",
	dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-tree/nvim-tree.lua",
    },
	keys = {
		{
			"<leader>o",
			desc = "Oil file explorer"
		},
	},
	config = function()
		local oil = require("oil")
		local api = require("nvim-tree.api")

		oil.setup {
			default_file_explorer = false,
			columns = {"icon", "permissions"},
			float = {
				preview_split = "right",
			},
			view_options = {
				show_hidden = true
			}
		}
		vim.keymap.set(
			'n', "<leader>o", function ()
				local buf = vim.api.nvim_get_current_buf()
				if api.tree.is_tree_buf(buf) then
					local node = api.tree.get_node_under_cursor()
					if node ~= nil then
						api.tree.toggle()
						if node.type == "directory" then
							oil.toggle_float(node.absolute_path)
						else
							oil.toggle_float(node.parent.absolute_path)
						end
					end
				else
					oil.toggle_float()
					api.tree.toggle()
				end
			end,
			{
				noremap = true, silent=false,
				desc="Oil file explorer"
				}
			)
	end,
}
