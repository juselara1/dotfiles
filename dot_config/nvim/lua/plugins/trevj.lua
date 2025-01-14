local Filetypes = {
	"lua",
	"python",
	"markdown",
	"c",
	"bash",
	"dockerfile",
	"gitignore",
	"json",
	"yaml",
	"toml",
}

---Setups the trevj plugin.
local function setup()
	local trevj = require("trevj")
	vim.keymap.set("n", "<leader>j", function()
		trevj.format_at_cursor()
	end, { silent = true, noremap = true, desc = "[J]oin lines inverse" })
end

return {
	"AckslD/nvim-trevJ.lua",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	keys = { { "<leader>j", desc = "[J]oin lines inverse" } },
	config = setup,
	ft = Filetypes,
}
