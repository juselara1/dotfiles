return {
	"nvim-mini/mini.indentscope",
	event = "BufReadPre",
	config = function()
		require("mini.indentscope").setup({
			symbol = "│",
			options = {
				try_as_border = true,
			},
		})
	end,
}
