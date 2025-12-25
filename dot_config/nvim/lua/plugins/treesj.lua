return {
	"Wansmer/treesj",
	keys = {
		{
			"<leader>j",
			function()
				require("treesj").toggle()
			end,
			mode = "v",
			desc = "[J]oin lines",
		},
	},
	opts = {},
}
