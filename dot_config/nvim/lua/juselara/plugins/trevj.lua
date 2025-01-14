return {
	"AckslD/nvim-trevJ.lua",
	keys = {
		{"<leader>j", desc="Format args"}
	},
	config = function()
		local trevj = require("trevj")
		vim.keymap.set('n', "<leader>j", trevj.format_at_cursor, {noremap = true, silent=true, desc="Format args"})
	end
}
