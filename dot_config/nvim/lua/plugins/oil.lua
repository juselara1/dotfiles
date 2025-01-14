---Setups the Oil file manager.
local function setup()
	local oil = require("oil")
	oil.setup({
		default_file_explorer = true,
		columns = { "icon", "permissions" },
		float = { preview_split = "right" },
		view_options = { show_hidden = true },
	})
	vim.keymap.set("n", "<leader>o", function()
		oil.toggle_float()
	end, { silent = true, noremap = true, desc = "[O]il file explorer." })
end

return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>o", desc = "[O]il file explorer." },
	},
	config = setup,
}
