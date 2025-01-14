---Setups the marks plugin.
function setup()
	require("marks").setup({})
end

return {
	"chentoast/marks.nvim",
	event = "VeryLazy",
	config = setup
}
