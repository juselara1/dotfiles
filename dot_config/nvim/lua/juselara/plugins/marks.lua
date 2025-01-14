return {
	"chentoast/marks.nvim",
	event = "VeryLazy",
	config = function ()
		require("marks").setup {
			signs = true
		}
	end
}
