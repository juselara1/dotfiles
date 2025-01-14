---Setups the Kanagawa colorscheme
local function setup()
	require("kanagawa").setup({ compile = true, transparent = true })
	vim.cmd("colorscheme kanagawa-wave")
end

return {
	"rebelot/kanagawa.nvim",
	config = setup,
}
